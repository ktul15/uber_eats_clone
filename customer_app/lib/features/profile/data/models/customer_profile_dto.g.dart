// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerProfileDto _$CustomerProfileDtoFromJson(Map<String, dynamic> json) =>
    _CustomerProfileDto(
      name: json['name'] as String,
      defaultAddress: json['defaultAddress'] as String?,
    );

Map<String, dynamic> _$CustomerProfileDtoToJson(_CustomerProfileDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'defaultAddress': instance.defaultAddress,
    };
