import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_dashboard/features/profile/data/models/owner_profile_dto.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required String id,
    required String email,
    String? phone,
    required String role,
    required OwnerProfileDto profile,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}
