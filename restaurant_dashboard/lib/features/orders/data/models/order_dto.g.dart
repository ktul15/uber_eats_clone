// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderRestaurantDto _$OrderRestaurantDtoFromJson(Map<String, dynamic> json) =>
    _OrderRestaurantDto(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$OrderRestaurantDtoToJson(_OrderRestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };

_OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => _OrderDto(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  restaurantId: json['restaurantId'] as String,
  status: json['status'] as String,
  totalAmount: doubleFromJson(json['totalAmount']),
  deliveryAddress: json['deliveryAddress'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  orderItems: (json['orderItems'] as List<dynamic>)
      .map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  restaurant: OrderRestaurantDto.fromJson(
    json['restaurant'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$OrderDtoToJson(_OrderDto instance) => <String, dynamic>{
  'id': instance.id,
  'customerId': instance.customerId,
  'restaurantId': instance.restaurantId,
  'status': instance.status,
  'totalAmount': instance.totalAmount,
  'deliveryAddress': instance.deliveryAddress,
  'createdAt': instance.createdAt.toIso8601String(),
  'orderItems': instance.orderItems,
  'restaurant': instance.restaurant,
};
