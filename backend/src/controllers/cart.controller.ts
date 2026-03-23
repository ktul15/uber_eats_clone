import { Response } from 'express';
import { PrismaClient } from '@prisma/client';
import { AuthRequest } from '../types/auth.types';
import { AppError } from '../utils/AppError';

const prisma = new PrismaClient();

// HELPER: resolve CustomerProfile.id from JWT userId
const getCustomerProfileId = async (userId: string): Promise<string> => {
    const profile = await prisma.customerProfile.findUnique({ where: { userId } });
    if (!profile) throw AppError.notFound('Customer profile not found');
    return profile.id;
};

// GET /api/cart
export const getCart = async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const customerId = await getCustomerProfileId(userId);

    const cart = await prisma.cart.findUnique({
        where: { customerId },
        include: {
            restaurant: true,
            items: { include: { menuItem: true } },
        },
    });

    res.status(200).json({ success: true, data: cart ?? null });
};

// POST /api/cart/items  — body: { menuItemId: string, quantity: number }
export const addItemToCart = async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const { menuItemId, quantity } = req.body as { menuItemId?: string; quantity?: number };

    if (!menuItemId) throw AppError.badRequest('menuItemId is required');
    if (quantity === undefined || quantity === null) throw AppError.badRequest('quantity is required');
    if (!Number.isInteger(quantity) || quantity < 1) {
        throw AppError.badRequest('quantity must be a positive integer');
    }

    const customerId = await getCustomerProfileId(userId);

    const menuItem = await prisma.menuItem.findUnique({ where: { id: menuItemId } });
    if (!menuItem) throw AppError.notFound('Menu item not found');
    if (!menuItem.isAvailable) throw AppError.badRequest('Menu item is not currently available');

    const existingCart = await prisma.cart.findUnique({ where: { customerId } });

    if (existingCart && existingCart.restaurantId !== menuItem.restaurantId) {
        throw AppError.conflict(
            'Your cart contains items from a different restaurant. Clear your cart before adding items from a new restaurant.',
        );
    }

    if (!existingCart) {
        // Create cart + first item atomically
        const cart = await prisma.$transaction(async (tx) => {
            const newCart = await tx.cart.create({
                data: { customerId, restaurantId: menuItem.restaurantId },
            });
            await tx.cartItem.create({
                data: { cartId: newCart.id, menuItemId, quantity },
            });
            return tx.cart.findUnique({
                where: { id: newCart.id },
                include: { restaurant: true, items: { include: { menuItem: true } } },
            });
        });
        res.status(201).json({ success: true, data: cart });
        return;
    }

    // Cart exists for the same restaurant — upsert the item
    const existingItem = await prisma.cartItem.findFirst({
        where: { cartId: existingCart.id, menuItemId },
    });

    if (existingItem) {
        await prisma.cartItem.update({
            where: { id: existingItem.id },
            data: { quantity: existingItem.quantity + quantity },
        });
    } else {
        await prisma.cartItem.create({
            data: { cartId: existingCart.id, menuItemId, quantity },
        });
    }

    const updatedCart = await prisma.cart.findUnique({
        where: { customerId },
        include: { restaurant: true, items: { include: { menuItem: true } } },
    });

    res.status(200).json({ success: true, data: updatedCart });
};

// PUT /api/cart/items/:cartItemId  — body: { quantity: number }
export const updateCartItem = async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const cartItemId = req.params.cartItemId as string;
    const { quantity } = req.body as { quantity?: number };

    if (quantity === undefined || quantity === null) throw AppError.badRequest('quantity is required');
    if (!Number.isInteger(quantity) || quantity < 0) {
        throw AppError.badRequest('quantity must be a non-negative integer');
    }

    const customerId = await getCustomerProfileId(userId);

    const cart = await prisma.cart.findUnique({ where: { customerId } });
    if (!cart) throw AppError.notFound('Cart not found');

    const cartItem = await prisma.cartItem.findUnique({ where: { id: cartItemId } });
    if (!cartItem || cartItem.cartId !== cart.id) throw AppError.notFound('Cart item not found');

    if (quantity === 0) {
        await prisma.cartItem.delete({ where: { id: cartItemId } });
        const remaining = await prisma.cartItem.count({ where: { cartId: cart.id } });
        if (remaining === 0) {
            await prisma.cart.delete({ where: { id: cart.id } });
            res.status(200).json({ success: true, data: null });
            return;
        }
    } else {
        await prisma.cartItem.update({ where: { id: cartItemId }, data: { quantity } });
    }

    const updatedCart = await prisma.cart.findUnique({
        where: { customerId },
        include: { restaurant: true, items: { include: { menuItem: true } } },
    });

    res.status(200).json({ success: true, data: updatedCart ?? null });
};

// DELETE /api/cart/items/:cartItemId
export const removeCartItem = async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const cartItemId = req.params.cartItemId as string;
    const customerId = await getCustomerProfileId(userId);

    const cart = await prisma.cart.findUnique({ where: { customerId } });
    if (!cart) throw AppError.notFound('Cart not found');

    const cartItem = await prisma.cartItem.findUnique({ where: { id: cartItemId } });
    if (!cartItem || cartItem.cartId !== cart.id) throw AppError.notFound('Cart item not found');

    await prisma.cartItem.delete({ where: { id: cartItemId } });

    const remaining = await prisma.cartItem.count({ where: { cartId: cart.id } });
    if (remaining === 0) {
        await prisma.cart.delete({ where: { id: cart.id } });
        res.status(200).json({ success: true, data: null });
        return;
    }

    const updatedCart = await prisma.cart.findUnique({
        where: { customerId },
        include: { restaurant: true, items: { include: { menuItem: true } } },
    });

    res.status(200).json({ success: true, data: updatedCart });
};

// DELETE /api/cart
export const clearCart = async (req: AuthRequest, res: Response): Promise<void> => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('Not authenticated');

    const customerId = await getCustomerProfileId(userId);

    const cart = await prisma.cart.findUnique({ where: { customerId } });
    if (!cart) throw AppError.notFound('Cart not found');

    await prisma.cart.delete({ where: { id: cart.id } });

    res.status(200).json({ success: true, data: null });
};
