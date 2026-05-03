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
    } on DioException catch (e) {
      // Silent fail — never block auth flow for FCM token registration
      print('[FCM] Token registration failed: ${e.message}');
    }
  }

  Future<Options?> _getAuthOptions() async {
    final jwt = await _storage.read(key: _tokenKey);
    if (jwt == null) return null;
    return Options(headers: {'Authorization': 'Bearer $jwt'});
  }
}
