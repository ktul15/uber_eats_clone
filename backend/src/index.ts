import express, { Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { errorHandler } from './middlewares/error.middleware';

dotenv.config();

const app = express();
const port = process.env.PORT || 8000;

import authRoutes from './routes/auth.routes';
import userRoutes from './routes/user.routes';
import restaurantRoutes from './routes/restaurant.routes';
import menuRoutes from './routes/menu.routes';

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/restaurants', restaurantRoutes);
// We mount menuRoutes under a specific restaurant ID route
app.use('/api/restaurants/:restaurantId/menu', menuRoutes);

app.get('/health', (req: Request, res: Response) => {
  res.status(200).json({ success: true, data: { status: 'ok', message: 'Uber Eats Clone API is healthy' } });
});

// Global Error Handler (must be LAST)
app.use(errorHandler);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
