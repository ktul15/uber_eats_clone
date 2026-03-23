// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MenuItemDto _$MenuItemDtoFromJson(Map<String, dynamic> json) => _MenuItemDto(
  id: json['id'] as String,
  restaurantId: json['restaurantId'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String?,
  isAvailable: json['isAvailable'] as bool,
);

Map<String, dynamic> _$MenuItemDtoToJson(_MenuItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurantId': instance.restaurantId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'isAvailable': instance.isAvailable,
    };
