import { body, validationResult } from 'express-validator';
import { Request, Response, NextFunction } from 'express';
import { AppError } from '../utils/AppError';

/**
 * Middleware that checks express-validator results and throws
 * a structured AppError if validation failed.
 */
export const validate = (req: Request, _res: Response, next: NextFunction): void => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        const details = errors.array().map((err) => ({
            field: (err as any).path,
            message: err.msg,
        }));
        throw AppError.validation('Validation failed', details);
    }
    next();
};

// --- Register validation rules ---
export const registerRules = [
    body('email')
        .isEmail().withMessage('Must be a valid email address')
        .normalizeEmail(),
    body('password')
        .isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
    body('name')
        .trim()
        .notEmpty().withMessage('Name is required'),
    body('role')
        .isIn(['CUSTOMER', 'DRIVER', 'OWNER']).withMessage('Role must be CUSTOMER, DRIVER, or OWNER'),
];

// --- Login validation rules ---
export const loginRules = [
    body('email')
        .isEmail().withMessage('Must be a valid email address')
        .normalizeEmail(),
    body('password')
        .notEmpty().withMessage('Password is required'),
];
