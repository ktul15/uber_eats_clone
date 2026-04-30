import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:driver_app/features/deliveries/providers/delivery_providers.dart';

part 'location_providers.g.dart';

@riverpod
class LocationTracker extends _$LocationTracker {
  StreamSubscription<Position>? _subscription;

  @override
  void build() {
    ref.onDispose(stop);
  }

  Future<void> start(String deliveryId) async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    await _subscription?.cancel();

    final LocationSettings settings;
    if (Platform.isAndroid) {
      settings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        intervalDuration: const Duration(seconds: 5),
        distanceFilter: 10,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: 'Sharing location for active delivery',
          notificationTitle: 'Driver App',
          enableWakeLock: true,
        ),
      );
    } else if (Platform.isIOS) {
      settings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.automotiveNavigation,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: false,
      );
    } else {
      settings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    }

    _subscription = Geolocator.getPositionStream(locationSettings: settings).listen(
      (position) {
        ref.read(deliveryApiClientProvider).updateLocation(
              deliveryId,
              position.latitude,
              position.longitude,
            );
      },
      onError: (_) {},
    );
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}
