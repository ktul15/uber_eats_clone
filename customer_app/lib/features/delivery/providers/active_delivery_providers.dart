import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:customer_app/features/delivery/data/directions_service.dart';
import 'package:customer_app/features/delivery/domain/active_delivery_state.dart';
import 'package:customer_app/features/orders/providers/order_providers.dart';
import 'package:customer_app/features/profile/providers/profile_providers.dart';
import 'package:customer_app/shared/constants/api_constants.dart';

part 'active_delivery_providers.g.dart';

ActiveDeliveryState hydrateDeliverySnapshot(
  ActiveDeliveryState current,
  String deliveryAddress,
  Map<String, dynamic>? delivery,
) => current.copyWith(
  deliveryAddress: deliveryAddress,
  deliveryId: delivery?['deliveryId'] as String? ?? current.deliveryId,
  status: delivery?['status'] as String? ?? current.status,
  driverName: delivery?['driverName'] as String? ?? current.driverName,
  driverVehicleType:
      delivery?['driverVehicleType'] as String? ?? current.driverVehicleType,
  driverLat: (delivery?['driverLat'] as num?)?.toDouble() ?? current.driverLat,
  driverLng: (delivery?['driverLng'] as num?)?.toDouble() ?? current.driverLng,
);

@riverpod
DirectionsService directionsService(Ref ref) =>
    DirectionsService(Dio(BaseOptions(baseUrl: 'https://maps.googleapis.com')));

@riverpod
class ActiveDeliveryNotifier extends _$ActiveDeliveryNotifier {
  io.Socket? _socket;
  bool _disposed = false;
  bool _fetchingRoute = false;
  DateTime? _lastDirectionsCall;
  int _stateGeneration = 0;

  static const _directionsThrottle = Duration(seconds: 30);

  @override
  ActiveDeliveryState build(String orderId) {
    _connect(orderId);
    _hydrateSnapshot(orderId);
    ref.onDispose(() {
      _disposed = true;
      _socket?.off('delivery:assigned');
      _socket?.off('delivery:status_updated');
      _socket?.off('driver:location');
      _socket?.disconnect();
    });
    return const ActiveDeliveryState();
  }

  Future<void> _connect(String orderId) async {
    if (_socket != null) return;
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'auth_token');
    if (_disposed || token == null) return;
    final profile = await ref.read(profileControllerProvider.future);
    if (_disposed || profile == null) return;

    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth(<String, dynamic>{'token': token})
          .disableAutoConnect()
          .build(),
    );

    _socket!.on('delivery:assigned', (data) {
      if (data is Map && data['orderId'] == orderId) {
        _stateGeneration++;
        state = state.copyWith(
          deliveryId: data['deliveryId'] as String?,
          driverName: data['driverName'] as String?,
          driverVehicleType: data['driverVehicleType'] as String?,
          status: 'ASSIGNED',
        );
      }
    });

    _socket!.on('delivery:status_updated', (data) {
      if (data is Map && data['orderId'] == orderId) {
        final newStatus = data['status'] as String?;
        if (newStatus != null) {
          _stateGeneration++;
          state = state.copyWith(status: newStatus);
        }
      }
    });

    _socket!.on('driver:location', (data) {
      if (data is Map && data['deliveryId'] == state.deliveryId) {
        _stateGeneration++;
        state = state.copyWith(
          driverLat: (data['lat'] as num?)?.toDouble(),
          driverLng: (data['lng'] as num?)?.toDouble(),
        );
        _maybeUpdateRoute();
      }
    });

    _socket!.onConnect((_) {
      _socket!.emit('join', <String>['customer:${profile.id}']);
      unawaited(_hydrateSnapshot(orderId));
    });

    _socket!.connect();
  }

  Future<void> _hydrateSnapshot(String orderId) async {
    final generation = ++_stateGeneration;
    try {
      final client = ref.read(orderApiClientProvider);
      final order = await client.getOrderById(orderId);
      final delivery = await client.getDeliveryForOrder(orderId);
      if (_disposed || generation != _stateGeneration) return;
      state = hydrateDeliverySnapshot(state, order.deliveryAddress, delivery);
      _maybeUpdateRoute();
    } catch (_) {}
  }

  void _maybeUpdateRoute() {
    final address = state.deliveryAddress;
    final lat = state.driverLat;
    final lng = state.driverLng;
    if (address == null || lat == null || lng == null) return;
    if (state.status == 'COMPLETED') return;

    final now = DateTime.now();
    if (_lastDirectionsCall != null &&
        now.difference(_lastDirectionsCall!) < _directionsThrottle) {
      return;
    }

    _lastDirectionsCall = now;
    _fetchRoute(lat, lng, address);
  }

  Future<void> _fetchRoute(double lat, double lng, String address) async {
    if (_fetchingRoute || _disposed) return;
    _fetchingRoute = true;
    try {
      final result = await ref
          .read(directionsServiceProvider)
          .getDirections(
            originLat: lat,
            originLng: lng,
            destinationAddress: address,
          );
      if (_disposed || result == null) return;
      state = state.copyWith(
        routePoints: result.routePoints,
        etaMinutes: result.etaMinutes,
        destination: result.destination,
      );
    } finally {
      _fetchingRoute = false;
    }
  }
}
