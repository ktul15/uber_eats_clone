import { Request, Response } from 'express';
import { prismaMock } from '../../__mocks__/prisma';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { register, login } from '../auth.controller';
import { Role } from '@prisma/client';
import { describe } from 'node:test';

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
        it('should return 400 if required fields are missing', async () => {
            mockReq = { body: { email: 'test@test.com' } }; // missing password, role, name

            await register(mockReq as Request, mockRes as Response, mockNext);

            expect(mockRes.status).toHaveBeenCalledWith(400);
            expect(mockRes.json).toHaveBeenCalledWith({ error: 'Email, password, role, and name are required' });
        });

        it('should return 409 if user already exists', async () => {
            mockReq = {
                body: { email: 'test@example.com', password: 'pass', role: 'CUSTOMER', name: 'John Doe' },
            };

            prismaMock.user.findUnique.mockResolvedValueOnce({ id: '1', email: 'test@example.com' } as any);

            await register(mockReq as Request, mockRes as Response, mockNext);

            expect(mockRes.status).toHaveBeenCalledWith(409);
            expect(mockRes.json).toHaveBeenCalledWith({ error: 'User with this email already exists' });
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

            // Mock the transaction returning the user
            prismaMock.$transaction.mockResolvedValueOnce(mockUser as any);
            (jwt.sign as jest.Mock).mockReturnValue('mockJwtToken');

            await register(mockReq as Request, mockRes as Response, mockNext);

            expect(prismaMock.$transaction).toHaveBeenCalled();
            expect(mockRes.status).toHaveBeenCalledWith(201);
            expect(mockRes.json).toHaveBeenCalledWith({
                message: 'User registered successfully',
                token: 'mockJwtToken',
                user: { id: 'user123', email: 'test@example.com', role: 'CUSTOMER' },
            });
        });
    });

    describe('login', () => {
        it('should return 400 if email or password are missing', async () => {
            mockReq = { body: { email: 'test@test.com' } };

            await login(mockReq as Request, mockRes as Response, mockNext);

            expect(mockRes.status).toHaveBeenCalledWith(400);
            expect(mockRes.json).toHaveBeenCalledWith({ error: 'Email and password are required' });
        });

        it('should return 401 for invalid email', async () => {
            mockReq = { body: { email: 'wrong@example.com', password: 'pass' } };
            prismaMock.user.findUnique.mockResolvedValueOnce(null);

            await login(mockReq as Request, mockRes as Response, mockNext);

            expect(mockRes.status).toHaveBeenCalledWith(401);
            expect(mockRes.json).toHaveBeenCalledWith({ error: 'Invalid credentials' });
        });

        it('should return 401 for valid email but wrong password', async () => {
            mockReq = { body: { email: 'test@example.com', password: 'wrong' } };
            prismaMock.user.findUnique.mockResolvedValueOnce({ passwordHash: 'hashedPass' } as any);
            (bcrypt.compare as jest.Mock).mockResolvedValueOnce(false);

            await login(mockReq as Request, mockRes as Response, mockNext);

            expect(mockRes.status).toHaveBeenCalledWith(401);
            expect(mockRes.json).toHaveBeenCalledWith({ error: 'Invalid credentials' });
        });

        it('should successfully log in and return a JWT', async () => {
            mockReq = { body: { email: 'test@example.com', password: 'correct' } };

            const mockUser = { id: 'user123', email: 'test@example.com', passwordHash: 'hashedPass', role: 'OWNER' as Role };
            prismaMock.user.findUnique.mockResolvedValueOnce(mockUser as any);
            (bcrypt.compare as jest.Mock).mockResolvedValueOnce(true);
            (jwt.sign as jest.Mock).mockReturnValue('mockJwtToken');

            await login(mockReq as Request, mockRes as Response, mockNext);

            expect(mockRes.status).toHaveBeenCalledWith(200);
            expect(mockRes.json).toHaveBeenCalledWith({
                message: 'Logged in successfully',
                token: 'mockJwtToken',
                user: { id: 'user123', email: 'test@example.com', role: 'OWNER' },
            });
        });
    });
});
