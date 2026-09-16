import { Router } from 'express';
import { getProfile, updateProfile, registerFcmToken, removeFcmToken } from '../controllers/user.controller';
import { authenticate } from '../middlewares/auth.middleware';

const router = Router();

// Require auth for all profile routes
router.use(authenticate);

router.get('/profile', getProfile);
router.put('/profile', updateProfile);
router.patch('/fcm-token', registerFcmToken);
router.delete('/fcm-token', removeFcmToken);

export default router;
