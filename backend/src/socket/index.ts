import { Server, Socket } from 'socket.io';
import { Server as HttpServer } from 'http';
import { verifySocketToken } from './socket.auth';
import { rooms } from './rooms';
import { prisma } from '../utils/prisma';

let io: Server | null = null;

export function initSocket(httpServer: HttpServer): Server {
    io = new Server(httpServer, {
        cors: {
            origin: process.env.CLIENT_URL ?? 'http://localhost:3000',
            methods: ['GET', 'POST'],
            credentials: true,
        },
    });

    io.use(verifySocketToken);

    io.on('connection', (socket: Socket) => {
        const user = socket.data.user as { id: string; role: string };
        console.info(JSON.stringify({ event: 'socket.connected', socketId: socket.id, userId: user.id, role: user.role }));

        socket.on('join', async (
            requested: unknown,
            acknowledge?: (result: { joined: string[]; denied: string[]; error?: string }) => void,
        ) => {
            if (!Array.isArray(requested) || requested.some((room) => typeof room !== 'string')) {
                acknowledge?.({ joined: [], denied: [], error: 'join payload must be a string array' });
                return;
            }

            await joinAuthorizedRooms(socket, user, [...new Set(requested as string[])], acknowledge);
        });

        socket.on('disconnect', (reason: string) => {
            console.info(JSON.stringify({ event: 'socket.disconnected', socketId: socket.id, reason }));
        });
    });

    return io;
}

export async function joinAuthorizedRooms(
    socket: Pick<Socket, 'id' | 'join'>,
    user: { id: string; role: string },
    requested: string[],
    acknowledge?: (result: { joined: string[]; denied: string[]; error?: string }) => void,
): Promise<void> {
    try {
        const joined = await filterAllowedRooms(user, requested);
        await Promise.all(joined.map((room) => socket.join(room)));
        const allowed = new Set(joined);
        acknowledge?.({ joined, denied: requested.filter((room) => !allowed.has(room)) });
    } catch (error) {
        console.error(JSON.stringify({
            event: 'socket.join_failed',
            socketId: socket.id,
            userId: user.id,
            message: error instanceof Error ? error.message : 'Unknown error',
        }));
        acknowledge?.({ joined: [], denied: requested, error: 'Unable to authorize rooms' });
    }
}

export function getIO(): Server {
    if (!io) throw new Error('Socket.io not initialized. Call initSocket() first.');
    return io;
}

export async function filterAllowedRooms(
    user: { id: string; role: string },
    requested: string[],
): Promise<string[]> {
    const allowed = new Set<string>();
    if (user.role === 'CUSTOMER' && requested.includes(rooms.customer(user.id))) {
        allowed.add(rooms.customer(user.id));
    }
    if (user.role === 'DRIVER' && requested.includes(rooms.driver(user.id))) {
        allowed.add(rooms.driver(user.id));
    }

    if (user.role === 'OWNER') {
        const restaurantIds = requested
            .filter((room) => room.startsWith('restaurant:'))
            .map((room) => room.slice('restaurant:'.length))
            .filter(Boolean);
        if (restaurantIds.length > 0) {
            const owned = await prisma.restaurant.findMany({
                where: { id: { in: restaurantIds }, ownerId: user.id },
                select: { id: true },
            });
            owned.forEach((restaurant) => allowed.add(rooms.restaurant(restaurant.id)));
        }
    }

    return requested.filter((room) => allowed.has(room));
}
