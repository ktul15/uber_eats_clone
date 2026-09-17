import { cert, getApps, initializeApp } from 'firebase-admin/app';
import { getMessaging as firebaseMessaging, Messaging } from 'firebase-admin/messaging';

let cachedMessaging: Messaging | null = null;

export function initFirebase(): void {
    if (getApps().length > 0) {
        cachedMessaging = firebaseMessaging();
        return;
    }

    const projectId = process.env.FIREBASE_PROJECT_ID;
    const clientEmail = process.env.FIREBASE_CLIENT_EMAIL;
    const privateKey = process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n');

    if (!projectId || !clientEmail || !privateKey) {
        console.warn(JSON.stringify({
            event: 'firebase.disabled',
            reason: 'missing_credentials',
            missing: [
                !projectId ? 'FIREBASE_PROJECT_ID' : null,
                !clientEmail ? 'FIREBASE_CLIENT_EMAIL' : null,
                !privateKey ? 'FIREBASE_PRIVATE_KEY' : null,
            ].filter(Boolean),
        }));
        return;
    }

    initializeApp({
        credential: cert({ projectId, clientEmail, privateKey }),
    });

    cachedMessaging = firebaseMessaging();
    console.info(JSON.stringify({ event: 'firebase.initialized' }));
}

export function getMessaging(): Messaging | null {
    return cachedMessaging;
}
