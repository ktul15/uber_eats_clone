import { createRestaurant, getMyRestaurants, updateRestaurant, getAllRestaurants, getRestaurantById } from '../restaurant.controller';
import { PrismaClient } from '@prisma/client';
import { AppError } from '../../utils/AppError';

// Mock dependencies
jest.mock('@prisma/client', () => {
    const mPrismaClient = {
        restaurant: {
            create: jest.fn(),
            findMany: jest.fn(),
            findUnique: jest.fn(),
            update: jest.fn(),
        },
    };
    return { PrismaClient: jest.fn(() => mPrismaClient) };
});

describe('Restaurant Controller', () => {
    let prisma: any;
    let req: any;
    let res: any;

    beforeEach(() => {
        prisma = new PrismaClient();
        req = {
            params: { id: 'rest-1' },
            body: {},
            user: { id: 'owner-1', role: 'OWNER' },
        };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        jest.clearAllMocks();
    });

    describe('createRestaurant', () => {
        it('creates a restaurant with valid data', async () => {
            req.body = { name: 'My Rest', address: '123 Main St' };
            prisma.restaurant.create.mockResolvedValueOnce({ id: 'new-rest', name: 'My Rest' });

            await createRestaurant(req, res);

            expect(prisma.restaurant.create).toHaveBeenCalledWith({
                data: expect.objectContaining({ name: 'My Rest', ownerId: 'owner-1', isActive: true }),
            });
            expect(res.status).toHaveBeenCalledWith(201);
        });

        it('throws error if missing required fields', async () => {
            req.body = { name: 'My Rest' }; // missing address
            await expect(createRestaurant(req, res)).rejects.toThrow(AppError);
        });
    });

    describe('getMyRestaurants', () => {
        it('returns restaurants for the logged-in owner', async () => {
            prisma.restaurant.findMany.mockResolvedValueOnce([{ id: 'rest-1', name: 'Owner Rest' }]);

            await getMyRestaurants(req, res);

            expect(prisma.restaurant.findMany).toHaveBeenCalledWith({
                where: { ownerId: 'owner-1' },
                include: { menuItems: true },
            });
            expect(res.json).toHaveBeenCalledWith(expect.objectContaining({ success: true, data: expect.any(Array) }));
        });
    });

    describe('updateRestaurant', () => {
        it('throws 403 if user does not own restaurant', async () => {
            req.body = { name: 'New Name' };
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1', ownerId: 'other-owner' });

            await expect(updateRestaurant(req, res)).rejects.toThrow(AppError);
        });

        it('updates restaurant if user is the owner', async () => {
            req.body = { name: 'New Name' };
            prisma.restaurant.findUnique.mockResolvedValueOnce({ id: 'rest-1', ownerId: 'owner-1' });
            prisma.restaurant.update.mockResolvedValueOnce({ id: 'rest-1', name: 'New Name' });

            await updateRestaurant(req, res);

            expect(prisma.restaurant.update).toHaveBeenCalledWith({
                where: { id: 'rest-1' },
                data: expect.objectContaining({ name: 'New Name' }),
            });
            expect(res.status).toHaveBeenCalledWith(200);
        });
    });
});
