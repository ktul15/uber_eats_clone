import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_dashboard/shared/constants/api_constants.dart';

class FcmApiClient {
  const FcmApiClient({required Dio dio, required FlutterSecureStorage storage})
    : _dio = dio,
      _storage = storage;

  final Dio _dio;
  final FlutterSecureStorage _storage;

  Future<Options?> _options() async {
    final jwt = await _storage.read(key: 'auth_token');
    return jwt == null
        ? null
        : Options(headers: {'Authorization': 'Bearer $jwt'});
  }

  Future<void> registerToken(String token) async {
    try {
      final options = await _options();
      if (options == null) return;
      await _dio.patch(
        ApiConstants.fcmToken,
        data: {'fcmToken': token},
        options: options,
      );
    } on DioException {
      // Push registration must never block authentication.
    }
  }

  Future<void> removeToken(String token) async {
    try {
      final options = await _options();
      if (options == null) return;
      await _dio.delete(
        ApiConstants.fcmToken,
        data: {'fcmToken': token},
        options: options,
      );
    } on DioException {
      // Logout still proceeds if the network is unavailable.
    }
  }
}
