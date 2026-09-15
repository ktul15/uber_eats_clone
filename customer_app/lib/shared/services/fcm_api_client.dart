import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:customer_app/shared/constants/api_constants.dart';

class FcmApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  FcmApiClient({required Dio dio, required FlutterSecureStorage storage})
    : _dio = dio,
      _storage = storage;

  Future<void> registerToken(String fcmToken) async {
    try {
      final options = await _getAuthOptions();
      if (options == null) return;
      await _dio.patch(
        ApiConstants.fcmToken,
        data: {'fcmToken': fcmToken},
        options: options,
      );
    } on DioException {
      // Push registration must never block authentication.
    }
  }

  Future<void> removeToken(String fcmToken) async {
    try {
      final options = await _getAuthOptions();
      if (options == null) return;
      await _dio.delete(
        ApiConstants.fcmToken,
        data: {'fcmToken': fcmToken},
        options: options,
      );
    } on DioException {
      // Logout still proceeds if the network is unavailable.
    }
  }

  Future<Options?> _getAuthOptions() async {
    final jwt = await _storage.read(key: _tokenKey);
    if (jwt == null) return null;
    return Options(headers: {'Authorization': 'Bearer $jwt'});
  }
}
