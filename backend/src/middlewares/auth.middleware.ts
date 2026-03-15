import { Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { AppError } from '../utils/AppError';
import { AuthRequest } from '../types/auth.types';

const JWT_SECRET = process.env.JWT_SECRET || 'super-secret-key-for-dev';

export const authenticate = (req: AuthRequest, _res: Response, next: NextFunction): void => {
    const authHeader = req.header('Authorization');

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        throw AppError.unauthorized('Access denied. No token provided or invalid format.');
    }

    const token = authHeader.replace('Bearer ', '');

    try {
        const decoded = jwt.verify(token, JWT_SECRET) as { id: string; role: string };
        req.user = decoded;
        next();
    } catch (error) {
        throw AppError.unauthorized('Invalid or expired token.');
    }
};

export const requireRole = (roles: string[]) => {
    return (req: AuthRequest, _res: Response, next: NextFunction): void => {
        if (!req.user || !roles.includes(req.user.role)) {
            throw AppError.forbidden(`Access denied. Requires one of these roles: ${roles.join(', ')}`);
        }
        next();
    };
};
