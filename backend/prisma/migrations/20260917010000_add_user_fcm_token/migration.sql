-- Reconcile the notification token column present in the Prisma schema but
-- omitted from the historical migration chain.
ALTER TABLE "User" ADD COLUMN IF NOT EXISTS "fcmToken" TEXT;
