import { randomUUID } from 'crypto';
import { NextFunction, Request, Response } from 'express';

export function requestLogger(req: Request, res: Response, next: NextFunction): void {
    const startedAt = process.hrtime.bigint();
    const incomingRequestId = req.header('x-request-id');
    const requestId = incomingRequestId?.trim() || randomUUID();

    res.setHeader('X-Request-Id', requestId);
    res.once('finish', () => {
        const durationMs = Number(process.hrtime.bigint() - startedAt) / 1_000_000;
        console.info(JSON.stringify({
            event: 'http.request',
            requestId,
            method: req.method,
            path: req.path,
            status: res.statusCode,
            durationMs: Number(durationMs.toFixed(2)),
            railwayReplicaId: process.env.RAILWAY_REPLICA_ID,
            railwayRegion: process.env.RAILWAY_REPLICA_REGION,
            railwayDeploymentId: process.env.RAILWAY_DEPLOYMENT_ID,
        }));
    });

    next();
}
