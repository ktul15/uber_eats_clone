# External Services Setup Guide

To run this application locally and deploy to production, you will need to configure **Firebase** and **Google Cloud Console**. Since API keys and service accounts are sensitive, they are not committed to this repository.

Please follow these steps to secure your credentials.

---

## 1. Firebase Setup (Auth & Push Notifications)

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click **Create Project** (e.g., `uber-eats-clone`).
3. Enable **Authentication** (Email/Password & Phone).
4. Enable **Cloud Messaging** (FCM).
5. **Backend Setup:**
   - Go to **Project Settings > Service Accounts**.
   - Click **Generate new private key** for the Node.js Admin SDK.
   - Download the JSON file.
   - Open your `backend/.env.example` file, rename it to `.env`, and populate those variables using the JSON file data.

6. **Flutter Apps Setup:**
   - Add iOS and Android apps to the Firebase Console.
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   - Place them inside their respective directories (`android/app/` and `ios/Runner/`) for the `customer_app`, `restaurant_dashboard`, and `driver_app`.

---

## 2. Google Cloud Platform Setup (Maps & Routing)

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a Project or select your connected Firebase Project.
3. Navigate to **APIs & Services > Library** and enable:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Routes API / Directions API (for driver navigation ETA & Polylines)
   - Places API (for customer address search)
4. Go to **APIs & Services > Credentials** and generate an API key. 
   - *Recommendation: Restrict this key to your apps only!*
5. In each Flutter app:
   - Look in `lib/core/constants/api_keys.dart.example`.
   - Rename these files to `api_keys.dart`.
   - Paste your generated API key inside.

---

## 3. Stripe Setup (Payments)

1. Create a [Stripe](https://stripe.com/) account.
2. Go to **Developers > API keys**.
3. Copy your specific `Publishable key` (for the Flutter frontend) and `Secret key` (for your backend `.env`).

*Once `.env` files and `api_keys.dart` files are created, ensure they are in your `.gitignore` to prevent any leaked secrets!*
