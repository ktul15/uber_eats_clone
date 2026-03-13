import { Request, Response, NextFunction } from 'express';
import { AppError } from '../utils/AppError';

/**
 * Global error handler middleware.
 * Must be registered LAST in the Express middleware chain.
 * Catches all errors and returns a consistent JSON response.
 */
export const errorHandler = (
    err: Error,
    _req: Request,
    res: Response,
    _next: NextFunction
): void => {
    // Known application errors
    if (err instanceof AppError) {
        const errorBody: Record<string, unknown> = {
            code: err.code,
            message: err.message,
        };
        if (err.details) {
            errorBody.details = err.details;
        }
        res.status(err.statusCode).json({
            success: false,
            error: errorBody,
        });
        return;
    }

    // Prisma known request errors (e.g., unique constraint violation)
    if (err.constructor?.name === 'PrismaClientKnownRequestError') {
        const prismaErr = err as any;
        if (prismaErr.code === 'P2002') {
            res.status(409).json({
                success: false,
                error: {
                    code: 'CONFLICT',
                    message: `A record with this ${prismaErr.meta?.target?.join(', ') || 'field'} already exists`,
                },
            });
            return;
        }
    }

    // Prisma validation errors
    if (err.constructor?.name === 'PrismaClientValidationError') {
        res.status(400).json({
            success: false,
            error: {
                code: 'BAD_REQUEST',
                message: 'Invalid data provided',
            },
        });
        return;
    }

    // Unknown / unexpected errors — don't leak stack traces
    console.error('Unhandled Error:', err);
    res.status(500).json({
        success: false,
        error: {
            code: 'INTERNAL_ERROR',
            message: 'An unexpected error occurred',
        },
    });
};
