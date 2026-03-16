// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverProfile {

 String get name; String? get vehicleType; String? get licenseNumber; bool get isAvailable; double? get currentLat; double? get currentLng;
/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverProfileCopyWith<DriverProfile> get copyWith => _$DriverProfileCopyWithImpl<DriverProfile>(this as DriverProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverProfile&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.currentLat, currentLat) || other.currentLat == currentLat)&&(identical(other.currentLng, currentLng) || other.currentLng == currentLng));
}


@override
int get hashCode => Object.hash(runtimeType,name,vehicleType,licenseNumber,isAvailable,currentLat,currentLng);

@override
String toString() {
  return 'DriverProfile(name: $name, vehicleType: $vehicleType, licenseNumber: $licenseNumber, isAvailable: $isAvailable, currentLat: $currentLat, currentLng: $currentLng)';
}


}

/// @nodoc
abstract mixin class $DriverProfileCopyWith<$Res>  {
  factory $DriverProfileCopyWith(DriverProfile value, $Res Function(DriverProfile) _then) = _$DriverProfileCopyWithImpl;
@useResult
$Res call({
 String name, String? vehicleType, String? licenseNumber, bool isAvailable, double? currentLat, double? currentLng
});




}
/// @nodoc
class _$DriverProfileCopyWithImpl<$Res>
    implements $DriverProfileCopyWith<$Res> {
  _$DriverProfileCopyWithImpl(this._self, this._then);

  final DriverProfile _self;
  final $Res Function(DriverProfile) _then;

/// Create a copy of DriverProfile
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


/// Adds pattern-matching-related methods to [DriverProfile].
extension DriverProfilePatterns on DriverProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverProfile value)  $default,){
final _that = this;
switch (_that) {
case _DriverProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DriverProfile() when $default != null:
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
case _DriverProfile() when $default != null:
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
case _DriverProfile():
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
case _DriverProfile() when $default != null:
return $default(_that.name,_that.vehicleType,_that.licenseNumber,_that.isAvailable,_that.currentLat,_that.currentLng);case _:
  return null;

}
}

}

/// @nodoc


class _DriverProfile implements DriverProfile {
  const _DriverProfile({required this.name, this.vehicleType, this.licenseNumber, this.isAvailable = false, this.currentLat, this.currentLng});
  

@override final  String name;
@override final  String? vehicleType;
@override final  String? licenseNumber;
@override@JsonKey() final  bool isAvailable;
@override final  double? currentLat;
@override final  double? currentLng;

/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverProfileCopyWith<_DriverProfile> get copyWith => __$DriverProfileCopyWithImpl<_DriverProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverProfile&&(identical(other.name, name) || other.name == name)&&(identical(other.vehicleType, vehicleType) || other.vehicleType == vehicleType)&&(identical(other.licenseNumber, licenseNumber) || other.licenseNumber == licenseNumber)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.currentLat, currentLat) || other.currentLat == currentLat)&&(identical(other.currentLng, currentLng) || other.currentLng == currentLng));
}


@override
int get hashCode => Object.hash(runtimeType,name,vehicleType,licenseNumber,isAvailable,currentLat,currentLng);

@override
String toString() {
  return 'DriverProfile(name: $name, vehicleType: $vehicleType, licenseNumber: $licenseNumber, isAvailable: $isAvailable, currentLat: $currentLat, currentLng: $currentLng)';
}


}

/// @nodoc
abstract mixin class _$DriverProfileCopyWith<$Res> implements $DriverProfileCopyWith<$Res> {
  factory _$DriverProfileCopyWith(_DriverProfile value, $Res Function(_DriverProfile) _then) = __$DriverProfileCopyWithImpl;
@override @useResult
$Res call({
 String name, String? vehicleType, String? licenseNumber, bool isAvailable, double? currentLat, double? currentLng
});




}
/// @nodoc
class __$DriverProfileCopyWithImpl<$Res>
    implements _$DriverProfileCopyWith<$Res> {
  __$DriverProfileCopyWithImpl(this._self, this._then);

  final _DriverProfile _self;
  final $Res Function(_DriverProfile) _then;

/// Create a copy of DriverProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? vehicleType = freezed,Object? licenseNumber = freezed,Object? isAvailable = null,Object? currentLat = freezed,Object? currentLng = freezed,}) {
  return _then(_DriverProfile(
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

/// @nodoc
mixin _$UserProfile {

 String get id; String get email; String? get phone; String get role; DriverProfile get profile;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,phone,role,profile);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, phone: $phone, role: $role, profile: $profile)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? phone, String role, DriverProfile profile
});


$DriverProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? phone = freezed,Object? role = null,Object? profile = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DriverProfile,
  ));
}
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverProfileCopyWith<$Res> get profile {
  
  return $DriverProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? phone,  String role,  DriverProfile profile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.phone,_that.role,_that.profile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? phone,  String role,  DriverProfile profile)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.email,_that.phone,_that.role,_that.profile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? phone,  String role,  DriverProfile profile)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.email,_that.phone,_that.role,_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class _UserProfile implements UserProfile {
  const _UserProfile({required this.id, required this.email, this.phone, required this.role, required this.profile});
  

@override final  String id;
@override final  String email;
@override final  String? phone;
@override final  String role;
@override final  DriverProfile profile;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,phone,role,profile);

@override
String toString() {
  return 'UserProfile(id: $id, email: $email, phone: $phone, role: $role, profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? phone, String role, DriverProfile profile
});


@override $DriverProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? phone = freezed,Object? role = null,Object? profile = null,}) {
  return _then(_UserProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as DriverProfile,
  ));
}

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverProfileCopyWith<$Res> get profile {
  
  return $DriverProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
