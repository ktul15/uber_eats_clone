import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import { asyncHandler } from '../utils/asyncHandler';
import {
    getCart,
    addItemToCart,
    updateCartItem,
    removeCartItem,
    clearCart,
} from '../controllers/cart.controller';

const router = Router();

router.use(authenticate);
router.use(requireRole(['CUSTOMER']));

router.get('/', asyncHandler(getCart));
router.post('/items', asyncHandler(addItemToCart));
router.put('/items/:cartItemId', asyncHandler(updateCartItem));
router.delete('/items/:cartItemId', asyncHandler(removeCartItem));
router.delete('/', asyncHandler(clearCart));

export default router;
