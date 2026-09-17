import path from 'path';
import { promises as fs } from 'fs';

export function getUploadDirectory(env: NodeJS.ProcessEnv = process.env): string {
    const configured = env.UPLOAD_DIR?.trim();
    if (configured) return path.resolve(configured);
    return path.resolve(__dirname, '../../uploads');
}

export async function ensureUploadDirectory(env: NodeJS.ProcessEnv = process.env): Promise<string> {
    const directory = getUploadDirectory(env);
    await fs.mkdir(directory, { recursive: true });
    return directory;
}
