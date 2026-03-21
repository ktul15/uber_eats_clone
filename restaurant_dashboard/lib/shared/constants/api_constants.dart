class ApiConstants {
  static const String baseUrl = 'http://localhost:8000';

  // Auth endpoints
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';

  // Profile endpoints
  static const String profile = '/api/users/profile';

  // Restaurant & Menu endpoints
  static const String myRestaurants = '/api/restaurants/owner/my';
  static const String upload = '/api/upload';
  static String restaurantById(String id) => '/api/restaurants/$id';
  static String restaurantMenu(String id) => '/api/restaurants/$id/menu';
}
