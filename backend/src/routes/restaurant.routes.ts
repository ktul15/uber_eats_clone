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

const router = Router();

// Public routes
router.get('/', asyncHandler(getAllRestaurants));
router.get('/:id', asyncHandler(getRestaurantById));

// Protected routes (OWNER only)
router.use(authenticate);
router.use(requireRole(['OWNER']));

router.get('/owner/my', asyncHandler(getMyRestaurants));
router.post('/', asyncHandler(createRestaurant));
router.put('/:id', asyncHandler(updateRestaurant));

export default router;
