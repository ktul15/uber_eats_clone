import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { Pool, PoolClient } from 'pg';

const testDatabaseUrl = process.env.TEST_DATABASE_URL;
if (!testDatabaseUrl && process.env.REQUIRE_TEST_DATABASE === '1') {
    throw new Error('TEST_DATABASE_URL is required for PostgreSQL integration tests');
}
const describePostgres = testDatabaseUrl ? describe : describe.skip;

describePostgres('order review PostgreSQL integration', () => {
    const schema = `review_it_${process.pid}_${Date.now()}`;
    const searchPathSql = `SET search_path TO "${schema}"`;
    let pool: Pool;

    beforeAll(async () => {
        pool = new Pool({ connectionString: testDatabaseUrl });
        const client = await pool.connect();
        try {
            await client.query(`CREATE SCHEMA "${schema}"`);
            await client.query(searchPathSql);
            await client.query(`
                CREATE TABLE "Restaurant" (
                    "id" TEXT PRIMARY KEY,
                    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0
                );
                CREATE TABLE "Order" (
                    "id" TEXT PRIMARY KEY,
                    "customerId" TEXT NOT NULL,
                    "restaurantId" TEXT NOT NULL REFERENCES "Restaurant"("id")
                );
                CREATE TABLE "Review" (
                    "id" TEXT PRIMARY KEY,
                    "orderId" TEXT NOT NULL UNIQUE REFERENCES "Order"("id") ON DELETE CASCADE,
                    "customerId" TEXT NOT NULL,
                    "restaurantId" TEXT NOT NULL REFERENCES "Restaurant"("id") ON DELETE CASCADE,
                    "rating" INTEGER NOT NULL,
                    "comment" TEXT,
                    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
                );
            `);

            const migration = fs.readFileSync(
                path.resolve(
                    __dirname,
                    '../../../prisma/migrations/20260802000000_harden_order_reviews/migration.sql',
                ),
                'utf8',
            );
            await client.query(migration);
            const paymentMigration = fs.readFileSync(
                path.resolve(
                    __dirname,
                    '../../../prisma/migrations/20260915000000_add_order_payment_intent/migration.sql',
                ),
                'utf8',
            );
            await client.query(paymentMigration);
            await client.query(`
                INSERT INTO "Restaurant" ("id") VALUES ('restaurant-1'), ('restaurant-2');
                INSERT INTO "Order" ("id", "customerId", "restaurantId") VALUES
                    ('order-1', 'customer-1', 'restaurant-1'),
                    ('order-2', 'customer-2', 'restaurant-1'),
                    ('order-3', 'customer-3', 'restaurant-1'),
                    ('order-4', 'customer-4', 'restaurant-1');
            `);
        } finally {
            client.release();
        }
    });

    afterAll(async () => {
        if (!pool) return;
        await pool.query(`DROP SCHEMA IF EXISTS "${schema}" CASCADE`);
        await pool.end();
    });

    it('serializes concurrent reviews and persists the correct average', async () => {
        await Promise.all([
            createReviewAndUpdateAverage('review-1', 'order-1', 'customer-1', 4, 0.1),
            createReviewAndUpdateAverage('review-2', 'order-2', 'customer-2', 5),
        ]);

        const result = await queryInSchema<{ rating: number }>(
            'SELECT "rating" FROM "Restaurant" WHERE "id" = $1',
            ['restaurant-1'],
        );
        expect(result.rows[0]?.rating).toBe(4.5);
    });

    it('enforces the rating range and review attribution constraints', async () => {
        await expect(
            queryInSchema(
                `INSERT INTO "Review"
                 ("id", "orderId", "customerId", "restaurantId", "rating")
                 VALUES ('bad-rating', 'order-3', 'customer-3', 'restaurant-1', 6)`,
            ),
        ).rejects.toMatchObject({ code: '23514' });

        await expect(
            queryInSchema(
                `INSERT INTO "Review"
                 ("id", "orderId", "customerId", "restaurantId", "rating")
                 VALUES ('bad-owner', 'order-3', 'wrong-customer', 'restaurant-1', 5)`,
            ),
        ).rejects.toMatchObject({ code: '23514' });
    });

    it('rejects concurrent duplicate reviews through the unique order constraint', async () => {
        const attempts = await Promise.allSettled([
            createReviewAndUpdateAverage('duplicate-1', 'order-3', 'customer-3', 3, 0.1),
            createReviewAndUpdateAverage('duplicate-2', 'order-3', 'customer-3', 3),
        ]);

        expect(attempts.filter((attempt) => attempt.status === 'fulfilled')).toHaveLength(1);
        const rejected = attempts.find((attempt) => attempt.status === 'rejected') as PromiseRejectedResult;
        expect(rejected.reason).toMatchObject({ code: '23505' });
    });

    it('prevents a PaymentIntent from being bound to more than one order', async () => {
        await queryInSchema(
            `UPDATE "Order" SET "paymentIntentId" = 'pi_unique' WHERE "id" = 'order-1'`,
        );
        await expect(queryInSchema(
            `UPDATE "Order" SET "paymentIntentId" = 'pi_unique' WHERE "id" = 'order-2'`,
        )).rejects.toMatchObject({ code: '23505' });
    });

    it('prevents changing attribution after an order is reviewed', async () => {
        await expect(
            queryInSchema(
                `UPDATE "Order" SET "restaurantId" = 'restaurant-2' WHERE "id" = 'order-1'`,
            ),
        ).rejects.toMatchObject({ code: '23514' });
    });

    it('serializes concurrent review insertion and order reassignment', async () => {
        const reviewClient = await pool.connect();
        const orderClient = await pool.connect();
        try {
            await reviewClient.query('BEGIN');
            await orderClient.query('BEGIN');
            await reviewClient.query(searchPathSql);
            await orderClient.query(searchPathSql);

            await reviewClient.query(`
                INSERT INTO "Review"
                    ("id", "orderId", "customerId", "restaurantId", "rating")
                VALUES ('race-review', 'order-4', 'customer-4', 'restaurant-1', 5)
            `);
            await orderClient.query(`
                UPDATE "Order" SET "restaurantId" = 'restaurant-2' WHERE "id" = 'order-4'
            `);

            const commits = await Promise.allSettled([
                reviewClient.query('COMMIT'),
                orderClient.query('COMMIT'),
            ]);

            expect(commits.filter((attempt) => attempt.status === 'fulfilled')).toHaveLength(1);
            const rejected = commits.find(
                (attempt) => attempt.status === 'rejected',
            ) as PromiseRejectedResult;
            expect(rejected.reason).toMatchObject({ code: '23514' });

            const consistency = await queryInSchema<{ matches: boolean }>(`
                SELECT NOT EXISTS (
                    SELECT 1
                    FROM "Review" review
                    JOIN "Order" orders ON orders."id" = review."orderId"
                    WHERE review."customerId" <> orders."customerId"
                       OR review."restaurantId" <> orders."restaurantId"
                ) AS "matches"
            `);
            expect(consistency.rows[0]?.matches).toBe(true);
        } finally {
            await reviewClient.query('ROLLBACK').catch(() => undefined);
            await orderClient.query('ROLLBACK').catch(() => undefined);
            reviewClient.release();
            orderClient.release();
        }
    });

    async function createReviewAndUpdateAverage(
        reviewId: string,
        orderId: string,
        customerId: string,
        rating: number,
        holdSeconds = 0,
    ): Promise<void> {
        const client = await pool.connect();
        try {
            await client.query('BEGIN');
            await client.query(searchPathSql);
            await client.query('SELECT pg_advisory_xact_lock(hashtext($1))', ['restaurant-1']);
            await client.query(
                `INSERT INTO "Review"
                 ("id", "orderId", "customerId", "restaurantId", "rating")
                 VALUES ($1, $2, $3, 'restaurant-1', $4)`,
                [reviewId, orderId, customerId, rating],
            );
            if (holdSeconds > 0) await client.query('SELECT pg_sleep($1)', [holdSeconds]);
            await client.query(`
                UPDATE "Restaurant"
                SET "rating" = (
                    SELECT AVG("rating") FROM "Review" WHERE "restaurantId" = 'restaurant-1'
                )
                WHERE "id" = 'restaurant-1'
            `);
            await client.query('COMMIT');
        } catch (error) {
            await client.query('ROLLBACK');
            throw error;
        } finally {
            client.release();
        }
    }

    async function queryInSchema<Row extends Record<string, unknown> = Record<string, unknown>>(
        sql: string,
        values: unknown[] = [],
    ) {
        const client: PoolClient = await pool.connect();
        try {
            await client.query(searchPathSql);
            return await client.query<Row>(sql, values);
        } finally {
            client.release();
        }
    }
});
