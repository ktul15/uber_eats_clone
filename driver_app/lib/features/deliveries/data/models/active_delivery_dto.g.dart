// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_delivery_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActiveMenuItemDto _$ActiveMenuItemDtoFromJson(Map<String, dynamic> json) =>
    _ActiveMenuItemDto(name: json['name'] as String);

Map<String, dynamic> _$ActiveMenuItemDtoToJson(_ActiveMenuItemDto instance) =>
    <String, dynamic>{'name': instance.name};

_ActiveOrderItemDto _$ActiveOrderItemDtoFromJson(Map<String, dynamic> json) =>
    _ActiveOrderItemDto(
      quantity: (json['quantity'] as num).toInt(),
      menuItem: ActiveMenuItemDto.fromJson(
        json['menuItem'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ActiveOrderItemDtoToJson(_ActiveOrderItemDto instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'menuItem': instance.menuItem,
    };

_ActiveRestaurantDto _$ActiveRestaurantDtoFromJson(Map<String, dynamic> json) =>
    _ActiveRestaurantDto(
      name: json['name'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$ActiveRestaurantDtoToJson(
  _ActiveRestaurantDto instance,
) => <String, dynamic>{'name': instance.name, 'address': instance.address};

_ActiveDeliveryOrderDto _$ActiveDeliveryOrderDtoFromJson(
  Map<String, dynamic> json,
) => _ActiveDeliveryOrderDto(
  deliveryAddress: json['deliveryAddress'] as String,
  totalAmount: json['totalAmount'] as String,
  restaurant: ActiveRestaurantDto.fromJson(
    json['restaurant'] as Map<String, dynamic>,
  ),
  orderItems: (json['orderItems'] as List<dynamic>)
      .map((e) => ActiveOrderItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ActiveDeliveryOrderDtoToJson(
  _ActiveDeliveryOrderDto instance,
) => <String, dynamic>{
  'deliveryAddress': instance.deliveryAddress,
  'totalAmount': instance.totalAmount,
  'restaurant': instance.restaurant,
  'orderItems': instance.orderItems,
};

_ActiveDeliveryDto _$ActiveDeliveryDtoFromJson(Map<String, dynamic> json) =>
    _ActiveDeliveryDto(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      status: json['status'] as String,
      order: ActiveDeliveryOrderDto.fromJson(
        json['order'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ActiveDeliveryDtoToJson(_ActiveDeliveryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'status': instance.status,
      'order': instance.order,
    };
