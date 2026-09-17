import express, { Request, Response } from 'express';
import cors from 'cors';
import { createCorsOptions } from './config/cors';
import { errorHandler } from './middlewares/error.middleware';
import { requestLogger } from './middlewares/request-logger.middleware';
import authRoutes from './routes/auth.routes';
import userRoutes from './routes/user.routes';
import restaurantRoutes from './routes/restaurant.routes';
import menuRoutes from './routes/menu.routes';
import uploadRoutes from './routes/upload.routes';
import cartRoutes from './routes/cart.routes';
import orderRoutes from './routes/order.routes';
import deliveryRoutes from './routes/delivery.routes';
import { prisma } from './utils/prisma';
import { getUploadDirectory } from './utils/uploads';

export async function readinessHealth(_req: Request, res: Response): Promise<void> {
    try {
        await prisma.$queryRaw`SELECT 1`;
        res.status(200).json({
            success: true,
            data: { status: 'ok', message: 'Uber Eats Clone API is healthy' },
        });
    } catch (error) {
        console.error(JSON.stringify({
            event: 'health.database_unavailable',
            message: error instanceof Error ? error.message : 'Unknown database error',
        }));
        res.status(503).json({
            success: false,
            error: { code: 'SERVICE_UNAVAILABLE', message: 'Database is unavailable' },
        });
    }
}

export function createApp() {
    const app = express();

    if (process.env.RAILWAY_ENVIRONMENT_NAME) {
        app.set('trust proxy', Number(process.env.TRUST_PROXY_HOPS ?? 1));
    }

    app.use(requestLogger);
    app.use(cors(createCorsOptions()));
    app.use(express.json());

    app.use('/api/auth', authRoutes);
    app.use('/api/users', userRoutes);
    app.use('/api/restaurants', restaurantRoutes);
    app.use('/api/upload', uploadRoutes);
    app.use('/api/cart', cartRoutes);
    app.use('/api/orders', orderRoutes);
    app.use('/api/deliveries', deliveryRoutes);
    app.use('/api/restaurants/:restaurantId/menu', menuRoutes);

    app.use('/uploads', express.static(getUploadDirectory(), {
        setHeaders: (res) => res.setHeader('X-Content-Type-Options', 'nosniff'),
    }));

    app.get('/health', readinessHealth);

    app.use(errorHandler);
    return app;
}
