import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner_profile_dto.freezed.dart';
part 'owner_profile_dto.g.dart';

@freezed
abstract class OwnerProfileDto with _$OwnerProfileDto {
  const factory OwnerProfileDto({required String name}) = _OwnerProfileDto;

  factory OwnerProfileDto.fromJson(Map<String, dynamic> json) =>
      _$OwnerProfileDtoFromJson(json);
}
