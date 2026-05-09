import { createOrderReview, getOrderById } from '../order.controller';
import { prisma } from '../../utils/prisma';
import { AppError } from '../../utils/AppError';

jest.mock('stripe', () => {
    return jest.fn().mockImplementation(() => ({
        paymentIntents: {
            create: jest.fn(),
            retrieve: jest.fn(),
        },
    }));
});

jest.mock('../../utils/prisma', () => ({
    prisma: {
        customerProfile: { findUnique: jest.fn() },
        order: { findUnique: jest.fn() },
        $transaction: jest.fn(),
    },
}));

jest.mock('../../socket/index', () => ({
    getIO: jest.fn(() => ({ to: jest.fn().mockReturnThis(), emit: jest.fn() })),
}));

jest.mock('../../utils/fcm', () => ({
    sendPushNotification: jest.fn(),
    sendPushNotificationToMany: jest.fn(),
}));

const prismaMock = prisma as jest.Mocked<typeof prisma>;

const flushPromises = () => new Promise<void>((resolve) => setImmediate(resolve));

describe('Order Controller', () => {
    let req: any;
    let res: any;
    let next: jest.Mock;

    beforeEach(() => {
        req = {
            params: { id: 'order-1' },
            body: { rating: 5, comment: 'Great food' },
            user: { id: 'user-1', role: 'CUSTOMER' },
        };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        next = jest.fn();
        jest.clearAllMocks();
    });

    describe('getOrderById', () => {
        it('returns an order for the owning customer', async () => {
            const order = {
                id: 'order-1',
                customerId: 'customer-1',
                restaurant: { ownerId: 'owner-1' },
            };
            prismaMock.order.findUnique.mockResolvedValueOnce(order as any);
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'customer-1' } as any);

            getOrderById(req, res, next);
            await flushPromises();

            expect(next).not.toHaveBeenCalled();
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: order });
        });

        it('rejects a customer accessing another customer order', async () => {
            prismaMock.order.findUnique.mockResolvedValueOnce({
                id: 'order-1',
                customerId: 'customer-2',
                restaurant: { ownerId: 'owner-1' },
            } as any);
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'customer-1' } as any);

            getOrderById(req, res, next);
            await flushPromises();

            expect(next).toHaveBeenCalledWith(expect.any(AppError));
        });

        it('returns an order for the owning restaurant owner', async () => {
            req.user = { id: 'owner-1', role: 'OWNER' };
            const order = {
                id: 'order-1',
                customerId: 'customer-1',
                restaurant: { ownerId: 'owner-1' },
            };
            prismaMock.order.findUnique.mockResolvedValueOnce(order as any);

            getOrderById(req, res, next);
            await flushPromises();

            expect(next).not.toHaveBeenCalled();
            expect(res.status).toHaveBeenCalledWith(200);
        });

        it('rejects an owner accessing another restaurant order', async () => {
            req.user = { id: 'owner-2', role: 'OWNER' };
            prismaMock.order.findUnique.mockResolvedValueOnce({
                id: 'order-1',
                customerId: 'customer-1',
                restaurant: { ownerId: 'owner-1' },
            } as any);

            getOrderById(req, res, next);
            await flushPromises();

            expect(next).toHaveBeenCalledWith(expect.any(AppError));
        });
    });

    describe('createOrderReview', () => {
        it('creates a review for a delivered customer order and updates restaurant rating', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'customer-1' } as any);

            const updatedOrder = { id: 'order-1', review: { id: 'review-1', rating: 5 } };
            const tx = {
                order: {
                    findUnique: jest.fn()
                        .mockResolvedValueOnce({
                            id: 'order-1',
                            customerId: 'customer-1',
                            restaurantId: 'restaurant-1',
                            status: 'DELIVERED',
                            review: null,
                        })
                        .mockResolvedValueOnce(updatedOrder),
                },
                review: {
                    create: jest.fn(),
                    aggregate: jest.fn().mockResolvedValue({ _avg: { rating: 4.5 } }),
                },
                restaurant: { update: jest.fn() },
            };
            prismaMock.$transaction.mockImplementationOnce((callback: any) => callback(tx));

            createOrderReview(req, res, next);
            await flushPromises();

            expect(next).not.toHaveBeenCalled();
            expect(tx.review.create).toHaveBeenCalledWith({
                data: {
                    orderId: 'order-1',
                    customerId: 'customer-1',
                    restaurantId: 'restaurant-1',
                    rating: 5,
                    comment: 'Great food',
                },
            });
            expect(tx.restaurant.update).toHaveBeenCalledWith({
                where: { id: 'restaurant-1' },
                data: { rating: 4.5 },
            });
            expect(res.status).toHaveBeenCalledWith(201);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: updatedOrder });
        });

        it('rejects invalid ratings', async () => {
            req.body = { rating: 6 };

            createOrderReview(req, res, next);
            await flushPromises();

            expect(next).toHaveBeenCalledWith(expect.any(AppError));
            expect(prismaMock.$transaction).not.toHaveBeenCalled();
        });

        it('rejects orders owned by another customer', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'customer-1' } as any);
            const tx = {
                order: {
                    findUnique: jest.fn().mockResolvedValueOnce({
                        id: 'order-1',
                        customerId: 'customer-2',
                        restaurantId: 'restaurant-1',
                        status: 'DELIVERED',
                        review: null,
                    }),
                },
            };
            prismaMock.$transaction.mockImplementationOnce((callback: any) => callback(tx));

            createOrderReview(req, res, next);
            await flushPromises();

            expect(next).toHaveBeenCalledWith(expect.any(AppError));
        });

        it('rejects non-delivered orders', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'customer-1' } as any);
            const tx = {
                order: {
                    findUnique: jest.fn().mockResolvedValueOnce({
                        id: 'order-1',
                        customerId: 'customer-1',
                        restaurantId: 'restaurant-1',
                        status: 'PREPARING',
                        review: null,
                    }),
                },
            };
            prismaMock.$transaction.mockImplementationOnce((callback: any) => callback(tx));

            createOrderReview(req, res, next);
            await flushPromises();

            expect(next).toHaveBeenCalledWith(expect.any(AppError));
        });

        it('rejects duplicate reviews', async () => {
            prismaMock.customerProfile.findUnique.mockResolvedValueOnce({ id: 'customer-1' } as any);
            const tx = {
                order: {
                    findUnique: jest.fn().mockResolvedValueOnce({
                        id: 'order-1',
                        customerId: 'customer-1',
                        restaurantId: 'restaurant-1',
                        status: 'DELIVERED',
                        review: { id: 'review-1' },
                    }),
                },
            };
            prismaMock.$transaction.mockImplementationOnce((callback: any) => callback(tx));

            createOrderReview(req, res, next);
            await flushPromises();

            expect(next).toHaveBeenCalledWith(expect.any(AppError));
        });
    });
});
