export const rooms = {
    customer: (userId: string) => `customer:${userId}`,
    restaurant: (restaurantId: string) => `restaurant:${restaurantId}`,
    driver: (userId: string) => `driver:${userId}`,
} as const;
