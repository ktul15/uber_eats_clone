import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import { asyncHandler } from '../utils/asyncHandler';
import {
    createRestaurant,
    getAllRestaurants,
    getMyRestaurants,
    getRestaurantById,
    updateRestaurant
} from '../controllers/restaurant.controller';
import { validateCreateRestaurant } from '../validators/restaurant.validator';

const router = Router();

// Public routes
router.get('/', asyncHandler(getAllRestaurants));

// Protected routes (OWNER only)
router.get('/owner/my', authenticate, requireRole(['OWNER']), asyncHandler(getMyRestaurants));
router.post('/', authenticate, requireRole(['OWNER']), validateCreateRestaurant, asyncHandler(createRestaurant));
router.put('/:id', authenticate, requireRole(['OWNER']), asyncHandler(updateRestaurant));
router.get('/:id', asyncHandler(getRestaurantById));

export default router;
