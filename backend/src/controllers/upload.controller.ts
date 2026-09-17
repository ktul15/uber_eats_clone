import { Request, Response } from 'express';
import { AppError } from '../utils/AppError';
import multer from 'multer';
import path from 'path';
import { randomUUID } from 'crypto';
import { promises as fs } from 'fs';
import { getUploadDirectory } from '../utils/uploads';

// Set Storage Engine
const storage = multer.diskStorage({
    destination: (_req, _file, cb) => cb(null, getUploadDirectory()),
    filename: (req: Request, file: Express.Multer.File, cb: (error: Error | null, filename: string) => void) => {
        cb(null, safeUploadFilename(file.mimetype));
    }
});

// Init Upload
export const upload = multer({
    storage: storage,
    limits: { fileSize: 5 * 1024 * 1024 },
    fileFilter: (req: Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
        checkFileType(file, cb);
    }
}).single('image');

// Check File Type
export function safeUploadFilename(mimetype: string): string {
    const extensions: Record<string, string> = {
        'image/jpeg': '.jpg',
        'image/png': '.png',
        'image/gif': '.gif',
    };
    return `image-${randomUUID()}${extensions[mimetype] ?? ''}`;
}

export function checkFileType(file: Express.Multer.File, cb: multer.FileFilterCallback) {
    const allowedMimeTypes = new Set(['image/jpeg', 'image/png', 'image/gif']);
    const allowedExtensions = new Set(['.jpeg', '.jpg', '.png', '.gif']);
    const extname = allowedExtensions.has(path.extname(path.basename(file.originalname)).toLowerCase());
    const mimetype = allowedMimeTypes.has(file.mimetype.toLowerCase());

    if (mimetype && extname) {
        return cb(null, true);
    } else {
        cb(AppError.badRequest('Only JPEG, PNG, and GIF images are allowed'));
    }
}

export async function hasValidImageSignature(filePath: string, mimetype: string): Promise<boolean> {
    const handle = await fs.open(filePath, 'r');
    try {
        const buffer = Buffer.alloc(12);
        const { bytesRead } = await handle.read(buffer, 0, buffer.length, 0);
        const bytes = buffer.subarray(0, bytesRead);
        if (mimetype === 'image/jpeg') return bytes.length >= 3 && bytes[0] === 0xff && bytes[1] === 0xd8 && bytes[2] === 0xff;
        if (mimetype === 'image/png') {
            return bytes.length >= 8 && bytes.subarray(0, 8).equals(Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]));
        }
        if (mimetype === 'image/gif') {
            const header = bytes.subarray(0, 6).toString('ascii');
            return header === 'GIF87a' || header === 'GIF89a';
        }
        return false;
    } finally {
        await handle.close();
    }
}

export const uploadImage = async (req: Request, res: Response): Promise<void> => {
    if (!req.file) {
        throw AppError.badRequest('No file uploaded');
    }

    if (!await hasValidImageSignature(req.file.path, req.file.mimetype)) {
        await fs.unlink(req.file.path).catch(() => undefined);
        throw AppError.badRequest('Uploaded content does not match its declared image type');
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
