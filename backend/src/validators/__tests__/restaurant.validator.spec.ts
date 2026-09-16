import { validateCreateRestaurant } from '../restaurant.validator';

describe('validateCreateRestaurant', () => {
    const valid = {
        name: 'Cafe One',
        address: '123 Main Street',
        lat: 37.77,
        lng: -122.41,
    };

    it('accepts complete bounded restaurant input', () => {
        const next = jest.fn();
        validateCreateRestaurant({ body: valid } as never, {} as never, next);
        expect(next).toHaveBeenCalledTimes(1);
    });

    it.each([
        [{ ...valid, lat: 91 }],
        [{ ...valid, lng: -181 }],
        [{ ...valid, name: ' ' }],
        [{ ...valid, imageUrl: 'file:///etc/passwd' }],
    ])('rejects invalid route input', (body) => {
        expect(() => validateCreateRestaurant({ body } as never, {} as never, jest.fn()))
            .toThrow(expect.objectContaining({ statusCode: 400 }));
    });
});
