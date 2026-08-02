import { AppError } from '../../utils/AppError';
import { REVIEW_COMMENT_MAX_LENGTH, validateCreateOrderReview } from '../order.validator';

describe('validateCreateOrderReview', () => {
    const res = {} as any;
    let next: jest.Mock;

    beforeEach(() => {
        next = jest.fn();
    });

    it('accepts a valid rating and bounded string comment', () => {
        const req = { body: { rating: 5, comment: 'Great food' } } as any;

        validateCreateOrderReview(req, res, next);

        expect(next).toHaveBeenCalledTimes(1);
    });

    it.each([0, 6, 2.5, '5', null])('rejects invalid rating %p', (rating) => {
        const req = { body: { rating } } as any;

        expect(() => validateCreateOrderReview(req, res, next)).toThrow(AppError);
        expect(next).not.toHaveBeenCalled();
    });

    it('rejects a non-string comment', () => {
        const req = { body: { rating: 5, comment: ['invalid'] } } as any;

        expect(() => validateCreateOrderReview(req, res, next)).toThrow('comment must be a string');
    });

    it('rejects a comment over the maximum length', () => {
        const req = {
            body: { rating: 5, comment: 'a'.repeat(REVIEW_COMMENT_MAX_LENGTH + 1) },
        } as any;

        expect(() => validateCreateOrderReview(req, res, next)).toThrow(
            `comment must be at most ${REVIEW_COMMENT_MAX_LENGTH} characters`,
        );
    });
});
