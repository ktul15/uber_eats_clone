import { Router } from 'express';
import { authenticate, requireRole } from '../middlewares/auth.middleware';
import { acceptDelivery, updateDeliveryStatus, getActiveDelivery } from '../controllers/delivery.controller';

const router = Router();

router.use(authenticate, requireRole(['DRIVER']));

router.post('/accept', acceptDelivery);
router.get('/active', getActiveDelivery);
router.patch('/:id/status', updateDeliveryStatus);

export default router;
