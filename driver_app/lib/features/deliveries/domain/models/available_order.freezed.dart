// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'available_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvailableOrder {

 String get orderId; String get restaurantId; String get restaurantName; String get deliveryAddress; double get totalAmount;
/// Create a copy of AvailableOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvailableOrderCopyWith<AvailableOrder> get copyWith => _$AvailableOrderCopyWithImpl<AvailableOrder>(this as AvailableOrder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvailableOrder&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,restaurantId,restaurantName,deliveryAddress,totalAmount);

@override
String toString() {
  return 'AvailableOrder(orderId: $orderId, restaurantId: $restaurantId, restaurantName: $restaurantName, deliveryAddress: $deliveryAddress, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class $AvailableOrderCopyWith<$Res>  {
  factory $AvailableOrderCopyWith(AvailableOrder value, $Res Function(AvailableOrder) _then) = _$AvailableOrderCopyWithImpl;
@useResult
$Res call({
 String orderId, String restaurantId, String restaurantName, String deliveryAddress, double totalAmount
});




}
/// @nodoc
class _$AvailableOrderCopyWithImpl<$Res>
    implements $AvailableOrderCopyWith<$Res> {
  _$AvailableOrderCopyWithImpl(this._self, this._then);

  final AvailableOrder _self;
  final $Res Function(AvailableOrder) _then;

/// Create a copy of AvailableOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? restaurantId = null,Object? restaurantName = null,Object? deliveryAddress = null,Object? totalAmount = null,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AvailableOrder].
extension AvailableOrderPatterns on AvailableOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AvailableOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AvailableOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AvailableOrder value)  $default,){
final _that = this;
switch (_that) {
case _AvailableOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AvailableOrder value)?  $default,){
final _that = this;
switch (_that) {
case _AvailableOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderId,  String restaurantId,  String restaurantName,  String deliveryAddress,  double totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AvailableOrder() when $default != null:
return $default(_that.orderId,_that.restaurantId,_that.restaurantName,_that.deliveryAddress,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderId,  String restaurantId,  String restaurantName,  String deliveryAddress,  double totalAmount)  $default,) {final _that = this;
switch (_that) {
case _AvailableOrder():
return $default(_that.orderId,_that.restaurantId,_that.restaurantName,_that.deliveryAddress,_that.totalAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderId,  String restaurantId,  String restaurantName,  String deliveryAddress,  double totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _AvailableOrder() when $default != null:
return $default(_that.orderId,_that.restaurantId,_that.restaurantName,_that.deliveryAddress,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc


class _AvailableOrder implements AvailableOrder {
  const _AvailableOrder({required this.orderId, required this.restaurantId, required this.restaurantName, required this.deliveryAddress, required this.totalAmount});
  

@override final  String orderId;
@override final  String restaurantId;
@override final  String restaurantName;
@override final  String deliveryAddress;
@override final  double totalAmount;

/// Create a copy of AvailableOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AvailableOrderCopyWith<_AvailableOrder> get copyWith => __$AvailableOrderCopyWithImpl<_AvailableOrder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AvailableOrder&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurantName, restaurantName) || other.restaurantName == restaurantName)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}


@override
int get hashCode => Object.hash(runtimeType,orderId,restaurantId,restaurantName,deliveryAddress,totalAmount);

@override
String toString() {
  return 'AvailableOrder(orderId: $orderId, restaurantId: $restaurantId, restaurantName: $restaurantName, deliveryAddress: $deliveryAddress, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$AvailableOrderCopyWith<$Res> implements $AvailableOrderCopyWith<$Res> {
  factory _$AvailableOrderCopyWith(_AvailableOrder value, $Res Function(_AvailableOrder) _then) = __$AvailableOrderCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String restaurantId, String restaurantName, String deliveryAddress, double totalAmount
});




}
/// @nodoc
class __$AvailableOrderCopyWithImpl<$Res>
    implements _$AvailableOrderCopyWith<$Res> {
  __$AvailableOrderCopyWithImpl(this._self, this._then);

  final _AvailableOrder _self;
  final $Res Function(_AvailableOrder) _then;

/// Create a copy of AvailableOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? restaurantId = null,Object? restaurantName = null,Object? deliveryAddress = null,Object? totalAmount = null,}) {
  return _then(_AvailableOrder(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,restaurantName: null == restaurantName ? _self.restaurantName : restaurantName // ignore: cast_nullable_to_non_nullable
as String,deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
