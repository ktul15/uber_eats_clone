import { Request, Response } from 'express';
import { prisma } from '../utils/prisma';
import { AppError } from '../utils/AppError';
import { asyncHandler } from '../utils/asyncHandler';
import { AuthRequest } from '../types/auth.types';

export const getProfile = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userRole = req.user?.role;
    const userId = req.user?.id;

    if (!userRole || !userId) {
        throw AppError.unauthorized('User not authenticated');
    }

    const user = await prisma.user.findUnique({
        where: { id: userId },
        include: {
            customerProfile: userRole === 'CUSTOMER',
            driverProfile: userRole === 'DRIVER',
            ownerProfile: userRole === 'OWNER',
        },
    });

    if (!user) {
        throw AppError.notFound('User not found');
    }

    let profileData: any = {};
    if (userRole === 'CUSTOMER' && user.customerProfile) {
        profileData = user.customerProfile;
    } else if (userRole === 'DRIVER' && user.driverProfile) {
        profileData = user.driverProfile;
    } else if (userRole === 'OWNER' && user.ownerProfile) {
        profileData = user.ownerProfile;
    }

    res.status(200).json({
        success: true,
        data: {
            id: user.id,
            email: user.email,
            phone: user.phone,
            role: user.role,
            profile: profileData,
            createdAt: user.createdAt,
        },
    });
});

export const registerFcmToken = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('User not authenticated');

    const { fcmToken } = req.body;
    if (!fcmToken || typeof fcmToken !== 'string' || fcmToken.trim() === '') {
        throw AppError.badRequest('fcmToken is required');
    }

    await prisma.user.update({
        where: { id: userId },
        data: { fcmToken: fcmToken.trim() },
    });

    res.status(200).json({ success: true, data: { message: 'FCM token registered' } });
});

export const removeFcmToken = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user?.id;
    if (!userId) throw AppError.unauthorized('User not authenticated');

    const { fcmToken } = req.body as { fcmToken?: unknown };
    if (typeof fcmToken !== 'string' || fcmToken.trim() === '') {
        throw AppError.badRequest('fcmToken is required');
    }

    const result = await prisma.user.updateMany({
        where: { id: userId, fcmToken: fcmToken.trim() },
        data: { fcmToken: null },
    });

    res.status(200).json({
        success: true,
        data: { removed: result.count === 1 },
    });
});

export const updateProfile = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userRole = req.user?.role;
    const userId = req.user?.id;
    const { phone, name, defaultAddress, vehicleType, licenseNumber } = req.body;

    if (!userRole || !userId) {
        throw AppError.unauthorized('User not authenticated');
    }

    // Update phone number on Base User if provided
    let phoneToUpdate = undefined;
    if (phone !== undefined) {
        if (phone === '') {
            phoneToUpdate = null; // Clear if empty string
        } else {
            phoneToUpdate = phone;
        }

        // Check for uniqueness if not null
        if (phoneToUpdate !== null) {
            const existingPhone = await prisma.user.findUnique({ where: { phone: phoneToUpdate } });
            if (existingPhone && existingPhone.id !== userId) {
                throw AppError.conflict('Phone number already in use');
            }
        }
    }

    const updatedUser = await prisma.$transaction(async (tx: any) => {
        // 1. Update User base
        if (phone !== undefined) {
            await tx.user.update({
                where: { id: userId },
                data: { phone: phoneToUpdate },
            });
        }

        // 2. Update Profile
        let updatedProfile = null;
        if (userRole === 'CUSTOMER') {
            updatedProfile = await tx.customerProfile.update({
                where: { userId },
                data: {
                    ...(name !== undefined && { name }),
                    ...(defaultAddress !== undefined && { defaultAddress: defaultAddress === '' ? null : defaultAddress }),
                },
            });
        } else if (userRole === 'DRIVER') {
            updatedProfile = await tx.driverProfile.update({
                where: { userId },
                data: {
                    ...(name !== undefined && { name }),
                    ...(vehicleType !== undefined && { vehicleType: vehicleType === '' ? null : vehicleType }),
                    ...(licenseNumber !== undefined && { licenseNumber: licenseNumber === '' ? null : licenseNumber }),
                },
            });
        } else if (userRole === 'OWNER') {
            updatedProfile = await tx.ownerProfile.update({
                where: { userId },
                data: {
                    ...(name !== undefined && { name }),
                },
            });
        }

        // Fetch completely mapped user
        return tx.user.findUnique({
            where: { id: userId },
            include: {
                customerProfile: userRole === 'CUSTOMER',
                driverProfile: userRole === 'DRIVER',
                ownerProfile: userRole === 'OWNER',
            },
        });
    });

    let profileData: any = {};
    if (userRole === 'CUSTOMER' && updatedUser.customerProfile) profileData = updatedUser.customerProfile;
    else if (userRole === 'DRIVER' && updatedUser.driverProfile) profileData = updatedUser.driverProfile;
    else if (userRole === 'OWNER' && updatedUser.ownerProfile) profileData = updatedUser.ownerProfile;

    res.status(200).json({
        success: true,
        data: {
            id: updatedUser.id,
            email: updatedUser.email,
            phone: updatedUser.phone,
            role: updatedUser.role,
            profile: profileData,
            createdAt: updatedUser.createdAt,
        },
    });
});
