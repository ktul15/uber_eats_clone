import { AppError } from '../../utils/AppError';
import { promises as fs } from 'fs';
import os from 'os';
import path from 'path';
import { checkFileType, hasValidImageSignature, safeUploadFilename } from '../upload.controller';

describe('upload security', () => {
    it('generates a server-owned safe filename', () => {
        const name = safeUploadFilename('image/jpeg');
        expect(name).toMatch(/^image-[0-9a-f-]+\.jpg$/);
        expect(name).not.toContain('..');
    });

    it('requires both an allowed MIME type and extension', () => {
        const callback = jest.fn();
        checkFileType({
            originalname: '../../payload.exe.jpg',
            mimetype: 'application/octet-stream',
        } as Express.Multer.File, callback);
        expect(callback).toHaveBeenCalledWith(expect.any(AppError));
    });

    it('accepts a matching supported image type', () => {
        const callback = jest.fn();
        checkFileType({ originalname: 'photo.PNG', mimetype: 'image/png' } as Express.Multer.File, callback);
        expect(callback).toHaveBeenCalledWith(null, true);
    });

    it('rejects spoofed image content despite a declared image MIME type', async () => {
        const directory = await fs.mkdtemp(path.join(os.tmpdir(), 'upload-test-'));
        const filePath = path.join(directory, 'spoof.png');
        try {
            await fs.writeFile(filePath, 'not an image');
            await expect(hasValidImageSignature(filePath, 'image/png')).resolves.toBe(false);
        } finally {
            await fs.rm(directory, { recursive: true, force: true });
        }
    });

    it('accepts a matching PNG signature', async () => {
        const directory = await fs.mkdtemp(path.join(os.tmpdir(), 'upload-test-'));
        const filePath = path.join(directory, 'image.png');
        try {
            await fs.writeFile(filePath, Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]));
            await expect(hasValidImageSignature(filePath, 'image/png')).resolves.toBe(true);
        } finally {
            await fs.rm(directory, { recursive: true, force: true });
        }
    });
});
