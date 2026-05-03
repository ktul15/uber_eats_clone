import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'active_delivery_state.freezed.dart';

@freezed
abstract class ActiveDeliveryState with _$ActiveDeliveryState {
  const factory ActiveDeliveryState({
    String? deliveryId,
    @Default('WAITING') String status,
    String? driverName,
    String? driverVehicleType,
    double? driverLat,
    double? driverLng,
    String? deliveryAddress,
    @Default([]) List<LatLng> routePoints,
    int? etaMinutes,
    LatLng? destination,
  }) = _ActiveDeliveryState;
}
