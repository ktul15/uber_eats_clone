#!/bin/bash
# Script to create GitHub issues for Uber Eats Clone

echo "Creating Phase 1 issues..."
gh issue create --title "Task 1.1: Setup GitHub repository, Project board, and CI/CD pipelines" --body "Phase 1: Project Setup & System Architecture"
gh issue create --title "Task 1.2: Initialize Flutter projects with state management and routing" --body "Phase 1: Project Setup & System Architecture"
gh issue create --title "Task 1.3: Initialize Node.js backend and setup Database" --body "Phase 1: Project Setup & System Architecture"
gh issue create --title "Task 1.4: Design Database Schema" --body "Phase 1: Project Setup & System Architecture"
gh issue create --title "Task 1.5: Setup Firebase and Google Cloud Console" --body "Phase 1: Project Setup & System Architecture"

echo "Creating Phase 2 issues..."
gh issue create --title "Task 2.1: Implement backend authentication structure" --body "Phase 2: Authentication & User Profiles"
gh issue create --title "Task 2.2: Customer App - Login, Registration, and OTP/Email verification" --body "Phase 2: Authentication & User Profiles"
gh issue create --title "Task 2.3: Restaurant Dashboard - Login/Registration logic" --body "Phase 2: Authentication & User Profiles"
gh issue create --title "Task 2.4: Driver App - Login/Registration logic & Vehicle Details collection" --body "Phase 2: Authentication & User Profiles"
gh issue create --title "Task 2.5: Profile Management screens for all three apps" --body "Phase 2: Authentication & User Profiles"

echo "Creating Phase 3 issues..."
gh issue create --title "Task 3.1: Backend APIs for Menu CRUD operations and Restaurant details" --body "Phase 3: Restaurant Dashboard & Menu Management"
gh issue create --title "Task 3.2: Restaurant Dashboard - Menu Category & Item management" --body "Phase 3: Restaurant Dashboard & Menu Management"
gh issue create --title "Task 3.3: Restaurant Dashboard - Status Management (Open/Close)" --body "Phase 3: Restaurant Dashboard & Menu Management"
gh issue create --title "Task 3.4: Cloud Storage integration for images" --body "Phase 3: Restaurant Dashboard & Menu Management"

echo "Creating Phase 4 issues..."
gh issue create --title "Task 4.1: Backend APIs for searching restaurants, fetching menus, and cart handling" --body "Phase 4: Customer App - Discovery & Ordering"
gh issue create --title "Task 4.2: Customer App - Home Screen UI" --body "Phase 4: Customer App - Discovery & Ordering"
gh issue create --title "Task 4.3: Customer App - Restaurant Details & Menu Screen UI" --body "Phase 4: Customer App - Discovery & Ordering"
gh issue create --title "Task 4.4: Customer App - Cart Management State & UI" --body "Phase 4: Customer App - Discovery & Ordering"
gh issue create --title "Task 4.5: Checkout Process & Payment Integration" --body "Phase 4: Customer App - Discovery & Ordering"
gh issue create --title "Task 4.6: Order Placement API integration" --body "Phase 4: Customer App - Discovery & Ordering"

echo "Creating Phase 5 issues..."
gh issue create --title "Task 5.1: Setup Socket.io on the backend for real-time order updates" --body "Phase 5: Order Management & Delivery System"
gh issue create --title "Task 5.2: Restaurant Dashboard - Active Orders screen" --body "Phase 5: Order Management & Delivery System"
gh issue create --title "Task 5.3: Backend logic for driver assignment" --body "Phase 5: Order Management & Delivery System"
gh issue create --title "Task 5.4: Driver App - Incoming Order alert UI" --body "Phase 5: Order Management & Delivery System"
gh issue create --title "Task 5.5: Driver App - Order Pickup flow" --body "Phase 5: Order Management & Delivery System"

echo "Creating Phase 6 issues..."
gh issue create --title "Task 6.1: Driver App - Background location tracking" --body "Phase 6: Live Location Tracking"
gh issue create --title "Task 6.2: Backend - Relay driver location stream" --body "Phase 6: Live Location Tracking"
gh issue create --title "Task 6.3: Customer App - Active Delivery screen UI" --body "Phase 6: Live Location Tracking"
gh issue create --title "Task 6.4: Customer App - Live marker movement" --body "Phase 6: Live Location Tracking"
gh issue create --title "Task 6.5: Route drawing & ETA calculation" --body "Phase 6: Live Location Tracking"

echo "Creating Phase 7 issues..."
gh issue create --title "Task 7.1: FCM integration for Push Notifications" --body "Phase 7: Notifications & Order History"
gh issue create --title "Task 7.2: Trigger notifications on Order Status changes" --body "Phase 7: Notifications & Order History"
gh issue create --title "Task 7.3: Order History UI for Customer & Restaurant Apps" --body "Phase 7: Notifications & Order History"
gh issue create --title "Task 7.4: Customer App - Rating & Review UI" --body "Phase 7: Notifications & Order History"

echo "Creating Phase 8 issues..."
gh issue create --title "Task 8.1: QA Testing and UI polish" --body "Phase 8: Polish, Testing & Deployment"
gh issue create --title "Task 8.2: Backend deployment and Database scaling setup" --body "Phase 8: Polish, Testing & Deployment"
gh issue create --title "Task 8.3: Prepare App Store/Play Store metadata" --body "Phase 8: Polish, Testing & Deployment"
gh issue create --title "Task 8.4: Production build generation & App Submissions" --body "Phase 8: Polish, Testing & Deployment"

echo "Successfully created all issues!"
