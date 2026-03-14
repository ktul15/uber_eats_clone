import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_profile_dto.freezed.dart';
part 'customer_profile_dto.g.dart';

@freezed
abstract class CustomerProfileDto with _$CustomerProfileDto {
  const factory CustomerProfileDto({
    required String name,
    String? defaultAddress,
  }) = _CustomerProfileDto;

  factory CustomerProfileDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerProfileDtoFromJson(json);
}
