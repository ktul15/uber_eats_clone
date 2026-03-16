import { Request, Response, NextFunction } from 'express';

type AsyncRouteHandler = (req: Request, res: Response, next: NextFunction) => Promise<void>;

/**
 * Wraps async route handlers to automatically catch errors
 * and forward them to the Express error handler via next().
 * Eliminates the need for try/catch blocks in every controller.
 */
export const asyncHandler = (fn: AsyncRouteHandler) => {
    return (req: Request, res: Response, next: NextFunction): void => {
        Promise.resolve(fn(req, res, next)).catch(next);
    };
};
