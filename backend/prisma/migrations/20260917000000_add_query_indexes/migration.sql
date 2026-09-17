-- Index the foreign-key filters and newest-first order history queries used by the API.
CREATE INDEX IF NOT EXISTS "Restaurant_ownerId_idx" ON "Restaurant"("ownerId");
CREATE INDEX IF NOT EXISTS "MenuItem_restaurantId_idx" ON "MenuItem"("restaurantId");
CREATE INDEX IF NOT EXISTS "Order_customerId_createdAt_idx" ON "Order"("customerId", "createdAt" DESC);
CREATE INDEX IF NOT EXISTS "Order_restaurantId_createdAt_idx" ON "Order"("restaurantId", "createdAt" DESC);
CREATE INDEX IF NOT EXISTS "Delivery_driverId_status_idx" ON "Delivery"("driverId", "status");
CREATE INDEX IF NOT EXISTS "OrderItem_orderId_idx" ON "OrderItem"("orderId");
CREATE INDEX IF NOT EXISTS "CartItem_cartId_idx" ON "CartItem"("cartId");
