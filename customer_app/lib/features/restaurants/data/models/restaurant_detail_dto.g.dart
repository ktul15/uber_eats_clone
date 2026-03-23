// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RestaurantDetailDto _$RestaurantDetailDtoFromJson(Map<String, dynamic> json) =>
    _RestaurantDetailDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      address: json['address'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      rating: (json['rating'] as num).toDouble(),
      menuItems: (json['menuItems'] as List<dynamic>)
          .map((e) => MenuItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RestaurantDetailDtoToJson(
  _RestaurantDetailDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'lat': instance.lat,
  'lng': instance.lng,
  'imageUrl': instance.imageUrl,
  'isActive': instance.isActive,
  'rating': instance.rating,
  'menuItems': instance.menuItems,
};
