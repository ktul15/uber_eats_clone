import { Response } from 'express';
import { prisma } from '../utils/prisma';
import { AuthRequest } from '../types/auth.types';
import { AppError } from '../utils/AppError';

// CREATE RESTAURANT (OWNER only)
export const createRestaurant = async (req: AuthRequest, res: Response): Promise<void> => {
    const { name, description, address, lat, lng, imageUrl } = req.body;
    const ownerId = req.user?.id;

    if (!ownerId) throw AppError.unauthorized('User not found');
    if (typeof name !== 'string' || typeof address !== 'string') {
        throw AppError.badRequest('Name and address are required');
    }
    const restaurant = await prisma.restaurant.create({
        data: {
            ownerId,
            name: name.trim(),
            description: description?.trim() || null,
            address: address.trim(),
            lat,
            lng,
            imageUrl: imageUrl?.trim() || null,
            isActive: true, // Auto-active for now, can be toggled later
        },
    });

    res.status(201).json({
        success: true,
        data: restaurant,
    });
};

// GET MY RESTAURANTS (OWNER only)
export const getMyRestaurants = async (req: AuthRequest, res: Response): Promise<void> => {
    const ownerId = req.user?.id;
    if (!ownerId) throw AppError.unauthorized('User not found');

    const restaurants = await prisma.restaurant.findMany({
        where: { ownerId },
        include: { menuItems: true },
    });

    res.status(200).json({
        success: true,
        data: restaurants,
    });
};

// UPDATE RESTAURANT (OWNER only)
export const updateRestaurant = async (req: AuthRequest, res: Response): Promise<void> => {
    const id = req.params.id as string;
    const isActive = req.body.isActive as boolean | undefined;
    const name = req.body.name as string | undefined;
    const description = req.body.description as string | null | undefined;
    const address = req.body.address as string | undefined;
    const lat = req.body.lat as number | null | undefined;
    const lng = req.body.lng as number | null | undefined;
    const imageUrl = req.body.imageUrl as string | null | undefined;
    const ownerId = req.user?.id;

    const restaurant = await prisma.restaurant.findUnique({ where: { id } });

    if (!restaurant) throw AppError.notFound('Restaurant not found');
    if (restaurant.ownerId !== ownerId) throw AppError.forbidden('You do not own this restaurant');

    const updatedRestaurant = await prisma.restaurant.update({
        where: { id },
        data: {
            name: name !== undefined ? name : restaurant.name,
            description: description !== undefined ? description : restaurant.description,
            address: address !== undefined ? address : restaurant.address,
            lat: lat !== undefined ? lat : restaurant.lat,
            lng: lng !== undefined ? lng : restaurant.lng,
            imageUrl: imageUrl !== undefined ? imageUrl : restaurant.imageUrl,
            isActive: isActive !== undefined ? isActive : restaurant.isActive,
        },
    });

    res.status(200).json({
        success: true,
        data: updatedRestaurant,
    });
};

// GET ALL RESTAURANTS (Public) — optional ?search= for name filtering
export const getAllRestaurants = async (req: AuthRequest, res: Response): Promise<void> => {
    const search = req.query.search as string | undefined;

    const restaurants = await prisma.restaurant.findMany({
        where: {
            isActive: true,
            ...(search?.trim().length
                ? { name: { contains: search.trim(), mode: 'insensitive' } }
                : {}),
        },
    });

    res.status(200).json({
        success: true,
        data: restaurants,
    });
};

// GET RESTAURANT BY ID (Public)
export const getRestaurantById = async (req: AuthRequest, res: Response): Promise<void> => {
    const id = req.params.id as string;

    const restaurant = await prisma.restaurant.findUnique({
        where: { id },
        include: { menuItems: true },
    });

    if (!restaurant) throw AppError.notFound('Restaurant not found');

    res.status(200).json({
        success: true,
        data: restaurant,
    });
};
