import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class OwnerProfile with _$OwnerProfile {
  const factory OwnerProfile({required String name}) = _OwnerProfile;
}

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    String? phone,
    required String role,
    required OwnerProfile profile,
  }) = _UserProfile;
}
