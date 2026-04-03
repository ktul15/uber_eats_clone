// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartItemMenuItemDto {

 String get id; String get name; String? get description; double get price; String? get imageUrl; bool get isAvailable;
/// Create a copy of CartItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemMenuItemDtoCopyWith<CartItemMenuItemDto> get copyWith => _$CartItemMenuItemDtoCopyWithImpl<CartItemMenuItemDto>(this as CartItemMenuItemDto, _$identity);

  /// Serializes this CartItemMenuItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemMenuItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'CartItemMenuItemDto(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $CartItemMenuItemDtoCopyWith<$Res>  {
  factory $CartItemMenuItemDtoCopyWith(CartItemMenuItemDto value, $Res Function(CartItemMenuItemDto) _then) = _$CartItemMenuItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, double price, String? imageUrl, bool isAvailable
});




}
/// @nodoc
class _$CartItemMenuItemDtoCopyWithImpl<$Res>
    implements $CartItemMenuItemDtoCopyWith<$Res> {
  _$CartItemMenuItemDtoCopyWithImpl(this._self, this._then);

  final CartItemMenuItemDto _self;
  final $Res Function(CartItemMenuItemDto) _then;

/// Create a copy of CartItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? imageUrl = freezed,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CartItemMenuItemDto].
extension CartItemMenuItemDtoPatterns on CartItemMenuItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemMenuItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemMenuItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemMenuItemDto value)  $default,){
final _that = this;
switch (_that) {
case _CartItemMenuItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemMenuItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemMenuItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  double price,  String? imageUrl,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemMenuItemDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  double price,  String? imageUrl,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _CartItemMenuItemDto():
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  double price,  String? imageUrl,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _CartItemMenuItemDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemMenuItemDto implements CartItemMenuItemDto {
  const _CartItemMenuItemDto({required this.id, required this.name, this.description, required this.price, this.imageUrl, required this.isAvailable});
  factory _CartItemMenuItemDto.fromJson(Map<String, dynamic> json) => _$CartItemMenuItemDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  double price;
@override final  String? imageUrl;
@override final  bool isAvailable;

/// Create a copy of CartItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemMenuItemDtoCopyWith<_CartItemMenuItemDto> get copyWith => __$CartItemMenuItemDtoCopyWithImpl<_CartItemMenuItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemMenuItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemMenuItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'CartItemMenuItemDto(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$CartItemMenuItemDtoCopyWith<$Res> implements $CartItemMenuItemDtoCopyWith<$Res> {
  factory _$CartItemMenuItemDtoCopyWith(_CartItemMenuItemDto value, $Res Function(_CartItemMenuItemDto) _then) = __$CartItemMenuItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, double price, String? imageUrl, bool isAvailable
});




}
/// @nodoc
class __$CartItemMenuItemDtoCopyWithImpl<$Res>
    implements _$CartItemMenuItemDtoCopyWith<$Res> {
  __$CartItemMenuItemDtoCopyWithImpl(this._self, this._then);

  final _CartItemMenuItemDto _self;
  final $Res Function(_CartItemMenuItemDto) _then;

/// Create a copy of CartItemMenuItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? imageUrl = freezed,Object? isAvailable = null,}) {
  return _then(_CartItemMenuItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CartItemDto {

 String get id; String get cartId; String get menuItemId; int get quantity; CartItemMenuItemDto get menuItem;
/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemDtoCopyWith<CartItemDto> get copyWith => _$CartItemDtoCopyWithImpl<CartItemDto>(this as CartItemDto, _$identity);

  /// Serializes this CartItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.cartId, cartId) || other.cartId == cartId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cartId,menuItemId,quantity,menuItem);

@override
String toString() {
  return 'CartItemDto(id: $id, cartId: $cartId, menuItemId: $menuItemId, quantity: $quantity, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class $CartItemDtoCopyWith<$Res>  {
  factory $CartItemDtoCopyWith(CartItemDto value, $Res Function(CartItemDto) _then) = _$CartItemDtoCopyWithImpl;
@useResult
$Res call({
 String id, String cartId, String menuItemId, int quantity, CartItemMenuItemDto menuItem
});


$CartItemMenuItemDtoCopyWith<$Res> get menuItem;

}
/// @nodoc
class _$CartItemDtoCopyWithImpl<$Res>
    implements $CartItemDtoCopyWith<$Res> {
  _$CartItemDtoCopyWithImpl(this._self, this._then);

  final CartItemDto _self;
  final $Res Function(CartItemDto) _then;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cartId = null,Object? menuItemId = null,Object? quantity = null,Object? menuItem = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cartId: null == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as CartItemMenuItemDto,
  ));
}
/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartItemMenuItemDtoCopyWith<$Res> get menuItem {
  
  return $CartItemMenuItemDtoCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartItemDto].
extension CartItemDtoPatterns on CartItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemDto value)  $default,){
final _that = this;
switch (_that) {
case _CartItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String cartId,  String menuItemId,  int quantity,  CartItemMenuItemDto menuItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
return $default(_that.id,_that.cartId,_that.menuItemId,_that.quantity,_that.menuItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String cartId,  String menuItemId,  int quantity,  CartItemMenuItemDto menuItem)  $default,) {final _that = this;
switch (_that) {
case _CartItemDto():
return $default(_that.id,_that.cartId,_that.menuItemId,_that.quantity,_that.menuItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String cartId,  String menuItemId,  int quantity,  CartItemMenuItemDto menuItem)?  $default,) {final _that = this;
switch (_that) {
case _CartItemDto() when $default != null:
return $default(_that.id,_that.cartId,_that.menuItemId,_that.quantity,_that.menuItem);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartItemDto implements CartItemDto {
  const _CartItemDto({required this.id, required this.cartId, required this.menuItemId, required this.quantity, required this.menuItem});
  factory _CartItemDto.fromJson(Map<String, dynamic> json) => _$CartItemDtoFromJson(json);

@override final  String id;
@override final  String cartId;
@override final  String menuItemId;
@override final  int quantity;
@override final  CartItemMenuItemDto menuItem;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemDtoCopyWith<_CartItemDto> get copyWith => __$CartItemDtoCopyWithImpl<_CartItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemDto&&(identical(other.id, id) || other.id == id)&&(identical(other.cartId, cartId) || other.cartId == cartId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cartId,menuItemId,quantity,menuItem);

@override
String toString() {
  return 'CartItemDto(id: $id, cartId: $cartId, menuItemId: $menuItemId, quantity: $quantity, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class _$CartItemDtoCopyWith<$Res> implements $CartItemDtoCopyWith<$Res> {
  factory _$CartItemDtoCopyWith(_CartItemDto value, $Res Function(_CartItemDto) _then) = __$CartItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String cartId, String menuItemId, int quantity, CartItemMenuItemDto menuItem
});


@override $CartItemMenuItemDtoCopyWith<$Res> get menuItem;

}
/// @nodoc
class __$CartItemDtoCopyWithImpl<$Res>
    implements _$CartItemDtoCopyWith<$Res> {
  __$CartItemDtoCopyWithImpl(this._self, this._then);

  final _CartItemDto _self;
  final $Res Function(_CartItemDto) _then;

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cartId = null,Object? menuItemId = null,Object? quantity = null,Object? menuItem = null,}) {
  return _then(_CartItemDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cartId: null == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as CartItemMenuItemDto,
  ));
}

/// Create a copy of CartItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartItemMenuItemDtoCopyWith<$Res> get menuItem {
  
  return $CartItemMenuItemDtoCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}

// dart format on
