// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DriverProfileDto _$DriverProfileDtoFromJson(Map<String, dynamic> json) =>
    _DriverProfileDto(
      name: json['name'] as String,
      vehicleType: json['vehicleType'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      isAvailable: json['isAvailable'] as bool? ?? false,
      currentLat: (json['currentLat'] as num?)?.toDouble(),
      currentLng: (json['currentLng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DriverProfileDtoToJson(_DriverProfileDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'vehicleType': instance.vehicleType,
      'licenseNumber': instance.licenseNumber,
      'isAvailable': instance.isAvailable,
      'currentLat': instance.currentLat,
      'currentLng': instance.currentLng,
    };
