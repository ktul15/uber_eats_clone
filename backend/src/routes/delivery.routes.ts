import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import { acceptDelivery, updateDeliveryStatus, getActiveDelivery, updateLocation, getDriverLocation } from '../controllers/delivery.controller';

const router = Router();

router.use(authenticate);

router.post('/accept', requireRole(['DRIVER']), acceptDelivery);
router.get('/active', requireRole(['DRIVER']), getActiveDelivery);
router.patch('/:id/status', requireRole(['DRIVER']), updateDeliveryStatus);
router.patch('/:id/location', requireRole(['DRIVER']), updateLocation);
router.get('/:id/driver-location', requireRole(['CUSTOMER']), getDriverLocation);

export default router;
