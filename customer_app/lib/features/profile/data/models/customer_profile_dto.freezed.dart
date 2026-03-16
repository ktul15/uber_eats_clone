// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerProfileDto {

 String get name; String? get defaultAddress;
/// Create a copy of CustomerProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerProfileDtoCopyWith<CustomerProfileDto> get copyWith => _$CustomerProfileDtoCopyWithImpl<CustomerProfileDto>(this as CustomerProfileDto, _$identity);

  /// Serializes this CustomerProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerProfileDto&&(identical(other.name, name) || other.name == name)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,defaultAddress);

@override
String toString() {
  return 'CustomerProfileDto(name: $name, defaultAddress: $defaultAddress)';
}


}

/// @nodoc
abstract mixin class $CustomerProfileDtoCopyWith<$Res>  {
  factory $CustomerProfileDtoCopyWith(CustomerProfileDto value, $Res Function(CustomerProfileDto) _then) = _$CustomerProfileDtoCopyWithImpl;
@useResult
$Res call({
 String name, String? defaultAddress
});




}
/// @nodoc
class _$CustomerProfileDtoCopyWithImpl<$Res>
    implements $CustomerProfileDtoCopyWith<$Res> {
  _$CustomerProfileDtoCopyWithImpl(this._self, this._then);

  final CustomerProfileDto _self;
  final $Res Function(CustomerProfileDto) _then;

/// Create a copy of CustomerProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? defaultAddress = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CustomerProfileDto].
extension CustomerProfileDtoPatterns on CustomerProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _CustomerProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? defaultAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerProfileDto() when $default != null:
return $default(_that.name,_that.defaultAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? defaultAddress)  $default,) {final _that = this;
switch (_that) {
case _CustomerProfileDto():
return $default(_that.name,_that.defaultAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? defaultAddress)?  $default,) {final _that = this;
switch (_that) {
case _CustomerProfileDto() when $default != null:
return $default(_that.name,_that.defaultAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerProfileDto implements CustomerProfileDto {
  const _CustomerProfileDto({required this.name, this.defaultAddress});
  factory _CustomerProfileDto.fromJson(Map<String, dynamic> json) => _$CustomerProfileDtoFromJson(json);

@override final  String name;
@override final  String? defaultAddress;

/// Create a copy of CustomerProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerProfileDtoCopyWith<_CustomerProfileDto> get copyWith => __$CustomerProfileDtoCopyWithImpl<_CustomerProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerProfileDto&&(identical(other.name, name) || other.name == name)&&(identical(other.defaultAddress, defaultAddress) || other.defaultAddress == defaultAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,defaultAddress);

@override
String toString() {
  return 'CustomerProfileDto(name: $name, defaultAddress: $defaultAddress)';
}


}

/// @nodoc
abstract mixin class _$CustomerProfileDtoCopyWith<$Res> implements $CustomerProfileDtoCopyWith<$Res> {
  factory _$CustomerProfileDtoCopyWith(_CustomerProfileDto value, $Res Function(_CustomerProfileDto) _then) = __$CustomerProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String? defaultAddress
});




}
/// @nodoc
class __$CustomerProfileDtoCopyWithImpl<$Res>
    implements _$CustomerProfileDtoCopyWith<$Res> {
  __$CustomerProfileDtoCopyWithImpl(this._self, this._then);

  final _CustomerProfileDto _self;
  final $Res Function(_CustomerProfileDto) _then;

/// Create a copy of CustomerProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? defaultAddress = freezed,}) {
  return _then(_CustomerProfileDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,defaultAddress: freezed == defaultAddress ? _self.defaultAddress : defaultAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
