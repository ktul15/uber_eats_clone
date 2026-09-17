const validateRuntimeEnvironment = jest.fn();
const ensureUploadDirectory = jest.fn().mockResolvedValue('/tmp/uploads');
const initFirebase = jest.fn();
const createApp = jest.fn().mockReturnValue((_request: unknown, response: { end: () => void }) => response.end());
const initSocket = jest.fn().mockReturnValue({ close: jest.fn() });
const shutdownServer = jest.fn().mockResolvedValue(undefined);
const listen = jest.fn((_port: number, callback: () => void) => callback());
const createServer = jest.fn().mockReturnValue({ listen });

jest.mock('../config/environment', () => ({ validateRuntimeEnvironment }));
jest.mock('../utils/uploads', () => ({ ensureUploadDirectory }));
jest.mock('../utils/firebase', () => ({ initFirebase }));
jest.mock('../app', () => ({ createApp }));
jest.mock('../socket', () => ({ initSocket }));
jest.mock('../server', () => ({ shutdownServer }));
jest.mock('http', () => ({ createServer }));

import { startServer } from '../index';

describe('server startup and signals', () => {
    let processOnce: jest.SpyInstance;
    let processExit: jest.SpyInstance;
    let signalHandlers: Partial<Record<NodeJS.Signals, () => void>>;
    const originalExitCode = process.exitCode;

    beforeEach(() => {
        signalHandlers = {};
        processOnce = jest.spyOn(process, 'once').mockImplementation(((signal: NodeJS.Signals, listener: () => void) => {
            signalHandlers[signal] = listener;
            return process;
        }) as typeof process.once);
        processExit = jest.spyOn(process, 'exit').mockImplementation((() => undefined as never));
        jest.spyOn(console, 'info').mockImplementation(() => undefined);
        jest.spyOn(console, 'error').mockImplementation(() => undefined);
        process.exitCode = undefined;
    });

    afterEach(() => {
        processOnce.mockRestore();
        processExit.mockRestore();
        jest.restoreAllMocks();
        process.exitCode = originalExitCode;
    });

    it('validates configuration and prepares uploads before loading runtime clients', async () => {
        await startServer();

        expect(validateRuntimeEnvironment).toHaveBeenCalledTimes(1);
        expect(ensureUploadDirectory).toHaveBeenCalledTimes(1);
        expect(initFirebase).toHaveBeenCalledTimes(1);
        expect(createApp).toHaveBeenCalledTimes(1);
        expect(validateRuntimeEnvironment.mock.invocationCallOrder[0])
            .toBeLessThan(ensureUploadDirectory.mock.invocationCallOrder[0] as number);
        expect(ensureUploadDirectory.mock.invocationCallOrder[0])
            .toBeLessThan(initFirebase.mock.invocationCallOrder[0] as number);
        expect(initFirebase.mock.invocationCallOrder[0])
            .toBeLessThan(createApp.mock.invocationCallOrder[0] as number);

        signalHandlers.SIGTERM?.();
        await Promise.resolve();
    });

    it('runs shutdown once when process signals race', async () => {
        await startServer();

        signalHandlers.SIGTERM?.();
        signalHandlers.SIGINT?.();
        await Promise.resolve();
        await Promise.resolve();

        expect(shutdownServer).toHaveBeenCalledTimes(1);
        expect(process.exitCode).toBe(0);
    });

    it('exits nonzero when graceful shutdown cannot close every resource', async () => {
        shutdownServer.mockRejectedValueOnce(new Error('cleanup timed out'));
        await startServer();

        signalHandlers.SIGTERM?.();
        await Promise.resolve();
        await Promise.resolve();

        expect(processExit).toHaveBeenCalledWith(1);
    });
});
