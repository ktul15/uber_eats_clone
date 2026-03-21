import { Request, Response } from 'express';
import { AppError } from '../utils/AppError';
import multer from 'multer';
import path from 'path';

// Set Storage Engine
const storage = multer.diskStorage({
    destination: './uploads/',
    filename: (req: Request, file: Express.Multer.File, cb: (error: Error | null, filename: string) => void) => {
        cb(null, `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`);
    }
});

// Init Upload
export const upload = multer({
    storage: storage,
    limits: { fileSize: 5000000 }, // 5MB limit
    fileFilter: (req: Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
        checkFileType(file, cb);
    }
}).single('image');

// Check File Type
function checkFileType(file: Express.Multer.File, cb: multer.FileFilterCallback) {
    // Allowed ext
    const filetypes = /jpeg|jpg|png|gif/;
    // Check ext
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    // Check mime
    const mimetype = filetypes.test(file.mimetype);

    if (mimetype && extname) {
        return cb(null, true);
    } else {
        cb(new Error('Error: Images Only!'));
    }
}

export const uploadImage = (req: Request, res: Response) => {
    if (!req.file) {
        throw AppError.badRequest('No file uploaded');
    }

    const baseUrl = process.env.BASE_URL || `http://localhost:${process.env.PORT || 8000}`;
    const imageUrl = `${baseUrl}/uploads/${req.file.filename}`;

    res.status(200).json({
        success: true,
        data: {
            url: imageUrl,
        },
    });
};
