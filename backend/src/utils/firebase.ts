import * as admin from 'firebase-admin';

let cachedMessaging: admin.messaging.Messaging | null = null;

export function initFirebase(): void {
    if (admin.apps.length > 0) return;

    const projectId = process.env.FIREBASE_PROJECT_ID;
    const clientEmail = process.env.FIREBASE_CLIENT_EMAIL;
    const privateKey = process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n');

    if (!projectId || !clientEmail || !privateKey) {
        console.warn('[Firebase] Missing credentials — FCM disabled. Set FIREBASE_PROJECT_ID, FIREBASE_CLIENT_EMAIL, FIREBASE_PRIVATE_KEY in .env');
        return;
    }

    admin.initializeApp({
        credential: admin.credential.cert({ projectId, clientEmail, privateKey }),
    });

    cachedMessaging = admin.messaging();
    console.log('[Firebase] Admin SDK initialized');
}

export function getMessaging(): admin.messaging.Messaging | null {
    return cachedMessaging;
}
