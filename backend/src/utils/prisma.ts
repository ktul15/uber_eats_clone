import { PrismaClient } from '@prisma/client';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { getDatabasePoolConfig } from '../config/environment';

const connectionString = process.env.DATABASE_URL;
const poolConfig = getDatabasePoolConfig();

export const pool = new Pool({
    connectionString,
    ...poolConfig,
});
const adapter = new PrismaPg(pool);

export const prisma = new PrismaClient({ adapter });
