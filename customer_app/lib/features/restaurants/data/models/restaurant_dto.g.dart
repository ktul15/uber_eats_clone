// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantDto _$RestaurantDtoFromJson(Map<String, dynamic> json) =>
    _RestaurantDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$RestaurantDtoToJson(_RestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'imageUrl': instance.imageUrl,
      'isActive': instance.isActive,
      'rating': instance.rating,
    };
