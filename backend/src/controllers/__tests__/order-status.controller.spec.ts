const mockPrisma = {
    order: {
        findUnique: jest.fn(),
        findUniqueOrThrow: jest.fn(),
        updateMany: jest.fn(),
    },
};
const mockEmit = jest.fn();
const mockTo = jest.fn(() => ({ emit: mockEmit }));

jest.mock('../../utils/prisma', () => ({ prisma: mockPrisma }));
jest.mock('../../utils/asyncHandler', () => ({ asyncHandler: (fn: unknown) => fn }));
jest.mock('../../socket/index', () => ({ getIO: () => ({ to: mockTo }) }));
jest.mock('../../utils/fcm', () => ({
    sendPushNotification: jest.fn(),
    sendPushNotificationToMany: jest.fn(),
}));
jest.mock('stripe', () => jest.fn().mockImplementation(() => ({ paymentIntents: {} })));

import { updateOrderStatus } from '../order.controller';

const res = () => ({ status: jest.fn().mockReturnThis(), json: jest.fn() });
const existing = {
    status: 'PENDING',
    restaurant: { ownerId: 'owner-1', name: 'R', lat: 1, lng: 1 },
    customer: { userId: 'customer-user-1', user: { fcmToken: null } },
};
const updated = {
    id: 'order-1', status: 'ACCEPTED', updatedAt: new Date(), restaurantId: 'restaurant-1',
    restaurant: { name: 'R' }, orderItems: [], deliveryAddress: '1 Main St', totalAmount: 10,
};

describe('atomic order status transitions', () => {
    beforeEach(() => jest.clearAllMocks());

    it('claims an allowed transition using the previously observed status', async () => {
        mockPrisma.order.findUnique.mockResolvedValueOnce(existing);
        mockPrisma.order.updateMany.mockResolvedValueOnce({ count: 1 });
        mockPrisma.order.findUniqueOrThrow.mockResolvedValueOnce(updated);
        const response = res();

        await updateOrderStatus({
            user: { id: 'owner-1' }, params: { id: 'order-1' }, body: { status: 'ACCEPTED' },
        } as never, response as never);

        expect(mockPrisma.order.updateMany).toHaveBeenCalledWith({
            where: { id: 'order-1', status: 'PENDING', restaurant: { ownerId: 'owner-1' } },
            data: { status: 'ACCEPTED' },
        });
        expect(response.status).toHaveBeenCalledWith(200);
    });

    it('rejects skipped or repeated transitions before updating', async () => {
        mockPrisma.order.findUnique.mockResolvedValueOnce(existing);
        await expect(updateOrderStatus({
            user: { id: 'owner-1' }, params: { id: 'order-1' }, body: { status: 'READY' },
        } as never, res() as never)).rejects.toMatchObject({ statusCode: 409 });
        expect(mockPrisma.order.updateMany).not.toHaveBeenCalled();
    });

    it('rejects a transition lost to a concurrent request without emitting', async () => {
        mockPrisma.order.findUnique.mockResolvedValueOnce(existing);
        mockPrisma.order.updateMany.mockResolvedValueOnce({ count: 0 });
        await expect(updateOrderStatus({
            user: { id: 'owner-1' }, params: { id: 'order-1' }, body: { status: 'ACCEPTED' },
        } as never, res() as never)).rejects.toMatchObject({ statusCode: 409 });
        expect(mockEmit).not.toHaveBeenCalled();
    });
});
