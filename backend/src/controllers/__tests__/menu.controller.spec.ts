import { getMenu, addMenuItem, updateMenuItem, deleteMenuItem } from '../menu.controller';
import { AppError } from '../../utils/AppError';

// Mock dependencies
jest.mock('../../utils/prisma', () => ({
    prisma: {
        restaurant: {
            findUnique: jest.fn(),
        },
        menuItem: {
            create: jest.fn(),
            findUnique: jest.fn(),
            findMany: jest.fn(),
            update: jest.fn(),
            delete: jest.fn(),
        },
    },
}));

import { prisma as sharedPrisma } from '../../utils/prisma';

describe('Menu Controller', () => {
    let prisma: any;
    let req: any;
    let res: any;

    beforeEach(() => {
        prisma = sharedPrisma;
        req = {
            params: { restaurantId: 'rest-1', menuItemId: 'item-1' },
            body: {},
            user: { id: 'owner-1', role: 'OWNER' },
        };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        jest.clearAllMocks();
    });

    describe('getMenu', () => {
        it('returns 404 if restaurant does not exist', async () => {
            prisma.restaurant.findUnique.mockResolvedValueOnce(null);

            await expect(getMenu(req, res)).rejects.toThrow(AppError);
            expect(prisma.restaurant.findUnique).toHaveBeenCalledWith({ where: { id: 'rest-1' } });
        });

        it('returns menu items if restaurant exists', async () => {
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1' });
            prisma.menuItem.findMany.mockResolvedValueOnce([{ id: 'item-1', name: 'Burger' }]);

            await getMenu(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({
                success: true,
                data: [{ id: 'item-1', name: 'Burger' }],
            });
        });
    });

    describe('addMenuItem', () => {
        it('throws 401 if user is unauthenticated', async () => {
            req.user = undefined;
            await expect(addMenuItem(req, res)).rejects.toThrow(AppError);
        });

        it('throws 403 if user does not own restaurant', async () => {
            req.body = { name: 'Fries', price: 5 };
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1', ownerId: 'other-owner' });

            await expect(addMenuItem(req, res)).rejects.toThrow(AppError);
        });

        it('creates menu item if valid owner and data', async () => {
            req.body = { name: 'Fries', price: 5 };
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1', ownerId: 'owner-1' });
            prisma.menuItem.create.mockResolvedValueOnce({ id: 'new-item', name: 'Fries' });

            await addMenuItem(req, res);

            expect(prisma.menuItem.create).toHaveBeenCalledWith({
                data: expect.objectContaining({ name: 'Fries', price: 5, restaurantId: 'rest-1' }),
            });
            expect(res.status).toHaveBeenCalledWith(201);
        });
    });

    describe('deleteMenuItem', () => {
        it('throws 404 if menu item not found', async () => {
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1', ownerId: 'owner-1' });
            prisma.menuItem.findUnique.mockResolvedValueOnce(null);

            await expect(deleteMenuItem(req, res)).rejects.toThrow(AppError);
        });

        it('deletes menu item if valid request', async () => {
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1', ownerId: 'owner-1' });
            prisma.menuItem.findUnique.mockResolvedValueOnce({ id: 'item-1', restaurantId: 'rest-1' });

            await deleteMenuItem(req, res);

            expect(prisma.menuItem.delete).toHaveBeenCalledWith({ where: { id: 'item-1' } });
            expect(res.status).toHaveBeenCalledWith(200);
        });
    });
});
