import { Response } from 'express';
import { prisma } from '../utils/prisma';
import { AppError } from '../utils/AppError';
import { asyncHandler } from '../utils/asyncHandler';
import { AuthRequest } from '../types/auth.types';
import { getIO } from '../socket/index';
import { rooms } from '../socket/rooms';
import { OrderStatus, Prisma } from '@prisma/client';
import { haversineKm } from '../utils/haversine';
import { sendPushNotification, sendPushNotificationToMany } from '../utils/fcm';
// eslint-disable-next-line @typescript-eslint/no-require-imports
const Stripe = require('stripe');
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY ?? '', { apiVersion: '2025-03-31.basil' });

// HELPER: resolve CustomerProfile.id from JWT userId
const getCustomerProfileId = async (userId: string): Promise<string> => {
    const profile = await prisma.customerProfile.findUnique({ where: { userId } });
    if (!profile) throw AppError.notFound('Customer profile not found');
    return profile.id;
};

const orderInclude = {
    orderItems: { include: { menuItem: true } },
    restaurant: true,
    review: true,
};

const updateRestaurantRating = async (
    tx: Pick<typeof prisma, 'review' | 'restaurant'>,
    restaurantId: string,
): Promise<void> => {
    const aggregate = await tx.review.aggregate({
        where: { restaurantId },
        _avg: { rating: true },
    });

    await tx.restaurant.update({
        where: { id: restaurantId },
        data: { rating: aggregate._avg.rating ?? 0 },
    });
};

// POST /api/orders/payment-intent
// Creates a Stripe PaymentIntent for the current cart total.
// Returns: { clientSecret }
export const createPaymentIntent = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const customerId = await getCustomerProfileId(userId);

    // Load the cart
    const cart = await prisma.cart.findUnique({
        where: { customerId },
        include: { items: { include: { menuItem: true } } },
    });

    if (!cart || cart.items.length === 0) {
        throw AppError.badRequest('Cart is empty');
    }

    // Calculate total in cents
    const totalCents = cart.items.reduce((sum, item) => {
        return sum + Math.round(Number(item.menuItem.price) * item.quantity * 100);
    }, 0);

    const paymentIntent = await stripe.paymentIntents.create({
        amount: totalCents,
        currency: 'usd',
        metadata: {
            customerId,
            cartId: cart.id,
            restaurantId: cart.restaurantId,
        },
    });

    res.status(200).json({
        success: true,
        data: { clientSecret: paymentIntent.client_secret },
    });
});

// POST /api/orders
// Places an order. Expects: { deliveryAddress: string, paymentIntentId: string }
export const placeOrder = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const { deliveryAddress, paymentIntentId } = req.body as { deliveryAddress?: string; paymentIntentId?: string };

    if (!deliveryAddress || deliveryAddress.trim() === '') {
        throw AppError.badRequest('deliveryAddress is required');
    }
    if (!paymentIntentId) {
        throw AppError.badRequest('paymentIntentId is required');
    }

    // Verify payment succeeded with Stripe
    const paymentIntent = await stripe.paymentIntents.retrieve(paymentIntentId);
    if (paymentIntent.status !== 'succeeded') {
        throw AppError.badRequest('Payment has not been completed');
    }

    const customerId = await getCustomerProfileId(userId);

    // Load cart
    const cart = await prisma.cart.findUnique({
        where: { customerId },
        include: { items: { include: { menuItem: true } } },
    });

    if (!cart || cart.items.length === 0) {
        throw AppError.badRequest('Cart is empty');
    }

    // Calculate total
    const totalAmount = cart.items.reduce((sum, item) => {
        return sum + Number(item.menuItem.price) * item.quantity;
    }, 0);

    // Create order + items + clear cart atomically
    const order = await prisma.$transaction(async (tx) => {
        const newOrder = await tx.order.create({
            data: {
                customerId,
                restaurantId: cart.restaurantId,
                deliveryAddress: deliveryAddress.trim(),
                totalAmount,
                status: 'PENDING',
            },
        });

        await tx.orderItem.createMany({
            data: cart.items.map((item) => ({
                orderId: newOrder.id,
                menuItemId: item.menuItemId,
                quantity: item.quantity,
                priceAtTime: item.menuItem.price,
            })),
        });

        // Clear the cart
        await tx.cart.delete({ where: { id: cart.id } });

        return tx.order.findUnique({
            where: { id: newOrder.id },
            include: {
                orderItems: { include: { menuItem: true } },
                restaurant: { include: { owner: { select: { fcmToken: true } } } },
            },
        });
    });

    if (order) {
        getIO().to(rooms.restaurant(order.restaurantId)).emit('order:new', {
            orderId: order.id,
            restaurantId: order.restaurantId,
            totalAmount: order.totalAmount,
            createdAt: order.createdAt,
        });

        if (order.restaurant.owner?.fcmToken) {
            void sendPushNotification(order.restaurant.owner.fcmToken, {
                title: 'New Order Received',
                body: `New order worth $${Number(order.totalAmount).toFixed(2)} at ${order.restaurant.name}`,
                data: { orderId: order.id },
            });
        }
    }

    res.status(201).json({ success: true, data: order });
});

// GET /api/orders
// Customers: their own orders. Owners: orders for their restaurants.
export const getOrders = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    const role = req.user?.role;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    if (role === 'CUSTOMER') {
        const customerId = await getCustomerProfileId(userId);
        const orders = await prisma.order.findMany({
            where: { customerId },
            include: orderInclude,
            orderBy: { createdAt: 'desc' },
        });
        res.status(200).json({ success: true, data: orders });
        return;
    }

    if (role === 'OWNER') {
        const restaurants = await prisma.restaurant.findMany({ where: { ownerId: userId }, select: { id: true } });
        const restaurantIds = restaurants.map((r) => r.id);
        const orders = await prisma.order.findMany({
            where: { restaurantId: { in: restaurantIds } },
            include: orderInclude,
            orderBy: { createdAt: 'desc' },
        });
        res.status(200).json({ success: true, data: orders });
        return;
    }

    throw AppError.forbidden('Access denied');
});

// GET /api/orders/:id
export const getOrderById = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    const role = req.user?.role;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const orderId = req.params['id'] as string;

    const order = await prisma.order.findUnique({
        where: { id: orderId },
        include: orderInclude,
    });

    if (!order) throw AppError.notFound('Order not found');

    if (role === 'CUSTOMER') {
        const customerId = await getCustomerProfileId(userId);
        if (order.customerId !== customerId) throw AppError.forbidden('You cannot access this order');
    } else if (role === 'OWNER') {
        if (order.restaurant.ownerId !== userId) throw AppError.forbidden('You do not own this restaurant');
    } else {
        throw AppError.forbidden('Access denied');
    }

    res.status(200).json({ success: true, data: order });
});

export const createOrderReview = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const orderId = req.params['id'] as string;
    const { rating, comment } = req.body as { rating?: unknown; comment?: unknown };
    if (typeof rating !== 'number' || !Number.isInteger(rating) || rating < 1 || rating > 5) {
        throw AppError.badRequest('rating must be an integer between 1 and 5');
    }
    if (comment !== undefined && typeof comment !== 'string') {
        throw AppError.badRequest('comment must be a string');
    }
    if (typeof comment === 'string' && comment.length > 1000) {
        throw AppError.badRequest('comment must be at most 1000 characters');
    }

    const customerId = await getCustomerProfileId(userId);

    const updatedOrder = await prisma.$transaction(async (tx) => {
        const orderIdentity = await tx.order.findUnique({
            where: { id: orderId },
            select: { restaurantId: true },
        });

        if (!orderIdentity) throw AppError.notFound('Order not found');

        // Serialize review creation and aggregate updates per restaurant. This
        // prevents concurrent reviews from persisting a stale average.
        await tx.$executeRaw`SELECT pg_advisory_xact_lock(hashtext(${orderIdentity.restaurantId}))`;

        const order = await tx.order.findUnique({
            where: { id: orderId },
            include: { review: true },
        });

        if (!order) throw AppError.notFound('Order not found');
        if (order.customerId !== customerId) throw AppError.forbidden('You cannot review this order');
        if (order.status !== OrderStatus.DELIVERED) throw AppError.badRequest('Only delivered orders can be reviewed');
        if (order.review) throw AppError.badRequest('Order has already been reviewed');

        await tx.review.create({
            data: {
                orderId: order.id,
                customerId,
                restaurantId: order.restaurantId,
                rating,
                comment: comment?.trim() || null,
            },
        });

        await updateRestaurantRating(tx, order.restaurantId);

        return tx.order.findUnique({
            where: { id: order.id },
            include: orderInclude,
        });
    }).catch((error: unknown) => {
        if (error instanceof Prisma.PrismaClientKnownRequestError && error.code === 'P2002') {
            throw AppError.conflict('Order has already been reviewed');
        }
        throw error;
    });

    res.status(201).json({ success: true, data: updatedOrder });
});

export const updateOrderStatus = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const orderId = req.params['id'] as string;
    const { status } = req.body as { status?: string };

    const validStatuses = Object.values(OrderStatus);
    if (!status || !validStatuses.includes(status as OrderStatus)) {
        throw AppError.badRequest(`status must be one of: ${validStatuses.join(', ')}`);
    }

    const order = await prisma.order.findUnique({
        where: { id: orderId },
        select: {
            restaurant: { select: { ownerId: true, name: true, lat: true, lng: true } },
            customer: { select: { userId: true, user: { select: { fcmToken: true } } } },
        },
    });

    if (!order) throw AppError.notFound('Order not found');
    if (order.restaurant.ownerId !== userId) throw AppError.forbidden('You do not own this restaurant');

    const updated = await prisma.order.update({
        where: { id: orderId },
        data: { status: status as OrderStatus },
        include: { orderItems: { include: { menuItem: true } }, restaurant: true },
    });

    getIO().to(rooms.customer(order.customer.userId)).emit('order:status_updated', {
        orderId: updated.id,
        status: updated.status,
        updatedAt: updated.updatedAt,
    });

    const customerToken = order.customer.user?.fcmToken;
    const customerMessages: Partial<Record<OrderStatus, { title: string; body: string }>> = {
        ACCEPTED: { title: 'Order Accepted', body: 'Your order has been accepted!' },
        PREPARING: { title: 'Order Being Prepared', body: 'Your order is being prepared!' },
        READY: { title: 'Order Almost Ready', body: 'Your order is ready for pickup by a driver!' },
        CANCELLED: { title: 'Order Cancelled', body: 'Your order has been cancelled.' },
    };
    const customerMsg = customerMessages[status as OrderStatus];
    if (customerToken && customerMsg) {
        void sendPushNotification(customerToken, { ...customerMsg, data: { orderId: updated.id } });
    }

    if (status === 'READY') {
        const availableDrivers = await prisma.driverProfile.findMany({
            where: { isAvailable: true },
            select: { userId: true, currentLat: true, currentLng: true, user: { select: { fcmToken: true } } },
        });
        const io = getIO();
        const payload = {
            orderId: updated.id,
            restaurantId: updated.restaurantId,
            restaurantName: updated.restaurant.name,
            deliveryAddress: updated.deliveryAddress,
            totalAmount: updated.totalAmount,
        };
        const nearbyDriverTokens: string[] = [];
        availableDrivers.forEach((driver) => {
            if (
                order.restaurant.lat != null &&
                order.restaurant.lng != null &&
                driver.currentLat != null &&
                driver.currentLng != null
            ) {
                const dist = haversineKm(
                    driver.currentLat,
                    driver.currentLng,
                    order.restaurant.lat,
                    order.restaurant.lng,
                );
                if (dist > 10) return;
            }
            io.to(rooms.driver(driver.userId)).emit('order:available', payload);
            if (driver.user.fcmToken) nearbyDriverTokens.push(driver.user.fcmToken);
        });
        if (nearbyDriverTokens.length > 0) {
            const staleTokens = await sendPushNotificationToMany(nearbyDriverTokens, {
                title: 'New Delivery Available',
                body: `New order near ${updated.restaurant.name}!`,
                data: { orderId: updated.id },
            });
            if (staleTokens.length > 0) {
                await prisma.user.updateMany({
                    where: { fcmToken: { in: staleTokens } },
                    data: { fcmToken: null },
                });
            }
        }
    }

    res.status(200).json({ success: true, data: updated });
});
