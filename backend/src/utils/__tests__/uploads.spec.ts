import { promises as fs } from 'fs';
import os from 'os';
import path from 'path';
import { ensureUploadDirectory, getUploadDirectory } from '../uploads';

describe('upload directory configuration', () => {
    it('resolves the local default to backend/uploads', () => {
        expect(getUploadDirectory({})).toBe(path.resolve(__dirname, '../../../uploads'));
    });

    it('creates a configured upload directory', async () => {
        const parent = await fs.mkdtemp(path.join(os.tmpdir(), 'configured-upload-test-'));
        const configured = path.join(parent, 'nested', 'uploads');
        try {
            await expect(ensureUploadDirectory({ UPLOAD_DIR: configured })).resolves.toBe(configured);
            await expect(fs.stat(configured)).resolves.toMatchObject({});
        } finally {
            await fs.rm(parent, { recursive: true, force: true });
        }
    });
});
