const mockUpdateMany = jest.fn();

jest.mock('../../utils/asyncHandler', () => ({ asyncHandler: (fn: unknown) => fn }));
jest.mock('../../utils/prisma', () => ({
    prisma: { user: { updateMany: mockUpdateMany } },
}));

import { removeFcmToken } from '../user.controller';

describe('removeFcmToken', () => {
    const response = () => ({ status: jest.fn().mockReturnThis(), json: jest.fn() });

    beforeEach(() => jest.clearAllMocks());

    it('clears only a token matching the authenticated user and device', async () => {
        mockUpdateMany.mockResolvedValue({ count: 1 });
        const res = response();

        await removeFcmToken({
            user: { id: 'user-1' },
            body: { fcmToken: ' device-token ' },
        } as never, res as never);

        expect(mockUpdateMany).toHaveBeenCalledWith({
            where: { id: 'user-1', fcmToken: 'device-token' },
            data: { fcmToken: null },
        });
        expect(res.json).toHaveBeenCalledWith({
            success: true,
            data: { removed: true },
        });
    });
});
