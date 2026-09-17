jest.mock('../utils/prisma', () => ({
    prisma: { $disconnect: jest.fn() },
    pool: { end: jest.fn() },
}));

import { shutdownServer } from '../server';

describe('graceful shutdown', () => {
    it('closes Socket.IO, HTTP, Prisma, and the PostgreSQL pool', async () => {
        const closeHttp = jest.fn((callback: (error?: Error) => void) => callback());
        const closeSocket = jest.fn((callback: () => void) => callback());
        const disconnectPrisma = jest.fn().mockResolvedValue(undefined);
        const closePool = jest.fn().mockResolvedValue(undefined);

        await shutdownServer({
            httpServer: { close: closeHttp, listening: true } as never,
            socketServer: { close: closeSocket } as never,
            disconnectPrisma,
            closePool,
        });

        expect(closeSocket).toHaveBeenCalledTimes(1);
        expect(closeHttp).toHaveBeenCalledTimes(1);
        expect(disconnectPrisma).toHaveBeenCalledTimes(1);
        expect(closePool).toHaveBeenCalledTimes(1);
    });

    it('does not close HTTP twice when Socket.IO already stopped it', async () => {
        const httpServer = {
            listening: true,
            close: jest.fn((callback: (error?: Error) => void) => callback()),
        };
        const closeSocket = jest.fn((callback: () => void) => {
            httpServer.listening = false;
            callback();
        });

        await shutdownServer({
            httpServer: httpServer as never,
            socketServer: { close: closeSocket } as never,
            disconnectPrisma: jest.fn().mockResolvedValue(undefined),
            closePool: jest.fn().mockResolvedValue(undefined),
        });

        expect(httpServer.close).not.toHaveBeenCalled();
    });

    it('attempts every cleanup and reports partial failures', async () => {
        const disconnectPrisma = jest.fn().mockRejectedValue(new Error('Prisma failed'));
        const closePool = jest.fn().mockResolvedValue(undefined);

        await expect(shutdownServer({
            httpServer: {
                listening: true,
                close: jest.fn((callback: (error?: Error) => void) => callback(new Error('HTTP failed'))),
            } as never,
            socketServer: {
                close: jest.fn((callback: (error?: Error) => void) => callback(new Error('Socket failed'))),
            } as never,
            disconnectPrisma,
            closePool,
        })).rejects.toMatchObject({
            message: 'Server shutdown failed for 3 resource(s)',
            errors: expect.arrayContaining([
                expect.objectContaining({ message: 'Socket failed' }),
                expect.objectContaining({ message: 'HTTP failed' }),
                expect.objectContaining({ message: 'Prisma failed' }),
            ]),
        });
        expect(disconnectPrisma).toHaveBeenCalledTimes(1);
        expect(closePool).toHaveBeenCalledTimes(1);
    });

    it('bounds a cleanup operation that never settles', async () => {
        await expect(shutdownServer({
            httpServer: { listening: false, close: jest.fn() } as never,
            socketServer: { close: jest.fn(() => undefined) } as never,
            disconnectPrisma: jest.fn().mockResolvedValue(undefined),
            closePool: jest.fn().mockResolvedValue(undefined),
            timeoutMs: 5,
        })).rejects.toMatchObject({
            errors: expect.arrayContaining([
                expect.objectContaining({ message: expect.stringMatching(/^Socket.IO did not close within [1-5]ms$/) }),
            ]),
        });
    });
});
