import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class CustomerProfile with _$CustomerProfile {
  const factory CustomerProfile({
    required String name,
    String? defaultAddress,
  }) = _CustomerProfile;
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? phone,
    required String role,
    required CustomerProfile profile,
  }) = _UserProfile;
}
