import { AppError } from '../../utils/AppError';
import { promises as fs } from 'fs';
import os from 'os';
import path from 'path';
import express from 'express';
import { Server } from 'http';
import { checkFileType, hasValidImageSignature, safeUploadFilename, upload, uploadImage } from '../upload.controller';
import { getUploadDirectory } from '../../utils/uploads';

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

    it('writes and serves an uploaded image through the configured HTTP path', async () => {
        const directory = await fs.mkdtemp(path.join(os.tmpdir(), 'upload-http-test-'));
        const previousUploadDirectory = process.env.UPLOAD_DIR;
        const previousBaseUrl = process.env.BASE_URL;
        let server: Server | undefined;

        try {
            process.env.UPLOAD_DIR = directory;
            const app = express();
            app.post('/api/upload', upload, uploadImage);
            app.use('/uploads', express.static(getUploadDirectory()));
            server = await new Promise<Server>((resolve) => {
                const listeningServer = app.listen(0, '127.0.0.1', () => resolve(listeningServer));
            });
            const address = server.address();
            if (!address || typeof address === 'string') throw new Error('Expected an ephemeral TCP port');
            process.env.BASE_URL = `http://127.0.0.1:${address.port}`;

            const imageBytes = Buffer.from([0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a]);
            const form = new FormData();
            form.append('image', new Blob([imageBytes], { type: 'image/png' }), 'image.png');
            const uploadResponse = await fetch(`${process.env.BASE_URL}/api/upload`, {
                method: 'POST',
                body: form,
            });
            const payload = await uploadResponse.json() as { success: boolean; data: { url: string } };

            expect(uploadResponse.status).toBe(200);
            expect(payload.success).toBe(true);
            const staticResponse = await fetch(payload.data.url);
            expect(staticResponse.status).toBe(200);
            expect(Buffer.from(await staticResponse.arrayBuffer())).toEqual(imageBytes);
            await expect(fs.stat(path.join(directory, path.basename(payload.data.url))))
                .resolves.toMatchObject({ size: imageBytes.length });
        } finally {
            if (server?.listening) {
                await new Promise<void>((resolve, reject) => {
                    server?.close((error) => error ? reject(error) : resolve());
                });
            }
            if (previousUploadDirectory === undefined) delete process.env.UPLOAD_DIR;
            else process.env.UPLOAD_DIR = previousUploadDirectory;
            if (previousBaseUrl === undefined) delete process.env.BASE_URL;
            else process.env.BASE_URL = previousBaseUrl;
            await fs.rm(directory, { recursive: true, force: true });
        }
    });
});
