import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import { acceptDelivery, updateDeliveryStatus, getActiveDelivery, updateLocation } from '../controllers/delivery.controller';

const router = Router();

router.use(authenticate, requireRole(['DRIVER']));

router.post('/accept', acceptDelivery);
router.get('/active', getActiveDelivery);
router.patch('/:id/status', updateDeliveryStatus);
router.patch('/:id/location', updateLocation);

export default router;
