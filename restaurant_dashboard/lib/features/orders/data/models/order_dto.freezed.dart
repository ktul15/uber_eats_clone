// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderRestaurantDto {

 String get id; String get name; String? get imageUrl;
/// Create a copy of OrderRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderRestaurantDtoCopyWith<OrderRestaurantDto> get copyWith => _$OrderRestaurantDtoCopyWithImpl<OrderRestaurantDto>(this as OrderRestaurantDto, _$identity);

  /// Serializes this OrderRestaurantDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderRestaurantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'OrderRestaurantDto(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $OrderRestaurantDtoCopyWith<$Res>  {
  factory $OrderRestaurantDtoCopyWith(OrderRestaurantDto value, $Res Function(OrderRestaurantDto) _then) = _$OrderRestaurantDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? imageUrl
});




}
/// @nodoc
class _$OrderRestaurantDtoCopyWithImpl<$Res>
    implements $OrderRestaurantDtoCopyWith<$Res> {
  _$OrderRestaurantDtoCopyWithImpl(this._self, this._then);

  final OrderRestaurantDto _self;
  final $Res Function(OrderRestaurantDto) _then;

/// Create a copy of OrderRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderRestaurantDto].
extension OrderRestaurantDtoPatterns on OrderRestaurantDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderRestaurantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderRestaurantDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderRestaurantDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderRestaurantDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderRestaurantDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderRestaurantDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderRestaurantDto() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _OrderRestaurantDto():
return $default(_that.id,_that.name,_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _OrderRestaurantDto() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderRestaurantDto implements OrderRestaurantDto {
  const _OrderRestaurantDto({required this.id, required this.name, this.imageUrl});
  factory _OrderRestaurantDto.fromJson(Map<String, dynamic> json) => _$OrderRestaurantDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? imageUrl;

/// Create a copy of OrderRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderRestaurantDtoCopyWith<_OrderRestaurantDto> get copyWith => __$OrderRestaurantDtoCopyWithImpl<_OrderRestaurantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderRestaurantDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderRestaurantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'OrderRestaurantDto(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$OrderRestaurantDtoCopyWith<$Res> implements $OrderRestaurantDtoCopyWith<$Res> {
  factory _$OrderRestaurantDtoCopyWith(_OrderRestaurantDto value, $Res Function(_OrderRestaurantDto) _then) = __$OrderRestaurantDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? imageUrl
});




}
/// @nodoc
class __$OrderRestaurantDtoCopyWithImpl<$Res>
    implements _$OrderRestaurantDtoCopyWith<$Res> {
  __$OrderRestaurantDtoCopyWithImpl(this._self, this._then);

  final _OrderRestaurantDto _self;
  final $Res Function(_OrderRestaurantDto) _then;

/// Create a copy of OrderRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,}) {
  return _then(_OrderRestaurantDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OrderDto {

 String get id; String get customerId; String get restaurantId; String get status;@JsonKey(fromJson: doubleFromJson) double get totalAmount; String get deliveryAddress; DateTime get createdAt; List<OrderItemDto> get orderItems; OrderRestaurantDto get restaurant;
/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDtoCopyWith<OrderDto> get copyWith => _$OrderDtoCopyWithImpl<OrderDto>(this as OrderDto, _$identity);

  /// Serializes this OrderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.orderItems, orderItems)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,restaurantId,status,totalAmount,deliveryAddress,createdAt,const DeepCollectionEquality().hash(orderItems),restaurant);

@override
String toString() {
  return 'OrderDto(id: $id, customerId: $customerId, restaurantId: $restaurantId, status: $status, totalAmount: $totalAmount, deliveryAddress: $deliveryAddress, createdAt: $createdAt, orderItems: $orderItems, restaurant: $restaurant)';
}


}

/// @nodoc
abstract mixin class $OrderDtoCopyWith<$Res>  {
  factory $OrderDtoCopyWith(OrderDto value, $Res Function(OrderDto) _then) = _$OrderDtoCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String restaurantId, String status,@JsonKey(fromJson: doubleFromJson) double totalAmount, String deliveryAddress, DateTime createdAt, List<OrderItemDto> orderItems, OrderRestaurantDto restaurant
});


$OrderRestaurantDtoCopyWith<$Res> get restaurant;

}
/// @nodoc
class _$OrderDtoCopyWithImpl<$Res>
    implements $OrderDtoCopyWith<$Res> {
  _$OrderDtoCopyWithImpl(this._self, this._then);

  final OrderDto _self;
  final $Res Function(OrderDto) _then;

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? restaurantId = null,Object? status = null,Object? totalAmount = null,Object? deliveryAddress = null,Object? createdAt = null,Object? orderItems = null,Object? restaurant = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,orderItems: null == orderItems ? _self.orderItems : orderItems // ignore: cast_nullable_to_non_nullable
as List<OrderItemDto>,restaurant: null == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as OrderRestaurantDto,
  ));
}
/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderRestaurantDtoCopyWith<$Res> get restaurant {
  
  return $OrderRestaurantDtoCopyWith<$Res>(_self.restaurant, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderDto].
extension OrderDtoPatterns on OrderDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String restaurantId,  String status, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String deliveryAddress,  DateTime createdAt,  List<OrderItemDto> orderItems,  OrderRestaurantDto restaurant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
return $default(_that.id,_that.customerId,_that.restaurantId,_that.status,_that.totalAmount,_that.deliveryAddress,_that.createdAt,_that.orderItems,_that.restaurant);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String restaurantId,  String status, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String deliveryAddress,  DateTime createdAt,  List<OrderItemDto> orderItems,  OrderRestaurantDto restaurant)  $default,) {final _that = this;
switch (_that) {
case _OrderDto():
return $default(_that.id,_that.customerId,_that.restaurantId,_that.status,_that.totalAmount,_that.deliveryAddress,_that.createdAt,_that.orderItems,_that.restaurant);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String restaurantId,  String status, @JsonKey(fromJson: doubleFromJson)  double totalAmount,  String deliveryAddress,  DateTime createdAt,  List<OrderItemDto> orderItems,  OrderRestaurantDto restaurant)?  $default,) {final _that = this;
switch (_that) {
case _OrderDto() when $default != null:
return $default(_that.id,_that.customerId,_that.restaurantId,_that.status,_that.totalAmount,_that.deliveryAddress,_that.createdAt,_that.orderItems,_that.restaurant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderDto implements OrderDto {
  const _OrderDto({required this.id, required this.customerId, required this.restaurantId, required this.status, @JsonKey(fromJson: doubleFromJson) required this.totalAmount, required this.deliveryAddress, required this.createdAt, required final  List<OrderItemDto> orderItems, required this.restaurant}): _orderItems = orderItems;
  factory _OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

@override final  String id;
@override final  String customerId;
@override final  String restaurantId;
@override final  String status;
@override@JsonKey(fromJson: doubleFromJson) final  double totalAmount;
@override final  String deliveryAddress;
@override final  DateTime createdAt;
 final  List<OrderItemDto> _orderItems;
@override List<OrderItemDto> get orderItems {
  if (_orderItems is EqualUnmodifiableListView) return _orderItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderItems);
}

@override final  OrderRestaurantDto restaurant;

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderDtoCopyWith<_OrderDto> get copyWith => __$OrderDtoCopyWithImpl<_OrderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderDto&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._orderItems, _orderItems)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,restaurantId,status,totalAmount,deliveryAddress,createdAt,const DeepCollectionEquality().hash(_orderItems),restaurant);

@override
String toString() {
  return 'OrderDto(id: $id, customerId: $customerId, restaurantId: $restaurantId, status: $status, totalAmount: $totalAmount, deliveryAddress: $deliveryAddress, createdAt: $createdAt, orderItems: $orderItems, restaurant: $restaurant)';
}


}

/// @nodoc
abstract mixin class _$OrderDtoCopyWith<$Res> implements $OrderDtoCopyWith<$Res> {
  factory _$OrderDtoCopyWith(_OrderDto value, $Res Function(_OrderDto) _then) = __$OrderDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String restaurantId, String status,@JsonKey(fromJson: doubleFromJson) double totalAmount, String deliveryAddress, DateTime createdAt, List<OrderItemDto> orderItems, OrderRestaurantDto restaurant
});


@override $OrderRestaurantDtoCopyWith<$Res> get restaurant;

}
/// @nodoc
class __$OrderDtoCopyWithImpl<$Res>
    implements _$OrderDtoCopyWith<$Res> {
  __$OrderDtoCopyWithImpl(this._self, this._then);

  final _OrderDto _self;
  final $Res Function(_OrderDto) _then;

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? restaurantId = null,Object? status = null,Object? totalAmount = null,Object? deliveryAddress = null,Object? createdAt = null,Object? orderItems = null,Object? restaurant = null,}) {
  return _then(_OrderDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,orderItems: null == orderItems ? _self._orderItems : orderItems // ignore: cast_nullable_to_non_nullable
as List<OrderItemDto>,restaurant: null == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as OrderRestaurantDto,
  ));
}

/// Create a copy of OrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderRestaurantDtoCopyWith<$Res> get restaurant {
  
  return $OrderRestaurantDtoCopyWith<$Res>(_self.restaurant, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}
}

// dart format on
