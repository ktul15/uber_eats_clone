import 'package:customer_app/features/profile/data/data_sources/profile_api_client.dart';
import 'package:customer_app/features/profile/data/models/user_profile_dto.dart';
import 'package:customer_app/features/profile/domain/models/user_profile.dart';

class ProfileRepository {
  final ProfileApiClient _apiClient;

  ProfileRepository({required ProfileApiClient apiClient})
    : _apiClient = apiClient;

  Future<UserProfile> getProfile() async {
    final dto = await _apiClient.getProfile();
    return _mapDtoToDomain(dto);
  }

  Future<UserProfile> updateProfile({
    String? name,
    String? phone,
    String? defaultAddress,
  }) async {
    final dto = await _apiClient.updateProfile(
      name: name,
      phone: phone,
      defaultAddress: defaultAddress,
    );
    return _mapDtoToDomain(dto);
  }

  UserProfile _mapDtoToDomain(UserProfileDto dto) {
    return UserProfile(
      id: dto.id,
      email: dto.email,
      phone: dto.phone,
      role: dto.role,
      profile: CustomerProfile(
        name: dto.profile.name,
        defaultAddress: dto.profile.defaultAddress,
      ),
    );
  }
}
