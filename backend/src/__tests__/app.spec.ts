const queryRaw = jest.fn();

jest.mock('../utils/prisma', () => ({
    prisma: { $queryRaw: queryRaw },
}));
jest.mock('stripe', () => jest.fn(() => ({ paymentIntents: {} })));

import { readinessHealth } from '../app';
import { requestLogger } from '../middlewares/request-logger.middleware';

describe('application readiness and request logging', () => {
    let consoleInfo: jest.SpyInstance;
    let consoleError: jest.SpyInstance;
    let response: any;

    beforeEach(() => {
        consoleInfo = jest.spyOn(console, 'info').mockImplementation(() => undefined);
        consoleError = jest.spyOn(console, 'error').mockImplementation(() => undefined);
        response = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
            setHeader: jest.fn(),
            once: jest.fn(),
            statusCode: 200,
        };
    });

    afterEach(() => {
        consoleInfo.mockRestore();
        consoleError.mockRestore();
    });

    it('returns the success envelope when PostgreSQL is ready', async () => {
        queryRaw.mockResolvedValueOnce([{ '?column?': 1 }]);
        await readinessHealth({} as never, response);

        expect(response.status).toHaveBeenCalledWith(200);
        expect(response.json).toHaveBeenCalledWith({
            success: true,
            data: { status: 'ok', message: 'Uber Eats Clone API is healthy' },
        });
    });

    it('returns the standard 503 envelope when PostgreSQL is unavailable', async () => {
        queryRaw.mockRejectedValueOnce(new Error('connection refused'));
        await readinessHealth({} as never, response);

        expect(response.status).toHaveBeenCalledWith(503);
        expect(response.json).toHaveBeenCalledWith({
            success: false,
            error: { code: 'SERVICE_UNAVAILABLE', message: 'Database is unavailable' },
        });
    });

    it('logs request metadata without headers or bodies', () => {
        let finish: (() => void) | undefined;
        response.once.mockImplementation((event: string, callback: () => void) => {
            if (event === 'finish') finish = callback;
        });
        const request = {
            header: jest.fn().mockReturnValue('request-123'),
            method: 'POST',
            path: '/api/orders',
            originalUrl: '/api/orders?token=query-secret',
            headers: { authorization: 'Bearer secret' },
            body: { password: 'secret' },
        };

        requestLogger(request as never, response, jest.fn());
        finish?.();

        const log = consoleInfo.mock.calls[0]?.[0] as string;
        expect(log).toContain('"requestId":"request-123"');
        expect(log).toContain('"path":"/api/orders"');
        expect(log).not.toContain('Bearer secret');
        expect(log).not.toContain('password');
        expect(log).not.toContain('query-secret');
    });
});
