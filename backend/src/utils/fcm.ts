import { getMessaging } from './firebase';

const STALE_TOKEN_ERROR = 'messaging/registration-token-not-registered';

export interface FcmPayload {
    title: string;
    body: string;
    data?: Record<string, string>;
}

// Returns true on success, false if token is stale/invalid
export async function sendPushNotification(fcmToken: string, payload: FcmPayload): Promise<boolean> {
    const messaging = getMessaging();
    if (!messaging) return false;

    try {
        await messaging.send({
            token: fcmToken,
            notification: { title: payload.title, body: payload.body },
            ...(payload.data && { data: payload.data }),
        });
        return true;
    } catch (err: any) {
        if (err.code === STALE_TOKEN_ERROR) return false;
        console.error('[FCM] sendPushNotification error:', err.message);
        return false;
    }
}

// Returns array of stale tokens that should be removed from DB
export async function sendPushNotificationToMany(fcmTokens: string[], payload: FcmPayload): Promise<string[]> {
    const messaging = getMessaging();
    if (!messaging || fcmTokens.length === 0) return [];

    const response = await messaging.sendEachForMulticast({
        tokens: fcmTokens,
        notification: { title: payload.title, body: payload.body },
        ...(payload.data && { data: payload.data }),
    });

    const staleTokens: string[] = [];
    response.responses.forEach((res, i) => {
        const token = fcmTokens[i];
        if (!res.success && res.error?.code === STALE_TOKEN_ERROR && token) {
            staleTokens.push(token);
        }
    });
    return staleTokens;
}
