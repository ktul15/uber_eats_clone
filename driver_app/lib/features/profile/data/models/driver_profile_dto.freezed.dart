// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DriverProfileDto {

 String get name; String? get vehicleType; String? get licenseNumber; bool get isAvailable; double? get currentLat; double? get currentLng;
/// Create a copy of DriverProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverProfileDtoCopyWith<DriverProfileDto> get copyWith => _$DriverProfileDtoCopyWithImpl<DriverProfileDto>(this as DriverProfileDto, _$identity);

  /// Serializes this DriverProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverProfileDto&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.currentLat, currentLat) || other.currentLat == currentLat)&&(identical(other.currentLng, currentLng) || other.currentLng == currentLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,vehicleType,licenseNumber,isAvailable,currentLat,currentLng);

@override
String toString() {
  return 'DriverProfileDto(name: $name, vehicleType: $vehicleType, licenseNumber: $licenseNumber, isAvailable: $isAvailable, currentLat: $currentLat, currentLng: $currentLng)';
}


}

/// @nodoc
abstract mixin class $DriverProfileDtoCopyWith<$Res>  {
  factory $DriverProfileDtoCopyWith(DriverProfileDto value, $Res Function(DriverProfileDto) _then) = _$DriverProfileDtoCopyWithImpl;
@useResult
$Res call({
 String name, String? vehicleType, String? licenseNumber, bool isAvailable, double? currentLat, double? currentLng
});




}
/// @nodoc
class _$DriverProfileDtoCopyWithImpl<$Res>
    implements $DriverProfileDtoCopyWith<$Res> {
  _$DriverProfileDtoCopyWithImpl(this._self, this._then);

  final DriverProfileDto _self;
  final $Res Function(DriverProfileDto) _then;

/// Create a copy of DriverProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? vehicleType = freezed,Object? licenseNumber = freezed,Object? isAvailable = null,Object? currentLat = freezed,Object? currentLng = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vehicleType: freezed == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String?,licenseNumber: freezed == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,currentLat: freezed == currentLat ? _self.currentLat : currentLat // ignore: cast_nullable_to_non_nullable
as double?,currentLng: freezed == currentLng ? _self.currentLng : currentLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverProfileDto].
extension DriverProfileDtoPatterns on DriverProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _DriverProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _DriverProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? vehicleType,  String? licenseNumber,  bool isAvailable,  double? currentLat,  double? currentLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverProfileDto() when $default != null:
return $default(_that.name,_that.vehicleType,_that.licenseNumber,_that.isAvailable,_that.currentLat,_that.currentLng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? vehicleType,  String? licenseNumber,  bool isAvailable,  double? currentLat,  double? currentLng)  $default,) {final _that = this;
switch (_that) {
case _DriverProfileDto():
return $default(_that.name,_that.vehicleType,_that.licenseNumber,_that.isAvailable,_that.currentLat,_that.currentLng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? vehicleType,  String? licenseNumber,  bool isAvailable,  double? currentLat,  double? currentLng)?  $default,) {final _that = this;
switch (_that) {
case _DriverProfileDto() when $default != null:
return $default(_that.name,_that.vehicleType,_that.licenseNumber,_that.isAvailable,_that.currentLat,_that.currentLng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DriverProfileDto implements DriverProfileDto {
  const _DriverProfileDto({required this.name, this.vehicleType, this.licenseNumber, this.isAvailable = false, this.currentLat, this.currentLng});
  factory _DriverProfileDto.fromJson(Map<String, dynamic> json) => _$DriverProfileDtoFromJson(json);

@override final  String name;
@override final  String? vehicleType;
@override final  String? licenseNumber;
@override@JsonKey() final  bool isAvailable;
@override final  double? currentLat;
@override final  double? currentLng;

/// Create a copy of DriverProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverProfileDtoCopyWith<_DriverProfileDto> get copyWith => __$DriverProfileDtoCopyWithImpl<_DriverProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DriverProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverProfileDto&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.currentLat, currentLat) || other.currentLat == currentLat)&&(identical(other.currentLng, currentLng) || other.currentLng == currentLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,vehicleType,licenseNumber,isAvailable,currentLat,currentLng);

@override
String toString() {
  return 'DriverProfileDto(name: $name, vehicleType: $vehicleType, licenseNumber: $licenseNumber, isAvailable: $isAvailable, currentLat: $currentLat, currentLng: $currentLng)';
}


}

/// @nodoc
abstract mixin class _$DriverProfileDtoCopyWith<$Res> implements $DriverProfileDtoCopyWith<$Res> {
  factory _$DriverProfileDtoCopyWith(_DriverProfileDto value, $Res Function(_DriverProfileDto) _then) = __$DriverProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String? vehicleType, String? licenseNumber, bool isAvailable, double? currentLat, double? currentLng
});




}
/// @nodoc
class __$DriverProfileDtoCopyWithImpl<$Res>
    implements _$DriverProfileDtoCopyWith<$Res> {
  __$DriverProfileDtoCopyWithImpl(this._self, this._then);

  final _DriverProfileDto _self;
  final $Res Function(_DriverProfileDto) _then;

/// Create a copy of DriverProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? vehicleType = freezed,Object? licenseNumber = freezed,Object? isAvailable = null,Object? currentLat = freezed,Object? currentLng = freezed,}) {
  return _then(_DriverProfileDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,vehicleType: freezed == vehicleType ? _self.vehicleType : vehicleType // ignore: cast_nullable_to_non_nullable
as String?,licenseNumber: freezed == licenseNumber ? _self.licenseNumber : licenseNumber // ignore: cast_nullable_to_non_nullable
as String?,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,currentLat: freezed == currentLat ? _self.currentLat : currentLat // ignore: cast_nullable_to_non_nullable
as double?,currentLng: freezed == currentLng ? _self.currentLng : currentLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
