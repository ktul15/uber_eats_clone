import { Response } from 'express';
import { prisma } from '../utils/prisma';
import { AppError } from '../utils/AppError';
import { asyncHandler } from '../utils/asyncHandler';
import { AuthRequest } from '../types/auth.types';
import { getIO } from '../socket/index';
import { rooms } from '../socket/rooms';
import { DeliveryStatus } from '@prisma/client';
import { sendPushNotification } from '../utils/fcm';

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

// POST /api/deliveries/accept
export const acceptDelivery = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const { orderId } = req.body as { orderId?: string };
    if (!orderId) throw AppError.badRequest('orderId is required');

    const driverProfileId = await getDriverProfileId(userId);

    const delivery = await prisma.$transaction(async (tx) => {
        const fresh = await tx.order.findUnique({
            where: { id: orderId },
            select: { status: true },
        });
        if (!fresh) throw AppError.notFound('Order not found');
        if (fresh.status !== 'READY') throw AppError.conflict('Order is no longer available');

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

        await tx.driverProfile.update({
            where: { id: driverProfileId },
            data: { isAvailable: false },
        });

        return created;
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

        const updated = await tx.delivery.update({
            where: { id: deliveryId },
            data: { status: status as DeliveryStatus },
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

// PATCH /api/deliveries/:id/location
export const updateLocation = asyncHandler(async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const deliveryId = req.params['id'] as string;
    const { lat, lng } = req.body as { lat?: unknown; lng?: unknown };

    if (typeof lat !== 'number' || typeof lng !== 'number' || !isFinite(lat) || !isFinite(lng)) {
        throw AppError.badRequest('lat and lng must be finite numbers');
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
            data: { currentLat: lat, currentLng: lng },
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
