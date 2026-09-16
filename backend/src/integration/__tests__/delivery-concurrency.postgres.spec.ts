import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { Pool } from 'pg';

const testDatabaseUrl = process.env.TEST_DATABASE_URL;
if (!testDatabaseUrl && process.env.REQUIRE_TEST_DATABASE === '1') {
    throw new Error('TEST_DATABASE_URL is required for PostgreSQL integration tests');
}
const describePostgres = testDatabaseUrl ? describe : describe.skip;

describePostgres('delivery assignment PostgreSQL constraints', () => {
    const schema = `delivery_it_${process.pid}_${Date.now()}`;
    let pool: Pool;

    beforeAll(async () => {
        pool = new Pool({ connectionString: testDatabaseUrl });
        await pool.query(`CREATE SCHEMA "${schema}"`);
        await pool.query(`
            SET search_path TO "${schema}";
            CREATE TYPE "DeliveryStatus" AS ENUM ('ASSIGNED', 'AT_RESTAURANT', 'IN_TRANSIT', 'COMPLETED');
            CREATE TABLE "Delivery" (
                "id" TEXT PRIMARY KEY,
                "driverId" TEXT NOT NULL,
                "status" "DeliveryStatus" NOT NULL DEFAULT 'ASSIGNED'
            );
        `);
        const migration = fs.readFileSync(path.resolve(
            __dirname,
            '../../../prisma/migrations/20260915010000_one_active_delivery_per_driver/migration.sql',
        ), 'utf8');
        await pool.query(`SET search_path TO "${schema}"; ${migration}`);
    });

    afterAll(async () => {
        if (!pool) return;
        await pool.query(`DROP SCHEMA IF EXISTS "${schema}" CASCADE`);
        await pool.end();
    });

    it('allows only one active delivery per driver under concurrent assignment', async () => {
        const insert = async (id: string) => {
            const client = await pool.connect();
            try {
                await client.query(`SET search_path TO "${schema}"`);
                return await client.query(
                    `INSERT INTO "Delivery" ("id", "driverId") VALUES ($1, 'driver-1')`,
                    [id],
                );
            } finally {
                client.release();
            }
        };
        const attempts = await Promise.allSettled([insert('delivery-1'), insert('delivery-2')]);

        expect(attempts.filter((attempt) => attempt.status === 'fulfilled')).toHaveLength(1);
        const rejected = attempts.find((attempt) => attempt.status === 'rejected') as PromiseRejectedResult;
        expect(rejected.reason).toMatchObject({ code: '23505' });
    });

    it('fails migration preflight clearly when legacy duplicates exist', async () => {
        const duplicateSchema = `${schema}_duplicates`;
        try {
            await pool.query(`
                CREATE SCHEMA "${duplicateSchema}";
                SET search_path TO "${duplicateSchema}";
                CREATE TYPE "DeliveryStatus" AS ENUM ('ASSIGNED', 'AT_RESTAURANT', 'IN_TRANSIT', 'COMPLETED');
                CREATE TABLE "Delivery" (
                    "id" TEXT PRIMARY KEY,
                    "driverId" TEXT NOT NULL,
                    "status" "DeliveryStatus" NOT NULL DEFAULT 'ASSIGNED'
                );
                INSERT INTO "Delivery" ("id", "driverId") VALUES
                    ('delivery-a', 'driver-1'), ('delivery-b', 'driver-1');
            `);
            const migration = fs.readFileSync(path.resolve(
                __dirname,
                '../../../prisma/migrations/20260915010000_one_active_delivery_per_driver/migration.sql',
            ), 'utf8');
            await expect(pool.query(`SET search_path TO "${duplicateSchema}"; ${migration}`))
                .rejects.toMatchObject({
                    message: expect.stringContaining('duplicate active assignments exist'),
                });
        } finally {
            await pool.query(`DROP SCHEMA IF EXISTS "${duplicateSchema}" CASCADE`);
        }
    });
});
