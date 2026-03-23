// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestaurantDto {

 String get id; String get name; String? get description; String get address; double? get lat; double? get lng; String? get imageUrl; bool get isActive; double get rating;
/// Create a copy of RestaurantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestaurantDtoCopyWith<RestaurantDto> get copyWith => _$RestaurantDtoCopyWithImpl<RestaurantDto>(this as RestaurantDto, _$identity);

  /// Serializes this RestaurantDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestaurantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,lat,lng,imageUrl,isActive,rating);

@override
String toString() {
  return 'RestaurantDto(id: $id, name: $name, description: $description, address: $address, lat: $lat, lng: $lng, imageUrl: $imageUrl, isActive: $isActive, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $RestaurantDtoCopyWith<$Res>  {
  factory $RestaurantDtoCopyWith(RestaurantDto value, $Res Function(RestaurantDto) _then) = _$RestaurantDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String address, double? lat, double? lng, String? imageUrl, bool isActive, double rating
});




}
/// @nodoc
class _$RestaurantDtoCopyWithImpl<$Res>
    implements $RestaurantDtoCopyWith<$Res> {
  _$RestaurantDtoCopyWithImpl(this._self, this._then);

  final RestaurantDto _self;
  final $Res Function(RestaurantDto) _then;

/// Create a copy of RestaurantDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? address = null,Object? lat = freezed,Object? lng = freezed,Object? imageUrl = freezed,Object? isActive = null,Object? rating = null,}) {
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
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RestaurantDto].
extension RestaurantDtoPatterns on RestaurantDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestaurantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestaurantDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestaurantDto value)  $default,){
final _that = this;
switch (_that) {
case _RestaurantDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestaurantDto value)?  $default,){
final _that = this;
switch (_that) {
case _RestaurantDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String address,  double? lat,  double? lng,  String? imageUrl,  bool isActive,  double rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestaurantDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.lat,_that.lng,_that.imageUrl,_that.isActive,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String address,  double? lat,  double? lng,  String? imageUrl,  bool isActive,  double rating)  $default,) {final _that = this;
switch (_that) {
case _RestaurantDto():
return $default(_that.id,_that.name,_that.description,_that.address,_that.lat,_that.lng,_that.imageUrl,_that.isActive,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String address,  double? lat,  double? lng,  String? imageUrl,  bool isActive,  double rating)?  $default,) {final _that = this;
switch (_that) {
case _RestaurantDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.lat,_that.lng,_that.imageUrl,_that.isActive,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RestaurantDto implements RestaurantDto {
  const _RestaurantDto({required this.id, required this.name, this.description, required this.address, this.lat, this.lng, this.imageUrl, required this.isActive, required this.rating});
  factory _RestaurantDto.fromJson(Map<String, dynamic> json) => _$RestaurantDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String address;
@override final  double? lat;
@override final  double? lng;
@override final  String? imageUrl;
@override final  bool isActive;
@override final  double rating;

/// Create a copy of RestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestaurantDtoCopyWith<_RestaurantDto> get copyWith => __$RestaurantDtoCopyWithImpl<_RestaurantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RestaurantDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestaurantDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,lat,lng,imageUrl,isActive,rating);

@override
String toString() {
  return 'RestaurantDto(id: $id, name: $name, description: $description, address: $address, lat: $lat, lng: $lng, imageUrl: $imageUrl, isActive: $isActive, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$RestaurantDtoCopyWith<$Res> implements $RestaurantDtoCopyWith<$Res> {
  factory _$RestaurantDtoCopyWith(_RestaurantDto value, $Res Function(_RestaurantDto) _then) = __$RestaurantDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String address, double? lat, double? lng, String? imageUrl, bool isActive, double rating
});




}
/// @nodoc
class __$RestaurantDtoCopyWithImpl<$Res>
    implements _$RestaurantDtoCopyWith<$Res> {
  __$RestaurantDtoCopyWithImpl(this._self, this._then);

  final _RestaurantDto _self;
  final $Res Function(_RestaurantDto) _then;

/// Create a copy of RestaurantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? address = null,Object? lat = freezed,Object? lng = freezed,Object? imageUrl = freezed,Object? isActive = null,Object? rating = null,}) {
  return _then(_RestaurantDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
