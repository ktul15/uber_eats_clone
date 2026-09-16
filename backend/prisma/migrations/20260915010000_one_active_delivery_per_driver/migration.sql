-- Prevent concurrent requests from assigning more than one active delivery to a driver.
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM "Delivery"
        WHERE "status" <> 'COMPLETED'
        GROUP BY "driverId"
        HAVING COUNT(*) > 1
    ) THEN
        RAISE EXCEPTION 'Cannot enforce one active delivery per driver: duplicate active assignments exist'
            USING HINT = 'Complete or reassign duplicate active deliveries, then retry the migration.';
    END IF;
END $$;

CREATE UNIQUE INDEX "Delivery_one_active_per_driver_key"
ON "Delivery" ("driverId")
WHERE "status" <> 'COMPLETED';
