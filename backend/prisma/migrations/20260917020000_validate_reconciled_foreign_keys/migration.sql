-- The reconciliation migration predates this validation and checked constraint
-- names globally. Verify the expected table, columns, target, and cascade actions
-- without rewriting the already-applied migration.
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_attribute source_column
          ON source_column.attrelid = c.conrelid AND source_column.attnum = c.conkey[1]
        JOIN pg_attribute target_column
          ON target_column.attrelid = c.confrelid AND target_column.attnum = c.confkey[1]
        WHERE c.conrelid = '"OwnerProfile"'::regclass
          AND c.conname = 'OwnerProfile_userId_fkey'
          AND c.contype = 'f'
          AND c.confrelid = '"User"'::regclass
          AND array_length(c.conkey, 1) = 1
          AND source_column.attname = 'userId'
          AND target_column.attname = 'id'
          AND c.confupdtype = 'c'
          AND c.confdeltype = 'c'
    ) THEN
        IF EXISTS (
            SELECT 1 FROM pg_constraint
            WHERE conrelid = '"OwnerProfile"'::regclass
              AND conname = 'OwnerProfile_userId_fkey'
        ) THEN
            RAISE EXCEPTION 'OwnerProfile_userId_fkey exists with an unexpected definition';
        END IF;
        ALTER TABLE "OwnerProfile" ADD CONSTRAINT "OwnerProfile_userId_fkey"
            FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_attribute source_column
          ON source_column.attrelid = c.conrelid AND source_column.attnum = c.conkey[1]
        JOIN pg_attribute target_column
          ON target_column.attrelid = c.confrelid AND target_column.attnum = c.confkey[1]
        WHERE c.conrelid = '"Cart"'::regclass
          AND c.conname = 'Cart_customerId_fkey'
          AND c.contype = 'f'
          AND c.confrelid = '"CustomerProfile"'::regclass
          AND array_length(c.conkey, 1) = 1
          AND source_column.attname = 'customerId'
          AND target_column.attname = 'id'
          AND c.confupdtype = 'c'
          AND c.confdeltype = 'c'
    ) THEN
        IF EXISTS (
            SELECT 1 FROM pg_constraint
            WHERE conrelid = '"Cart"'::regclass AND conname = 'Cart_customerId_fkey'
        ) THEN
            RAISE EXCEPTION 'Cart_customerId_fkey exists with an unexpected definition';
        END IF;
        ALTER TABLE "Cart" ADD CONSTRAINT "Cart_customerId_fkey"
            FOREIGN KEY ("customerId") REFERENCES "CustomerProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_attribute source_column
          ON source_column.attrelid = c.conrelid AND source_column.attnum = c.conkey[1]
        JOIN pg_attribute target_column
          ON target_column.attrelid = c.confrelid AND target_column.attnum = c.confkey[1]
        WHERE c.conrelid = '"Cart"'::regclass
          AND c.conname = 'Cart_restaurantId_fkey'
          AND c.contype = 'f'
          AND c.confrelid = '"Restaurant"'::regclass
          AND array_length(c.conkey, 1) = 1
          AND source_column.attname = 'restaurantId'
          AND target_column.attname = 'id'
          AND c.confupdtype = 'c'
          AND c.confdeltype = 'c'
    ) THEN
        IF EXISTS (
            SELECT 1 FROM pg_constraint
            WHERE conrelid = '"Cart"'::regclass AND conname = 'Cart_restaurantId_fkey'
        ) THEN
            RAISE EXCEPTION 'Cart_restaurantId_fkey exists with an unexpected definition';
        END IF;
        ALTER TABLE "Cart" ADD CONSTRAINT "Cart_restaurantId_fkey"
            FOREIGN KEY ("restaurantId") REFERENCES "Restaurant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_attribute source_column
          ON source_column.attrelid = c.conrelid AND source_column.attnum = c.conkey[1]
        JOIN pg_attribute target_column
          ON target_column.attrelid = c.confrelid AND target_column.attnum = c.confkey[1]
        WHERE c.conrelid = '"CartItem"'::regclass
          AND c.conname = 'CartItem_cartId_fkey'
          AND c.contype = 'f'
          AND c.confrelid = '"Cart"'::regclass
          AND array_length(c.conkey, 1) = 1
          AND source_column.attname = 'cartId'
          AND target_column.attname = 'id'
          AND c.confupdtype = 'c'
          AND c.confdeltype = 'c'
    ) THEN
        IF EXISTS (
            SELECT 1 FROM pg_constraint
            WHERE conrelid = '"CartItem"'::regclass AND conname = 'CartItem_cartId_fkey'
        ) THEN
            RAISE EXCEPTION 'CartItem_cartId_fkey exists with an unexpected definition';
        END IF;
        ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_cartId_fkey"
            FOREIGN KEY ("cartId") REFERENCES "Cart"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_attribute source_column
          ON source_column.attrelid = c.conrelid AND source_column.attnum = c.conkey[1]
        JOIN pg_attribute target_column
          ON target_column.attrelid = c.confrelid AND target_column.attnum = c.confkey[1]
        WHERE c.conrelid = '"CartItem"'::regclass
          AND c.conname = 'CartItem_menuItemId_fkey'
          AND c.contype = 'f'
          AND c.confrelid = '"MenuItem"'::regclass
          AND array_length(c.conkey, 1) = 1
          AND source_column.attname = 'menuItemId'
          AND target_column.attname = 'id'
          AND c.confupdtype = 'c'
          AND c.confdeltype = 'c'
    ) THEN
        IF EXISTS (
            SELECT 1 FROM pg_constraint
            WHERE conrelid = '"CartItem"'::regclass AND conname = 'CartItem_menuItemId_fkey'
        ) THEN
            RAISE EXCEPTION 'CartItem_menuItemId_fkey exists with an unexpected definition';
        END IF;
        ALTER TABLE "CartItem" ADD CONSTRAINT "CartItem_menuItemId_fkey"
            FOREIGN KEY ("menuItemId") REFERENCES "MenuItem"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
END $$;
