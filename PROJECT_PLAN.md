# Uber Eats Clone - Project Plan

## Overview
This document outlines the development phases, milestones, and subtasks for the **Uber Eats Clone** project. The project consists of a Customer app, a Restaurant Dashboard, a Delivery Tracking screen with live location using Google Maps SDK, and a Node.js backend. The tech stack focuses on Flutter for all frontend interfaces and Node.js for the backend.

---

## Strict Git Workflow
We adhere to the following git workflow throughout development:
- **`master` branch**: Production-ready state.
- **`dev` branch**: Active development and integration branch.
- **Feature branches**: Always branch off from `dev` for every issue (e.g., `feature/issue-1-ci-cd`).
- **Merge Process**: 
  1. Finish issue development on the feature branch.
  2. Merge the feature branch into `dev`.
  3. Merge `dev` into `master` ONLY upon completing an entire phase.

---

## Phases & Milestones

### Phase 1: Project Setup & System Architecture
**Milestone:** Initialized project repositories, CI/CD, database schemas, and basic routing.
- **Task 1.1:** Setup GitHub repository, Project board, and CI/CD pipelines.
- **Task 1.2:** Initialize Flutter projects (Customer, Driver, Restaurant Apps/Dashboards) with state management and routing.
- **Task 1.3:** Initialize Node.js backend (Express) and setup Database.
- **Task 1.4:** Design Database Schema (Users, Restaurants, Menu Items, Orders, Deliveries).
- **Task 1.5:** Setup Firebase (for Push Notifications/Auth) and Google Cloud Console (Maps SDK API Keys).

### Phase 2: Authentication & User Profiles
**Milestone:** Users (Customers, Restaurant Owners, Drivers) can sign up, log in, and manage profiles.
- **Task 2.1:** Implement backend authentication structure (JWT & bcrypt).
- **Task 2.2:** Customer App - UI & Integration for Login, Registration, and OTP/Email verification.
- **Task 2.3:** Restaurant Dashboard - Login/Registration logic.
- **Task 2.4:** Driver App - Login/Registration logic & Vehicle Details collection.
- **Task 2.5:** Profile Management screens for all three apps (Address parsing, Avatar upload).

### Phase 3: Restaurant Dashboard & Menu Management
**Milestone:** Restaurants can manage their profiles, menus, and operating hours.
- **Task 3.1:** Backend APIs for Menu CRUD operations and Restaurant details.
- **Task 3.2:** Restaurant Dashboard - UI/UX for Menu Category & Item management (Adding items, pricing, images).
- **Task 3.3:** Restaurant Dashboard - UI for opening/closing the restaurant (Status Management).
- **Task 3.4:** Cloud Storage integration for menu item and restaurant profile images.

### Phase 4: Customer App - Discovery & Ordering
**Milestone:** Customers can browse restaurants, view menus, add to cart, and checkout.
- **Task 4.1:** Backend APIs for searching restaurants, fetching menus, and cart handling.
- **Task 4.2:** Customer App - Home Screen UI (List of nearby restaurants, Promos, Categories).
- **Task 4.3:** Customer App - Restaurant Details & Menu Screen UI.
- **Task 4.4:** Customer App - Cart Management State & UI.
- **Task 4.5:** Checkout Process & Payment Integration.
- **Task 4.6:** Order Placement API integration.

### Phase 5: Order Management & Delivery System
**Milestone:** Real-time order flow between Customer, Restaurant, and Driver apps.
- **Task 5.1:** Setup Socket.io on the backend for real-time order updates.
- **Task 5.2:** Restaurant Dashboard - Active Orders screen to Accept/Reject incoming orders.
- **Task 5.3:** Backend logic to broadcast accepted orders to nearby available drivers.
- **Task 5.4:** Driver App - Incoming Order alert UI (Accept/Reject).
- **Task 5.5:** Driver App - Order Pickup flow (Navigate to restaurant, confirm pickup).

### Phase 6: Live Location Tracking (Google Maps SDK)
**Milestone:** Real-time delivery tracking for the Customer.
- **Task 6.1:** Driver App - Background location tracking & transmitting coordinates via WebSockets.
- **Task 6.2:** Backend - Relay driver location stream securely to the customer.
- **Task 6.3:** Customer App - Active Delivery screen UI with Google Maps integration.
- **Task 6.4:** Customer App - Live marker movement for driver location.
- **Task 6.5:** Route drawing (Polylines) & Estimated Time of Arrival (ETA) calculation using Google Maps Directions API.

### Phase 7: Notifications & Order History
**Milestone:** Status alerts, history logs, and rating functionality.
- **Task 7.1:** Backend & Firebase Cloud Messaging (FCM) integration for targeted Push Notifications.
- **Task 7.2:** Trigger notifications on Order Accepted, Driver Assigned, Order Picked Up, and Order Delivered.
- **Task 7.3:** Customer & Restaurant Apps - Order History UI.
- **Task 7.4:** Customer App - Rating & Review UI for Driver and Restaurant (Post-delivery).

### Phase 8: Polish, Testing & Deployment
**Milestone:** Production-ready applications on respective app stores and hosting platforms.
- **Task 8.1:** QA Testing, Bug fixes, and UI polish across all platforms.
- **Task 8.2:** Backend deployment and Database scaling setup.
- **Task 8.3:** Prepare App Store and Google Play Store metadata.
- **Task 8.4:** Production build generation & App Submissions.
