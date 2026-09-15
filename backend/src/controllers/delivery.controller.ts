import { Response } from 'express';
import { prisma } from '../utils/prisma';
import { AppError } from '../utils/AppError';
import { asyncHandler } from '../utils/asyncHandler';
import { AuthRequest } from '../types/auth.types';
import { getIO } from '../socket/index';
import { rooms } from '../socket/rooms';
import { DeliveryStatus, Prisma } from '@prisma/client';
import { sendPushNotification } from '../utils/fcm';
import { haversineKm } from '../utils/haversine';

const MAX_ASSIGNMENT_DISTANCE_KM = 10;

const NEXT_STATUS: Partial<Record<DeliveryStatus, DeliveryStatus>> = {
    ASSIGNED: 'AT_RESTAURANT',
    AT_RESTAURANT: 'IN_TRANSIT',
    IN_TRANSIT: 'COMPLETED',
};

const getDriverProfileId = async (userId: string): Promise<string> => {
    const profile = await prisma.driverProfile.findUnique({ where: { userId } });
    if (!profile) throw AppError.notFound('Driver profile not found');
    return profile.id;
};

const validCoordinates = (lat: unknown, lng: unknown): lat is number =>
    typeof lat === 'number' &&
    typeof lng === 'number' &&
    Number.isFinite(lat) &&
    Number.isFinite(lng) &&
    lat >= -90 && lat <= 90 &&
    lng >= -180 && lng <= 180;

// PATCH /api/deliveries/availability
export const updateAvailability = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const { isAvailable, lat, lng } = req.body as {
        isAvailable?: unknown;
        lat?: unknown;
        lng?: unknown;
    };
    if (typeof isAvailable !== 'boolean') {
        throw AppError.badRequest('isAvailable must be a boolean');
    }
    if ((lat === undefined) !== (lng === undefined)) {
        throw AppError.badRequest('lat and lng must be provided together');
    }
    if (isAvailable && (lat === undefined || lng === undefined)) {
        throw AppError.badRequest('Fresh lat and lng are required to go online');
    }
    if (lat !== undefined && !validCoordinates(lat, lng)) {
        throw AppError.badRequest('lat and lng must be valid coordinates');
    }

    const profileId = await getDriverProfileId(userId);
    const updated = await prisma.$transaction(async (tx) => {
        await tx.$executeRaw`SELECT pg_advisory_xact_lock(hashtext(${profileId}))`;
        const profile = await tx.driverProfile.findUnique({ where: { id: profileId } });
        if (!profile) throw AppError.notFound('Driver profile not found');

        const activeDelivery = await tx.delivery.findFirst({
            where: { driverId: profile.id, status: { not: DeliveryStatus.COMPLETED } },
            select: { id: true },
        });
        if (activeDelivery) {
            throw AppError.conflict(
                isAvailable
                    ? 'Complete the active delivery before going online'
                    : 'You cannot go offline during an active delivery',
            );
        }

        return tx.driverProfile.update({
            where: { id: profile.id },
            data: {
                isAvailable,
                ...(lat !== undefined && { currentLat: lat as number, currentLng: lng as number }),
            },
            select: { isAvailable: true, currentLat: true, currentLng: true },
        });
    });

    res.status(200).json({ success: true, data: updated });
});

// POST /api/deliveries/accept
export const acceptDelivery = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const { orderId } = req.body as { orderId?: string };
    if (!orderId) throw AppError.badRequest('orderId is required');

    const driverProfileId = await getDriverProfileId(userId);

    const delivery = await prisma.$transaction(async (tx) => {
        await tx.$executeRaw`SELECT pg_advisory_xact_lock(hashtext(${driverProfileId}))`;
        const driver = await tx.driverProfile.findUnique({ where: { id: driverProfileId } });
        if (!driver || !driver.isAvailable) {
            throw AppError.conflict('Driver is offline or already handling a delivery');
        }

        const fresh = await tx.order.findUnique({
            where: { id: orderId },
            select: { status: true, restaurant: { select: { lat: true, lng: true } } },
        });
        if (!fresh) throw AppError.notFound('Order not found');
        if (fresh.status !== 'READY') throw AppError.conflict('Order is no longer available');
        if (!validCoordinates(driver.currentLat, driver.currentLng) ||
            !validCoordinates(fresh.restaurant.lat, fresh.restaurant.lng)) {
            throw AppError.conflict('Valid driver and restaurant coordinates are required');
        }
        const driverLat = driver.currentLat as number;
        const driverLng = driver.currentLng as number;
        const restaurantLat = fresh.restaurant.lat as number;
        const restaurantLng = fresh.restaurant.lng as number;
        if (haversineKm(
            driverLat,
            driverLng,
            restaurantLat,
            restaurantLng,
        ) > MAX_ASSIGNMENT_DISTANCE_KM) {
            throw AppError.forbidden('Order is outside the delivery radius');
        }

        const claimed = await tx.driverProfile.updateMany({
            where: {
                id: driverProfileId,
                isAvailable: true,
                currentLat: { not: null },
                currentLng: { not: null },
            },
            data: { isAvailable: false },
        });
        if (claimed.count !== 1) {
            throw AppError.conflict('Driver is offline or already handling a delivery');
        }

        const created = await tx.delivery.create({
            data: { orderId, driverId: driverProfileId, status: 'ASSIGNED' },
            include: {
                driver: true,
                order: {
                    include: {
                        restaurant: { select: { id: true } },
                        customer: { select: { userId: true, user: { select: { fcmToken: true } } } },
                    },
                },
            },
        });

        return created;
    }).catch((error: unknown) => {
        if (error instanceof Prisma.PrismaClientKnownRequestError && error.code === 'P2002') {
            throw AppError.conflict('Order is no longer available');
        }
        throw error;
    });

    const io = getIO();
    const assignedPayload = {
        deliveryId: delivery.id,
        orderId: delivery.orderId,
        driverName: delivery.driver.name,
        driverVehicleType: delivery.driver.vehicleType,
    };
    io.to(rooms.customer(delivery.order.customer.userId)).emit('delivery:assigned', assignedPayload);
    io.to(rooms.restaurant(delivery.order.restaurant.id)).emit('delivery:assigned', assignedPayload);

    const customerToken = delivery.order.customer.user?.fcmToken;
    if (customerToken) {
        void sendPushNotification(customerToken, {
            title: 'Driver Assigned',
            body: `${delivery.driver.name} is on their way to the restaurant!`,
            data: { orderId: delivery.orderId },
        });
    }

    res.status(201).json({ success: true, data: delivery });
});

// PATCH /api/deliveries/:id/status
export const updateDeliveryStatus = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const deliveryId = req.params['id'] as string;
    const { status } = req.body as { status?: string };

    const validStatuses = Object.values(DeliveryStatus);
    if (!status || !validStatuses.includes(status as DeliveryStatus)) {
        throw AppError.badRequest(`status must be one of: ${validStatuses.join(', ')}`);
    }

    const driverProfileId = await getDriverProfileId(userId);

    const delivery = await prisma.$transaction(async (tx) => {
        const existing = await tx.delivery.findUnique({
            where: { id: deliveryId },
            include: {
                order: {
                    include: {
                        restaurant: { select: { id: true } },
                        customer: { select: { userId: true, user: { select: { fcmToken: true } } } },
                    },
                },
            },
        });

        if (!existing) throw AppError.notFound('Delivery not found');
        if (existing.driverId !== driverProfileId) throw AppError.forbidden('You do not own this delivery');

        const allowed = NEXT_STATUS[existing.status];
        if (!allowed || allowed !== status) {
            throw AppError.badRequest(`Cannot transition from ${existing.status} to ${status}`);
        }

        const claimed = await tx.delivery.updateMany({
            where: { id: deliveryId, driverId: driverProfileId, status: existing.status },
            data: { status: status as DeliveryStatus },
        });
        if (claimed.count !== 1) {
            throw AppError.conflict('Delivery status changed; refresh and try again');
        }

        const updated = await tx.delivery.findUniqueOrThrow({
            where: { id: deliveryId },
            include: {
                order: {
                    include: {
                        restaurant: { select: { id: true } },
                        customer: { select: { userId: true, user: { select: { fcmToken: true } } } },
                    },
                },
            },
        });

        if (status === 'IN_TRANSIT') {
            await tx.order.update({ where: { id: existing.orderId }, data: { status: 'PICKED_UP' } });
        }

        if (status === 'COMPLETED') {
            await tx.order.update({ where: { id: existing.orderId }, data: { status: 'DELIVERED' } });
            await tx.driverProfile.update({ where: { id: driverProfileId }, data: { isAvailable: true } });
        }

        return updated;
    });

    const io = getIO();
    const statusPayload = {
        deliveryId: delivery.id,
        orderId: delivery.orderId,
        status: delivery.status,
        updatedAt: delivery.updatedAt,
    };
    io.to(rooms.customer(delivery.order.customer.userId)).emit('delivery:status_updated', statusPayload);
    io.to(rooms.restaurant(delivery.order.restaurant.id)).emit('delivery:status_updated', statusPayload);

    const customerToken = delivery.order.customer.user?.fcmToken;
    const deliveryMessages: Partial<Record<DeliveryStatus, { title: string; body: string }>> = {
        AT_RESTAURANT: { title: 'Driver Arrived', body: 'Your driver is at the restaurant!' },
        IN_TRANSIT: { title: 'Order On The Way', body: 'Your order is on its way!' },
        COMPLETED: { title: 'Order Delivered', body: 'Your order has been delivered. Enjoy!' },
    };
    const deliveryMsg = deliveryMessages[delivery.status];
    if (customerToken && deliveryMsg) {
        void sendPushNotification(customerToken, { ...deliveryMsg, data: { orderId: delivery.orderId } });
    }

    res.status(200).json({ success: true, data: delivery });
});

// GET /api/deliveries/order/:orderId — customer-authorized tracking snapshot
export const getDeliveryForOrder = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const orderId = req.params['orderId'] as string;
    const customer = await prisma.customerProfile.findUnique({ where: { userId }, select: { id: true } });
    if (!customer) throw AppError.notFound('Customer profile not found');

    const order = await prisma.order.findUnique({
        where: { id: orderId },
        select: {
            customerId: true,
            deliveryAddress: true,
            delivery: {
                include: {
                    driver: { select: { name: true, vehicleType: true, currentLat: true, currentLng: true } },
                },
            },
        },
    });
    if (!order) throw AppError.notFound('Order not found');
    if (order.customerId !== customer.id) throw AppError.forbidden('You cannot track this order');

    res.status(200).json({
        success: true,
        data: order.delivery == null ? null : {
            deliveryId: order.delivery.id,
            orderId,
            status: order.delivery.status,
            driverName: order.delivery.driver.name,
            driverVehicleType: order.delivery.driver.vehicleType,
            driverLat: order.delivery.driver.currentLat,
            driverLng: order.delivery.driver.currentLng,
            deliveryAddress: order.deliveryAddress,
        },
    });
});

// PATCH /api/deliveries/:id/location
export const updateLocation = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const deliveryId = req.params['id'] as string;
    const { lat, lng } = req.body as { lat?: unknown; lng?: unknown };

    if (!validCoordinates(lat, lng)) {
        throw AppError.badRequest('lat and lng must be valid coordinates');
    }

    const delivery = await prisma.$transaction(async (tx) => {
        const profile = await tx.driverProfile.findUnique({ where: { userId } });
        if (!profile) throw AppError.notFound('Driver profile not found');

        const existing = await tx.delivery.findUnique({
            where: { id: deliveryId },
            include: { order: { include: { customer: { select: { userId: true } } } } },
        });

        if (!existing) throw AppError.notFound('Delivery not found');
        if (existing.driverId !== profile.id) throw AppError.forbidden('You do not own this delivery');
        if (existing.status === DeliveryStatus.COMPLETED) throw AppError.badRequest('Delivery already completed');

        await tx.driverProfile.update({
            where: { id: profile.id },
            data: { currentLat: lat as number, currentLng: lng as number },
        });

        return existing;
    });

    const io = getIO();
    io.to(rooms.customer(delivery.order.customer.userId)).emit('driver:location', {
        deliveryId,
        lat,
        lng,
        updatedAt: new Date(),
    });

    res.status(200).json({ success: true });
});

// GET /api/deliveries/active
export const getActiveDelivery = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const driverProfileId = await getDriverProfileId(userId);

    const delivery = await prisma.delivery.findFirst({
        where: {
            driverId: driverProfileId,
            status: { not: 'COMPLETED' },
        },
        include: {
            order: {
                include: {
                    restaurant: { select: { id: true, name: true, address: true } },
                    customer: { select: { userId: true } },
                    orderItems: { include: { menuItem: true } },
                },
            },
        },
    });

    res.status(200).json({ success: true, data: delivery });
});

// GET /api/deliveries/:id/driver-location
export const getDriverLocation = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const deliveryId = req.params['id'] as string;

    const customerProfile = await prisma.customerProfile.findUnique({ where: { userId } });
    if (!customerProfile) throw AppError.notFound('Customer profile not found');

    const delivery = await prisma.delivery.findUnique({
        where: { id: deliveryId },
        include: {
            order: { select: { customerId: true } },
            driver: { select: { currentLat: true, currentLng: true } },
        },
    });
    if (!delivery) throw AppError.notFound('Delivery not found');

    if (delivery.order.customerId !== customerProfile.id) {
        throw AppError.forbidden('You do not own this delivery');
    }

    if (delivery.status === DeliveryStatus.COMPLETED) {
        throw AppError.badRequest('Delivery already completed');
    }

    res.status(200).json({
        success: true,
        data: { deliveryId, lat: delivery.driver.currentLat, lng: delivery.driver.currentLng },
    });
});
