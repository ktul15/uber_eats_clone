// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartItemMenuItem {

 String get id; String get name; String? get description; double get price; String? get imageUrl; bool get isAvailable;
/// Create a copy of CartItemMenuItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemMenuItemCopyWith<CartItemMenuItem> get copyWith => _$CartItemMenuItemCopyWithImpl<CartItemMenuItem>(this as CartItemMenuItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemMenuItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'CartItemMenuItem(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $CartItemMenuItemCopyWith<$Res>  {
  factory $CartItemMenuItemCopyWith(CartItemMenuItem value, $Res Function(CartItemMenuItem) _then) = _$CartItemMenuItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, double price, String? imageUrl, bool isAvailable
});




}
/// @nodoc
class _$CartItemMenuItemCopyWithImpl<$Res>
    implements $CartItemMenuItemCopyWith<$Res> {
  _$CartItemMenuItemCopyWithImpl(this._self, this._then);

  final CartItemMenuItem _self;
  final $Res Function(CartItemMenuItem) _then;

/// Create a copy of CartItemMenuItem
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


/// Adds pattern-matching-related methods to [CartItemMenuItem].
extension CartItemMenuItemPatterns on CartItemMenuItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItemMenuItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItemMenuItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItemMenuItem value)  $default,){
final _that = this;
switch (_that) {
case _CartItemMenuItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItemMenuItem value)?  $default,){
final _that = this;
switch (_that) {
case _CartItemMenuItem() when $default != null:
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
case _CartItemMenuItem() when $default != null:
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
case _CartItemMenuItem():
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
case _CartItemMenuItem() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.imageUrl,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc


class _CartItemMenuItem implements CartItemMenuItem {
  const _CartItemMenuItem({required this.id, required this.name, this.description, required this.price, this.imageUrl, required this.isAvailable});
  

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  double price;
@override final  String? imageUrl;
@override final  bool isAvailable;

/// Create a copy of CartItemMenuItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemMenuItemCopyWith<_CartItemMenuItem> get copyWith => __$CartItemMenuItemCopyWithImpl<_CartItemMenuItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItemMenuItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,imageUrl,isAvailable);

@override
String toString() {
  return 'CartItemMenuItem(id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$CartItemMenuItemCopyWith<$Res> implements $CartItemMenuItemCopyWith<$Res> {
  factory _$CartItemMenuItemCopyWith(_CartItemMenuItem value, $Res Function(_CartItemMenuItem) _then) = __$CartItemMenuItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, double price, String? imageUrl, bool isAvailable
});




}
/// @nodoc
class __$CartItemMenuItemCopyWithImpl<$Res>
    implements _$CartItemMenuItemCopyWith<$Res> {
  __$CartItemMenuItemCopyWithImpl(this._self, this._then);

  final _CartItemMenuItem _self;
  final $Res Function(_CartItemMenuItem) _then;

/// Create a copy of CartItemMenuItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? imageUrl = freezed,Object? isAvailable = null,}) {
  return _then(_CartItemMenuItem(
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
mixin _$CartItem {

 String get id; String get cartId; String get menuItemId; int get quantity; CartItemMenuItem get menuItem;
/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemCopyWith<CartItem> get copyWith => _$CartItemCopyWithImpl<CartItem>(this as CartItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItem&&(identical(other.id, id) || other.id == id)&&(identical(other.cartId, cartId) || other.cartId == cartId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}


@override
int get hashCode => Object.hash(runtimeType,id,cartId,menuItemId,quantity,menuItem);

@override
String toString() {
  return 'CartItem(id: $id, cartId: $cartId, menuItemId: $menuItemId, quantity: $quantity, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class $CartItemCopyWith<$Res>  {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) _then) = _$CartItemCopyWithImpl;
@useResult
$Res call({
 String id, String cartId, String menuItemId, int quantity, CartItemMenuItem menuItem
});


$CartItemMenuItemCopyWith<$Res> get menuItem;

}
/// @nodoc
class _$CartItemCopyWithImpl<$Res>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._self, this._then);

  final CartItem _self;
  final $Res Function(CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cartId = null,Object? menuItemId = null,Object? quantity = null,Object? menuItem = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cartId: null == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as CartItemMenuItem,
  ));
}
/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartItemMenuItemCopyWith<$Res> get menuItem {
  
  return $CartItemMenuItemCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartItem].
extension CartItemPatterns on CartItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItem value)  $default,){
final _that = this;
switch (_that) {
case _CartItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItem value)?  $default,){
final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String cartId,  String menuItemId,  int quantity,  CartItemMenuItem menuItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String cartId,  String menuItemId,  int quantity,  CartItemMenuItem menuItem)  $default,) {final _that = this;
switch (_that) {
case _CartItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String cartId,  String menuItemId,  int quantity,  CartItemMenuItem menuItem)?  $default,) {final _that = this;
switch (_that) {
case _CartItem() when $default != null:
return $default(_that.id,_that.cartId,_that.menuItemId,_that.quantity,_that.menuItem);case _:
  return null;

}
}

}

/// @nodoc


class _CartItem implements CartItem {
  const _CartItem({required this.id, required this.cartId, required this.menuItemId, required this.quantity, required this.menuItem});
  

@override final  String id;
@override final  String cartId;
@override final  String menuItemId;
@override final  int quantity;
@override final  CartItemMenuItem menuItem;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemCopyWith<_CartItem> get copyWith => __$CartItemCopyWithImpl<_CartItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItem&&(identical(other.id, id) || other.id == id)&&(identical(other.cartId, cartId) || other.cartId == cartId)&&(identical(other.menuItemId, menuItemId) || other.menuItemId == menuItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.menuItem, menuItem) || other.menuItem == menuItem));
}


@override
int get hashCode => Object.hash(runtimeType,id,cartId,menuItemId,quantity,menuItem);

@override
String toString() {
  return 'CartItem(id: $id, cartId: $cartId, menuItemId: $menuItemId, quantity: $quantity, menuItem: $menuItem)';
}


}

/// @nodoc
abstract mixin class _$CartItemCopyWith<$Res> implements $CartItemCopyWith<$Res> {
  factory _$CartItemCopyWith(_CartItem value, $Res Function(_CartItem) _then) = __$CartItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String cartId, String menuItemId, int quantity, CartItemMenuItem menuItem
});


@override $CartItemMenuItemCopyWith<$Res> get menuItem;

}
/// @nodoc
class __$CartItemCopyWithImpl<$Res>
    implements _$CartItemCopyWith<$Res> {
  __$CartItemCopyWithImpl(this._self, this._then);

  final _CartItem _self;
  final $Res Function(_CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cartId = null,Object? menuItemId = null,Object? quantity = null,Object? menuItem = null,}) {
  return _then(_CartItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cartId: null == cartId ? _self.cartId : cartId // ignore: cast_nullable_to_non_nullable
as String,menuItemId: null == menuItemId ? _self.menuItemId : menuItemId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,menuItem: null == menuItem ? _self.menuItem : menuItem // ignore: cast_nullable_to_non_nullable
as CartItemMenuItem,
  ));
}

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartItemMenuItemCopyWith<$Res> get menuItem {
  
  return $CartItemMenuItemCopyWith<$Res>(_self.menuItem, (value) {
    return _then(_self.copyWith(menuItem: value));
  });
}
}

// dart format on
