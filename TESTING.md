# Testing Guide — Uber Eats Clone

Developer-oriented reference for running the system and performing a focused smoke test. For full Phase 8 regression, security, accessibility, resilience, evidence collection, and release exit criteria, use [QA_GUIDE.md](QA_GUIDE.md).

Expected results below describe the intended behavior. See **Known Current Limitations** before executing the end-to-end flow.

---

## Prerequisites

| Tool | Version |
|------|---------|
| Node.js | `20.19+`, `22.12+`, or `24+` (Prisma requirement) |
| npm | Version bundled with the selected supported Node release |
| Flutter | Stable release containing Dart `3.11.x` or compatible with `sdk: ^3.11.0` |
| PostgreSQL | 14+ |
| Stripe account | Test mode keys (required for payment work) |

Backend environment must be configured before running anything.

```bash
cp backend/.env.example backend/.env
# Fill in: DATABASE_URL, JWT_SECRET, STRIPE_SECRET_KEY and Firebase values
```

`JWT_SECRET` is required for a meaningful QA run even though the current example file omits it and the backend has a development fallback. Add a long, non-production secret locally.

Run DB migrations:
```bash
cd backend
npx prisma migrate deploy
npx prisma generate
```

---

## Running the Apps

> Run all four simultaneously in separate terminals for end-to-end testing.

### 1. Backend (port 8000)
```bash
cd backend
npm ci
npm run dev
```
Verify: `GET http://localhost:8000/health` returns:

```json
{"success":true,"data":{"status":"ok","message":"Uber Eats Clone API is healthy"}}
```

### 2. Customer App
```bash
cd customer_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### 3. Restaurant Dashboard
```bash
cd restaurant_dashboard
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

### 4. Driver App
```bash
cd driver_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

> If running multiple Flutter apps on a simulator/device, use `flutter run -d <device-id>` or use different simulators.

### Device networking

All three apps currently use `http://localhost:8000`. That generally works for desktop and the iOS Simulator. Use `http://10.0.2.2:8000` for the Android Emulator or the development computer's LAN IP for a physical device, then restore the constant before committing. Update each app's `lib/shared/constants/api_constants.dart` consistently.

---

## Known Current Limitations

These are open QA blockers in the current implementation:

- Registration immediately returns a JWT; OTP/email verification mentioned in the project roadmap is not implemented.
- The customer app creates a Stripe PaymentIntent but does not collect/confirm a card payment, so a normal UI checkout cannot produce Stripe status `succeeded`. The backend also does not bind a succeeded intent's amount/customer/cart metadata to the order or prevent reuse.
- New drivers default to unavailable and have no go-online/API flow; pre-assignment location is also missing. The current nearby-driver query permits missing coordinates instead of rejecting or explicitly handling them.
- The restaurant dashboard has no restaurant-creation screen; an authenticated `POST /api/restaurants` request is currently required for setup.
- Restaurant and driver socket clients emit a scalar room string while the backend expects a list. Customer tracking never joins its customer room. The server does not verify restaurant ownership when an owner requests a room, and the dashboard joins only the first owned restaurant.
- The restaurant dashboard does not register an FCM token, so owner push notifications cannot be validated end to end.
- The driver smoke test fails because it lacks `ProviderScope` and expects stale screen text.
- GitHub Actions currently has its build, analysis, and test commands commented out, and its production trigger uses `master` instead of the required `main` branch.

Treat these as defects to resolve in issue #35. Fixture-assisted testing can validate downstream behavior, but it is not a successful end-to-end result.

---

## Test Scenarios

### Backend — API Sanity

#### Health Check

- `GET /health` → `200 { "success": true, "data": { "status": "ok", "message": "Uber Eats Clone API is healthy" } }`

---

### Auth — All Apps

All three apps share the same auth flow pattern.

#### Register

| # | Action | Expected |
|---|--------|----------|
| 1 | Open app fresh (unauthenticated) | Redirected to `/login` (restaurant dashboard) or app shows login prompt |
| 2 | Tap "Register" / navigate to register screen | Register form appears |
| 3 | Submit with empty fields | Validation errors shown on each required field |
| 4 | Submit with invalid email format | Email validation error |
| 5 | Submit with password < min length | Password validation error |
| 6 | Submit valid CUSTOMER registration (name, email, phone, password) | Success — redirected to home |
| 7 | Repeat with same email | Error: email already in use |
| 8 | Register as OWNER (restaurant dashboard) | Success — redirected to home dashboard |
| 9 | Register as DRIVER (driver app) with vehicle type + license number | Success — redirected to home |

#### Login

| # | Action | Expected |
|---|--------|----------|
| 1 | Submit with wrong password | Error message displayed |
| 2 | Submit with unregistered email | Error message displayed |
| 3 | Submit valid credentials | Success — JWT stored, redirected to home |
| 4 | Close and reopen app | Still logged in (token persisted) |

#### Logout

| # | Action | Expected |
|---|--------|----------|
| 1 | Tap logout on Profile screen | Token cleared, redirected to login |
| 2 | Try navigating to protected route after logout | Redirected to login |

---

### Customer App

#### Browse Restaurants

| # | Action | Expected |
|---|--------|----------|
| 1 | Open home screen | List of all active restaurants shown |
| 2 | Leave search empty | All restaurants displayed |
| 3 | Type restaurant name in search bar | List filters after ~300ms debounce |
| 4 | Clear search | Full list restored |
| 5 | Tap a restaurant card | Navigate to restaurant detail screen |

#### Restaurant Detail + Menu

| # | Action | Expected |
|---|--------|----------|
| 1 | Open restaurant detail | Restaurant name, address, image shown |
| 2 | Scroll menu items | Full menu list shown with prices and availability |
| 3 | Tap "+" on an available item | Item added to cart, quantity indicator shown |
| 4 | Tap "+" again | Quantity increments |
| 5 | Tap "−" | Quantity decrements (0 removes from cart) |
| 6 | Try adding item from a different restaurant (with existing cart) | Error: cart belongs to another restaurant |

#### Cart

| # | Action | Expected |
|---|--------|----------|
| 1 | Open cart with items | Items listed with quantities and line totals |
| 2 | Tap "−" to reduce quantity to 0 | Item removed from list |
| 3 | Tap trash / remove item | Item removed |
| 4 | Tap "Clear Cart" | Confirmation dialog shown |
| 5 | Confirm clear | Cart emptied, empty state shown |
| 6 | Open cart when empty | Empty state message shown |
| 7 | Tap "Proceed to Checkout" | Navigate to checkout screen |

#### Checkout + Place Order

> Intended behavior after Stripe client confirmation is implemented. Use test card `4242 4242 4242 4242`, any future expiry, and any three-digit CVC.

| # | Action | Expected |
|---|--------|----------|
| 1 | Open checkout | Order summary with items and total shown |
| 2 | Delivery address pre-filled from profile | Address field populated |
| 3 | Clear address and submit | Validation error |
| 4 | Enter valid address and tap "Place Order" | Stripe payment UI opens and the PaymentIntent is confirmed |
| 5 | Successful payment | Navigate to Order Confirmation screen with order ID |
| 6 | Tap "View Orders" from confirmation | Navigate to orders list |

Current-build check: an unconfirmed PaymentIntent must be rejected by the backend and must not create an order. Do not interpret PaymentIntent creation as successful payment.

#### Order History

| # | Action | Expected |
|---|--------|----------|
| 1 | Open Orders screen | All past orders listed with status badges |
| 2 | No orders yet | Empty state message shown |
| 3 | Place an order, then view orders | New order appears at top |
| 4 | Order status updates as restaurant/driver act | Status badge updates (may require pull-to-refresh) |

#### Profile

| # | Action | Expected |
|---|--------|----------|
| 1 | Open Profile screen | Name, email, phone, address pre-filled |
| 2 | Edit name, tap Save | Profile updated, success feedback |
| 3 | Edit phone to duplicate (used by another account) | Error: phone already in use |
| 4 | Edit delivery address | Address saved, pre-filled in checkout |

---

### Restaurant Dashboard

#### Home Dashboard

| # | Action | Expected |
|---|--------|----------|
| 1 | Login as OWNER | Home shows list of owned restaurants |
| 2 | No restaurants created yet | Empty state instructs the owner to use the backend API; record the missing creation UI as a blocker if in scope |
| 3 | Tap the cover-image camera button on a restaurant card | Photo library picker opens |
| 4 | Select image | Image uploaded, restaurant card updates |
| 5 | Tap restaurant card → navigate to menu | Menu management screen opens |
| 6 | Tap "Active Orders" | Active orders screen opens |

#### Menu Management

| # | Action | Expected |
|---|--------|----------|
| 1 | Open menu for restaurant | All existing menu items listed |
| 2 | No items yet | Empty state shown |
| 3 | Tap "Add Item" | Modal form dialog opens |
| 4 | Submit empty form | Validation errors on required fields |
| 5 | Fill name, price, description, image URL — submit | Item added, list refreshes |
| 6 | Tap edit on existing item | Form pre-filled with item data |
| 7 | Modify price, save | Item updated in list |
| 8 | Toggle availability on item | `isAvailable` flips — reflected in customer app |
| 9 | Tap delete on item | Confirmation → item removed from list |

#### Active Orders + Real-Time Updates

> Requires Customer App open and backend running with Socket.IO.

| # | Action | Expected |
|---|--------|----------|
| 1 | Open Active Orders screen | Connects to socket, joins `restaurant:{id}` room |
| 2 | Customer places order for this restaurant | New order appears in list in real time (`order:new` event) |
| 3 | Order shows items, total, customer delivery address | All order details visible |
| 4 | Tap "Accept" | Order status → ACCEPTED |
| 5 | Tap "Start Preparing" | Order status → PREPARING |
| 6 | Tap "Mark Ready" | Order status → READY; backend broadcasts `order:available` to nearby drivers |
| 7 | Tap cancel on an eligible active order and confirm | Order status → CANCELLED |
| 8 | Disconnect and restore the socket connection | Events resume without duplicates; verify with logs because the restaurant dashboard currently has no connection-status indicator |

#### Profile

| # | Action | Expected |
|---|--------|----------|
| 1 | Open Profile | Name, phone pre-filled |
| 2 | Edit and save | Profile updated |
| 3 | Logout | Redirected to login |

---

### Driver App

#### Home — Available Deliveries

> Requires: Customer placed order, restaurant marked it READY, and driver is available with a location within 10 km. The current app lacks the go-online/pre-assignment location flow, so a temporary QA fixture is required until that blocker is fixed.

| # | Action | Expected |
|---|--------|----------|
| 1 | Login as DRIVER | Home screen loads, socket connects |
| 2 | Socket status indicator | Shows “Online — Waiting for orders” |
| 3 | Active delivery exists on load | Auto-redirected to `/delivery` screen |
| 4 | Restaurant marks order READY | `order:available` event received, `IncomingOrderSheet` modal appears |
| 5 | Modal shows restaurant name, delivery address, total | Correct order info displayed |
| 6 | Tap "Decline" on modal | Modal dismisses, driver stays on home |
| 7 | Tap "Accept" | `POST /api/deliveries/accept` called, navigate to Active Delivery screen |
| 8 | Another driver accepts first | Error handled gracefully |

#### Active Delivery — Status Flow

| # | Action | Expected |
|---|--------|----------|
| 1 | Open an ASSIGNED delivery | Restaurant name/address and total are shown |
| 2 | Tap "I've Arrived at Restaurant" | Status → AT_RESTAURANT; order items and delivery address become visible |
| 3 | Tap "Confirm Pickup" | Status → IN_TRANSIT |
| 4 | Tap "Confirm Delivery" | Status → COMPLETED; order status → DELIVERED |
| 5 | After completion | Auto-navigate back to home screen; driver availability reset to true |
| 6 | Try to skip a status (e.g., go from ASSIGNED to IN_TRANSIT directly) | Backend rejects with error |

#### Profile

| # | Action | Expected |
|---|--------|----------|
| 1 | Open Profile | Name, phone, vehicle type, license number pre-filled |
| 2 | Edit vehicle type | Saved successfully |
| 3 | Edit license number | Saved successfully |
| 4 | Logout | Redirected to login |

---

## End-to-End Happy Path

Run all four components concurrently and walk through this flow after the known payment, driver availability, and socket blockers are fixed. Until then, record any fixture-assisted run as a partial downstream regression:

```
1. [Customer App]       Register as CUSTOMER
2. [Restaurant Dashboard/API] Register as OWNER → create restaurant through the API until creation UI exists → add menu items
3. [Driver App]         Register as DRIVER (set vehicle + license, ensure location near restaurant)
4. [Customer App]       Browse → open restaurant → add items to cart → checkout → place order
5. [Restaurant Dashboard] Active Orders → new order appears in real time → mark READY
6. [Driver App]         Incoming order modal appears → Accept
7. [Customer App]       Order detail / orders list → status shows driver assigned
8. [Restaurant Dashboard] Refresh active orders and verify the assigned delivery/order state
9. [Driver App]         Step through: AT_RESTAURANT → IN_TRANSIT → COMPLETED
10.[Customer App]       Order status updates to DELIVERED
11.[Restaurant Dashboard] Order marked delivered
12.[Customer App]       Submit a rating/review and verify the restaurant rating updates
```

---

## Socket.IO Events Reference

| Event | Flow | Payload |
|-------|------|---------|
| `order:new` | Server → Restaurant room | `{ orderId, restaurantId, totalAmount, createdAt }` |
| `order:status_updated` | Server → Customer room | `{ orderId, status, updatedAt }` |
| `order:available` | Server → Driver rooms (≤10km) | `{ orderId, restaurantId, restaurantName, deliveryAddress, totalAmount }` |
| `delivery:assigned` | Server → Customer + Restaurant rooms | `{ deliveryId, orderId, driverName, driverVehicleType }` |
| `delivery:status_updated` | Server → Customer + Restaurant rooms | `{ deliveryId, orderId, status, updatedAt }` |
| `driver:location` | Server → Customer room | `{ deliveryId, lat, lng, updatedAt }` |

**Room naming:** `customer:{userId}` · `restaurant:{restaurantId}` · `driver:{userId}`

**Join payload:** the backend currently expects a list such as `['customer:<userId>']`. Clients must use the same payload shape, and the customer tracking client must actually join its room. Verify that owners cannot join restaurant rooms they do not own.

---

## Edge Cases & Error Scenarios

| Scenario | Expected Behaviour |
|----------|--------------------|
| Add items from two different restaurants | Second restaurant blocked; error shown |
| Place order with empty cart | Checkout blocked |
| Accept delivery already taken by another driver | Error returned from API |
| Driver tries to skip delivery status | 400 error from backend |
| Socket disconnects mid-session | Connection recovers or an explicit retry is available; no events are lost, leaked, or duplicated |
| Upload image > 5MB | Backend rejects with file size error |
| Upload non-image file | Backend rejects with file type error |
| JWT expired | API returns 401; app redirects to login |
| Owner tries to edit another owner's restaurant | 403 Forbidden |
| Owner tries to modify another restaurant's menu | 403 Forbidden |

---

## API Base URLs

| Service | URL |
|---------|-----|
| Backend REST API | `http://localhost:8000/api` |
| Static uploads | `http://localhost:8000/uploads` |
| Socket.IO | `http://localhost:8000` |

All Flutter apps currently hardcode `http://localhost:8000` in `lib/shared/constants/api_constants.dart`; adjust it for the selected emulator/device as described above.

---

## Automated Verification

Run these before manual smoke testing:

```bash
cd backend
npm run build
npm test -- --runInBand
```

With a reachable `TEST_DATABASE_URL`, the backend should pass 104 tests total, including 5 PostgreSQL integration tests. Without it, the normal suite reports 99 passed and 5 skipped; `npm run test:integration` intentionally fails if the variable is absent.

In each Flutter app, run:

```bash
flutter analyze
flutter test
```

The release baseline is zero analysis findings and all tests passing. Current test counts are documented in `QA_GUIDE.md`; counts should be updated whenever tests are added or removed.
