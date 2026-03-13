import { Router } from 'express';
import { register, login } from '../controllers/auth.controller';
import { registerRules, loginRules, validate } from '../validators/auth.validator';

const router = Router();

// /api/auth/register
router.post('/register', registerRules, validate, register);

// /api/auth/login
router.post('/login', loginRules, validate, login);

export default router;
