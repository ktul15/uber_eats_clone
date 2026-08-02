ALTER TABLE "Review"
ADD CONSTRAINT "Review_rating_check" CHECK ("rating" BETWEEN 1 AND 5);

CREATE OR REPLACE FUNCTION validate_review_order_relations()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'UPDATE' AND OLD."orderId" IS DISTINCT FROM NEW."orderId" THEN
        PERFORM pg_advisory_xact_lock(
            LEAST(hashtextextended(OLD."orderId", 0), hashtextextended(NEW."orderId", 0))
        );
        PERFORM pg_advisory_xact_lock(
            GREATEST(hashtextextended(OLD."orderId", 0), hashtextextended(NEW."orderId", 0))
        );
    ELSE
        PERFORM pg_advisory_xact_lock(hashtextextended(NEW."orderId", 0));
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM "Order"
        WHERE "id" = NEW."orderId"
          AND "customerId" = NEW."customerId"
          AND "restaurantId" = NEW."restaurantId"
    ) THEN
        RAISE EXCEPTION 'Review customer and restaurant must match its order'
            USING ERRCODE = '23514';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER "Review_order_relations_check"
AFTER INSERT OR UPDATE ON "Review"
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION validate_review_order_relations();

CREATE OR REPLACE FUNCTION protect_reviewed_order_relations()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM pg_advisory_xact_lock(hashtextextended(NEW."id", 0));

    IF (NEW."customerId", NEW."restaurantId") IS DISTINCT FROM
       (OLD."customerId", OLD."restaurantId")
       AND EXISTS (SELECT 1 FROM "Review" WHERE "orderId" = OLD."id") THEN
        RAISE EXCEPTION 'Cannot change customer or restaurant for a reviewed order'
            USING ERRCODE = '23514';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE CONSTRAINT TRIGGER "Order_review_relations_immutable"
AFTER UPDATE ON "Order"
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW EXECUTE FUNCTION protect_reviewed_order_relations();
