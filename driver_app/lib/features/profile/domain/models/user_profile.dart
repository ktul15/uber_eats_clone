import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class DriverProfile with _$DriverProfile {
  const factory DriverProfile({
    required String name,
    String? vehicleType,
    String? licenseNumber,
    @Default(false) bool isAvailable,
    double? currentLat,
    double? currentLng,
  }) = _DriverProfile;
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? phone,
    required String role,
    required DriverProfile profile,
  }) = _UserProfile;
}
