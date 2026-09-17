import { createCorsOptions, getAllowedOrigins, isOriginAllowed } from '../cors';

describe('CORS configuration', () => {
    const env = { ALLOWED_ORIGINS: 'https://one.example, https://two.example ' };

    it('parses configured origins', () => {
        expect(getAllowedOrigins(env)).toEqual(['https://one.example', 'https://two.example']);
    });

    it('allows configured web origins and origin-less mobile requests', () => {
        expect(isOriginAllowed('https://one.example', env)).toBe(true);
        expect(isOriginAllowed(undefined, env)).toBe(true);
        expect(isOriginAllowed('https://attacker.example', env)).toBe(false);
    });

    it('passes only allowed origins to the CORS callback', () => {
        const origin = createCorsOptions(env).origin;
        expect(typeof origin).toBe('function');
        const callback = jest.fn();
        (origin as Function)('https://attacker.example', callback);
        expect(callback).toHaveBeenCalledWith(expect.any(Error));
    });
});
