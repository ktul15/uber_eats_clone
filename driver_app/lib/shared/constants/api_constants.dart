class ApiConstants {
  static const String baseUrl = 'http://localhost:8000';

  // Auth endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';

  // Profile endpoints
  static const String profile = '/api/users/profile';

  // Delivery endpoints
  static const String acceptDelivery = '/api/deliveries/accept';
  static const String activeDelivery = '/api/deliveries/active';
  static String updateDeliveryStatus(String id) => '/api/deliveries/$id/status';
  static String updateDeliveryLocation(String id) => '/api/deliveries/$id/location';

  // Notification endpoints
  static const String fcmToken = '/api/users/fcm-token';
}
