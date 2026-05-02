import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:customer_app/features/delivery/domain/active_delivery_state.dart';
import 'package:customer_app/shared/constants/api_constants.dart';

part 'active_delivery_providers.g.dart';

@riverpod
class ActiveDeliveryNotifier extends _$ActiveDeliveryNotifier {
  io.Socket? _socket;
  bool _disposed = false;

  @override
  ActiveDeliveryState build(String orderId) {
    _connect(orderId);
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
          state = state.copyWith(status: newStatus);
        }
      }
    });

    _socket!.on('driver:location', (data) {
      if (data is Map && data['deliveryId'] == state.deliveryId) {
        state = state.copyWith(
          driverLat: (data['lat'] as num?)?.toDouble(),
          driverLng: (data['lng'] as num?)?.toDouble(),
        );
      }
    });

    _socket!.connect();
  }
}
