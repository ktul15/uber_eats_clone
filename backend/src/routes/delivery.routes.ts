import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import {
    acceptDelivery,
    updateAvailability,
    updateDeliveryStatus,
    getActiveDelivery,
    updateLocation,
    getDriverLocation,
    getDeliveryForOrder,
} from '../controllers/delivery.controller';

const router = Router();

router.use(authenticate);

router.post('/accept', requireRole(['DRIVER']), acceptDelivery);
router.get('/active', requireRole(['DRIVER']), getActiveDelivery);
router.patch('/availability', requireRole(['DRIVER']), updateAvailability);
router.get('/order/:orderId', requireRole(['CUSTOMER']), getDeliveryForOrder);
router.patch('/:id/status', requireRole(['DRIVER']), updateDeliveryStatus);
router.patch('/:id/location', requireRole(['DRIVER']), updateLocation);
router.get('/:id/driver-location', requireRole(['CUSTOMER']), getDriverLocation);

export default router;
