import { Response } from 'express';
import { prisma } from '../utils/prisma';
import { AppError } from '../utils/AppError';
import { asyncHandler } from '../utils/asyncHandler';
import { AuthRequest } from '../types/auth.types';
import { getIO } from '../socket/index';
import { rooms } from '../socket/rooms';
import { OrderStatus } from '@prisma/client';
// eslint-disable-next-line @typescript-eslint/no-require-imports
const Stripe = require('stripe');
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY ?? '', { apiVersion: '2025-03-31.basil' });

// HELPER: resolve CustomerProfile.id from JWT userId
const getCustomerProfileId = async (userId: string): Promise<string> => {
    const profile = await prisma.customerProfile.findUnique({ where: { userId } });
    if (!profile) throw AppError.notFound('Customer profile not found');
    return profile.id;
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
            include: { orderItems: { include: { menuItem: true } }, restaurant: true },
        });
    });

    if (order) {
        getIO().to(rooms.restaurant(order.restaurantId)).emit('order:new', {
            orderId: order.id,
            restaurantId: order.restaurantId,
            totalAmount: order.totalAmount,
            createdAt: order.createdAt,
        });
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
            include: { orderItems: { include: { menuItem: true } }, restaurant: true },
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
            include: { orderItems: { include: { menuItem: true } }, restaurant: true },
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
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const orderId = req.params['id'] as string;

    const order = await prisma.order.findUnique({
        where: { id: orderId },
        include: { orderItems: { include: { menuItem: true } }, restaurant: true },
    });

    if (!order) throw AppError.notFound('Order not found');

    res.status(200).json({ success: true, data: order });
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
            restaurant: { select: { ownerId: true } },
            customer: { select: { userId: true } },
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

    res.status(200).json({ success: true, data: updated });
});
