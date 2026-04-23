import 'package:dio/dio.dart';
import 'package:restaurant_dashboard/features/profile/data/models/user_profile_dto.dart';
import 'package:restaurant_dashboard/shared/constants/api_constants.dart';

class ProfileApiClient {
  final Dio _dio;

  ProfileApiClient(this._dio);

  Future<UserProfileDto> getProfile() async {
    final response = await _dio.get(ApiConstants.profile);
    return UserProfileDto.fromJson(
      (response.data as Map<String, dynamic>)['data'],
    );
  }

  Future<UserProfileDto> updateProfile({String? name, String? phone}) async {
    final response = await _dio.put(
      ApiConstants.profile,
      data: {
        // ignore: use_null_aware_elements
        if (name != null) 'name': name,
        // ignore: use_null_aware_elements
        if (phone != null) 'phone': phone.isEmpty ? '' : phone,
      },
    );
    return UserProfileDto.fromJson(
      (response.data as Map<String, dynamic>)['data'],
    );
  }
}
