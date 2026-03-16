import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_profile_dto.freezed.dart';
part 'driver_profile_dto.g.dart';

@freezed
abstract class DriverProfileDto with _$DriverProfileDto {
  const factory DriverProfileDto({
    required String name,
    String? vehicleType,
    String? licenseNumber,
    @Default(false) bool isAvailable,
    double? currentLat,
    double? currentLng,
  }) = _DriverProfileDto;

  factory DriverProfileDto.fromJson(Map<String, dynamic> json) =>
      _$DriverProfileDtoFromJson(json);
}
