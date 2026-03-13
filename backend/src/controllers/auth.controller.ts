import { Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { Role } from '@prisma/client';
import { prisma } from '../utils/prisma';
import { AppError } from '../utils/AppError';
import { asyncHandler } from '../utils/asyncHandler';

const JWT_SECRET = process.env.JWT_SECRET || 'super-secret-key-for-dev';

export const register = asyncHandler(async (req: Request, res: Response): Promise<void> => {
    const { email, password, role, name, phone } = req.body;

    // Check if user exists
    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) {
        throw AppError.conflict('User with this email already exists');
    }

    // Hash Password
    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(password, salt);

    // Create User & Corresponding Profile using Prisma Transactions
    const newUser = await prisma.$transaction(async (tx: any) => {
        const user = await tx.user.create({
            data: {
                email,
                phone,
                passwordHash,
                role: role as Role,
            },
        });

        if (role === 'CUSTOMER') {
            await tx.customerProfile.create({
                data: { userId: user.id, name },
            });
        } else if (role === 'DRIVER') {
            await tx.driverProfile.create({
                data: { userId: user.id, name },
            });
        }

        return user;
    });

    const token = jwt.sign(
        { id: newUser.id, role: newUser.role },
        JWT_SECRET,
        { expiresIn: '7d' }
    );

    res.status(201).json({
        success: true,
        data: {
            message: 'User registered successfully',
            token,
            user: {
                id: newUser.id,
                email: newUser.email,
                role: newUser.role,
            },
        },
    });
});

export const login = asyncHandler(async (req: Request, res: Response): Promise<void> => {
    const { email, password } = req.body;

    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) {
        throw AppError.unauthorized('Invalid credentials');
    }

    const isMatch = await bcrypt.compare(password, user.passwordHash);
    if (!isMatch) {
        throw AppError.unauthorized('Invalid credentials');
    }

    const token = jwt.sign(
        { id: user.id, role: user.role },
        JWT_SECRET,
        { expiresIn: '7d' }
    );

    res.status(200).json({
        success: true,
        data: {
            message: 'Logged in successfully',
            token,
            user: {
                id: user.id,
                email: user.email,
                role: user.role,
            },
        },
    });
});
