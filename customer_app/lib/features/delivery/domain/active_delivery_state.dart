import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _ActiveDeliveryState;
}
