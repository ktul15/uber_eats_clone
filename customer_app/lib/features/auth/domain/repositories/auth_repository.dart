import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:customer_app/features/auth/data/data_sources/auth_api_client.dart';
import 'package:customer_app/features/auth/data/models/user_dto.dart';
import 'package:customer_app/features/auth/domain/models/user.dart';

class AuthRepository {
  final AuthApiClient _apiClient;
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  AuthRepository({
    required AuthApiClient apiClient,
    required FlutterSecureStorage storage,
  }) : _apiClient = apiClient,
       _storage = storage;

  /// Register a new customer and persist JWT token.
  Future<User> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final response = await _apiClient.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    await _storage.write(key: _tokenKey, value: response.token);
    return _mapDtoToUser(response.user);
  }

  /// Login and persist JWT token.
  Future<User> login({required String email, required String password}) async {
    final response = await _apiClient.login(email: email, password: password);

    await _storage.write(key: _tokenKey, value: response.token);
    return _mapDtoToUser(response.user);
  }

  /// Check if a JWT token exists.
  Future<bool> isAuthenticated() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  /// Get the stored JWT token.
  Future<String?> getToken() async {
    return _storage.read(key: _tokenKey);
  }

  /// Clear the stored token (logout).
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  User _mapDtoToUser(UserDto dto) {
    return User(id: dto.id, email: dto.email, role: dto.role);
  }
}
