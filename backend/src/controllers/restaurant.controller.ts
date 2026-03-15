import { Response } from 'express';
import { PrismaClient } from '@prisma/client';
import { AuthRequest } from '../types/auth.types';
import { AppError } from '../utils/AppError';

const prisma = new PrismaClient();

// CREATE RESTAURANT (OWNER only)
export const createRestaurant = async (req: AuthRequest, res: Response): Promise<void> => {
    const { name, description, address, lat, lng } = req.body;
    const ownerId = req.user?.id;

    if (!ownerId) throw AppError.unauthorized('User not found');
    if (!name || !address) throw AppError.badRequest('Name and address are required');

    const restaurant = await prisma.restaurant.create({
        data: {
            ownerId,
            name,
            description,
            address,
            lat,
            lng,
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
            isActive: isActive !== undefined ? isActive : restaurant.isActive,
        },
    });

    res.status(200).json({
        success: true,
        data: updatedRestaurant,
    });
};

// GET ALL RESTAURANTS (Public)
export const getAllRestaurants = async (_req: AuthRequest, res: Response): Promise<void> => {
    const restaurants = await prisma.restaurant.findMany({
        where: { isActive: true },
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
