import { NextFunction, Request, Response } from 'express';
import { AppError } from '../utils/AppError';

export const REVIEW_COMMENT_MAX_LENGTH = 1000;

export const validateCreateOrderReview = (
    req: Request,
    _res: Response,
    next: NextFunction,
): void => {
    const { rating, comment } = req.body as { rating?: unknown; comment?: unknown };

    if (!Number.isInteger(rating) || (rating as number) < 1 || (rating as number) > 5) {
        throw AppError.badRequest('rating must be an integer between 1 and 5');
    }
    if (comment !== undefined && typeof comment !== 'string') {
        throw AppError.badRequest('comment must be a string');
    }
    if (typeof comment === 'string' && comment.length > REVIEW_COMMENT_MAX_LENGTH) {
        throw AppError.badRequest(`comment must be at most ${REVIEW_COMMENT_MAX_LENGTH} characters`);
    }

    next();
};
