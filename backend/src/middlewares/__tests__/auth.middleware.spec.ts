import { Request, Response, NextFunction } from 'express';
import { authenticate, AuthRequest } from '../auth.middleware';
import jwt from 'jsonwebtoken';

jest.mock('jsonwebtoken');

describe('Auth Middleware', () => {
    let mockReq: Partial<AuthRequest>;
    let mockRes: Partial<Response>;
    let mockNext: NextFunction;

    beforeEach(() => {
        mockReq = {
            header: jest.fn(),
        };
        mockRes = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        mockNext = jest.fn();
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    it('should return 401 if no Authorization header is present', () => {
        (mockReq.header as jest.Mock).mockReturnValue(undefined);

        authenticate(mockReq as AuthRequest, mockRes as Response, mockNext);

        expect(mockRes.status).toHaveBeenCalledWith(401);
        expect(mockRes.json).toHaveBeenCalledWith({ error: 'Access denied. No token provided.' });
        expect(mockNext).not.toHaveBeenCalled();
    });

    it('should return 400 if token is invalid or expired', () => {
        (mockReq.header as jest.Mock).mockReturnValue('Bearer invalid_token');
        (jwt.verify as jest.Mock).mockImplementation(() => {
            throw new Error('Invalid token');
        });

        authenticate(mockReq as AuthRequest, mockRes as Response, mockNext);

        expect(mockRes.status).toHaveBeenCalledWith(400);
        expect(mockRes.json).toHaveBeenCalledWith({ error: 'Invalid token.' });
        expect(mockNext).not.toHaveBeenCalled();
    });

    it('should attach user payload to request and call next() if token is valid', () => {
        const validToken = 'valid.jwt.token';
        const decodedPayload = { id: 'user123', role: 'CUSTOMER' };

        (mockReq.header as jest.Mock).mockReturnValue(`Bearer ${validToken}`);
        (jwt.verify as jest.Mock).mockReturnValue(decodedPayload);

        authenticate(mockReq as AuthRequest, mockRes as Response, mockNext);

        expect(jwt.verify).toHaveBeenCalledWith(validToken, expect.any(String));
        expect((mockReq as AuthRequest).user).toEqual(decodedPayload);
        expect(mockNext).toHaveBeenCalled();
    });
});
