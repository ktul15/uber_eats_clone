-- Reconcile tables and a column present in the Prisma schema but omitted from
-- the historical migration chain. IF NOT EXISTS keeps this safe for databases
-- that previously received these objects through `prisma db push`.
ALTER TABLE "Restaurant" ADD COLUMN IF NOT EXISTS "imageUrl" TEXT;

CREATE TABLE IF NOT EXISTS "OwnerProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    CONSTRAINT "OwnerProfile_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "Cart" (
    "id" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "restaurantId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    CONSTRAINT "Cart_pkey" PRIMARY KEY ("id")
);

CREATE TABLE IF NOT EXISTS "CartItem" (
    "id" TEXT NOT NULL,
    "cartId" TEXT NOT NULL,
    "menuItemId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    CONSTRAINT "CartItem_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX IF NOT EXISTS "OwnerProfile_userId_key" ON "OwnerProfile"("userId");
CREATE UNIQUE INDEX IF NOT EXISTS "Cart_customerId_key" ON "Cart"("customerId");

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'OwnerProfile_userId_fkey') THEN
        ALTER TABLE "OwnerProfile" ADD CONSTRAINT "OwnerProfile_userId_fkey"
            FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'Cart_customerId_fkey') THEN
        ALTER TABLE "Cart" ADD CONSTRAINT "Cart_customerId_fkey"
            FOREIGN KEY ("customerId") REFERENCES "CustomerProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'Cart_restaurantId_fkey') THEN
        ALTER TABLE "Cart" ADD CONSTRAINT "Cart_restaurantId_fkey"
            FOREIGN KEY ("restaurantId") REFERENCES "Restaurant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'CartItem_cartId_fkey') THEN
        ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_cartId_fkey"
            FOREIGN KEY ("cartId") REFERENCES "Cart"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'CartItem_menuItemId_fkey') THEN
        ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_menuItemId_fkey"
            FOREIGN KEY ("menuItemId") REFERENCES "MenuItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
END $$;
