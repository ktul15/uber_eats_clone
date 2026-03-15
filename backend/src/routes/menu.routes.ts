import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import { asyncHandler } from '../utils/asyncHandler';
import {
    addMenuItem,
    deleteMenuItem,
    getMenu,
    updateMenuItem
} from '../controllers/menu.controller';

// Note: This router will be mounted at /api/restaurants under the hood
// but conceptually it's /api/restaurants/:restaurantId/menu
const router = Router({ mergeParams: true });

// Public routes
router.get('/', asyncHandler(getMenu));

// Protected routes (OWNER only)
router.use(authenticate);
router.use(requireRole(['OWNER']));

router.post('/', asyncHandler(addMenuItem));
router.put('/:menuItemId', asyncHandler(updateMenuItem));
router.delete('/:menuItemId', asyncHandler(deleteMenuItem));

export default router;
