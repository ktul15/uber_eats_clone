import { Router } from 'express';
import { upload, uploadImage } from '../controllers/upload.controller';
import { authenticate } from '../middlewares/auth.middleware';

const router = Router();

// Endpoint strictly expects a `multipart/form-data` payload 
// with the file attached under the 'image' key.
router.post(
    '/',
    authenticate,
    upload, // multer middleware parsing the 'image' key
    uploadImage
);

export default router;
