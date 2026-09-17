class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8000',
  );

  // Auth endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';

  // Profile endpoints
  static const String profile = '/api/users/profile';
  static const String fcmToken = '/api/users/fcm-token';

  // Restaurant & Menu endpoints
  static const String myRestaurants = '/api/restaurants/owner/my';
  static const String restaurants = '/api/restaurants';
  static const String upload = '/api/upload';
  static String restaurantById(String id) => '/api/restaurants/$id';
  static String restaurantMenu(String id) => '/api/restaurants/$id/menu';
}
