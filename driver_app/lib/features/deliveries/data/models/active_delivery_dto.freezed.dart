// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_delivery_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveMenuItemDto {

 String get name;
/// Create a copy of ActiveMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveMenuItemDtoCopyWith<ActiveMenuItemDto> get copyWith => _$ActiveMenuItemDtoCopyWithImpl<ActiveMenuItemDto>(this as ActiveMenuItemDto, _$identity);

  /// Serializes this ActiveMenuItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveMenuItemDto&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'ActiveMenuItemDto(name: $name)';
}


}

/// @nodoc
abstract mixin class $ActiveMenuItemDtoCopyWith<$Res>  {
  factory $ActiveMenuItemDtoCopyWith(ActiveMenuItemDto value, $Res Function(ActiveMenuItemDto) _then) = _$ActiveMenuItemDtoCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$ActiveMenuItemDtoCopyWithImpl<$Res>
    implements $ActiveMenuItemDtoCopyWith<$Res> {
  _$ActiveMenuItemDtoCopyWithImpl(this._self, this._then);

  final ActiveMenuItemDto _self;
  final $Res Function(ActiveMenuItemDto) _then;

/// Create a copy of ActiveMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveMenuItemDto].
extension ActiveMenuItemDtoPatterns on ActiveMenuItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveMenuItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveMenuItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveMenuItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ActiveMenuItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveMenuItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveMenuItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveMenuItemDto() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _ActiveMenuItemDto():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _ActiveMenuItemDto() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveMenuItemDto implements ActiveMenuItemDto {
  const _ActiveMenuItemDto({required this.name});
  factory _ActiveMenuItemDto.fromJson(Map<String, dynamic> json) => _$ActiveMenuItemDtoFromJson(json);

@override final  String name;

/// Create a copy of ActiveMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveMenuItemDtoCopyWith<_ActiveMenuItemDto> get copyWith => __$ActiveMenuItemDtoCopyWithImpl<_ActiveMenuItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveMenuItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveMenuItemDto&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'ActiveMenuItemDto(name: $name)';
}


}

/// @nodoc
abstract mixin class _$ActiveMenuItemDtoCopyWith<$Res> implements $ActiveMenuItemDtoCopyWith<$Res> {
  factory _$ActiveMenuItemDtoCopyWith(_ActiveMenuItemDto value, $Res Function(_ActiveMenuItemDto) _then) = __$ActiveMenuItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$ActiveMenuItemDtoCopyWithImpl<$Res>
    implements _$ActiveMenuItemDtoCopyWith<$Res> {
  __$ActiveMenuItemDtoCopyWithImpl(this._self, this._then);

  final _ActiveMenuItemDto _self;
  final $Res Function(_ActiveMenuItemDto) _then;

/// Create a copy of ActiveMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_ActiveMenuItemDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ActiveOrderItemDto {

 int get quantity; ActiveMenuItemDto get menuItem;
/// Create a copy of ActiveOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveOrderItemDtoCopyWith<ActiveOrderItemDto> get copyWith => _$ActiveOrderItemDtoCopyWithImpl<ActiveOrderItemDto>(this as ActiveOrderItemDto, _$identity);

  /// Serializes this ActiveOrderItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveOrderItemDto&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quantity,menuItem);

@override
String toString() {
  return 'ActiveOrderItemDto(quantity: $quantity, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class $ActiveOrderItemDtoCopyWith<$Res>  {
  factory $ActiveOrderItemDtoCopyWith(ActiveOrderItemDto value, $Res Function(ActiveOrderItemDto) _then) = _$ActiveOrderItemDtoCopyWithImpl;
@useResult
$Res call({
 int quantity, ActiveMenuItemDto menuItem
});


$ActiveMenuItemDtoCopyWith<$Res> get menuItem;

}
/// @nodoc
class _$ActiveOrderItemDtoCopyWithImpl<$Res>
    implements $ActiveOrderItemDtoCopyWith<$Res> {
  _$ActiveOrderItemDtoCopyWithImpl(this._self, this._then);

  final ActiveOrderItemDto _self;
  final $Res Function(ActiveOrderItemDto) _then;

/// Create a copy of ActiveOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quantity = null,Object? menuItem = null,}) {
  return _then(_self.copyWith(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as ActiveMenuItemDto,
  ));
}
/// Create a copy of ActiveOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveMenuItemDtoCopyWith<$Res> get menuItem {
  
  return $ActiveMenuItemDtoCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveOrderItemDto].
extension ActiveOrderItemDtoPatterns on ActiveOrderItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveOrderItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveOrderItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveOrderItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveOrderItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveOrderItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quantity,  ActiveMenuItemDto menuItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveOrderItemDto() when $default != null:
return $default(_that.quantity,_that.menuItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quantity,  ActiveMenuItemDto menuItem)  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderItemDto():
return $default(_that.quantity,_that.menuItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quantity,  ActiveMenuItemDto menuItem)?  $default,) {final _that = this;
switch (_that) {
case _ActiveOrderItemDto() when $default != null:
return $default(_that.quantity,_that.menuItem);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveOrderItemDto implements ActiveOrderItemDto {
  const _ActiveOrderItemDto({required this.quantity, required this.menuItem});
  factory _ActiveOrderItemDto.fromJson(Map<String, dynamic> json) => _$ActiveOrderItemDtoFromJson(json);

@override final  int quantity;
@override final  ActiveMenuItemDto menuItem;

/// Create a copy of ActiveOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveOrderItemDtoCopyWith<_ActiveOrderItemDto> get copyWith => __$ActiveOrderItemDtoCopyWithImpl<_ActiveOrderItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveOrderItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveOrderItemDto&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,quantity,menuItem);

@override
String toString() {
  return 'ActiveOrderItemDto(quantity: $quantity, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class _$ActiveOrderItemDtoCopyWith<$Res> implements $ActiveOrderItemDtoCopyWith<$Res> {
  factory _$ActiveOrderItemDtoCopyWith(_ActiveOrderItemDto value, $Res Function(_ActiveOrderItemDto) _then) = __$ActiveOrderItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int quantity, ActiveMenuItemDto menuItem
});


@override $ActiveMenuItemDtoCopyWith<$Res> get menuItem;

}
/// @nodoc
class __$ActiveOrderItemDtoCopyWithImpl<$Res>
    implements _$ActiveOrderItemDtoCopyWith<$Res> {
  __$ActiveOrderItemDtoCopyWithImpl(this._self, this._then);

  final _ActiveOrderItemDto _self;
  final $Res Function(_ActiveOrderItemDto) _then;

/// Create a copy of ActiveOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quantity = null,Object? menuItem = null,}) {
  return _then(_ActiveOrderItemDto(
quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as ActiveMenuItemDto,
  ));
}

/// Create a copy of ActiveOrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveMenuItemDtoCopyWith<$Res> get menuItem {
  
  return $ActiveMenuItemDtoCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}


/// @nodoc
mixin _$ActiveRestaurantDto {

 String get name; String get address;
/// Create a copy of ActiveRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveRestaurantDtoCopyWith<ActiveRestaurantDto> get copyWith => _$ActiveRestaurantDtoCopyWithImpl<ActiveRestaurantDto>(this as ActiveRestaurantDto, _$identity);

  /// Serializes this ActiveRestaurantDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveRestaurantDto&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address);

@override
String toString() {
  return 'ActiveRestaurantDto(name: $name, address: $address)';
}


}

/// @nodoc
abstract mixin class $ActiveRestaurantDtoCopyWith<$Res>  {
  factory $ActiveRestaurantDtoCopyWith(ActiveRestaurantDto value, $Res Function(ActiveRestaurantDto) _then) = _$ActiveRestaurantDtoCopyWithImpl;
@useResult
$Res call({
 String name, String address
});




}
/// @nodoc
class _$ActiveRestaurantDtoCopyWithImpl<$Res>
    implements $ActiveRestaurantDtoCopyWith<$Res> {
  _$ActiveRestaurantDtoCopyWithImpl(this._self, this._then);

  final ActiveRestaurantDto _self;
  final $Res Function(ActiveRestaurantDto) _then;

/// Create a copy of ActiveRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? address = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveRestaurantDto].
extension ActiveRestaurantDtoPatterns on ActiveRestaurantDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveRestaurantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveRestaurantDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveRestaurantDto value)  $default,){
final _that = this;
switch (_that) {
case _ActiveRestaurantDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveRestaurantDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveRestaurantDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveRestaurantDto() when $default != null:
return $default(_that.name,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String address)  $default,) {final _that = this;
switch (_that) {
case _ActiveRestaurantDto():
return $default(_that.name,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String address)?  $default,) {final _that = this;
switch (_that) {
case _ActiveRestaurantDto() when $default != null:
return $default(_that.name,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveRestaurantDto implements ActiveRestaurantDto {
  const _ActiveRestaurantDto({required this.name, required this.address});
  factory _ActiveRestaurantDto.fromJson(Map<String, dynamic> json) => _$ActiveRestaurantDtoFromJson(json);

@override final  String name;
@override final  String address;

/// Create a copy of ActiveRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveRestaurantDtoCopyWith<_ActiveRestaurantDto> get copyWith => __$ActiveRestaurantDtoCopyWithImpl<_ActiveRestaurantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveRestaurantDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveRestaurantDto&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address);

@override
String toString() {
  return 'ActiveRestaurantDto(name: $name, address: $address)';
}


}

/// @nodoc
abstract mixin class _$ActiveRestaurantDtoCopyWith<$Res> implements $ActiveRestaurantDtoCopyWith<$Res> {
  factory _$ActiveRestaurantDtoCopyWith(_ActiveRestaurantDto value, $Res Function(_ActiveRestaurantDto) _then) = __$ActiveRestaurantDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String address
});




}
/// @nodoc
class __$ActiveRestaurantDtoCopyWithImpl<$Res>
    implements _$ActiveRestaurantDtoCopyWith<$Res> {
  __$ActiveRestaurantDtoCopyWithImpl(this._self, this._then);

  final _ActiveRestaurantDto _self;
  final $Res Function(_ActiveRestaurantDto) _then;

/// Create a copy of ActiveRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? address = null,}) {
  return _then(_ActiveRestaurantDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ActiveDeliveryOrderDto {

 String get deliveryAddress; String get totalAmount; ActiveRestaurantDto get restaurant; List<ActiveOrderItemDto> get orderItems;
/// Create a copy of ActiveDeliveryOrderDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveDeliveryOrderDtoCopyWith<ActiveDeliveryOrderDto> get copyWith => _$ActiveDeliveryOrderDtoCopyWithImpl<ActiveDeliveryOrderDto>(this as ActiveDeliveryOrderDto, _$identity);

  /// Serializes this ActiveDeliveryOrderDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDeliveryOrderDto&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant)&&const DeepCollectionEquality().equals(other.orderItems, orderItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deliveryAddress,totalAmount,restaurant,const DeepCollectionEquality().hash(orderItems));

@override
String toString() {
  return 'ActiveDeliveryOrderDto(deliveryAddress: $deliveryAddress, totalAmount: $totalAmount, restaurant: $restaurant, orderItems: $orderItems)';
}


}

/// @nodoc
abstract mixin class $ActiveDeliveryOrderDtoCopyWith<$Res>  {
  factory $ActiveDeliveryOrderDtoCopyWith(ActiveDeliveryOrderDto value, $Res Function(ActiveDeliveryOrderDto) _then) = _$ActiveDeliveryOrderDtoCopyWithImpl;
@useResult
$Res call({
 String deliveryAddress, String totalAmount, ActiveRestaurantDto restaurant, List<ActiveOrderItemDto> orderItems
});


$ActiveRestaurantDtoCopyWith<$Res> get restaurant;

}
/// @nodoc
class _$ActiveDeliveryOrderDtoCopyWithImpl<$Res>
    implements $ActiveDeliveryOrderDtoCopyWith<$Res> {
  _$ActiveDeliveryOrderDtoCopyWithImpl(this._self, this._then);

  final ActiveDeliveryOrderDto _self;
  final $Res Function(ActiveDeliveryOrderDto) _then;

/// Create a copy of ActiveDeliveryOrderDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveryAddress = null,Object? totalAmount = null,Object? restaurant = null,Object? orderItems = null,}) {
  return _then(_self.copyWith(
deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as String,restaurant: null == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as ActiveRestaurantDto,orderItems: null == orderItems ? _self.orderItems : orderItems // ignore: cast_nullable_to_non_nullable
as List<ActiveOrderItemDto>,
  ));
}
/// Create a copy of ActiveDeliveryOrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveRestaurantDtoCopyWith<$Res> get restaurant {
  
  return $ActiveRestaurantDtoCopyWith<$Res>(_self.restaurant, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveDeliveryOrderDto].
extension ActiveDeliveryOrderDtoPatterns on ActiveDeliveryOrderDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveDeliveryOrderDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveDeliveryOrderDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveDeliveryOrderDto value)  $default,){
final _that = this;
switch (_that) {
case _ActiveDeliveryOrderDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveDeliveryOrderDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveDeliveryOrderDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deliveryAddress,  String totalAmount,  ActiveRestaurantDto restaurant,  List<ActiveOrderItemDto> orderItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveDeliveryOrderDto() when $default != null:
return $default(_that.deliveryAddress,_that.totalAmount,_that.restaurant,_that.orderItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deliveryAddress,  String totalAmount,  ActiveRestaurantDto restaurant,  List<ActiveOrderItemDto> orderItems)  $default,) {final _that = this;
switch (_that) {
case _ActiveDeliveryOrderDto():
return $default(_that.deliveryAddress,_that.totalAmount,_that.restaurant,_that.orderItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deliveryAddress,  String totalAmount,  ActiveRestaurantDto restaurant,  List<ActiveOrderItemDto> orderItems)?  $default,) {final _that = this;
switch (_that) {
case _ActiveDeliveryOrderDto() when $default != null:
return $default(_that.deliveryAddress,_that.totalAmount,_that.restaurant,_that.orderItems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveDeliveryOrderDto implements ActiveDeliveryOrderDto {
  const _ActiveDeliveryOrderDto({required this.deliveryAddress, required this.totalAmount, required this.restaurant, required final  List<ActiveOrderItemDto> orderItems}): _orderItems = orderItems;
  factory _ActiveDeliveryOrderDto.fromJson(Map<String, dynamic> json) => _$ActiveDeliveryOrderDtoFromJson(json);

@override final  String deliveryAddress;
@override final  String totalAmount;
@override final  ActiveRestaurantDto restaurant;
 final  List<ActiveOrderItemDto> _orderItems;
@override List<ActiveOrderItemDto> get orderItems {
  if (_orderItems is EqualUnmodifiableListView) return _orderItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderItems);
}


/// Create a copy of ActiveDeliveryOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveDeliveryOrderDtoCopyWith<_ActiveDeliveryOrderDto> get copyWith => __$ActiveDeliveryOrderDtoCopyWithImpl<_ActiveDeliveryOrderDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveDeliveryOrderDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveDeliveryOrderDto&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant)&&const DeepCollectionEquality().equals(other._orderItems, _orderItems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deliveryAddress,totalAmount,restaurant,const DeepCollectionEquality().hash(_orderItems));

@override
String toString() {
  return 'ActiveDeliveryOrderDto(deliveryAddress: $deliveryAddress, totalAmount: $totalAmount, restaurant: $restaurant, orderItems: $orderItems)';
}


}

/// @nodoc
abstract mixin class _$ActiveDeliveryOrderDtoCopyWith<$Res> implements $ActiveDeliveryOrderDtoCopyWith<$Res> {
  factory _$ActiveDeliveryOrderDtoCopyWith(_ActiveDeliveryOrderDto value, $Res Function(_ActiveDeliveryOrderDto) _then) = __$ActiveDeliveryOrderDtoCopyWithImpl;
@override @useResult
$Res call({
 String deliveryAddress, String totalAmount, ActiveRestaurantDto restaurant, List<ActiveOrderItemDto> orderItems
});


@override $ActiveRestaurantDtoCopyWith<$Res> get restaurant;

}
/// @nodoc
class __$ActiveDeliveryOrderDtoCopyWithImpl<$Res>
    implements _$ActiveDeliveryOrderDtoCopyWith<$Res> {
  __$ActiveDeliveryOrderDtoCopyWithImpl(this._self, this._then);

  final _ActiveDeliveryOrderDto _self;
  final $Res Function(_ActiveDeliveryOrderDto) _then;

/// Create a copy of ActiveDeliveryOrderDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveryAddress = null,Object? totalAmount = null,Object? restaurant = null,Object? orderItems = null,}) {
  return _then(_ActiveDeliveryOrderDto(
deliveryAddress: null == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as String,restaurant: null == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as ActiveRestaurantDto,orderItems: null == orderItems ? _self._orderItems : orderItems // ignore: cast_nullable_to_non_nullable
as List<ActiveOrderItemDto>,
  ));
}

/// Create a copy of ActiveDeliveryOrderDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveRestaurantDtoCopyWith<$Res> get restaurant {
  
  return $ActiveRestaurantDtoCopyWith<$Res>(_self.restaurant, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}
}


/// @nodoc
mixin _$ActiveDeliveryDto {

 String get id; String get orderId; String get status; ActiveDeliveryOrderDto get order;
/// Create a copy of ActiveDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveDeliveryDtoCopyWith<ActiveDeliveryDto> get copyWith => _$ActiveDeliveryDtoCopyWithImpl<ActiveDeliveryDto>(this as ActiveDeliveryDto, _$identity);

  /// Serializes this ActiveDeliveryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDeliveryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,status,order);

@override
String toString() {
  return 'ActiveDeliveryDto(id: $id, orderId: $orderId, status: $status, order: $order)';
}


}

/// @nodoc
abstract mixin class $ActiveDeliveryDtoCopyWith<$Res>  {
  factory $ActiveDeliveryDtoCopyWith(ActiveDeliveryDto value, $Res Function(ActiveDeliveryDto) _then) = _$ActiveDeliveryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, String status, ActiveDeliveryOrderDto order
});


$ActiveDeliveryOrderDtoCopyWith<$Res> get order;

}
/// @nodoc
class _$ActiveDeliveryDtoCopyWithImpl<$Res>
    implements $ActiveDeliveryDtoCopyWith<$Res> {
  _$ActiveDeliveryDtoCopyWithImpl(this._self, this._then);

  final ActiveDeliveryDto _self;
  final $Res Function(ActiveDeliveryDto) _then;

/// Create a copy of ActiveDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? status = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as ActiveDeliveryOrderDto,
  ));
}
/// Create a copy of ActiveDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveDeliveryOrderDtoCopyWith<$Res> get order {
  
  return $ActiveDeliveryOrderDtoCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveDeliveryDto].
extension ActiveDeliveryDtoPatterns on ActiveDeliveryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveDeliveryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveDeliveryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveDeliveryDto value)  $default,){
final _that = this;
switch (_that) {
case _ActiveDeliveryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveDeliveryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveDeliveryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  String status,  ActiveDeliveryOrderDto order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveDeliveryDto() when $default != null:
return $default(_that.id,_that.orderId,_that.status,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  String status,  ActiveDeliveryOrderDto order)  $default,) {final _that = this;
switch (_that) {
case _ActiveDeliveryDto():
return $default(_that.id,_that.orderId,_that.status,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  String status,  ActiveDeliveryOrderDto order)?  $default,) {final _that = this;
switch (_that) {
case _ActiveDeliveryDto() when $default != null:
return $default(_that.id,_that.orderId,_that.status,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveDeliveryDto implements ActiveDeliveryDto {
  const _ActiveDeliveryDto({required this.id, required this.orderId, required this.status, required this.order});
  factory _ActiveDeliveryDto.fromJson(Map<String, dynamic> json) => _$ActiveDeliveryDtoFromJson(json);

@override final  String id;
@override final  String orderId;
@override final  String status;
@override final  ActiveDeliveryOrderDto order;

/// Create a copy of ActiveDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveDeliveryDtoCopyWith<_ActiveDeliveryDto> get copyWith => __$ActiveDeliveryDtoCopyWithImpl<_ActiveDeliveryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveDeliveryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveDeliveryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.status, status) || other.status == status)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,status,order);

@override
String toString() {
  return 'ActiveDeliveryDto(id: $id, orderId: $orderId, status: $status, order: $order)';
}


}

/// @nodoc
abstract mixin class _$ActiveDeliveryDtoCopyWith<$Res> implements $ActiveDeliveryDtoCopyWith<$Res> {
  factory _$ActiveDeliveryDtoCopyWith(_ActiveDeliveryDto value, $Res Function(_ActiveDeliveryDto) _then) = __$ActiveDeliveryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, String status, ActiveDeliveryOrderDto order
});


@override $ActiveDeliveryOrderDtoCopyWith<$Res> get order;

}
/// @nodoc
class __$ActiveDeliveryDtoCopyWithImpl<$Res>
    implements _$ActiveDeliveryDtoCopyWith<$Res> {
  __$ActiveDeliveryDtoCopyWithImpl(this._self, this._then);

  final _ActiveDeliveryDto _self;
  final $Res Function(_ActiveDeliveryDto) _then;

/// Create a copy of ActiveDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? status = null,Object? order = null,}) {
  return _then(_ActiveDeliveryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as ActiveDeliveryOrderDto,
  ));
}

/// Create a copy of ActiveDeliveryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveDeliveryOrderDtoCopyWith<$Res> get order {
  
  return $ActiveDeliveryOrderDtoCopyWith<$Res>(_self.order, (value) {
    return _then(_self.copyWith(order: value));
  });
}
}

// dart format on
