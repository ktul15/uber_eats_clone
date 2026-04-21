import { Server, Socket } from 'socket.io';
import { Server as HttpServer } from 'http';
import { verifySocketToken } from './socket.auth';
import { rooms } from './rooms';

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
        console.log(`[Socket] connected: ${socket.id} user=${user.id} role=${user.role}`);

        socket.on('join', (rooms: string[]) => {
            const allowed = filterAllowedRooms(user, rooms);
            allowed.forEach((room) => socket.join(room));
        });

        socket.on('disconnect', (reason: string) => {
            console.log(`[Socket] disconnected: ${socket.id} reason=${reason}`);
        });
    });

    return io;
}

export function getIO(): Server {
    if (!io) throw new Error('Socket.io not initialized. Call initSocket() first.');
    return io;
}

function filterAllowedRooms(user: { id: string; role: string }, requested: string[]): string[] {
    return requested.filter((room) => {
        if (room === rooms.customer(user.id)) return true;
        if (room.startsWith('restaurant:') && user.role === 'OWNER') return true;
        if (room === rooms.driver(user.id) && user.role === 'DRIVER') return true;
        return false;
    });
}
