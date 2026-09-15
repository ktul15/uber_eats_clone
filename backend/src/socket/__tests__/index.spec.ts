const mockFindMany = jest.fn();

jest.mock('../../utils/prisma', () => ({
    prisma: { restaurant: { findMany: mockFindMany } },
}));

import { filterAllowedRooms, joinAuthorizedRooms } from '../index';

describe('socket room authorization', () => {
    beforeEach(() => jest.clearAllMocks());

    it('allows only the exact authenticated customer room', async () => {
        await expect(filterAllowedRooms(
            { id: 'customer-user-1', role: 'CUSTOMER' },
            ['customer:customer-user-1', 'customer:other', 'driver:customer-user-1'],
        )).resolves.toEqual(['customer:customer-user-1']);
    });

    it('allows only the exact authenticated driver room', async () => {
        await expect(filterAllowedRooms(
            { id: 'driver-user-1', role: 'DRIVER' },
            ['driver:driver-user-1', 'driver:other', 'customer:driver-user-1'],
        )).resolves.toEqual(['driver:driver-user-1']);
    });

    it('checks every requested restaurant against owner identity', async () => {
        mockFindMany.mockResolvedValue([{ id: 'restaurant-1' }]);

        await expect(filterAllowedRooms(
            { id: 'owner-1', role: 'OWNER' },
            ['restaurant:restaurant-1', 'restaurant:restaurant-2'],
        )).resolves.toEqual(['restaurant:restaurant-1']);
        expect(mockFindMany).toHaveBeenCalledWith({
            where: {
                id: { in: ['restaurant-1', 'restaurant-2'] },
                ownerId: 'owner-1',
            },
            select: { id: true },
        });
    });

    it('acknowledges authorization failures without rejecting the listener', async () => {
        mockFindMany.mockRejectedValueOnce(new Error('database unavailable'));
        const acknowledge = jest.fn();
        const socket = { id: 'socket-1', join: jest.fn() };
        const consoleError = jest.spyOn(console, 'error').mockImplementation(() => undefined);
        try {
            await expect(joinAuthorizedRooms(
                socket as never,
                { id: 'owner-1', role: 'OWNER' },
                ['restaurant:restaurant-1'],
                acknowledge,
            )).resolves.toBeUndefined();
            expect(acknowledge).toHaveBeenCalledWith({
                joined: [], denied: ['restaurant:restaurant-1'], error: 'Unable to authorize rooms',
            });
            expect(socket.join).not.toHaveBeenCalled();
        } finally {
            consoleError.mockRestore();
        }
    });
});
