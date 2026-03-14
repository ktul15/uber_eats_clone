import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:driver_app/features/profile/data/models/user_profile_dto.dart';
import 'package:driver_app/shared/constants/api_constants.dart';

class ProfileApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  static const _tokenKey = 'auth_token';

  ProfileApiClient({required Dio dio, required FlutterSecureStorage storage})
    : _dio = dio,
      _storage = storage;

  Future<Options> _getAuthOptions() async {
    final token = await _storage.read(key: _tokenKey);
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<UserProfileDto> getProfile() async {
    final options = await _getAuthOptions();
    final response = await _dio.get(ApiConstants.profile, options: options);

    return UserProfileDto.fromJson(
      (response.data as Map<String, dynamic>)["data"],
    );
  }

  Future<UserProfileDto> updateProfile({
    String? name,
    String? phone,
    String? vehicleType,
    String? licenseNumber,
  }) async {
    final options = await _getAuthOptions();
    final response = await _dio.put(
      ApiConstants.profile,
      data: {
        // ignore: use_null_aware_elements
        if (name != null) 'name': name,
        // ignore: use_null_aware_elements
        if (phone != null) 'phone': phone.isEmpty ? '' : phone,
        // ignore: use_null_aware_elements
        if (vehicleType != null)
          'vehicleType': vehicleType.isEmpty ? '' : vehicleType,
        // ignore: use_null_aware_elements
        if (licenseNumber != null)
          'licenseNumber': licenseNumber.isEmpty ? '' : licenseNumber,
      },
      options: options,
    );

    return UserProfileDto.fromJson(
      (response.data as Map<String, dynamic>)["data"],
    );
  }
}
