import {
    getCart,
    addItemToCart,
    updateCartItem,
    removeCartItem,
    clearCart,
} from '../cart.controller';
import { PrismaClient } from '@prisma/client';
import { AppError } from '../../utils/AppError';

jest.mock('@prisma/client', () => {
    const mPrismaClient = {
        customerProfile: { findUnique: jest.fn() },
        cart: {
            findUnique: jest.fn(),
            create: jest.fn(),
            update: jest.fn(),
            delete: jest.fn(),
        },
        cartItem: {
            findUnique: jest.fn(),
            findFirst: jest.fn(),
            create: jest.fn(),
            update: jest.fn(),
            delete: jest.fn(),
            count: jest.fn(),
        },
        menuItem: { findUnique: jest.fn() },
        $transaction: jest.fn(),
    };
    return { PrismaClient: jest.fn(() => mPrismaClient) };
});

const CUSTOMER_USER_ID = 'user-1';
const CUSTOMER_PROFILE_ID = 'profile-1';
const RESTAURANT_ID = 'rest-1';
const MENU_ITEM_ID = 'item-1';
const CART_ID = 'cart-1';
const CART_ITEM_ID = 'cartitem-1';

const mockCart = {
    id: CART_ID,
    customerId: CUSTOMER_PROFILE_ID,
    restaurantId: RESTAURANT_ID,
    restaurant: { id: RESTAURANT_ID, name: 'Test Rest' },
    items: [{ id: CART_ITEM_ID, menuItemId: MENU_ITEM_ID, quantity: 2, menuItem: { id: MENU_ITEM_ID, name: 'Burger' } }],
};

describe('Cart Controller', () => {
    let prisma: any;
    let req: any;
    let res: any;

    beforeEach(() => {
        prisma = new PrismaClient();
        req = {
            params: {},
            body: {},
            query: {},
            user: { id: CUSTOMER_USER_ID, role: 'CUSTOMER' },
        };
        res = {
            status: jest.fn().mockReturnThis(),
            json: jest.fn(),
        };
        jest.clearAllMocks();
    });

    // -----------------------------------------------------------------------
    // getCart
    // -----------------------------------------------------------------------
    describe('getCart', () => {
        it('returns 401 if no user', async () => {
            req.user = undefined;
            await expect(getCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns 404 if no customer profile', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce(null);
            await expect(getCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns null when customer has no cart', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce(null);

            await getCart(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: null });
        });

        it('returns cart with items when cart exists', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce(mockCart);

            await getCart(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: mockCart });
        });
    });

    // -----------------------------------------------------------------------
    // addItemToCart
    // -----------------------------------------------------------------------
    describe('addItemToCart', () => {
        it('returns 400 if menuItemId is missing', async () => {
            req.body = { quantity: 1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            await expect(addItemToCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns 400 if quantity is missing', async () => {
            req.body = { menuItemId: MENU_ITEM_ID };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            await expect(addItemToCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns 400 if quantity < 1', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 0 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            await expect(addItemToCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns 404 if menu item not found', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.menuItem.findUnique.mockResolvedValueOnce(null);
            await expect(addItemToCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns 400 if menu item is not available', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.menuItem.findUnique.mockResolvedValueOnce({ id: MENU_ITEM_ID, restaurantId: RESTAURANT_ID, isAvailable: false });
            await expect(addItemToCart(req, res)).rejects.toThrow(AppError);
        });

        it('returns 409 if item is from a different restaurant', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.menuItem.findUnique.mockResolvedValueOnce({ id: MENU_ITEM_ID, restaurantId: 'other-rest', isAvailable: true });
            prisma.cart.findUnique.mockResolvedValueOnce({ id: CART_ID, customerId: CUSTOMER_PROFILE_ID, restaurantId: RESTAURANT_ID });
            await expect(addItemToCart(req, res)).rejects.toThrow(AppError);
        });

        it('creates a new cart with the first item (201)', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.menuItem.findUnique.mockResolvedValueOnce({ id: MENU_ITEM_ID, restaurantId: RESTAURANT_ID, isAvailable: true });
            prisma.cart.findUnique.mockResolvedValueOnce(null);
            prisma.$transaction.mockImplementationOnce(async (fn: any) => {
                const txMock = {
                    cart: { create: jest.fn().mockResolvedValue({ id: CART_ID }), findUnique: jest.fn().mockResolvedValue(mockCart) },
                    cartItem: { create: jest.fn().mockResolvedValue({}) },
                };
                return fn(txMock);
            });

            await addItemToCart(req, res);

            expect(res.status).toHaveBeenCalledWith(201);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: mockCart });
        });

        it('increments quantity if item already in cart', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.menuItem.findUnique.mockResolvedValueOnce({ id: MENU_ITEM_ID, restaurantId: RESTAURANT_ID, isAvailable: true });
            prisma.cart.findUnique
                .mockResolvedValueOnce({ id: CART_ID, customerId: CUSTOMER_PROFILE_ID, restaurantId: RESTAURANT_ID })
                .mockResolvedValueOnce(mockCart);
            prisma.cartItem.findFirst.mockResolvedValueOnce({ id: CART_ITEM_ID, quantity: 2 });
            prisma.cartItem.update.mockResolvedValueOnce({});

            await addItemToCart(req, res);

            expect(prisma.cartItem.update).toHaveBeenCalledWith({
                where: { id: CART_ITEM_ID },
                data: { quantity: 3 },
            });
            expect(res.status).toHaveBeenCalledWith(200);
        });

        it('adds a new item to an existing same-restaurant cart', async () => {
            req.body = { menuItemId: MENU_ITEM_ID, quantity: 2 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.menuItem.findUnique.mockResolvedValueOnce({ id: MENU_ITEM_ID, restaurantId: RESTAURANT_ID, isAvailable: true });
            prisma.cart.findUnique
                .mockResolvedValueOnce({ id: CART_ID, customerId: CUSTOMER_PROFILE_ID, restaurantId: RESTAURANT_ID })
                .mockResolvedValueOnce(mockCart);
            prisma.cartItem.findFirst.mockResolvedValueOnce(null);
            prisma.cartItem.create.mockResolvedValueOnce({});

            await addItemToCart(req, res);

            expect(prisma.cartItem.create).toHaveBeenCalledWith({
                data: { cartId: CART_ID, menuItemId: MENU_ITEM_ID, quantity: 2 },
            });
            expect(res.status).toHaveBeenCalledWith(200);
        });
    });

    // -----------------------------------------------------------------------
    // updateCartItem
    // -----------------------------------------------------------------------
    describe('updateCartItem', () => {
        beforeEach(() => {
            req.params = { cartItemId: CART_ITEM_ID };
        });

        it('returns 400 if quantity is negative', async () => {
            req.body = { quantity: -1 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            await expect(updateCartItem(req, res)).rejects.toThrow(AppError);
        });

        it('returns 404 if cart item does not belong to user cart', async () => {
            req.body = { quantity: 2 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce({ id: CART_ID });
            prisma.cartItem.findUnique.mockResolvedValueOnce({ id: CART_ITEM_ID, cartId: 'other-cart' });
            await expect(updateCartItem(req, res)).rejects.toThrow(AppError);
        });

        it('removes item and deletes cart when quantity is 0 and it is the last item', async () => {
            req.body = { quantity: 0 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce({ id: CART_ID });
            prisma.cartItem.findUnique.mockResolvedValueOnce({ id: CART_ITEM_ID, cartId: CART_ID });
            prisma.cartItem.delete.mockResolvedValueOnce({});
            prisma.cartItem.count.mockResolvedValueOnce(0);
            prisma.cart.delete.mockResolvedValueOnce({});

            await updateCartItem(req, res);

            expect(prisma.cart.delete).toHaveBeenCalledWith({ where: { id: CART_ID } });
            expect(res.json).toHaveBeenCalledWith({ success: true, data: null });
        });

        it('updates quantity successfully', async () => {
            req.body = { quantity: 5 };
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique
                .mockResolvedValueOnce({ id: CART_ID })
                .mockResolvedValueOnce(mockCart);
            prisma.cartItem.findUnique.mockResolvedValueOnce({ id: CART_ITEM_ID, cartId: CART_ID });
            prisma.cartItem.update.mockResolvedValueOnce({});

            await updateCartItem(req, res);

            expect(prisma.cartItem.update).toHaveBeenCalledWith({
                where: { id: CART_ITEM_ID },
                data: { quantity: 5 },
            });
            expect(res.status).toHaveBeenCalledWith(200);
        });
    });

    // -----------------------------------------------------------------------
    // removeCartItem
    // -----------------------------------------------------------------------
    describe('removeCartItem', () => {
        beforeEach(() => {
            req.params = { cartItemId: CART_ITEM_ID };
        });

        it('returns 404 if cart not found', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce(null);
            await expect(removeCartItem(req, res)).rejects.toThrow(AppError);
        });

        it('returns 404 if item does not belong to user cart', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce({ id: CART_ID });
            prisma.cartItem.findUnique.mockResolvedValueOnce({ id: CART_ITEM_ID, cartId: 'other-cart' });
            await expect(removeCartItem(req, res)).rejects.toThrow(AppError);
        });

        it('auto-deletes cart when last item is removed', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce({ id: CART_ID });
            prisma.cartItem.findUnique.mockResolvedValueOnce({ id: CART_ITEM_ID, cartId: CART_ID });
            prisma.cartItem.delete.mockResolvedValueOnce({});
            prisma.cartItem.count.mockResolvedValueOnce(0);
            prisma.cart.delete.mockResolvedValueOnce({});

            await removeCartItem(req, res);

            expect(prisma.cart.delete).toHaveBeenCalledWith({ where: { id: CART_ID } });
            expect(res.json).toHaveBeenCalledWith({ success: true, data: null });
        });

        it('returns updated cart after removal when items remain', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique
                .mockResolvedValueOnce({ id: CART_ID })
                .mockResolvedValueOnce(mockCart);
            prisma.cartItem.findUnique.mockResolvedValueOnce({ id: CART_ITEM_ID, cartId: CART_ID });
            prisma.cartItem.delete.mockResolvedValueOnce({});
            prisma.cartItem.count.mockResolvedValueOnce(1);

            await removeCartItem(req, res);

            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: mockCart });
        });
    });

    // -----------------------------------------------------------------------
    // clearCart
    // -----------------------------------------------------------------------
    describe('clearCart', () => {
        it('returns 404 if no cart exists', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce(null);
            await expect(clearCart(req, res)).rejects.toThrow(AppError);
        });

        it('deletes the cart and returns null', async () => {
            prisma.customerProfile.findUnique.mockResolvedValueOnce({ id: CUSTOMER_PROFILE_ID });
            prisma.cart.findUnique.mockResolvedValueOnce({ id: CART_ID });
            prisma.cart.delete.mockResolvedValueOnce({});

            await clearCart(req, res);

            expect(prisma.cart.delete).toHaveBeenCalledWith({ where: { id: CART_ID } });
            expect(res.status).toHaveBeenCalledWith(200);
            expect(res.json).toHaveBeenCalledWith({ success: true, data: null });
        });
    });
});
