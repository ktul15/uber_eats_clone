import { CorsOptions } from 'cors';

const LOCAL_WEB_ORIGIN = 'http://localhost:3000';

export function getAllowedOrigins(env: NodeJS.ProcessEnv = process.env): string[] {
    const configured = env.ALLOWED_ORIGINS ?? env.CLIENT_URL ?? LOCAL_WEB_ORIGIN;
    return configured
        .split(',')
        .map((origin) => origin.trim())
        .filter(Boolean);
}

export function isOriginAllowed(origin: string | undefined, env: NodeJS.ProcessEnv = process.env): boolean {
    // Native mobile clients do not send an Origin header.
    return origin === undefined || getAllowedOrigins(env).includes(origin);
}

export function createCorsOptions(env: NodeJS.ProcessEnv = process.env): CorsOptions {
    return {
        origin(origin, callback) {
            if (isOriginAllowed(origin, env)) {
                callback(null, true);
                return;
            }
            callback(new Error('Origin is not allowed by CORS'));
        },
        credentials: true,
    };
}
