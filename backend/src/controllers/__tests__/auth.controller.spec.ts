import { Request, Response, NextFunction } from 'express';
import { prismaMock } from '../../__mocks__/prisma';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { register, login } from '../auth.controller';
import { Role } from '@prisma/client';
import { AppError } from '../../utils/AppError';

jest.mock('bcryptjs');
jest.mock('jsonwebtoken');

describe('Auth Controller', () => {
    let mockReq: Partial<Request>;
    let mockRes: Partial<Response>;
    let mockNext: jest.Mock;

    beforeEach(() => {
        mockRes = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        mockNext = jest.fn();
        jest.clearAllMocks();
    });

    describe('register', () => {
        it('should pass 409 AppError to next() if user already exists', async () => {
            mockReq = {
                body: { email: 'test@example.com', password: 'pass123', role: 'CUSTOMER', name: 'John Doe' },
            };

            prismaMock.user.findUnique.mockResolvedValueOnce({ id: '1', email: 'test@example.com' } as any);

            // asyncHandler catches the thrown AppError and passes it to next()
            await new Promise<void>((resolve) => {
                mockNext = jest.fn(() => resolve());
                register(mockReq as Request, mockRes as Response, mockNext);
            });

            expect(mockNext).toHaveBeenCalledWith(expect.any(AppError));
            const error = mockNext.mock.calls[0][0] as AppError;
            expect(error.statusCode).toBe(409);
            expect(error.message).toBe('User with this email already exists');
        });

        it('should register a new customer successfully', async () => {
            mockReq = {
                body: { email: 'test@example.com', password: 'password', role: 'CUSTOMER', name: 'John Doe', phone: '1234567890' },
            };

            prismaMock.user.findUnique.mockResolvedValueOnce(null);
            (bcrypt.genSalt as jest.Mock).mockResolvedValue('salt');
            (bcrypt.hash as jest.Mock).mockResolvedValue('hashedPassword');

            const mockUser = {
                id: 'user123',
                email: 'test@example.com',
                role: 'CUSTOMER' as Role,
            };

            prismaMock.$transaction.mockResolvedValueOnce(mockUser as any);
            (jwt.sign as jest.Mock).mockReturnValue('mockJwtToken');

            // For success, the handler completes without calling next(err)
            await new Promise<void>((resolve) => {
                const originalJson = mockRes.json as jest.Mock;
                mockRes.json = jest.fn((...args) => {
                    originalJson(...args);
                    resolve();
                    return mockRes as Response;
                });
                register(mockReq as Request, mockRes as Response, mockNext);
            });

            expect(prismaMock.$transaction).toHaveBeenCalled();
            expect(mockRes.status).toHaveBeenCalledWith(201);
            expect(mockRes.json).toHaveBeenCalledWith({
                success: true,
                data: {
                    message: 'User registered successfully',
                    token: 'mockJwtToken',
                    user: { id: 'user123', email: 'test@example.com', role: 'CUSTOMER' },
                },
            });
        });
    });

    describe('login', () => {
        it('should pass 401 AppError to next() for invalid email', async () => {
            mockReq = { body: { email: 'wrong@example.com', password: 'pass' } };
            prismaMock.user.findUnique.mockResolvedValueOnce(null);

            await new Promise<void>((resolve) => {
                mockNext = jest.fn(() => resolve());
                login(mockReq as Request, mockRes as Response, mockNext);
            });

            expect(mockNext).toHaveBeenCalledWith(expect.any(AppError));
            const error = mockNext.mock.calls[0][0] as AppError;
            expect(error.statusCode).toBe(401);
            expect(error.message).toBe('Invalid credentials');
        });

        it('should pass 401 AppError to next() for wrong password', async () => {
            mockReq = { body: { email: 'test@example.com', password: 'wrong' } };
            prismaMock.user.findUnique.mockResolvedValueOnce({ passwordHash: 'hashedPass' } as any);
            (bcrypt.compare as jest.Mock).mockResolvedValueOnce(false);

            await new Promise<void>((resolve) => {
                mockNext = jest.fn(() => resolve());
                login(mockReq as Request, mockRes as Response, mockNext);
            });

            expect(mockNext).toHaveBeenCalledWith(expect.any(AppError));
            const error = mockNext.mock.calls[0][0] as AppError;
            expect(error.statusCode).toBe(401);
            expect(error.message).toBe('Invalid credentials');
        });

        it('should successfully log in and return a JWT', async () => {
            mockReq = { body: { email: 'test@example.com', password: 'correct' } };

            const mockUser = { id: 'user123', email: 'test@example.com', passwordHash: 'hashedPass', role: 'OWNER' as Role };
            prismaMock.user.findUnique.mockResolvedValueOnce(mockUser as any);
            (bcrypt.compare as jest.Mock).mockResolvedValueOnce(true);
            (jwt.sign as jest.Mock).mockReturnValue('mockJwtToken');

            await new Promise<void>((resolve) => {
                const originalJson = mockRes.json as jest.Mock;
                mockRes.json = jest.fn((...args) => {
                    originalJson(...args);
                    resolve();
                    return mockRes as Response;
                });
                login(mockReq as Request, mockRes as Response, mockNext);
            });

            expect(mockRes.status).toHaveBeenCalledWith(200);
            expect(mockRes.json).toHaveBeenCalledWith({
                success: true,
                data: {
                    message: 'Logged in successfully',
                    token: 'mockJwtToken',
                    user: { id: 'user123', email: 'test@example.com', role: 'OWNER' },
                },
            });
        });
    });
});
