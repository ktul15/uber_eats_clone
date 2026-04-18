// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderItemMenuItemDto {

 String get id; String get name; String? get imageUrl;
/// Create a copy of OrderItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemMenuItemDtoCopyWith<OrderItemMenuItemDto> get copyWith => _$OrderItemMenuItemDtoCopyWithImpl<OrderItemMenuItemDto>(this as OrderItemMenuItemDto, _$identity);

  /// Serializes this OrderItemMenuItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItemMenuItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'OrderItemMenuItemDto(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $OrderItemMenuItemDtoCopyWith<$Res>  {
  factory $OrderItemMenuItemDtoCopyWith(OrderItemMenuItemDto value, $Res Function(OrderItemMenuItemDto) _then) = _$OrderItemMenuItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? imageUrl
});




}
/// @nodoc
class _$OrderItemMenuItemDtoCopyWithImpl<$Res>
    implements $OrderItemMenuItemDtoCopyWith<$Res> {
  _$OrderItemMenuItemDtoCopyWithImpl(this._self, this._then);

  final OrderItemMenuItemDto _self;
  final $Res Function(OrderItemMenuItemDto) _then;

/// Create a copy of OrderItemMenuItemDto
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


/// Adds pattern-matching-related methods to [OrderItemMenuItemDto].
extension OrderItemMenuItemDtoPatterns on OrderItemMenuItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItemMenuItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItemMenuItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItemMenuItemDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderItemMenuItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItemMenuItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItemMenuItemDto() when $default != null:
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
case _OrderItemMenuItemDto() when $default != null:
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
case _OrderItemMenuItemDto():
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
case _OrderItemMenuItemDto() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItemMenuItemDto implements OrderItemMenuItemDto {
  const _OrderItemMenuItemDto({required this.id, required this.name, this.imageUrl});
  factory _OrderItemMenuItemDto.fromJson(Map<String, dynamic> json) => _$OrderItemMenuItemDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? imageUrl;

/// Create a copy of OrderItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemMenuItemDtoCopyWith<_OrderItemMenuItemDto> get copyWith => __$OrderItemMenuItemDtoCopyWithImpl<_OrderItemMenuItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemMenuItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItemMenuItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'OrderItemMenuItemDto(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$OrderItemMenuItemDtoCopyWith<$Res> implements $OrderItemMenuItemDtoCopyWith<$Res> {
  factory _$OrderItemMenuItemDtoCopyWith(_OrderItemMenuItemDto value, $Res Function(_OrderItemMenuItemDto) _then) = __$OrderItemMenuItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? imageUrl
});




}
/// @nodoc
class __$OrderItemMenuItemDtoCopyWithImpl<$Res>
    implements _$OrderItemMenuItemDtoCopyWith<$Res> {
  __$OrderItemMenuItemDtoCopyWithImpl(this._self, this._then);

  final _OrderItemMenuItemDto _self;
  final $Res Function(_OrderItemMenuItemDto) _then;

/// Create a copy of OrderItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,}) {
  return _then(_OrderItemMenuItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OrderItemDto {

 String get id; String get orderId; String get menuItemId; int get quantity;@JsonKey(fromJson: _doubleFromJson) double get priceAtTime; OrderItemMenuItemDto get menuItem;
/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderItemDtoCopyWith<OrderItemDto> get copyWith => _$OrderItemDtoCopyWithImpl<OrderItemDto>(this as OrderItemDto, _$identity);

  /// Serializes this OrderItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.priceAtTime, priceAtTime) || other.priceAtTime == priceAtTime)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,menuItemId,quantity,priceAtTime,menuItem);

@override
String toString() {
  return 'OrderItemDto(id: $id, orderId: $orderId, menuItemId: $menuItemId, quantity: $quantity, priceAtTime: $priceAtTime, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class $OrderItemDtoCopyWith<$Res>  {
  factory $OrderItemDtoCopyWith(OrderItemDto value, $Res Function(OrderItemDto) _then) = _$OrderItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, String menuItemId, int quantity,@JsonKey(fromJson: _doubleFromJson) double priceAtTime, OrderItemMenuItemDto menuItem
});


$OrderItemMenuItemDtoCopyWith<$Res> get menuItem;

}
/// @nodoc
class _$OrderItemDtoCopyWithImpl<$Res>
    implements $OrderItemDtoCopyWith<$Res> {
  _$OrderItemDtoCopyWithImpl(this._self, this._then);

  final OrderItemDto _self;
  final $Res Function(OrderItemDto) _then;

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? menuItemId = null,Object? quantity = null,Object? priceAtTime = null,Object? menuItem = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,priceAtTime: null == priceAtTime ? _self.priceAtTime : priceAtTime // ignore: cast_nullable_to_non_nullable
as double,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as OrderItemMenuItemDto,
  ));
}
/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderItemMenuItemDtoCopyWith<$Res> get menuItem {
  
  return $OrderItemMenuItemDtoCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}


/// Adds pattern-matching-related methods to [OrderItemDto].
extension OrderItemDtoPatterns on OrderItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderItemDto value)  $default,){
final _that = this;
switch (_that) {
case _OrderItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  String menuItemId,  int quantity, @JsonKey(fromJson: _doubleFromJson)  double priceAtTime,  OrderItemMenuItemDto menuItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
return $default(_that.id,_that.orderId,_that.menuItemId,_that.quantity,_that.priceAtTime,_that.menuItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  String menuItemId,  int quantity, @JsonKey(fromJson: _doubleFromJson)  double priceAtTime,  OrderItemMenuItemDto menuItem)  $default,) {final _that = this;
switch (_that) {
case _OrderItemDto():
return $default(_that.id,_that.orderId,_that.menuItemId,_that.quantity,_that.priceAtTime,_that.menuItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  String menuItemId,  int quantity, @JsonKey(fromJson: _doubleFromJson)  double priceAtTime,  OrderItemMenuItemDto menuItem)?  $default,) {final _that = this;
switch (_that) {
case _OrderItemDto() when $default != null:
return $default(_that.id,_that.orderId,_that.menuItemId,_that.quantity,_that.priceAtTime,_that.menuItem);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderItemDto implements OrderItemDto {
  const _OrderItemDto({required this.id, required this.orderId, required this.menuItemId, required this.quantity, @JsonKey(fromJson: _doubleFromJson) required this.priceAtTime, required this.menuItem});
  factory _OrderItemDto.fromJson(Map<String, dynamic> json) => _$OrderItemDtoFromJson(json);

@override final  String id;
@override final  String orderId;
@override final  String menuItemId;
@override final  int quantity;
@override@JsonKey(fromJson: _doubleFromJson) final  double priceAtTime;
@override final  OrderItemMenuItemDto menuItem;

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderItemDtoCopyWith<_OrderItemDto> get copyWith => __$OrderItemDtoCopyWithImpl<_OrderItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.priceAtTime, priceAtTime) || other.priceAtTime == priceAtTime)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,menuItemId,quantity,priceAtTime,menuItem);

@override
String toString() {
  return 'OrderItemDto(id: $id, orderId: $orderId, menuItemId: $menuItemId, quantity: $quantity, priceAtTime: $priceAtTime, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class _$OrderItemDtoCopyWith<$Res> implements $OrderItemDtoCopyWith<$Res> {
  factory _$OrderItemDtoCopyWith(_OrderItemDto value, $Res Function(_OrderItemDto) _then) = __$OrderItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, String menuItemId, int quantity,@JsonKey(fromJson: _doubleFromJson) double priceAtTime, OrderItemMenuItemDto menuItem
});


@override $OrderItemMenuItemDtoCopyWith<$Res> get menuItem;

}
/// @nodoc
class __$OrderItemDtoCopyWithImpl<$Res>
    implements _$OrderItemDtoCopyWith<$Res> {
  __$OrderItemDtoCopyWithImpl(this._self, this._then);

  final _OrderItemDto _self;
  final $Res Function(_OrderItemDto) _then;

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? menuItemId = null,Object? quantity = null,Object? priceAtTime = null,Object? menuItem = null,}) {
  return _then(_OrderItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,priceAtTime: null == priceAtTime ? _self.priceAtTime : priceAtTime // ignore: cast_nullable_to_non_nullable
as double,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as OrderItemMenuItemDto,
  ));
}

/// Create a copy of OrderItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrderItemMenuItemDtoCopyWith<$Res> get menuItem {
  
  return $OrderItemMenuItemDtoCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}

// dart format on
