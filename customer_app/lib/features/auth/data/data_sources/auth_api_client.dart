import 'package:dio/dio.dart';
import 'package:customer_app/features/auth/data/models/auth_response_dto.dart';
import 'package:customer_app/shared/constants/api_constants.dart';
import 'package:customer_app/shared/constants/user_role.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient(this._dio);

  Future<AuthResponseDto> register({
    required String email,
    required String password,
    required String name,
    String? phone,
  }) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: {
        'email': email,
        'password': password,
        'role': UserRole.customer.value,
        'name': name,
        // ignore: use_null_aware_elements
        if (phone != null) 'phone': phone,
      },
    );

    return AuthResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponseDto> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );

    return AuthResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
