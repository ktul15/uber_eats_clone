// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestaurantDetail {

 String get id; String get name; String? get description; String get address; double? get lat; double? get lng; String? get imageUrl; bool get isActive; double get rating; List<MenuItem> get menuItems;
/// Create a copy of RestaurantDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantDetailCopyWith<RestaurantDetail> get copyWith => _$RestaurantDetailCopyWithImpl<RestaurantDetail>(this as RestaurantDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.menuItems, menuItems));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,lat,lng,imageUrl,isActive,rating,const DeepCollectionEquality().hash(menuItems));

@override
String toString() {
  return 'RestaurantDetail(id: $id, name: $name, description: $description, address: $address, lat: $lat, lng: $lng, imageUrl: $imageUrl, isActive: $isActive, rating: $rating, menuItems: $menuItems)';
}


}

/// @nodoc
abstract mixin class $RestaurantDetailCopyWith<$Res>  {
  factory $RestaurantDetailCopyWith(RestaurantDetail value, $Res Function(RestaurantDetail) _then) = _$RestaurantDetailCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String address, double? lat, double? lng, String? imageUrl, bool isActive, double rating, List<MenuItem> menuItems
});




}
/// @nodoc
class _$RestaurantDetailCopyWithImpl<$Res>
    implements $RestaurantDetailCopyWith<$Res> {
  _$RestaurantDetailCopyWithImpl(this._self, this._then);

  final RestaurantDetail _self;
  final $Res Function(RestaurantDetail) _then;

/// Create a copy of RestaurantDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? address = null,Object? lat = freezed,Object? lng = freezed,Object? imageUrl = freezed,Object? isActive = null,Object? rating = null,Object? menuItems = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,menuItems: null == menuItems ? _self.menuItems : menuItems // ignore: cast_nullable_to_non_nullable
as List<MenuItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantDetail].
extension RestaurantDetailPatterns on RestaurantDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantDetail value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantDetail value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String address,  double? lat,  double? lng,  String? imageUrl,  bool isActive,  double rating,  List<MenuItem> menuItems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantDetail() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.lat,_that.lng,_that.imageUrl,_that.isActive,_that.rating,_that.menuItems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String address,  double? lat,  double? lng,  String? imageUrl,  bool isActive,  double rating,  List<MenuItem> menuItems)  $default,) {final _that = this;
switch (_that) {
case _RestaurantDetail():
return $default(_that.id,_that.name,_that.description,_that.address,_that.lat,_that.lng,_that.imageUrl,_that.isActive,_that.rating,_that.menuItems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String address,  double? lat,  double? lng,  String? imageUrl,  bool isActive,  double rating,  List<MenuItem> menuItems)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantDetail() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.lat,_that.lng,_that.imageUrl,_that.isActive,_that.rating,_that.menuItems);case _:
  return null;

}
}

}

/// @nodoc


class _RestaurantDetail implements RestaurantDetail {
  const _RestaurantDetail({required this.id, required this.name, this.description, required this.address, this.lat, this.lng, this.imageUrl, required this.isActive, required this.rating, required final  List<MenuItem> menuItems}): _menuItems = menuItems;
  

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String address;
@override final  double? lat;
@override final  double? lng;
@override final  String? imageUrl;
@override final  bool isActive;
@override final  double rating;
 final  List<MenuItem> _menuItems;
@override List<MenuItem> get menuItems {
  if (_menuItems is EqualUnmodifiableListView) return _menuItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_menuItems);
}


/// Create a copy of RestaurantDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantDetailCopyWith<_RestaurantDetail> get copyWith => __$RestaurantDetailCopyWithImpl<_RestaurantDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._menuItems, _menuItems));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,lat,lng,imageUrl,isActive,rating,const DeepCollectionEquality().hash(_menuItems));

@override
String toString() {
  return 'RestaurantDetail(id: $id, name: $name, description: $description, address: $address, lat: $lat, lng: $lng, imageUrl: $imageUrl, isActive: $isActive, rating: $rating, menuItems: $menuItems)';
}


}

/// @nodoc
abstract mixin class _$RestaurantDetailCopyWith<$Res> implements $RestaurantDetailCopyWith<$Res> {
  factory _$RestaurantDetailCopyWith(_RestaurantDetail value, $Res Function(_RestaurantDetail) _then) = __$RestaurantDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String address, double? lat, double? lng, String? imageUrl, bool isActive, double rating, List<MenuItem> menuItems
});




}
/// @nodoc
class __$RestaurantDetailCopyWithImpl<$Res>
    implements _$RestaurantDetailCopyWith<$Res> {
  __$RestaurantDetailCopyWithImpl(this._self, this._then);

  final _RestaurantDetail _self;
  final $Res Function(_RestaurantDetail) _then;

/// Create a copy of RestaurantDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? address = null,Object? lat = freezed,Object? lng = freezed,Object? imageUrl = freezed,Object? isActive = null,Object? rating = null,Object? menuItems = null,}) {
  return _then(_RestaurantDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,menuItems: null == menuItems ? _self._menuItems : menuItems // ignore: cast_nullable_to_non_nullable
as List<MenuItem>,
  ));
}


}

// dart format on
