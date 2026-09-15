# Whole-Project QA Guide

This is the Phase 8 QA runbook for the Uber Eats clone. Test each component independently first, then verify the complete customer → restaurant → driver lifecycle. Use [TESTING.md](TESTING.md) for the shorter developer smoke-test guide; this document is the release-oriented regression checklist.

This guide describes the intended acceptance behavior. A failed expectation is a defect, not a reason to edit the expected result to match the implementation. Record the branch and commit for every QA run so results remain reproducible.

## 0. Known Baseline Blockers

The following code/document mismatches were present when this guide was reviewed on 2026-09-07. Verify and close them during issue #35 before attempting release sign-off:

| Area | Current implementation | Required QA outcome |
|---|---|---|
| Account verification | Registration immediately issues a JWT; no OTP or email-verification flow exists despite the Phase 2 roadmap wording | Implement and test verification, or explicitly remove it from release scope |
| Customer payment | Creates a PaymentIntent but does not collect or confirm a payment method; order placement therefore cannot complete through the normal UI against Stripe | Integrate Stripe client confirmation and test success, decline, cancellation, and retry |
| Payment validation | Order placement checks only that the supplied PaymentIntent succeeded; it does not bind the intent's amount/customer/cart metadata to the order or prevent reuse | Validate ownership, amount, currency, metadata, and one-time/idempotent use |
| Driver availability | New drivers default to unavailable, with no UI or API for going online; coordinates are only uploaded after accepting a delivery | Add an availability/location-before-assignment flow |
| Driver proximity | The ready-order broadcast allows an available driver through when restaurant or driver coordinates are missing | Define the fallback explicitly; otherwise require valid coordinates before treating a driver as nearby |
| Restaurant creation | The backend supports creation, but the dashboard empty state instructs the owner to use the API and has no creation UI | Add the intended owner creation flow or explicitly keep setup admin-only |
| Socket rooms | Restaurant and driver clients emit a single room string while the server expects a list; the customer tracking client never joins its customer room; the server lets any owner request any `restaurant:*` room; and the dashboard joins only its first restaurant | Use one payload contract, join required rooms, verify ownership, support every owned restaurant, and add connection/event tests |
| Restaurant notifications | The backend can send to an owner's FCM token, but the restaurant dashboard does not register an FCM token | Add registration or narrow the notification requirement |
| Driver smoke test | The test mounts `App` without `ProviderScope` and asserts stale text | Fix the test and make `flutter test` pass |
| CI | Workflow build/test commands are commented out, and workflow production triggers name `master` while the repository workflow requires `main` | Make CI run backend and all three Flutter checks on the correct branches |

Temporary database edits or API tooling may be used to prepare downstream QA data, but they do not count as a pass for the blocked user journey.

## 1. Prepare a Clean QA Environment

Use Node.js `20.19+`, `22.12+`, or `24+` as required by the pinned Prisma packages. Use a Flutter SDK that includes Dart `3.11.x` or another version allowed by the apps' `sdk: ^3.11.0` constraint. Record exact `node --version`, `npm --version`, and `flutter --version` output with the QA evidence.

### PostgreSQL

Create the disposable integration-test database once, then start it on later runs:

```bash
docker run --name uber-eats-test-postgres \
  -e POSTGRES_USER=testuser \
  -e POSTGRES_PASSWORD=testpass \
  -e POSTGRES_DB=testdb \
  -p 5434:5432 \
  -d postgres:16

# On later runs, use this instead of docker run:
docker start uber-eats-test-postgres
docker exec uber-eats-test-postgres pg_isready -U testuser -d testdb
```

If port `5434` or that container name is already in use, choose another dedicated port/name and update `TEST_DATABASE_URL` accordingly. Do not run the `docker run` command again after the container exists.

Keep the integration database separate from development and production. Configure `backend/.env` with development credentials and a dedicated test URL:

```env
DATABASE_URL="postgresql://<development-user>:<password>@localhost:5432/uber_eats_db?schema=public"
TEST_DATABASE_URL="postgresql://testuser:testpass@localhost:5434/testdb"
JWT_SECRET="replace-with-a-long-random-development-secret"
STRIPE_SECRET_KEY="sk_test_..."
```

`TEST_DATABASE_URL` and `JWT_SECRET` are not currently listed in `backend/.env.example`; add them locally when following this guide. Never rely on the backend's development JWT fallback for QA.

Never use production Stripe, Firebase, PostgreSQL, or Google credentials for QA.

Apply and validate migrations:

```bash
cd backend
npm ci
npx prisma generate
npx prisma migrate deploy
npx prisma migrate status
npx prisma validate
```

Confirm the review migrations are applied:

- `20260509000000_add_order_reviews`
- `20260802000000_harden_order_reviews`

### Flutter dependencies

Run in `customer_app`, `restaurant_dashboard`, and `driver_app`:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Device networking

The apps currently use `http://localhost:8000`.

- iOS Simulator and desktop targets can generally use `localhost`.
- Android Emulator normally needs `http://10.0.2.2:8000`.
- Physical devices need the development computer's LAN IP, such as `http://192.168.1.10:8000`.

Ensure every device can reach the same backend before testing. Prefer physical devices for notifications, background location, and realistic permission behavior.

## 2. Establish the Automated Baseline

Record the date, branch, commit, command, result, and failure output for every run.

### Backend

```bash
cd backend
npm run build
npm test -- --runInBand
npm run test:integration
npx prisma validate
```

Expected baseline after issue #34:

- TypeScript build passes.
- With `TEST_DATABASE_URL` configured and reachable, 104 total backend tests pass, including 5 PostgreSQL integration tests.
- Without `TEST_DATABASE_URL`, a normal `npm test` run reports 99 passed and 5 skipped.
- `npm run test:integration` passes all 5 integration tests and deliberately fails when `TEST_DATABASE_URL` is absent.

`npm run test:integration` must fail when `TEST_DATABASE_URL` is absent so database coverage cannot be silently skipped.

### Customer app

```bash
cd customer_app
flutter analyze
flutter test
```

Expected release baseline: 8 tests pass and analysis has no findings. The current `avoid_print` finding in the FCM client is a known Phase 8 cleanup item, not an accepted release result.

### Restaurant dashboard

```bash
cd restaurant_dashboard
flutter analyze
flutter test
```

Expected release baseline: analysis is clean and the smoke test passes. Add feature-level tests for the order and menu flows exercised during Phase 8.

### Driver app

```bash
cd driver_app
flutter analyze
flutter test
```

Expected release baseline: analysis is clean and all tests pass. The current driver smoke test lacks `ProviderScope` and expects stale text; treat it as a Phase 8 defect and fix it before declaring the repository green.

### Repository checks

```bash
git diff --check
git status --short
```

Confirm generated files are current, secrets are ignored, and unrelated changes are not included in QA commits.

## 3. Create Controlled QA Data

Use separate accounts for authorization and data-isolation testing:

| Role | Suggested account |
|---|---|
| Customer A | `qa.customer.a@example.com` |
| Customer B | `qa.customer.b@example.com` |
| Owner A | `qa.owner.a@example.com` |
| Owner B | `qa.owner.b@example.com` |
| Driver A | `qa.driver.a@example.com` |
| Driver B | `qa.driver.b@example.com` |

Create (Restaurant creation currently requires an authenticated API request because the dashboard has no creation screen):

- Restaurant A owned by Owner A.
- Restaurant B owned by Owner B.
- At least three menu items per restaurant.
- One unavailable menu item.
- Valid restaurant and menu images.
- Driver A and Driver B marked available and within 10 km of Restaurant A.
- Customer A with a saved delivery address.

Use recognizable names such as `QA Pizza Kitchen`, `QA Burger House`, and `Margherita QA` so cross-user or cross-restaurant mistakes are obvious.

Until the driver availability blocker is fixed, a QA fixture may set `DriverProfile.isAvailable`, `currentLat`, and `currentLng` to exercise downstream assignment. Record that workaround in the test evidence; it does not validate the missing go-online journey.

## 4. Start the Complete System

Use four terminals.

```bash
# Terminal 1
cd backend
npm run dev

# Terminal 2
cd customer_app
flutter run -d <device-id>

# Terminal 3
cd restaurant_dashboard
flutter run -d <device-id>

# Terminal 4
cd driver_app
flutter run -d <device-id>
```

Verify the backend:

```bash
curl http://localhost:8000/health
```

Expected:

```json
{"success":true,"data":{"status":"ok","message":"Uber Eats Clone API is healthy"}}
```

Keep backend, Flutter, and device logs visible throughout testing.

## 5. Authentication and Authorization

### Registration

Test each role with:

- Empty fields.
- Invalid email.
- Short password.
- Duplicate email and phone.
- Leading and trailing spaces.
- Very long names.
- Wrong role/app combination.
- Valid registration.
- Network loss during submission.
- Rapid double-submission.

Expected:

- Invalid forms do not call the backend.
- Duplicate fields produce understandable errors.
- Successful registration stores the token and opens only role-appropriate screens.
- Repeated taps do not create duplicate accounts.

### Login, persistence, and logout

Test wrong passwords, unknown users, empty fields, valid login, application restart, corrupted/expired tokens, backend unavailability, logout, Back navigation after logout, and direct protected-route navigation.

Expected:

- Sessions survive restart.
- Invalid tokens return users to login.
- Protected screens cannot be restored after logout.
- Errors do not expose stack traces or secrets.

### Cross-role access

Through UI and direct API requests, attempt:

- Customer access to owner functions.
- Owner access to driver functions.
- Driver or owner review submission.
- Owner B editing Owner A's restaurant or menu.
- Customer B reading Customer A's order.
- Driver B updating Driver A's delivery.

Expect `401` for unauthenticated requests and `403` for authenticated but unauthorized requests.

## 6. Restaurant Dashboard

### Restaurant management

Test empty state, valid creation, missing fields, invalid coordinates, editing, status changes, valid image upload, non-image upload, files over 5 MB, broken image URLs, offline updates, retries, and cross-owner access.

Verify changes appear in the customer app after refresh and unauthorized access returns `403`.

Also create two restaurants for one owner. Both must be visible and manageable, and both must receive their own real-time orders. The current dashboard renders and joins only the first restaurant, so this is a known blocker rather than an accepted single-restaurant constraint.

### Menu management

Test:

- Empty menu.
- Add, edit, availability toggle, and deletion.
- Zero, negative, large, and decimal prices.
- Missing names and long descriptions.
- Duplicate submission.
- Delete cancellation and confirmation.
- Cross-owner modification.
- Immediate reflection in the customer app.

Prices must remain precise, unavailable items must not be orderable, and destructive actions must require confirmation.

### Open/closed behavior

Verify active restaurants are discoverable, closed restaurants follow the intended unavailable behavior, existing carts remain safe if a restaurant closes, and closed/deleted restaurants cannot receive invalid new orders.

## 7. Customer Discovery and Cart

### Discovery

Test loading, empty, error, retry, refresh, slow network, complete and partial searches, case differences, spaces, no results, clearing search, and rapid typing.

Old responses must not overwrite newer searches, and refreshes must not create duplicates.

### Restaurant details

Verify restaurant name, image, address, description, rating, menu availability, prices, empty-menu state, broken images, and Back navigation.

### Cart

Test add, increment, decrement, removal at zero, direct removal, clear cancellation/confirmation, empty cart, unavailable items, cross-restaurant additions, rapid tapping, relaunch persistence, and menu changes after an item enters the cart.

Verify:

```text
line total = unit price × quantity
cart total = sum of line totals
```

Quantities must never be negative and one cart must never silently combine multiple restaurants.

## 8. Checkout and Stripe

Use Stripe test mode only. After client-side Stripe confirmation is implemented, use this successful test card:

```text
4242 4242 4242 4242
Any future expiry
Any three-digit CVC
```

Test empty addresses, trimmed addresses, empty carts, valid payment, declined cards, authentication flows, network loss before and after PaymentIntent creation, double-tapping Place Order, cancelled Stripe flows, application restart, and cart changes while checkout is open.

Current limitation: the customer app extracts the PaymentIntent ID without presenting or confirming Stripe's payment UI. In the present build, verify that an unconfirmed PaymentIntent is rejected and file/retain the blocker; do not report a successful UI checkout. A separately confirmed test PaymentIntent or controlled database fixture may be used only to continue testing downstream order, delivery, and review behavior.

Verify:

- Backend calculation is authoritative.
- Stripe amount matches the backend cart total.
- One payment creates one order.
- Successful checkout clears the cart.
- Failed payment creates no order.
- Secrets never appear in logs.
- Confirmation shows the correct order ID.

## 9. Complete Real-Time Happy Path

Run this flow without manually altering the database after the payment and driver-availability blockers are fixed. Until then, clearly label any fixture-assisted run as a partial downstream regression, not a full happy-path pass:

1. Customer A places an order at Restaurant A.
2. Restaurant A receives it without refresh.
3. Owner moves it through `ACCEPTED`, `PREPARING`, and `READY`.
4. Driver A receives the incoming-delivery sheet.
5. Driver A accepts.
6. Customer and restaurant see the assignment.
7. Driver moves through `AT_RESTAURANT`, `IN_TRANSIT`, and `COMPLETED`.
8. Order becomes `DELIVERED` everywhere.
9. Customer submits a rating and review.
10. Restaurant aggregate rating updates.

At every step verify UI state, API response, Socket.IO event, push notification, database state, refresh behavior, and restart recovery.

### Socket.IO events

| Event | Recipient |
|---|---|
| `order:new` | Restaurant |
| `order:status_updated` | Customer |
| `order:available` | Nearby drivers |
| `delivery:assigned` | Customer and restaurant |
| `delivery:status_updated` | Customer and restaurant |
| `driver:location` | Customer |

The server's current join contract accepts a list, for example `['restaurant:<id>']`. Verify that every Flutter client sends the same shape. Also verify that an owner can join only rooms for restaurants they own; an `OWNER` role check alone is insufficient isolation.

Also test backend restart, background/foreground transitions, network interruption, reconnection, duplicate events, late events after navigation, and logout while connected.

No events may leak across customer, restaurant, or driver rooms.

## 10. Driver Assignment and Delivery

### Availability and proximity

Test drivers within and outside 10 km, missing location, denied permissions, disabled location services, approximate location, two available drivers, and a driver with an active delivery. Drivers with missing coordinates must not be treated as nearby unless the product explicitly defines and documents a fallback.

### Acceptance race

Let Driver A and Driver B accept the same ready order nearly simultaneously.

Expected:

- Exactly one succeeds.
- The loser receives a controlled error.
- Only one delivery exists.
- Customer and restaurant see the winner.
- The losing driver remains available.

### Delivery transitions

Only this sequence should succeed:

```text
ASSIGNED → AT_RESTAURANT → IN_TRANSIT → COMPLETED
```

Test skipped, repeated, cross-driver, and post-completion updates. Invalid transitions should return `400`; unauthorized updates should return `403`.

## 11. Live Location and Maps

Prefer a physical device. Test granted, denied, permanently denied, and background permissions; disabled services; poor accuracy; no movement; simulated movement; device lock; backend interruption; and completion while updates are in flight.

Customer checks:

- Driver marker appears and moves smoothly.
- Route and endpoints are correct.
- ETA is plausible.
- Stale updates do not move the marker backward.
- Missing API keys and Directions API failures are controlled.
- Tracking stops after completion or logout.

Watch battery use and location-update frequency.

## 12. Firebase Notifications

Use real devices and valid Firebase configuration. Test new-order, accepted, preparing, ready, assigned, in-transit, delivered, and new-delivery notifications. Customer and driver token registration exists; owner/restaurant token registration is a known blocker and must be implemented before owner push cases can pass.

For every role, test foreground, background, terminated, permission-denied, refreshed tokens, stale tokens, logout/login as another user, and multiple devices where supported.

No notification may reach the wrong user or expose sensitive information.

## 13. Ratings and Reviews

Test:

- Rate action only on delivered orders.
- Submission without stars.
- Ratings 1 through 5.
- Empty and trimmed comments.
- Exactly 1,000 characters.
- More than 1,000 characters through the API.
- Non-string comments through the API.
- Double submission and two-device races.
- Another customer, owner, or driver attempting submission.
- Existing review after restart.
- Screen-reader focus and activation.
- Accurate restaurant average after concurrent reviews.

Run database concurrency coverage:

```bash
cd backend
npm run test:integration
```

## 14. Order History and Profiles

### Order history

Test empty, single, and large histories; newest-first order; all statuses; item expansion; totals; reviews; refresh; errors; retry; and owner/customer isolation.

### Profiles

For every role, test load, edit, duplicate phone, empty/long values, whitespace, offline save, double-save, restart persistence, and logout/login.

Verify customer addresses prefill checkout, driver vehicle data persists, owner data remains isolated, and profile APIs cannot change roles.

## 15. Resilience and Negative Testing

During important flows, stop/restart the backend and PostgreSQL, disable/restore network, add latency, expire JWTs, revoke permissions, disable Maps credentials, simulate Stripe declines, repeat requests, and background/terminate apps.

Every screen should have intentional loading, empty, error, retry, success, and submitting/disabled states.

Watch for infinite spinners, blank screens, duplicates, repeated dialogs, permanently disabled buttons, crashes, leaked stack traces, secrets in logs, and state leaking between users.

## 16. UI and Accessibility

Test small and large phones, tablets where supported, portrait, landscape, large text, dark/light modes, visible keyboard, and screen readers.

Check overflows, clipping, touch-target size, labels, focus order, loading announcements, contrast, error communication, modal dismissal, navigation, and retained form data after errors.

For ratings, confirm every star has a distinct accessibility label and `Rate Order` remains independently focusable.

## 17. Security

Test missing/invalid/expired JWTs, wrong roles, other users' IDs, SQL-like input, HTML/script input, oversized requests, invalid uploads, path-like filenames, duplicate requests, ratings outside 1–5, and invalid order/delivery transitions.

Run:

```bash
cd backend
npm audit
```

Do not run `npm audit fix --force` without reviewing breaking changes.

Confirm `.env`, Firebase service accounts, and API-key files are ignored, and logs contain no JWTs, passwords, Stripe secrets, or private keys.

## 18. Performance and Stability

Observe restaurant/menu load times, cart and checkout latency, socket latency, location update rate, map smoothness, memory after repeated navigation, long sessions, repeated order creation, and large histories.

Useful local targets:

- Normal API responses under roughly 500 ms.
- Socket changes visible within roughly one second.
- No scroll/render overflow.
- No location updates after completion.
- No sustained backend memory growth.

These are QA targets, not formal production SLAs.

## 19. Bug Report Template

Create one GitHub issue per independently fixable defect:

```markdown
## Summary
One-sentence description.

## Environment
- Commit:
- Branch:
- Backend:
- Device:
- OS:
- Flutter:
- Network:

## Preconditions
Required users, restaurant, order, or delivery state.

## Steps to reproduce
1.
2.
3.

## Expected
What should happen.

## Actual
What happened.

## Evidence
- Screenshot/video
- Backend log
- Flutter log
- API request/response
- Relevant database state

## Frequency
Always / intermittent / once

## Severity
Blocker / High / Medium / Low
```

Severity definitions:

- **Blocker:** primary lifecycle cannot complete, security breach, data loss, or widespread crash.
- **High:** major feature unusable without a reasonable workaround.
- **Medium:** incorrect behavior with a workaround.
- **Low:** cosmetic, wording, minor accessibility, or small inconsistency.

## 20. Recommended Execution Order

1. Automated tests and analysis.
2. Authentication and authorization.
3. Restaurant and menu setup.
4. Customer discovery and cart.
5. Stripe checkout.
6. Real-time restaurant order flow.
7. Driver assignment race.
8. Delivery lifecycle.
9. Live location and maps.
10. Notifications.
11. Order history.
12. Ratings and reviews.
13. Profiles.
14. Offline and error recovery.
15. Accessibility and responsive layout.
16. Security.
17. Performance and long-running stability.
18. Full regression rerun.

Do not release with blocker or high-severity issues. Medium issues must be fixed or explicitly accepted; low issues must still be recorded.

## 21. Exit Criteria

The project can move from QA toward deployment only when:

- Backend build, unit tests, and integration tests pass.
- All three Flutter apps pass tests and analysis.
- The complete order lifecycle passes on supported platforms.
- Stripe success and failure cases are controlled.
- Customer payment is confirmed through Stripe before order creation; PaymentIntent creation alone is not considered payment success.
- Socket reconnection is verified.
- Socket room joins use a consistent payload shape and enforce restaurant ownership.
- FCM works in foreground, background, and terminated states.
- Required owner notification behavior is implemented and verified, or explicitly removed from scope.
- Driver location permissions and interruptions are covered.
- Drivers can intentionally go online/offline and publish a location before assignment.
- Maps route and ETA behavior are verified.
- Rating/review concurrency tests pass.
- No blocker or high-severity defects remain.
- Medium defects are fixed or explicitly accepted.
- No secrets are tracked.
- Migrations pass against a clean database.
- QA evidence and results are attached to issue #35.
