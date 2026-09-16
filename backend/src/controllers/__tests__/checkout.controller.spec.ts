import { Prisma } from '@prisma/client';

const mockIntentCreate = jest.fn();
const mockIntentRetrieve = jest.fn();
const mockEmit = jest.fn();
const mockTo = jest.fn(() => ({ emit: mockEmit }));

jest.mock('stripe', () => jest.fn().mockImplementation(() => ({
    paymentIntents: { create: mockIntentCreate, retrieve: mockIntentRetrieve },
})));
jest.mock('../../utils/asyncHandler', () => ({ asyncHandler: (fn: unknown) => fn }));
jest.mock('../../socket/index', () => ({ getIO: () => ({ to: mockTo }) }));
jest.mock('../../utils/fcm', () => ({
    sendPushNotification: jest.fn(),
    sendPushNotificationToMany: jest.fn(),
}));

const mockPrisma = {
    customerProfile: { findUnique: jest.fn() },
    cart: { findUnique: jest.fn(), delete: jest.fn() },
    order: { findUnique: jest.fn(), create: jest.fn() },
    orderItem: { createMany: jest.fn() },
    $transaction: jest.fn(),
};
jest.mock('../../utils/prisma', () => ({ prisma: mockPrisma }));

import { createPaymentIntent, placeOrder } from '../order.controller';

const cart = {
    id: 'cart-1',
    customerId: 'customer-1',
    restaurantId: 'restaurant-1',
    items: [
        { menuItemId: 'item-2', quantity: 2, menuItem: { price: 3.25 } },
        { menuItemId: 'item-1', quantity: 1, menuItem: { price: 5 } },
    ],
};

const metadata = {
    customerId: 'customer-1',
    cartId: 'cart-1',
    restaurantId: 'restaurant-1',
    cartFingerprint: 'placeholder',
    amountCents: '1150',
    currency: 'usd',
};

const response = () => ({ status: jest.fn().mockReturnThis(), json: jest.fn() });

describe('secure checkout', () => {
    beforeEach(() => {
        jest.clearAllMocks();
        mockPrisma.customerProfile.findUnique.mockResolvedValue({ id: 'customer-1' });
        mockPrisma.cart.findUnique.mockResolvedValue(cart);
    });

    it('binds a card-only PaymentIntent to a canonical cart fingerprint', async () => {
        mockIntentCreate.mockResolvedValue({ id: 'pi_1', client_secret: 'pi_1_secret_test' });
        const res = response();

        await createPaymentIntent({ user: { id: 'user-1' } } as never, res as never);

        expect(mockIntentCreate).toHaveBeenCalledWith(expect.objectContaining({
            amount: 1150,
            currency: 'usd',
            payment_method_types: ['card'],
            metadata: expect.objectContaining({
                customerId: 'customer-1',
                cartId: 'cart-1',
                restaurantId: 'restaurant-1',
                amountCents: '1150',
                currency: 'usd',
                cartFingerprint: expect.stringMatching(/^[a-f0-9]{64}$/),
            }),
        }));
        expect(res.json).toHaveBeenCalledWith({
            success: true,
            data: { clientSecret: 'pi_1_secret_test', paymentIntentId: 'pi_1' },
        });
    });

    it('rejects a succeeded intent when its cart binding is mismatched', async () => {
        mockPrisma.order.findUnique.mockResolvedValue(null);
        mockIntentRetrieve.mockResolvedValue({
            status: 'succeeded', amount: 1150, currency: 'usd', metadata,
        });

        await expect(placeOrder({
            user: { id: 'user-1' },
            body: { deliveryAddress: '1 Main St', paymentIntentId: 'pi_1' },
        } as never, response() as never)).rejects.toMatchObject({ statusCode: 400 });
        expect(mockPrisma.$transaction).not.toHaveBeenCalled();
    });

    it('returns the existing customer order without retrieving or reusing payment', async () => {
        const existing = { id: 'order-1', customerId: 'customer-1', deliveryAddress: '1 Main St' };
        mockPrisma.order.findUnique.mockResolvedValue(existing);
        const res = response();

        await placeOrder({
            user: { id: 'user-1' },
            body: { deliveryAddress: '1 Main St', paymentIntentId: 'pi_1' },
        } as never, res as never);

        expect(mockIntentRetrieve).not.toHaveBeenCalled();
        expect(res.status).toHaveBeenCalledWith(200);
        expect(res.json).toHaveBeenCalledWith({ success: true, data: existing });
    });

    it('rejects an idempotent retry with a different delivery address', async () => {
        mockPrisma.order.findUnique.mockResolvedValue({
            id: 'order-1', customerId: 'customer-1', deliveryAddress: '1 Main St',
        });

        await expect(placeOrder({
            user: { id: 'user-1' },
            body: { deliveryAddress: '2 Other St', paymentIntentId: 'pi_1' },
        } as never, response() as never)).rejects.toMatchObject({ statusCode: 409 });
        expect(mockIntentRetrieve).not.toHaveBeenCalled();
    });

    it('maps a concurrent PaymentIntent unique conflict to the existing order', async () => {
        const fingerprint = 'a'.repeat(64);
        const boundCart = { ...cart };
        mockPrisma.order.findUnique
            .mockResolvedValueOnce(null)
            .mockResolvedValueOnce({ id: 'order-1', customerId: 'customer-1', deliveryAddress: '1 Main St' });
        mockPrisma.cart.findUnique.mockResolvedValue(boundCart);
        mockIntentRetrieve.mockResolvedValue({
            status: 'succeeded',
            amount: 1150,
            currency: 'usd',
            metadata: { ...metadata, cartFingerprint: fingerprint },
        });

        // Capture the actual canonical fingerprint from intent creation.
        mockIntentCreate.mockImplementation(async (params) => {
            mockIntentRetrieve.mockResolvedValueOnce({
                status: 'succeeded',
                amount: 1150,
                currency: 'usd',
                metadata: params.metadata,
            });
            return { id: 'pi_seed', client_secret: 'secret' };
        });
        await createPaymentIntent({ user: { id: 'user-1' } } as never, response() as never);
        mockPrisma.$transaction.mockRejectedValueOnce(
            new Prisma.PrismaClientKnownRequestError('duplicate', {
                code: 'P2002',
                clientVersion: '7.10.0',
            }),
        );
        const res = response();

        await placeOrder({
            user: { id: 'user-1' },
            body: { deliveryAddress: '1 Main St', paymentIntentId: 'pi_1' },
        } as never, res as never);

        expect(res.status).toHaveBeenCalledWith(200);
        expect(mockEmit).not.toHaveBeenCalled();
    });
});
