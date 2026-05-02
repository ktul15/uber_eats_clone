import { prismaMock } from '../../__mocks__/prisma';
import { AppError } from '../../utils/AppError';

jest.mock('../../utils/asyncHandler', () => ({
    asyncHandler: (fn: any) => fn,
}));

const mockEmit = jest.fn();
const mockTo = jest.fn(() => ({ emit: mockEmit }));

jest.mock('../../socket/index', () => ({
    getIO: jest.fn(() => ({ to: mockTo })),
}));

// Import after mocks are established
import { acceptDelivery, updateDeliveryStatus, getActiveDelivery, updateLocation, getDriverLocation } from '../delivery.controller';

describe('Delivery Controller', () => {
    let req: any;
    let res: any;

    beforeEach(() => {
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        jest.clearAllMocks();
    });

    // ─── acceptDelivery ───────────────────────────────────────────────────────

    describe('acceptDelivery', () => {
        beforeEach(() => {
            req = {
                user: { id: 'user-1', role: 'DRIVER' },
                body: { orderId: 'order-1' },
            };
        });

        it('throws 401 if unauthenticated', async () => {
            req.user = undefined;
            await expect(acceptDelivery(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 if orderId missing', async () => {
            req.body = {};
            await expect(acceptDelivery(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if driver profile not found', async () => {
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce(null);
            await expect(acceptDelivery(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if order not found inside transaction', async () => {
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.order.findUnique.mockResolvedValueOnce(null);

            await expect(acceptDelivery(req, res)).rejects.toThrow(AppError);
        });

        it('throws 409 if order not in READY status', async () => {
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.order.findUnique.mockResolvedValueOnce({ status: 'PREPARING' } as any);

            const err = await acceptDelivery(req, res).catch((e) => e);
            expect(err).toBeInstanceOf(AppError);
            expect((err as AppError).statusCode).toBe(409);
        });

        it('creates delivery, marks driver unavailable, and emits socket events', async () => {
            const mockDelivery = {
                id: 'del-1',
                orderId: 'order-1',
                driver: { name: 'Ali', vehicleType: 'Bike' },
                order: {
                    restaurant: { id: 'rest-1' },
                    customer: { userId: 'cust-user-1' },
                },
            };

            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.order.findUnique.mockResolvedValueOnce({ status: 'READY' } as any);
            prismaMock.delivery.create.mockResolvedValueOnce(mockDelivery as any);
            prismaMock.driverProfile.update.mockResolvedValueOnce({} as any);

            await acceptDelivery(req, res);

            expect(prismaMock.delivery.create).toHaveBeenCalledWith(
                expect.objectContaining({
                    data: expect.objectContaining({ orderId: 'order-1', driverId: 'dp-1', status: 'ASSIGNED' }),
                }),
            );
            expect(prismaMock.driverProfile.update).toHaveBeenCalledWith(
                expect.objectContaining({ data: { isAvailable: false } }),
            );
            expect(mockTo).toHaveBeenCalledWith('customer:cust-user-1');
            expect(mockTo).toHaveBeenCalledWith('restaurant:rest-1');
            expect(res.status).toHaveBeenCalledWith(201);
        });
    });

    // ─── updateDeliveryStatus ─────────────────────────────────────────────────

    describe('updateDeliveryStatus', () => {
        beforeEach(() => {
            req = {
                user: { id: 'user-1', role: 'DRIVER' },
                params: { id: 'del-1' },
                body: { status: 'AT_RESTAURANT' },
            };
        });

        it('throws 400 if status is invalid', async () => {
            req.body = { status: 'FLYING' };
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            await expect(updateDeliveryStatus(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if delivery not found', async () => {
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce(null);

            await expect(updateDeliveryStatus(req, res)).rejects.toThrow(AppError);
        });

        it('throws 403 if driver does not own delivery', async () => {
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-other',
                status: 'ASSIGNED',
                orderId: 'order-1',
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            } as any);

            await expect(updateDeliveryStatus(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 on invalid transition (ASSIGNED → COMPLETED)', async () => {
            req.body = { status: 'COMPLETED' };
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'ASSIGNED',
                orderId: 'order-1',
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            } as any);

            await expect(updateDeliveryStatus(req, res)).rejects.toThrow(AppError);
        });

        it('advances to AT_RESTAURANT without order side effects', async () => {
            const mockUpdated = {
                id: 'del-1',
                orderId: 'order-1',
                status: 'AT_RESTAURANT',
                updatedAt: new Date(),
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            };

            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'ASSIGNED',
                orderId: 'order-1',
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            } as any);
            prismaMock.delivery.update.mockResolvedValueOnce(mockUpdated as any);

            await updateDeliveryStatus(req, res);

            expect(prismaMock.order.update).not.toHaveBeenCalled();
            expect(res.status).toHaveBeenCalledWith(200);
        });

        it('updates order to PICKED_UP when advancing to IN_TRANSIT', async () => {
            req.body = { status: 'IN_TRANSIT' };
            const mockUpdated = {
                id: 'del-1',
                orderId: 'order-1',
                status: 'IN_TRANSIT',
                updatedAt: new Date(),
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            };

            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'AT_RESTAURANT',
                orderId: 'order-1',
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            } as any);
            prismaMock.delivery.update.mockResolvedValueOnce(mockUpdated as any);

            await updateDeliveryStatus(req, res);

            expect(prismaMock.order.update).toHaveBeenCalledWith(
                expect.objectContaining({ data: { status: 'PICKED_UP' } }),
            );
        });

        it('updates order to DELIVERED and re-enables driver on COMPLETED', async () => {
            req.body = { status: 'COMPLETED' };
            const mockUpdated = {
                id: 'del-1',
                orderId: 'order-1',
                status: 'COMPLETED',
                updatedAt: new Date(),
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            };

            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'IN_TRANSIT',
                orderId: 'order-1',
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            } as any);
            prismaMock.delivery.update.mockResolvedValueOnce(mockUpdated as any);

            await updateDeliveryStatus(req, res);

            expect(prismaMock.order.update).toHaveBeenCalledWith(
                expect.objectContaining({ data: { status: 'DELIVERED' } }),
            );
            expect(prismaMock.driverProfile.update).toHaveBeenCalledWith(
                expect.objectContaining({ data: { isAvailable: true } }),
            );
        });

        it('emits delivery:status_updated to customer and restaurant rooms', async () => {
            const mockUpdated = {
                id: 'del-1',
                orderId: 'order-1',
                status: 'AT_RESTAURANT',
                updatedAt: new Date(),
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            };

            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'ASSIGNED',
                orderId: 'order-1',
                order: { restaurant: { id: 'rest-1' }, customer: { userId: 'cu-1' } },
            } as any);
            prismaMock.delivery.update.mockResolvedValueOnce(mockUpdated as any);

            await updateDeliveryStatus(req, res);

            expect(mockTo).toHaveBeenCalledWith('customer:cu-1');
            expect(mockTo).toHaveBeenCalledWith('restaurant:rest-1');
            expect(mockEmit).toHaveBeenCalledWith(
                'delivery:status_updated',
                expect.objectContaining({ status: 'AT_RESTAURANT' }),
            );
        });
    });

    // ─── updateLocation ───────────────────────────────────────────────────────

    describe('updateLocation', () => {
        beforeEach(() => {
            req = {
                user: { id: 'user-1', role: 'DRIVER' },
                params: { id: 'del-1' },
                body: { lat: 37.77, lng: -122.41 },
            };
        });

        it('throws 401 if unauthenticated', async () => {
            req.user = undefined;
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 if lat is missing', async () => {
            req.body = { lng: -122.41 };
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 if lng is missing', async () => {
            req.body = { lat: 37.77 };
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 if lat is NaN', async () => {
            req.body = { lat: NaN, lng: -122.41 };
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 if lat is Infinity', async () => {
            req.body = { lat: Infinity, lng: -122.41 };
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 400 if lat/lng are strings', async () => {
            req.body = { lat: '37.77', lng: '-122.41' };
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if driver profile not found', async () => {
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce(null);
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if delivery not found', async () => {
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce(null);
            await expect(updateLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 403 if driver does not own delivery', async () => {
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-other',
                status: 'IN_TRANSIT',
                order: { customer: { userId: 'cust-user-1' } },
            } as any);
            const err = await updateLocation(req, res).catch((e) => e);
            expect(err).toBeInstanceOf(AppError);
            expect((err as AppError).statusCode).toBe(403);
        });

        it('throws 400 if delivery is COMPLETED', async () => {
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'COMPLETED',
                order: { customer: { userId: 'cust-user-1' } },
            } as any);
            const err = await updateLocation(req, res).catch((e) => e);
            expect(err).toBeInstanceOf(AppError);
            expect((err as AppError).statusCode).toBe(400);
        });

        it('updates driver coordinates and emits driver:location to customer room', async () => {
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1', userId: 'user-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'IN_TRANSIT',
                order: { customer: { userId: 'cust-user-1' } },
            } as any);
            prismaMock.driverProfile.update.mockResolvedValueOnce({} as any);

            await updateLocation(req, res);

            expect(prismaMock.driverProfile.update).toHaveBeenCalledWith(
                expect.objectContaining({ where: { id: 'dp-1' }, data: { currentLat: 37.77, currentLng: -122.41 } }),
            );
            expect(mockTo).toHaveBeenCalledWith('customer:cust-user-1');
            expect(mockEmit).toHaveBeenCalledWith(
                'driver:location',
                expect.objectContaining({ deliveryId: 'del-1', lat: 37.77, lng: -122.41 }),
            );
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true });
        });

        it('emits only to customer room, not restaurant', async () => {
            prismaMock.$transaction.mockImplementation(async (fn: any) => fn(prismaMock));
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1', userId: 'user-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                driverId: 'dp-1',
                status: 'IN_TRANSIT',
                order: { customer: { userId: 'cust-user-1' } },
            } as any);
            prismaMock.driverProfile.update.mockResolvedValueOnce({} as any);

            await updateLocation(req, res);

            expect(mockTo).toHaveBeenCalledTimes(1);
            expect(mockTo).toHaveBeenCalledWith('customer:cust-user-1');
        });
    });

    // ─── getDriverLocation ────────────────────────────────────────────────────

    describe('getDriverLocation', () => {
        beforeEach(() => {
            req = {
                user: { id: 'user-1', role: 'CUSTOMER' },
                params: { id: 'del-1' },
            };
        });

        it('throws 401 if unauthenticated', async () => {
            req.user = undefined;
            await expect(getDriverLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if customer profile not found', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce(null);
            await expect(getDriverLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 404 if delivery not found', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'cp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce(null);
            await expect(getDriverLocation(req, res)).rejects.toThrow(AppError);
        });

        it('throws 403 if customer does not own delivery', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'cp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                order: { customerId: 'cp-other' },
                driver: { currentLat: 37.77, currentLng: -122.41 },
            } as any);
            const err = await getDriverLocation(req, res).catch((e) => e);
            expect(err).toBeInstanceOf(AppError);
            expect((err as AppError).statusCode).toBe(403);
        });

        it('throws 400 if delivery is COMPLETED', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'cp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                status: 'COMPLETED',
                order: { customerId: 'cp-1' },
                driver: { currentLat: 37.77, currentLng: -122.41 },
            } as any);
            const err = await getDriverLocation(req, res).catch((e) => e);
            expect(err).toBeInstanceOf(AppError);
            expect((err as AppError).statusCode).toBe(400);
        });

        it('returns lat/lng when driver has sent location', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'cp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                order: { customerId: 'cp-1' },
                driver: { currentLat: 37.77, currentLng: -122.41 },
            } as any);

            await getDriverLocation(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({
                success: true,
                data: { deliveryId: 'del-1', lat: 37.77, lng: -122.41 },
            });
        });

        it('returns null lat/lng when driver has not sent location yet', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'cp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                order: { customerId: 'cp-1' },
                driver: { currentLat: null, currentLng: null },
            } as any);

            await getDriverLocation(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({
                success: true,
                data: { deliveryId: 'del-1', lat: null, lng: null },
            });
        });

        it('queries delivery with correct include shape', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'cp-1' } as any);
            prismaMock.delivery.findUnique.mockResolvedValueOnce({
                id: 'del-1',
                order: { customerId: 'cp-1' },
                driver: { currentLat: 37.77, currentLng: -122.41 },
            } as any);

            await getDriverLocation(req, res);

            expect(prismaMock.delivery.findUnique).toHaveBeenCalledWith(
                expect.objectContaining({
                    where: { id: 'del-1' },
                    include: expect.objectContaining({
                        order: expect.anything(),
                        driver: expect.anything(),
                    }),
                }),
            );
        });
    });

    // ─── getActiveDelivery ────────────────────────────────────────────────────

    describe('getActiveDelivery', () => {
        beforeEach(() => {
            req = { user: { id: 'user-1', role: 'DRIVER' } };
        });

        it('returns null if no active delivery', async () => {
            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.delivery.findFirst.mockResolvedValueOnce(null);

            await getActiveDelivery(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: null });
        });

        it('returns active delivery with correct query filter', async () => {
            const mockDelivery = {
                id: 'del-1',
                status: 'ASSIGNED',
                order: {
                    restaurant: { id: 'rest-1', name: 'Pizza Place', address: '123 Main St' },
                    customer: { userId: 'cu-1' },
                    orderItems: [],
                },
            };

            prismaMock.driverProfile.findUnique.mockResolvedValueOnce({ id: 'dp-1' } as any);
            prismaMock.delivery.findFirst.mockResolvedValueOnce(mockDelivery as any);

            await getActiveDelivery(req, res);

            expect(prismaMock.delivery.findFirst).toHaveBeenCalledWith(
                expect.objectContaining({
                    where: expect.objectContaining({
                        driverId: 'dp-1',
                        status: { not: 'COMPLETED' },
                    }),
                }),
            );
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: mockDelivery });
        });
    });
});
