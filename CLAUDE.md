# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Uber Eats clone with three Flutter client apps and a shared Node.js/Express backend:
- **backend** — Express + TypeScript REST API (PostgreSQL via Prisma ORM)
- **customer_app** — Flutter app for customers to browse and order
- **restaurant_dashboard** — Flutter app for restaurant owners to manage their menu/restaurant
- **driver_app** — Flutter app for delivery drivers

## Commands

### Backend

```bash
cd backend
npm run dev       # development with nodemon
npm run build     # TypeScript compilation to dist/
npm start         # production (runs dist/index.js)
npm test          # Jest test runner
npx prisma migrate dev   # run DB migrations
npx prisma generate      # regenerate Prisma client after schema changes
npx prisma studio        # GUI for inspecting the database
```

### Flutter Apps (customer_app, restaurant_dashboard, driver_app)

```bash
cd <app_dir>
flutter pub get                        # install dependencies
flutter pub run build_runner build     # generate code (Riverpod, Freezed, JSON)
flutter pub run build_runner watch     # watch mode for code generation
flutter analyze                        # lint
flutter run                            # run in development
flutter test test/path/to/test.dart    # run a single test
```

**Code generation must be re-run** after modifying any file annotated with `@riverpod`, `@freezed`, or `@JsonSerializable`.

## Architecture

### Backend

MVC structure under `backend/src/`:
- `routes/` → `controllers/` → Prisma client (no service layer)
- `middlewares/` — `authenticate` (JWT validation, attaches `req.user`), `requireRole` (RBAC), `asyncHandler` (wraps async controllers), global error handler
- `utils/AppError.ts` — custom error class with factory methods (`badRequest`, `unauthorized`, `notFound`, etc.)
- All API routes are prefixed with `/api`; static uploads served at `/uploads`

JWT secret falls back to `'super-secret-key-for-dev'` if `JWT_SECRET` env var is not set.

### Flutter Apps

All three apps use the same architecture:

**Clean Architecture per feature** (`lib/features/<feature>/`):
- `domain/` — Freezed models (pure data, no serialization)
- `data/` — DTOs (`*_dto.dart` with JSON serialization), API clients (Dio), repository implementations
- `presentation/` — screens and widgets

**State management:** Riverpod with code generation (`@riverpod` annotation). Use `AsyncNotifier`/`Notifier` for controllers, `AsyncValue` for loading/error/success states.

**Routing:** GoRouter in `lib/app/router.dart`. Auth redirection is driven by `isAuthenticatedProvider` (a `ValueNotifier` listener) — redirects to `/login` if unauthenticated, to `/home` if authenticated and accessing auth screens.

**Data flow:** UI → Controller (Riverpod Notifier) → Repository → API Client (Dio) → backend. The Dio instance is configured in `lib/shared/providers/dio_provider.dart` and attaches the JWT Bearer token automatically.

**API base URL** is hardcoded in `lib/shared/constants/api_constants.dart` as `http://localhost:8000`.

### Database Schema (Prisma)

Key entities: `User` (with role: CUSTOMER/OWNER/DRIVER) → role-specific profiles (`CustomerProfile`, `OwnerProfile`, `DriverProfile`) → `Restaurant` → `MenuItem`. Orders: `Order` → `OrderItem`; delivery: `Delivery`.

## Environment Setup

Copy `backend/.env.example` to `backend/.env` and fill in:
- `DATABASE_URL` — PostgreSQL connection string
- `JWT_SECRET`
- Firebase, Stripe, Google Cloud credentials (see `EXTERNAL_SERVICES_SETUP.md`)

Flutter apps expect `lib/shared/constants/api_keys.dart` (gitignored) for Google Maps API key.

## Branch & Issue Conventions

Feature branches follow `feature/issue-{N}-{description}`. Commit messages follow `closes #N: <type>: <description>` format.
