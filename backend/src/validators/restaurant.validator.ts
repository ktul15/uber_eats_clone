import { NextFunction, Request, Response } from 'express';
import { AppError } from '../utils/AppError';

export const validateCreateRestaurant = (
    req: Request,
    _res: Response,
    next: NextFunction,
): void => {
    const { name, description, address, lat, lng, imageUrl } = req.body as Record<string, unknown>;
    if (typeof name !== 'string' || name.trim().length < 2 || name.trim().length > 120) {
        throw AppError.badRequest('name must be between 2 and 120 characters');
    }
    if (typeof address !== 'string' || address.trim().length < 5 || address.trim().length > 500) {
        throw AppError.badRequest('address must be between 5 and 500 characters');
    }
    if (description !== undefined && (typeof description !== 'string' || description.length > 1000)) {
        throw AppError.badRequest('description must be at most 1000 characters');
    }
    if (
        typeof lat !== 'number' || !Number.isFinite(lat) || lat < -90 || lat > 90 ||
        typeof lng !== 'number' || !Number.isFinite(lng) || lng < -180 || lng > 180
    ) {
        throw AppError.badRequest('lat and lng must be valid coordinates');
    }
    if (imageUrl !== undefined && imageUrl !== null) {
        if (typeof imageUrl !== 'string' || imageUrl.length > 2048) {
            throw AppError.badRequest('imageUrl must be a valid URL');
        }
        try {
            const url = new URL(imageUrl);
            if (!['http:', 'https:'].includes(url.protocol)) throw new Error('unsupported protocol');
        } catch {
            throw AppError.badRequest('imageUrl must be a valid URL');
        }
    }
    next();
};
