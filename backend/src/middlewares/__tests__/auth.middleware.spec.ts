import { Response, NextFunction } from 'express';
import { authenticate } from '../auth.middleware';
import { AuthRequest } from '../../types/auth.types';
import { AppError } from '../../utils/AppError';
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

    it('should throw AppError 401 if no Authorization header is present', () => {
        (mockReq.header as jest.Mock).mockReturnValue(undefined);

        expect(() => {
            authenticate(mockReq as AuthRequest, mockRes as Response, mockNext);
        }).toThrow(AppError);

        expect(mockNext).not.toHaveBeenCalled();
    });

    it('should throw AppError 401 if token is invalid or expired', () => {
        (mockReq.header as jest.Mock).mockReturnValue('Bearer invalid_token');
        (jwt.verify as jest.Mock).mockImplementation(() => {
            throw new Error('Invalid token');
        });

        expect(() => {
            authenticate(mockReq as AuthRequest, mockRes as Response, mockNext);
        }).toThrow(AppError);

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
