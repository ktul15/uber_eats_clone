import { Socket } from 'socket.io';
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET ?? 'super-secret-key-for-dev';

interface JwtPayload {
    id: string;
    role: string;
    email?: string;
}

export function decodeToken(token: string): JwtPayload {
    return jwt.verify(token, JWT_SECRET) as JwtPayload;
}

export function verifySocketToken(socket: Socket, next: (err?: Error) => void): void {
    try {
        const auth = socket.handshake.auth as { token?: string };
        const header = socket.handshake.headers['authorization'] as string | undefined;
        const raw = auth.token ?? header?.replace('Bearer ', '') ?? '';

        if (!raw) return next(new Error('AUTH_MISSING_TOKEN'));

        socket.data.user = decodeToken(raw) as { id: string; role: string };
        next();
    } catch {
        next(new Error('AUTH_INVALID_TOKEN'));
    }
}
