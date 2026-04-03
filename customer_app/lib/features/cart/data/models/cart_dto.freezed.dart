// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartRestaurantDto {

 String get id; String get name; String? get imageUrl;
/// Create a copy of CartRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartRestaurantDtoCopyWith<CartRestaurantDto> get copyWith => _$CartRestaurantDtoCopyWithImpl<CartRestaurantDto>(this as CartRestaurantDto, _$identity);

  /// Serializes this CartRestaurantDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartRestaurantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'CartRestaurantDto(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $CartRestaurantDtoCopyWith<$Res>  {
  factory $CartRestaurantDtoCopyWith(CartRestaurantDto value, $Res Function(CartRestaurantDto) _then) = _$CartRestaurantDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? imageUrl
});




}
/// @nodoc
class _$CartRestaurantDtoCopyWithImpl<$Res>
    implements $CartRestaurantDtoCopyWith<$Res> {
  _$CartRestaurantDtoCopyWithImpl(this._self, this._then);

  final CartRestaurantDto _self;
  final $Res Function(CartRestaurantDto) _then;

/// Create a copy of CartRestaurantDto
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


/// Adds pattern-matching-related methods to [CartRestaurantDto].
extension CartRestaurantDtoPatterns on CartRestaurantDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartRestaurantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartRestaurantDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartRestaurantDto value)  $default,){
final _that = this;
switch (_that) {
case _CartRestaurantDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartRestaurantDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartRestaurantDto() when $default != null:
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
case _CartRestaurantDto() when $default != null:
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
case _CartRestaurantDto():
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
case _CartRestaurantDto() when $default != null:
return $default(_that.id,_that.name,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartRestaurantDto implements CartRestaurantDto {
  const _CartRestaurantDto({required this.id, required this.name, this.imageUrl});
  factory _CartRestaurantDto.fromJson(Map<String, dynamic> json) => _$CartRestaurantDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? imageUrl;

/// Create a copy of CartRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartRestaurantDtoCopyWith<_CartRestaurantDto> get copyWith => __$CartRestaurantDtoCopyWithImpl<_CartRestaurantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartRestaurantDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartRestaurantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,imageUrl);

@override
String toString() {
  return 'CartRestaurantDto(id: $id, name: $name, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$CartRestaurantDtoCopyWith<$Res> implements $CartRestaurantDtoCopyWith<$Res> {
  factory _$CartRestaurantDtoCopyWith(_CartRestaurantDto value, $Res Function(_CartRestaurantDto) _then) = __$CartRestaurantDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? imageUrl
});




}
/// @nodoc
class __$CartRestaurantDtoCopyWithImpl<$Res>
    implements _$CartRestaurantDtoCopyWith<$Res> {
  __$CartRestaurantDtoCopyWithImpl(this._self, this._then);

  final _CartRestaurantDto _self;
  final $Res Function(_CartRestaurantDto) _then;

/// Create a copy of CartRestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imageUrl = freezed,}) {
  return _then(_CartRestaurantDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CartDto {

 String get id; String get customerId; String get restaurantId; CartRestaurantDto get restaurant; List<CartItemDto> get items;
/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartDtoCopyWith<CartDto> get copyWith => _$CartDtoCopyWithImpl<CartDto>(this as CartDto, _$identity);

  /// Serializes this CartDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartDto&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,restaurantId,restaurant,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CartDto(id: $id, customerId: $customerId, restaurantId: $restaurantId, restaurant: $restaurant, items: $items)';
}


}

/// @nodoc
abstract mixin class $CartDtoCopyWith<$Res>  {
  factory $CartDtoCopyWith(CartDto value, $Res Function(CartDto) _then) = _$CartDtoCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String restaurantId, CartRestaurantDto restaurant, List<CartItemDto> items
});


$CartRestaurantDtoCopyWith<$Res> get restaurant;

}
/// @nodoc
class _$CartDtoCopyWithImpl<$Res>
    implements $CartDtoCopyWith<$Res> {
  _$CartDtoCopyWithImpl(this._self, this._then);

  final CartDto _self;
  final $Res Function(CartDto) _then;

/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? restaurantId = null,Object? restaurant = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,restaurant: null == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as CartRestaurantDto,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemDto>,
  ));
}
/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartRestaurantDtoCopyWith<$Res> get restaurant {
  
  return $CartRestaurantDtoCopyWith<$Res>(_self.restaurant, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartDto].
extension CartDtoPatterns on CartDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartDto value)  $default,){
final _that = this;
switch (_that) {
case _CartDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String restaurantId,  CartRestaurantDto restaurant,  List<CartItemDto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartDto() when $default != null:
return $default(_that.id,_that.customerId,_that.restaurantId,_that.restaurant,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String restaurantId,  CartRestaurantDto restaurant,  List<CartItemDto> items)  $default,) {final _that = this;
switch (_that) {
case _CartDto():
return $default(_that.id,_that.customerId,_that.restaurantId,_that.restaurant,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String restaurantId,  CartRestaurantDto restaurant,  List<CartItemDto> items)?  $default,) {final _that = this;
switch (_that) {
case _CartDto() when $default != null:
return $default(_that.id,_that.customerId,_that.restaurantId,_that.restaurant,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartDto implements CartDto {
  const _CartDto({required this.id, required this.customerId, required this.restaurantId, required this.restaurant, required final  List<CartItemDto> items}): _items = items;
  factory _CartDto.fromJson(Map<String, dynamic> json) => _$CartDtoFromJson(json);

@override final  String id;
@override final  String customerId;
@override final  String restaurantId;
@override final  CartRestaurantDto restaurant;
 final  List<CartItemDto> _items;
@override List<CartItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartDtoCopyWith<_CartDto> get copyWith => __$CartDtoCopyWithImpl<_CartDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartDto&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.restaurantId, restaurantId) || other.restaurantId == restaurantId)&&(identical(other.restaurant, restaurant) || other.restaurant == restaurant)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,customerId,restaurantId,restaurant,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CartDto(id: $id, customerId: $customerId, restaurantId: $restaurantId, restaurant: $restaurant, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CartDtoCopyWith<$Res> implements $CartDtoCopyWith<$Res> {
  factory _$CartDtoCopyWith(_CartDto value, $Res Function(_CartDto) _then) = __$CartDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String restaurantId, CartRestaurantDto restaurant, List<CartItemDto> items
});


@override $CartRestaurantDtoCopyWith<$Res> get restaurant;

}
/// @nodoc
class __$CartDtoCopyWithImpl<$Res>
    implements _$CartDtoCopyWith<$Res> {
  __$CartDtoCopyWithImpl(this._self, this._then);

  final _CartDto _self;
  final $Res Function(_CartDto) _then;

/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? restaurantId = null,Object? restaurant = null,Object? items = null,}) {
  return _then(_CartDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,restaurantId: null == restaurantId ? _self.restaurantId : restaurantId // ignore: cast_nullable_to_non_nullable
as String,restaurant: null == restaurant ? _self.restaurant : restaurant // ignore: cast_nullable_to_non_nullable
as CartRestaurantDto,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItemDto>,
  ));
}

/// Create a copy of CartDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartRestaurantDtoCopyWith<$Res> get restaurant {
  
  return $CartRestaurantDtoCopyWith<$Res>(_self.restaurant, (value) {
    return _then(_self.copyWith(restaurant: value));
  });
}
}

// dart format on
