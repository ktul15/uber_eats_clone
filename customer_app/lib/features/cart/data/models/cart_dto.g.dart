// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartRestaurantDto _$CartRestaurantDtoFromJson(Map<String, dynamic> json) =>
    _CartRestaurantDto(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CartRestaurantDtoToJson(_CartRestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };

_CartDto _$CartDtoFromJson(Map<String, dynamic> json) => _CartDto(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  restaurantId: json['restaurantId'] as String,
  restaurant: CartRestaurantDto.fromJson(
    json['restaurant'] as Map<String, dynamic>,
  ),
  items: (json['items'] as List<dynamic>)
      .map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CartDtoToJson(_CartDto instance) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'restaurantId': instance.restaurantId,
  'restaurant': instance.restaurant,
  'items': instance.items,
};
