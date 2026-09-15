# Repository Guidelines

## Scope and Sources of Truth

This repository is a monorepo containing one backend and three independent Flutter applications. Run commands from the component being changed; there is no root package manager or workspace command.

- `backend/`: TypeScript, Express 5, Socket.IO, Prisma 7 with the PostgreSQL driver adapter, and Jest.
- `customer_app/`: customer discovery, cart, checkout, order history/reviews, notifications, and live delivery tracking.
- `restaurant_dashboard/`: restaurant profile/menu management and real-time order handling.
- `driver_app/`: driver profile, available-order handling, delivery status, location updates, and notifications.
- `TESTING.md`: normal local setup, manual scenarios, API base URLs, and automated verification.
- `QA_GUIDE.md`: full-system QA setup, known baseline limitations, test data, security checks, and release exit criteria.
- `EXTERNAL_SERVICES_SETUP.md`: Firebase, Google Maps/Directions, and Stripe setup.
- `PROJECT_PLAN.md`: product phases and historical feature context; prefer the current code and testing guides when it conflicts with implementation details.

Do not assume the commented-out GitHub Actions steps validate the project. The current workflows are scaffolds, so run the relevant checks locally.

## Project Structure and Architecture

### Backend

Backend source lives in `backend/src/`:

- `routes/` wires HTTP paths, authentication/role middleware, validators, and controllers.
- `controllers/` contains request handling and Prisma operations. Preserve the existing route -> controller -> Prisma flow unless a new layer is clearly justified.
- `middlewares/` contains JWT/RBAC and the global error handler. Keep the global error handler last in `src/index.ts`.
- `validators/` contains `express-validator` rules and validation middleware.
- `socket/` authenticates Socket.IO connections, authorizes room joins, and defines room names/events.
- `utils/` contains the Prisma client, Firebase initialization/FCM helpers, `AppError`, `asyncHandler`, and shared calculations.
- Unit tests are colocated in `__tests__/`; PostgreSQL integration tests live in `src/integration/__tests__/`.
- `backend/prisma/schema.prisma`, `backend/prisma.config.ts`, and `backend/prisma/migrations/` define the database and migration history.

All REST APIs are mounted below `/api`, except `/health` and static `/uploads`. Preserve the response envelope: successful responses use `{ success: true, data: ... }`; failures use `{ success: false, error: { code, message, details? } }`. Use `AppError` for expected HTTP failures and ensure async failures reach the global error handler. Protected endpoints and Socket.IO connections use the same JWT identity/role model.

When changing order or delivery behavior, account for all three surfaces together: persisted Prisma state, Socket.IO events/rooms, and FCM notifications. Keep status transitions compatible with the enums and constraints in the Prisma schema.

### Flutter Applications

Each Flutter app is its own package. Common structure:

- `lib/app/`: app widget, theme, GoRouter configuration, and route constants.
- `lib/features/<feature>/domain/`: domain models and repository contracts where the feature has them.
- `lib/features/<feature>/data/`: Dio API clients, DTOs, and repository implementations.
- `lib/features/<feature>/presentation/`: screens and widgets.
- `lib/features/<feature>/providers/`: Riverpod providers/notifiers connecting UI, repositories, APIs, sockets, and state.
- `lib/shared/`: cross-feature constants, providers, services, themes, utilities, and widgets.
- `lib/core/constants/`: checked-in example configuration files.

Follow the feature's established organization rather than forcing every feature to contain every layer. The usual data flow is UI -> Riverpod provider/notifier -> repository -> Dio API client -> backend. Routing is handled by generated Riverpod providers around GoRouter, with authentication-driven redirects. Shared Dio providers set the backend base URL; individual clients currently attach bearer tokens where needed.

Use `snake_case.dart` filenames and `PascalCase` types. Follow each app's `analysis_options.yaml` and existing Flutter/Riverpod patterns. Generated `*.g.dart` and `*.freezed.dart` files are committed, but never edit them by hand.

## Runtime and Environment Requirements

- Use Node.js `20.19+`, `22.12+`, or `24+`; these satisfy the pinned Prisma 7 engine requirement.
- The Flutter lockfiles require Dart `>=3.11.0 <4.0.0` and Flutter `>=3.38.4`.
- Copy `backend/.env.example` to `backend/.env`. The code reads `PORT`, `DATABASE_URL`, `BASE_URL`, `JWT_SECRET`, `CLIENT_URL`, Firebase credentials, and `STRIPE_SECRET_KEY` as applicable.
- `TEST_DATABASE_URL` is intentionally separate from `DATABASE_URL`. Integration tests create and drop isolated schemas, but it must still point to a dedicated test PostgreSQL database.
- Firebase client files (`lib/firebase_options.dart`, `google-services.json`, and `GoogleService-Info.plist`) are generated/local configuration in the customer and driver apps. Use `flutterfire configure`; do not commit real credentials.
- Google Maps/Directions configuration uses the example key files under `lib/core/constants/` and the customer app's `lib/shared/constants/api_keys.dart`. Keep checked-in values as placeholders and never commit production secrets.
- `ApiConstants.baseUrl` is currently `http://localhost:8000`. Adjust it for the target device as described in `TESTING.md` (for example, an Android emulator cannot reach the host through its own `localhost`). Keep REST and Socket.IO URLs aligned across the affected apps.

The backend contains development fallbacks for some services, including JWT and disabled Firebase behavior. Do not rely on these fallbacks for integration, QA, or production verification.

## Build, Test, and Development Commands

### Backend

Run from `backend/`:

```bash
npm ci                         # reproducible install from package-lock.json
npm run dev                    # nodemon development server, default port 8000
npm run build                  # strict TypeScript compile to dist/
npm start                      # run dist/index.js
npm test                       # all Jest specs; DB specs skip without TEST_DATABASE_URL
npm test -- --runInBand path/to/file.spec.ts
npm run test:integration       # require and run PostgreSQL integration specs serially
npx prisma generate            # regenerate the Prisma client
npx prisma migrate dev         # create/apply a development migration
npx prisma studio              # inspect the configured development database
```

Use `npm install` only when intentionally changing dependencies/lockfile. After changing `schema.prisma`, create an additive migration, inspect its SQL (especially constraints, locks, and data backfills), and run `npx prisma generate`. Do not rewrite already-shared migrations.

### Flutter apps

Run from the affected app (`customer_app/`, `restaurant_dashboard/`, or `driver_app/`):

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
dart format lib test
flutter analyze
flutter test
flutter test test/path/to/test.dart
flutter run -d <device-id>
```

Re-run `build_runner` after editing `@riverpod`, `@freezed`, `@JsonSerializable`, router/provider annotations, or inputs consumed by those generators. Include the regenerated files in the same change.

## Testing Expectations

- Add or update focused tests with behavior changes. Backend specs use Jest/`ts-jest` and the existing Prisma/socket mocks; Flutter tests use `flutter_test` and should cover changed widgets/providers/navigation where practical.
- Run `npm run build` as well as relevant Jest tests for backend changes; the Jest configuration excludes test files from the production TypeScript build.
- Run both `flutter analyze` and `flutter test` for every Flutter app touched. If shared API contracts change, validate every affected client, not only the backend.
- Run `npm run test:integration` for Prisma migrations, PostgreSQL constraints/transactions, or behavior covered by the integration suite. Never point it at development or production data.
- Use `TESTING.md` for normal end-to-end flows. Use `QA_GUIDE.md` for whole-project or release QA and check its known-baseline section before attributing an existing failure to the current change.
- For real-time changes, test connection/authentication, authorized room joins, reconnect behavior, duplicate/racing actions, and event payload compatibility between backend and clients.
- For UI changes, manually check loading, empty, error, and success states plus role-based navigation. Include screenshots or recordings in PRs where the visible behavior changes.

## Coding and Change Guidelines

- Keep changes scoped to the issue and preserve unrelated working-tree changes.
- Follow TypeScript strictness and existing naming/import style. Add validators and role checks at the route boundary; keep expected failures in the standard `AppError` envelope.
- Preserve Flutter separation between domain models, serializable DTOs, APIs/repositories, Riverpod state, and presentation. Avoid parsing transport JSON directly in widgets.
- Treat backend DTO/event changes as cross-client contracts. Search all three apps for consumers before changing field names, enum strings, routes, or Socket.IO event payloads.
- Do not silently change role or status strings; they correspond to Prisma enums and client-side assumptions.
- Never hand-edit generated Dart files, Prisma client output, dependency caches, or build artifacts.
- Do not commit secrets, `.env`, service-account material, platform Firebase files, local API endpoints intended only for one machine, uploaded test files, or build output.

## Commit and Pull Request Guidelines

Use Conventional Commits, preferably scoped, such as `feat(orders): add order history UI` or `fix(delivery): reject stale status transitions`. PRs should include a concise description, linked issue (`Closes #<id>` where applicable), test commands/results, and screenshots or recordings for Flutter UI changes. Explicitly note migrations and required Firebase, Stripe, Maps, environment, or device-networking changes.

## Git and Issue Workflow

The required branch hierarchy is `feature/*` -> `dev` -> `main`.

- Always manage the GitHub Project card for an issue: move it to **In Progress** when work starts and to **Done** after the issue is completed.
- Always create feature branches from an up-to-date `dev`, never from `main`.
- Name branches `feature/<issue-number>-<short-description>`, for example `feature/21-product-filters`.
- Do not commit directly to `main` or `dev`.
- Include `Closes #<issue-number>` in the commit body so GitHub associates the commit with the issue.
- Merge the feature branch into `dev` only after the feature is complete and its relevant checks pass.
- After pushing `dev`, close the GitHub issue with a short comment identifying the feature branch and `dev` as the merge target.
- Update `main` only by merging `dev`; never commit directly to `main`.

Start a feature with:

```bash
git checkout dev
git pull origin dev
git checkout -b feature/<issue-number>-<short-description>
```

Finish a feature with:

```bash
git checkout dev
git merge --no-ff feature/<issue-number>-<short-description>
git push origin dev
gh issue close <issue-number> --comment "Resolved in feature/<issue-number>-<short-description>, merged into dev."
```

## Mandatory Pre-Commit Review

Before committing:

1. Run the `senior-code-reviewer` agent on every changed file.
2. List every issue or suggestion it identifies with a short description.
3. Ask the user which fixes to apply before proceeding with the commit.

Keep unrelated user changes out of the issue commit. Do not stage or commit until the review-and-selection step is complete.

## Mandatory Completion Summary

After the feature is merged into `dev`, pushed, the GitHub issue is closed, and its project card is moved to **Done**, provide a written summary covering:

- **Why:** the business or product reason the feature was built.
- **What:** the endpoints, behavior, and key decisions implemented.
- **How:** the technical approach, patterns, and non-obvious design choices.
- **Validation:** the exact automated/manual checks run and any remaining limitations.
- **Modified files:** every created or changed file, with a one-line description of its change.
