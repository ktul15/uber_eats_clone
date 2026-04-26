// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_delivery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveOrderItem {

 String get name; int get quantity;
/// Create a copy of ActiveOrderItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveOrderItemCopyWith<ActiveOrderItem> get copyWith => _$ActiveOrderItemCopyWithImpl<ActiveOrderItem>(this as ActiveOrderItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveOrderItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,name,quantity);

@override
String toString() {
  return 'ActiveOrderItem(name: $name, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $ActiveOrderItemCopyWith<$Res>  {
  factory $ActiveOrderItemCopyWith(ActiveOrderItem value, $Res Function(ActiveOrderItem) _then) = _$ActiveOrderItemCopyWithImpl;
@useResult
$Res call({
 String name, int quantity
});




}
/// @nodoc
class _$ActiveOrderItemCopyWithImpl<$Res>
    implements $ActiveOrderItemCopyWith<$Res> {
  _$ActiveOrderItemCopyWithImpl(this._self, this._then);

  final ActiveOrderItem _self;
  final $Res Function(ActiveOrderItem) _then;

/// Create a copy of ActiveOrderItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveOrderItem].
extension ActiveOrderItemPatterns on ActiveOrderItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveOrderItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveOrderItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveOrderItem value)  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveOrderItem value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveOrderItem() when $default != null:
return $default(_that.name,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderItem():
return $default(_that.name,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderItem() when $default != null:
return $default(_that.name,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveOrderItem implements ActiveOrderItem {
  const _ActiveOrderItem({required this.name, required this.quantity});
  

@override final  String name;
@override final  int quantity;

/// Create a copy of ActiveOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveOrderItemCopyWith<_ActiveOrderItem> get copyWith => __$ActiveOrderItemCopyWithImpl<_ActiveOrderItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveOrderItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode => Object.hash(runtimeType,name,quantity);

@override
String toString() {
  return 'ActiveOrderItem(name: $name, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$ActiveOrderItemCopyWith<$Res> implements $ActiveOrderItemCopyWith<$Res> {
  factory _$ActiveOrderItemCopyWith(_ActiveOrderItem value, $Res Function(_ActiveOrderItem) _then) = __$ActiveOrderItemCopyWithImpl;
@override @useResult
$Res call({
 String name, int quantity
});




}
/// @nodoc
class __$ActiveOrderItemCopyWithImpl<$Res>
    implements _$ActiveOrderItemCopyWith<$Res> {
  __$ActiveOrderItemCopyWithImpl(this._self, this._then);

  final _ActiveOrderItem _self;
  final $Res Function(_ActiveOrderItem) _then;

/// Create a copy of ActiveOrderItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantity = null,}) {
  return _then(_ActiveOrderItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ActiveDelivery {

 String get id; String get orderId; DeliveryStatus get status; String get restaurantName; String get restaurantAddress; String get deliveryAddress; double get totalAmount; List<ActiveOrderItem> get orderItems;
/// Create a copy of ActiveDelivery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveDeliveryCopyWith<ActiveDelivery> get copyWith => _$ActiveDeliveryCopyWithImpl<ActiveDelivery>(this as ActiveDelivery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDelivery&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.restaurantAddress, restaurantAddress) || other.restaurantAddress == restaurantAddress)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&const DeepCollectionEquality().equals(other.orderItems, orderItems));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderId,status,restaurantName,restaurantAddress,deliveryAddress,totalAmount,const DeepCollectionEquality().hash(orderItems));

@override
String toString() {
  return 'ActiveDelivery(id: $id, orderId: $orderId, status: $status, restaurantName: $restaurantName, restaurantAddress: $restaurantAddress, deliveryAddress: $deliveryAddress, totalAmount: $totalAmount, orderItems: $orderItems)';
}


}

/// @nodoc
abstract mixin class $ActiveDeliveryCopyWith<$Res>  {
  factory $ActiveDeliveryCopyWith(ActiveDelivery value, $Res Function(ActiveDelivery) _then) = _$ActiveDeliveryCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, DeliveryStatus status, String restaurantName, String restaurantAddress, String deliveryAddress, double totalAmount, List<ActiveOrderItem> orderItems
});




}
/// @nodoc
class _$ActiveDeliveryCopyWithImpl<$Res>
    implements $ActiveDeliveryCopyWith<$Res> {
  _$ActiveDeliveryCopyWithImpl(this._self, this._then);

  final ActiveDelivery _self;
  final $Res Function(ActiveDelivery) _then;

/// Create a copy of ActiveDelivery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? status = null,Object? restaurantName = null,Object? restaurantAddress = null,Object? deliveryAddress = null,Object? totalAmount = null,Object? orderItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,restaurantAddress: null == restaurantAddress ? _self.restaurantAddress : restaurantAddress // ignore: cast_nullable_to_non_nullable
as String,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,orderItems: null == orderItems ? _self.orderItems : orderItems // ignore: cast_nullable_to_non_nullable
as List<ActiveOrderItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveDelivery].
extension ActiveDeliveryPatterns on ActiveDelivery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveDelivery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveDelivery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveDelivery value)  $default,){
final _that = this;
switch (_that) {
case _ActiveDelivery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveDelivery value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveDelivery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  DeliveryStatus status,  String restaurantName,  String restaurantAddress,  String deliveryAddress,  double totalAmount,  List<ActiveOrderItem> orderItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveDelivery() when $default != null:
return $default(_that.id,_that.orderId,_that.status,_that.restaurantName,_that.restaurantAddress,_that.deliveryAddress,_that.totalAmount,_that.orderItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  DeliveryStatus status,  String restaurantName,  String restaurantAddress,  String deliveryAddress,  double totalAmount,  List<ActiveOrderItem> orderItems)  $default,) {final _that = this;
switch (_that) {
case _ActiveDelivery():
return $default(_that.id,_that.orderId,_that.status,_that.restaurantName,_that.restaurantAddress,_that.deliveryAddress,_that.totalAmount,_that.orderItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  DeliveryStatus status,  String restaurantName,  String restaurantAddress,  String deliveryAddress,  double totalAmount,  List<ActiveOrderItem> orderItems)?  $default,) {final _that = this;
switch (_that) {
case _ActiveDelivery() when $default != null:
return $default(_that.id,_that.orderId,_that.status,_that.restaurantName,_that.restaurantAddress,_that.deliveryAddress,_that.totalAmount,_that.orderItems);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveDelivery implements ActiveDelivery {
  const _ActiveDelivery({required this.id, required this.orderId, required this.status, required this.restaurantName, required this.restaurantAddress, required this.deliveryAddress, required this.totalAmount, required final  List<ActiveOrderItem> orderItems}): _orderItems = orderItems;
  

@override final  String id;
@override final  String orderId;
@override final  DeliveryStatus status;
@override final  String restaurantName;
@override final  String restaurantAddress;
@override final  String deliveryAddress;
@override final  double totalAmount;
 final  List<ActiveOrderItem> _orderItems;
@override List<ActiveOrderItem> get orderItems {
  if (_orderItems is EqualUnmodifiableListView) return _orderItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderItems);
}


/// Create a copy of ActiveDelivery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveDeliveryCopyWith<_ActiveDelivery> get copyWith => __$ActiveDeliveryCopyWithImpl<_ActiveDelivery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveDelivery&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.restaurantAddress, restaurantAddress) || other.restaurantAddress == restaurantAddress)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&const DeepCollectionEquality().equals(other._orderItems, _orderItems));
}


@override
int get hashCode => Object.hash(runtimeType,id,orderId,status,restaurantName,restaurantAddress,deliveryAddress,totalAmount,const DeepCollectionEquality().hash(_orderItems));

@override
String toString() {
  return 'ActiveDelivery(id: $id, orderId: $orderId, status: $status, restaurantName: $restaurantName, restaurantAddress: $restaurantAddress, deliveryAddress: $deliveryAddress, totalAmount: $totalAmount, orderItems: $orderItems)';
}


}

/// @nodoc
abstract mixin class _$ActiveDeliveryCopyWith<$Res> implements $ActiveDeliveryCopyWith<$Res> {
  factory _$ActiveDeliveryCopyWith(_ActiveDelivery value, $Res Function(_ActiveDelivery) _then) = __$ActiveDeliveryCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, DeliveryStatus status, String restaurantName, String restaurantAddress, String deliveryAddress, double totalAmount, List<ActiveOrderItem> orderItems
});




}
/// @nodoc
class __$ActiveDeliveryCopyWithImpl<$Res>
    implements _$ActiveDeliveryCopyWith<$Res> {
  __$ActiveDeliveryCopyWithImpl(this._self, this._then);

  final _ActiveDelivery _self;
  final $Res Function(_ActiveDelivery) _then;

/// Create a copy of ActiveDelivery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? status = null,Object? restaurantName = null,Object? restaurantAddress = null,Object? deliveryAddress = null,Object? totalAmount = null,Object? orderItems = null,}) {
  return _then(_ActiveDelivery(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeliveryStatus,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,restaurantAddress: null == restaurantAddress ? _self.restaurantAddress : restaurantAddress // ignore: cast_nullable_to_non_nullable
as String,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,orderItems: null == orderItems ? _self._orderItems : orderItems // ignore: cast_nullable_to_non_nullable
as List<ActiveOrderItem>,
  ));
}


}

// dart format on
