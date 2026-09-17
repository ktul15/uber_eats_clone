import { Server as HttpServer } from 'http';
import { Server as SocketServer } from 'socket.io';
import { pool, prisma } from './utils/prisma';

export type ShutdownDependencies = {
    httpServer: Pick<HttpServer, 'close' | 'listening'>;
    socketServer: Pick<SocketServer, 'close'>;
    disconnectPrisma?: () => Promise<void>;
    closePool?: () => Promise<void>;
    timeoutMs?: number;
};

const DEFAULT_SHUTDOWN_TIMEOUT_MS = 10000;

function closeHttpServer(httpServer: Pick<HttpServer, 'close'>): Promise<void> {
    return new Promise((resolve, reject) => {
        httpServer.close((error?: Error) => error ? reject(error) : resolve());
    });
}

function closeSocketServer(socketServer: Pick<SocketServer, 'close'>): Promise<void> {
    return new Promise((resolve, reject) => {
        socketServer.close((error?: Error) => error ? reject(error) : resolve());
    });
}

function withTimeout(operation: Promise<void>, label: string, timeoutMs: number): Promise<void> {
    return new Promise((resolve, reject) => {
        const timeout = setTimeout(
            () => reject(new Error(`${label} did not close within ${timeoutMs}ms`)),
            timeoutMs,
        );
        operation.then(
            () => {
                clearTimeout(timeout);
                resolve();
            },
            (error: unknown) => {
                clearTimeout(timeout);
                reject(error);
            },
        );
    });
}

export async function shutdownServer(dependencies: ShutdownDependencies): Promise<void> {
    const timeoutMs = dependencies.timeoutMs ?? DEFAULT_SHUTDOWN_TIMEOUT_MS;
    const deadline = Date.now() + timeoutMs;
    const errors: Error[] = [];
    const attempt = async (label: string, operation: () => Promise<void>) => {
        try {
            const remainingMs = Math.max(1, deadline - Date.now());
            await withTimeout(operation(), label, remainingMs);
        } catch (error) {
            errors.push(error instanceof Error ? error : new Error(`${label} failed`));
        }
    };

    // Socket.IO normally closes its attached HTTP server. Only close HTTP
    // separately when it is still listening (or a test double cannot report it).
    await attempt('Socket.IO', () => closeSocketServer(dependencies.socketServer));
    if (dependencies.httpServer.listening !== false) {
        await attempt('HTTP server', () => closeHttpServer(dependencies.httpServer));
    }

    await Promise.all([
        attempt('Prisma', dependencies.disconnectPrisma ?? (() => prisma.$disconnect())),
        attempt('PostgreSQL pool', dependencies.closePool ?? (() => pool.end())),
    ]);

    if (errors.length > 0) {
        throw new AggregateError(errors, `Server shutdown failed for ${errors.length} resource(s)`);
    }
}
