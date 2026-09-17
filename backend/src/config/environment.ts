const STAGING_ENVIRONMENT = 'staging';

const databaseSettingRanges = {
    DATABASE_POOL_MAX: { defaultValue: 10, minimum: 1, maximum: 100 },
    DATABASE_CONNECTION_TIMEOUT_MS: { defaultValue: 5000, minimum: 100, maximum: 120000 },
    DATABASE_IDLE_TIMEOUT_MS: { defaultValue: 30000, minimum: 1000, maximum: 600000 },
} as const;

export type DatabasePoolConfig = {
    max: number;
    connectionTimeoutMillis: number;
    idleTimeoutMillis: number;
};

const requiredStagingVariables = [
    'DATABASE_URL',
    'JWT_SECRET',
    'BASE_URL',
    'ALLOWED_ORIGINS',
    'STRIPE_SECRET_KEY',
] as const;

export function isStagingEnvironment(env: NodeJS.ProcessEnv = process.env): boolean {
    return env.APP_ENV?.toLowerCase() === STAGING_ENVIRONMENT
        || env.RAILWAY_ENVIRONMENT_NAME?.toLowerCase() === STAGING_ENVIRONMENT;
}

function parseBoundedInteger(
    name: keyof typeof databaseSettingRanges,
    env: NodeJS.ProcessEnv,
): number {
    const { defaultValue, minimum, maximum } = databaseSettingRanges[name];
    const rawValue = env[name]?.trim();
    if (!rawValue) return defaultValue;

    const value = Number(rawValue);
    if (!Number.isInteger(value) || value < minimum || value > maximum) {
        throw new Error(`${name} must be an integer between ${minimum} and ${maximum}`);
    }
    return value;
}

export function getDatabasePoolConfig(env: NodeJS.ProcessEnv = process.env): DatabasePoolConfig {
    return {
        max: parseBoundedInteger('DATABASE_POOL_MAX', env),
        connectionTimeoutMillis: parseBoundedInteger('DATABASE_CONNECTION_TIMEOUT_MS', env),
        idleTimeoutMillis: parseBoundedInteger('DATABASE_IDLE_TIMEOUT_MS', env),
    };
}

export function validateRuntimeEnvironment(env: NodeJS.ProcessEnv = process.env): void {
    getDatabasePoolConfig(env);
    if (!isStagingEnvironment(env)) return;

    const missing = requiredStagingVariables.filter((name) => !env[name]?.trim());
    if (missing.length > 0) {
        throw new Error(`Missing required staging environment variables: ${missing.join(', ')}`);
    }

    if (!env.BASE_URL?.startsWith('https://')) {
        throw new Error('BASE_URL must use HTTPS in staging');
    }
    if (Buffer.byteLength(env.JWT_SECRET ?? '', 'utf8') < 32) {
        throw new Error('JWT_SECRET must be at least 32 bytes in staging');
    }
    if (!env.STRIPE_SECRET_KEY?.startsWith('sk_test_')) {
        throw new Error('STRIPE_SECRET_KEY must be a Stripe test-mode secret in staging');
    }
}
