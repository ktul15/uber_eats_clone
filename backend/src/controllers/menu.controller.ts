import { Response } from 'express';
import { AuthRequest } from '../types/auth.types';
import { AppError } from '../utils/AppError';
import { prisma } from '../utils/prisma';

// HELPER: Verify Restaurant Ownership
const verifyRestaurantOwnership = async (restaurantId: string, userId: string) => {
    const restaurant = await prisma.restaurant.findUnique({ where: { id: restaurantId } });
    if (!restaurant) throw AppError.notFound('Restaurant not found');
    if (restaurant.ownerId !== userId) throw AppError.forbidden('You do not own this restaurant');
    return restaurant;
};

// ADD MENU ITEM (OWNER only)
export const addMenuItem = async (req: AuthRequest, res: Response): Promise<void> => {
    const restaurantId = req.params.restaurantId as string;
    const { name, description, price, imageUrl, isAvailable } = req.body;
    const ownerId = req.user?.id;

    if (!ownerId) throw AppError.unauthorized('User not found');
    if (!name || price === undefined) throw AppError.badRequest('Name and price are required');

    await verifyRestaurantOwnership(restaurantId, ownerId);

    const nameStr = name as string;
    const descStr = description as string | null;
    const imgUrlStr = imageUrl as string | null;
    const availBool = isAvailable as boolean | undefined;

    const menuItem = await prisma.menuItem.create({
        data: {
            restaurantId,
            name: nameStr,
            description: descStr,
            price,
            imageUrl: imgUrlStr,
            isAvailable: availBool ?? true,
        },
    });

    res.status(201).json({
        success: true,
        data: menuItem,
    });
};

// UPDATE MENU ITEM (OWNER only)
export const updateMenuItem = async (req: AuthRequest, res: Response): Promise<void> => {
    const restaurantId = req.params.restaurantId as string;
    const menuItemId = req.params.menuItemId as string;
    const { name, description, price, imageUrl, isAvailable } = req.body;
    const ownerId = req.user?.id;

    if (!ownerId) throw AppError.unauthorized('User not found');

    await verifyRestaurantOwnership(restaurantId, ownerId);

    const existingMenuItem = await prisma.menuItem.findUnique({ where: { id: menuItemId } });
    if (!existingMenuItem || existingMenuItem.restaurantId !== restaurantId) {
        throw AppError.notFound('Menu item not found in this restaurant');
    }

    const nameStr = name as string | undefined;
    const descStr = description as string | null;
    const imgUrlStr = imageUrl as string | null;
    const availBool = isAvailable as boolean | undefined;

    const updatedMenuItem = await prisma.menuItem.update({
        where: { id: menuItemId },
        data: {
            name: nameStr ?? existingMenuItem.name,
            description: descStr !== undefined ? descStr : existingMenuItem.description,
            price: price ?? existingMenuItem.price,
            imageUrl: imgUrlStr !== undefined ? imgUrlStr : existingMenuItem.imageUrl,
            isAvailable: availBool ?? existingMenuItem.isAvailable,
        },
    });

    res.status(200).json({
        success: true,
        data: updatedMenuItem,
    });
};

// DELETE MENU ITEM (OWNER only)
export const deleteMenuItem = async (req: AuthRequest, res: Response): Promise<void> => {
    const restaurantId = req.params.restaurantId as string;
    const menuItemId = req.params.menuItemId as string;
    const ownerId = req.user?.id;

    if (!ownerId) throw AppError.unauthorized('User not found');

    await verifyRestaurantOwnership(restaurantId, ownerId);

    const existingMenuItem = await prisma.menuItem.findUnique({ where: { id: menuItemId } });
    if (!existingMenuItem || existingMenuItem.restaurantId !== restaurantId) {
        throw AppError.notFound('Menu item not found in this restaurant');
    }

    await prisma.menuItem.delete({ where: { id: menuItemId } });

    res.status(200).json({
        success: true,
        message: 'Menu item deleted successfully',
    });
};

// GET MENU (Public)
export const getMenu = async (req: AuthRequest, res: Response): Promise<void> => {
    const restaurantId = req.params.restaurantId as string;

    // Verify restaurant exists
    const restaurant = await prisma.restaurant.findUnique({ where: { id: restaurantId } });
    if (!restaurant) throw AppError.notFound('Restaurant not found');

    const menuItems = await prisma.menuItem.findMany({
        where: { restaurantId },
    });

    res.status(200).json({
        success: true,
        data: menuItems,
    });
};
