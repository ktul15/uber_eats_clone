// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_delivery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveDeliveryState {

 String? get deliveryId; String get status; String? get driverName; String? get driverVehicleType; double? get driverLat; double? get driverLng; String? get deliveryAddress; List<LatLng> get routePoints; int? get etaMinutes; LatLng? get destination;
/// Create a copy of ActiveDeliveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveDeliveryStateCopyWith<ActiveDeliveryState> get copyWith => _$ActiveDeliveryStateCopyWithImpl<ActiveDeliveryState>(this as ActiveDeliveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveDeliveryState&&(identical(other.deliveryId, deliveryId) || other.deliveryId == deliveryId)&&(identical(other.status, status) || other.status == status)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverVehicleType, driverVehicleType) || other.driverVehicleType == driverVehicleType)&&(identical(other.driverLat, driverLat) || other.driverLat == driverLat)&&(identical(other.driverLng, driverLng) || other.driverLng == driverLng)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&const DeepCollectionEquality().equals(other.routePoints, routePoints)&&(identical(other.etaMinutes, etaMinutes) || other.etaMinutes == etaMinutes)&&(identical(other.destination, destination) || other.destination == destination));
}


@override
int get hashCode => Object.hash(runtimeType,deliveryId,status,driverName,driverVehicleType,driverLat,driverLng,deliveryAddress,const DeepCollectionEquality().hash(routePoints),etaMinutes,destination);

@override
String toString() {
  return 'ActiveDeliveryState(deliveryId: $deliveryId, status: $status, driverName: $driverName, driverVehicleType: $driverVehicleType, driverLat: $driverLat, driverLng: $driverLng, deliveryAddress: $deliveryAddress, routePoints: $routePoints, etaMinutes: $etaMinutes, destination: $destination)';
}


}

/// @nodoc
abstract mixin class $ActiveDeliveryStateCopyWith<$Res>  {
  factory $ActiveDeliveryStateCopyWith(ActiveDeliveryState value, $Res Function(ActiveDeliveryState) _then) = _$ActiveDeliveryStateCopyWithImpl;
@useResult
$Res call({
 String? deliveryId, String status, String? driverName, String? driverVehicleType, double? driverLat, double? driverLng, String? deliveryAddress, List<LatLng> routePoints, int? etaMinutes, LatLng? destination
});




}
/// @nodoc
class _$ActiveDeliveryStateCopyWithImpl<$Res>
    implements $ActiveDeliveryStateCopyWith<$Res> {
  _$ActiveDeliveryStateCopyWithImpl(this._self, this._then);

  final ActiveDeliveryState _self;
  final $Res Function(ActiveDeliveryState) _then;

/// Create a copy of ActiveDeliveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deliveryId = freezed,Object? status = null,Object? driverName = freezed,Object? driverVehicleType = freezed,Object? driverLat = freezed,Object? driverLng = freezed,Object? deliveryAddress = freezed,Object? routePoints = null,Object? etaMinutes = freezed,Object? destination = freezed,}) {
  return _then(_self.copyWith(
deliveryId: freezed == deliveryId ? _self.deliveryId : deliveryId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverVehicleType: freezed == driverVehicleType ? _self.driverVehicleType : driverVehicleType // ignore: cast_nullable_to_non_nullable
as String?,driverLat: freezed == driverLat ? _self.driverLat : driverLat // ignore: cast_nullable_to_non_nullable
as double?,driverLng: freezed == driverLng ? _self.driverLng : driverLng // ignore: cast_nullable_to_non_nullable
as double?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,routePoints: null == routePoints ? _self.routePoints : routePoints // ignore: cast_nullable_to_non_nullable
as List<LatLng>,etaMinutes: freezed == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LatLng?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveDeliveryState].
extension ActiveDeliveryStatePatterns on ActiveDeliveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveDeliveryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveDeliveryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveDeliveryState value)  $default,){
final _that = this;
switch (_that) {
case _ActiveDeliveryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveDeliveryState value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveDeliveryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? deliveryId,  String status,  String? driverName,  String? driverVehicleType,  double? driverLat,  double? driverLng,  String? deliveryAddress,  List<LatLng> routePoints,  int? etaMinutes,  LatLng? destination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveDeliveryState() when $default != null:
return $default(_that.deliveryId,_that.status,_that.driverName,_that.driverVehicleType,_that.driverLat,_that.driverLng,_that.deliveryAddress,_that.routePoints,_that.etaMinutes,_that.destination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? deliveryId,  String status,  String? driverName,  String? driverVehicleType,  double? driverLat,  double? driverLng,  String? deliveryAddress,  List<LatLng> routePoints,  int? etaMinutes,  LatLng? destination)  $default,) {final _that = this;
switch (_that) {
case _ActiveDeliveryState():
return $default(_that.deliveryId,_that.status,_that.driverName,_that.driverVehicleType,_that.driverLat,_that.driverLng,_that.deliveryAddress,_that.routePoints,_that.etaMinutes,_that.destination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? deliveryId,  String status,  String? driverName,  String? driverVehicleType,  double? driverLat,  double? driverLng,  String? deliveryAddress,  List<LatLng> routePoints,  int? etaMinutes,  LatLng? destination)?  $default,) {final _that = this;
switch (_that) {
case _ActiveDeliveryState() when $default != null:
return $default(_that.deliveryId,_that.status,_that.driverName,_that.driverVehicleType,_that.driverLat,_that.driverLng,_that.deliveryAddress,_that.routePoints,_that.etaMinutes,_that.destination);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveDeliveryState implements ActiveDeliveryState {
  const _ActiveDeliveryState({this.deliveryId, this.status = 'WAITING', this.driverName, this.driverVehicleType, this.driverLat, this.driverLng, this.deliveryAddress, final  List<LatLng> routePoints = const [], this.etaMinutes, this.destination}): _routePoints = routePoints;
  

@override final  String? deliveryId;
@override@JsonKey() final  String status;
@override final  String? driverName;
@override final  String? driverVehicleType;
@override final  double? driverLat;
@override final  double? driverLng;
@override final  String? deliveryAddress;
 final  List<LatLng> _routePoints;
@override@JsonKey() List<LatLng> get routePoints {
  if (_routePoints is EqualUnmodifiableListView) return _routePoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routePoints);
}

@override final  int? etaMinutes;
@override final  LatLng? destination;

/// Create a copy of ActiveDeliveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveDeliveryStateCopyWith<_ActiveDeliveryState> get copyWith => __$ActiveDeliveryStateCopyWithImpl<_ActiveDeliveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveDeliveryState&&(identical(other.deliveryId, deliveryId) || other.deliveryId == deliveryId)&&(identical(other.status, status) || other.status == status)&&(identical(other.driverName, driverName) || other.driverName == driverName)&&(identical(other.driverVehicleType, driverVehicleType) || other.driverVehicleType == driverVehicleType)&&(identical(other.driverLat, driverLat) || other.driverLat == driverLat)&&(identical(other.driverLng, driverLng) || other.driverLng == driverLng)&&(identical(other.deliveryAddress, deliveryAddress) || other.deliveryAddress == deliveryAddress)&&const DeepCollectionEquality().equals(other._routePoints, _routePoints)&&(identical(other.etaMinutes, etaMinutes) || other.etaMinutes == etaMinutes)&&(identical(other.destination, destination) || other.destination == destination));
}


@override
int get hashCode => Object.hash(runtimeType,deliveryId,status,driverName,driverVehicleType,driverLat,driverLng,deliveryAddress,const DeepCollectionEquality().hash(_routePoints),etaMinutes,destination);

@override
String toString() {
  return 'ActiveDeliveryState(deliveryId: $deliveryId, status: $status, driverName: $driverName, driverVehicleType: $driverVehicleType, driverLat: $driverLat, driverLng: $driverLng, deliveryAddress: $deliveryAddress, routePoints: $routePoints, etaMinutes: $etaMinutes, destination: $destination)';
}


}

/// @nodoc
abstract mixin class _$ActiveDeliveryStateCopyWith<$Res> implements $ActiveDeliveryStateCopyWith<$Res> {
  factory _$ActiveDeliveryStateCopyWith(_ActiveDeliveryState value, $Res Function(_ActiveDeliveryState) _then) = __$ActiveDeliveryStateCopyWithImpl;
@override @useResult
$Res call({
 String? deliveryId, String status, String? driverName, String? driverVehicleType, double? driverLat, double? driverLng, String? deliveryAddress, List<LatLng> routePoints, int? etaMinutes, LatLng? destination
});




}
/// @nodoc
class __$ActiveDeliveryStateCopyWithImpl<$Res>
    implements _$ActiveDeliveryStateCopyWith<$Res> {
  __$ActiveDeliveryStateCopyWithImpl(this._self, this._then);

  final _ActiveDeliveryState _self;
  final $Res Function(_ActiveDeliveryState) _then;

/// Create a copy of ActiveDeliveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deliveryId = freezed,Object? status = null,Object? driverName = freezed,Object? driverVehicleType = freezed,Object? driverLat = freezed,Object? driverLng = freezed,Object? deliveryAddress = freezed,Object? routePoints = null,Object? etaMinutes = freezed,Object? destination = freezed,}) {
  return _then(_ActiveDeliveryState(
deliveryId: freezed == deliveryId ? _self.deliveryId : deliveryId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,driverName: freezed == driverName ? _self.driverName : driverName // ignore: cast_nullable_to_non_nullable
as String?,driverVehicleType: freezed == driverVehicleType ? _self.driverVehicleType : driverVehicleType // ignore: cast_nullable_to_non_nullable
as String?,driverLat: freezed == driverLat ? _self.driverLat : driverLat // ignore: cast_nullable_to_non_nullable
as double?,driverLng: freezed == driverLng ? _self.driverLng : driverLng // ignore: cast_nullable_to_non_nullable
as double?,deliveryAddress: freezed == deliveryAddress ? _self.deliveryAddress : deliveryAddress // ignore: cast_nullable_to_non_nullable
as String?,routePoints: null == routePoints ? _self._routePoints : routePoints // ignore: cast_nullable_to_non_nullable
as List<LatLng>,etaMinutes: freezed == etaMinutes ? _self.etaMinutes : etaMinutes // ignore: cast_nullable_to_non_nullable
as int?,destination: freezed == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as LatLng?,
  ));
}


}

// dart format on
