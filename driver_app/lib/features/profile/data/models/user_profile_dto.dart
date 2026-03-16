import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:driver_app/features/profile/data/models/driver_profile_dto.dart';

part 'user_profile_dto.freezed.dart';
part 'user_profile_dto.g.dart';

@freezed
abstract class UserProfileDto with _$UserProfileDto {
  const factory UserProfileDto({
    required String id,
    required String email,
    String? phone,
    required String role,
    required DriverProfileDto profile,
  }) = _UserProfileDto;

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);
}
