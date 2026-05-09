import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import {
    createPaymentIntent,
    placeOrder,
    getOrders,
    getOrderById,
    updateOrderStatus,
    createOrderReview,
} from '../controllers/order.controller';

const router = Router();

// All order routes require authentication
router.use(authenticate);

// POST /api/orders/payment-intent  — Customer only
router.post('/payment-intent', requireRole(['CUSTOMER']), createPaymentIntent);

// POST /api/orders  — Customer only
router.post('/', requireRole(['CUSTOMER']), placeOrder);

// GET /api/orders  — Customer + Owner
router.get('/', requireRole(['CUSTOMER', 'OWNER']), getOrders);

// POST /api/orders/:id/review  — Customer only
router.post('/:id/review', requireRole(['CUSTOMER']), createOrderReview);

// GET /api/orders/:id
router.get('/:id', getOrderById);

router.patch('/:id/status', requireRole(['OWNER']), updateOrderStatus);

export default router;
