import { getDatabasePoolConfig, isStagingEnvironment, validateRuntimeEnvironment } from '../environment';

const validStagingEnvironment: NodeJS.ProcessEnv = {
    APP_ENV: 'staging',
    DATABASE_URL: 'postgresql://user:password@db/railway',
    JWT_SECRET: 'a-secure-random-secret-with-32-bytes',
    BASE_URL: 'https://api.example.com',
    ALLOWED_ORIGINS: 'https://app.example.com',
    STRIPE_SECRET_KEY: 'sk_test_example',
};

describe('runtime environment validation', () => {
    it('detects a Railway staging environment', () => {
        expect(isStagingEnvironment({ RAILWAY_ENVIRONMENT_NAME: 'Staging' })).toBe(true);
    });

    it('does not require deployment secrets for local development', () => {
        expect(() => validateRuntimeEnvironment({ APP_ENV: 'development' })).not.toThrow();
    });

    it('accepts a complete staging configuration', () => {
        expect(() => validateRuntimeEnvironment(validStagingEnvironment)).not.toThrow();
    });

    it('lists missing staging configuration', () => {
        expect(() => validateRuntimeEnvironment({ APP_ENV: 'staging' }))
            .toThrow('Missing required staging environment variables: DATABASE_URL, JWT_SECRET, BASE_URL, ALLOWED_ORIGINS, STRIPE_SECRET_KEY');
    });

    it('rejects live or malformed Stripe credentials in staging', () => {
        expect(() => validateRuntimeEnvironment({
            ...validStagingEnvironment,
            STRIPE_SECRET_KEY: 'sk_live_example',
        })).toThrow('STRIPE_SECRET_KEY must be a Stripe test-mode secret in staging');
    });

    it('rejects a staging JWT secret shorter than 32 bytes', () => {
        expect(() => validateRuntimeEnvironment({
            ...validStagingEnvironment,
            JWT_SECRET: 'too-short',
        })).toThrow('JWT_SECRET must be at least 32 bytes in staging');
    });

    it('accepts the minimum 32-byte JWT secret boundary', () => {
        expect(() => validateRuntimeEnvironment({
            ...validStagingEnvironment,
            JWT_SECRET: 'x'.repeat(32),
        })).not.toThrow();
    });

    it('returns bounded database pool settings', () => {
        expect(getDatabasePoolConfig({
            DATABASE_POOL_MAX: '20',
            DATABASE_CONNECTION_TIMEOUT_MS: '1000',
            DATABASE_IDLE_TIMEOUT_MS: '60000',
        })).toEqual({
            max: 20,
            connectionTimeoutMillis: 1000,
            idleTimeoutMillis: 60000,
        });
    });

    it.each([
        ['DATABASE_POOL_MAX', '0'],
        ['DATABASE_POOL_MAX', '10.5'],
        ['DATABASE_CONNECTION_TIMEOUT_MS', 'not-a-number'],
        ['DATABASE_IDLE_TIMEOUT_MS', '600001'],
    ])('rejects invalid %s values', (name, value) => {
        expect(() => validateRuntimeEnvironment({ [name]: value }))
            .toThrow(`${name} must be an integer`);
    });
});
