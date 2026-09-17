import 'dotenv/config';

import { createServer } from 'http';
import { validateRuntimeEnvironment } from './config/environment';
import { initFirebase } from './utils/firebase';
import { ensureUploadDirectory } from './utils/uploads';

export async function startServer(): Promise<void> {
    validateRuntimeEnvironment();
    await ensureUploadDirectory();
    initFirebase();

    // Load modules that initialize external clients only after configuration
    // validation has produced an actionable startup error.
    const [{ createApp }, { initSocket }, { shutdownServer }] = await Promise.all([
        import('./app'),
        import('./socket'),
        import('./server'),
    ]);

    const app = createApp();
    const httpServer = createServer(app);
    const socketServer = initSocket(httpServer);
    const port = Number(process.env.PORT ?? 8000);
    let shuttingDown = false;

    const shutdown = async (signal: NodeJS.Signals) => {
        if (shuttingDown) return;
        shuttingDown = true;
        console.info(JSON.stringify({ event: 'server.shutdown_started', signal }));
        try {
            await shutdownServer({ httpServer, socketServer });
            console.info(JSON.stringify({ event: 'server.shutdown_complete', signal }));
            process.exitCode = 0;
        } catch (error) {
            console.error(JSON.stringify({
                event: 'server.shutdown_failed',
                signal,
                message: error instanceof Error ? error.message : 'Unknown shutdown error',
            }));
            // Cleanup has attempted every resource within a bounded deadline.
            // Exit explicitly because a timed-out transport may still hold an
            // active event-loop handle and Railway will otherwise send SIGKILL.
            process.exit(1);
        }
    };

    process.once('SIGTERM', () => void shutdown('SIGTERM'));
    process.once('SIGINT', () => void shutdown('SIGINT'));

    httpServer.listen(port, () => {
        console.info(JSON.stringify({
            event: 'server.started',
            port,
            railwayReplicaId: process.env.RAILWAY_REPLICA_ID,
            railwayRegion: process.env.RAILWAY_REPLICA_REGION,
        }));
    });
}

if (require.main === module) {
    void startServer().catch((error: unknown) => {
        console.error(JSON.stringify({
            event: 'server.startup_failed',
            message: error instanceof Error ? error.message : 'Unknown startup error',
        }));
        process.exitCode = 1;
    });
}
