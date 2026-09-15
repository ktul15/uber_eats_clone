import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver_app/features/deliveries/providers/delivery_providers.dart';
import 'package:driver_app/features/profile/providers/profile_providers.dart';

part 'availability_provider.g.dart';

enum AvailabilityStatus {
  offline,
  requestingPermission,
  locationDisabled,
  permissionDenied,
  connecting,
  online,
  failure,
}

AvailabilityStatus? availabilityBlocker({
  required bool locationServiceEnabled,
  required LocationPermission permission,
}) {
  if (!locationServiceEnabled) return AvailabilityStatus.locationDisabled;
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    return AvailabilityStatus.permissionDenied;
  }
  return null;
}

@riverpod
class DriverAvailability extends _$DriverAvailability {
  StreamSubscription<Position>? _positions;

  @override
  Future<AvailabilityStatus> build() async {
    ref.onDispose(() => _positions?.cancel());
    final profile = await ref.watch(profileControllerProvider.future);
    if (profile?.profile.isAvailable == true) {
      Timer.run(goOnline);
      return AvailabilityStatus.connecting;
    }
    return AvailabilityStatus.offline;
  }

  Future<void> goOnline() async {
    if (state.isLoading || state.value == AvailabilityStatus.online) return;
    state = const AsyncData(AvailabilityStatus.requestingPermission);
    final locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      state = AsyncData(
        availabilityBlocker(
          locationServiceEnabled: false,
          permission: LocationPermission.unableToDetermine,
        )!,
      );
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    final blocker = availabilityBlocker(
      locationServiceEnabled: true,
      permission: permission,
    );
    if (blocker != null) {
      state = AsyncData(blocker);
      return;
    }

    state = const AsyncData(AvailabilityStatus.connecting);
    try {
      final position = await Geolocator.getCurrentPosition();
      await ref
          .read(deliveryApiClientProvider)
          .updateAvailability(
            isAvailable: true,
            lat: position.latitude,
            lng: position.longitude,
          );
      await _positions?.cancel();
      _positions =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 25,
            ),
          ).listen((next) async {
            try {
              await ref
                  .read(deliveryApiClientProvider)
                  .updateAvailability(
                    isAvailable: true,
                    lat: next.latitude,
                    lng: next.longitude,
                  );
            } catch (_) {
              await stopForDelivery();
            }
          });
      state = const AsyncData(AvailabilityStatus.online);
      ref.invalidate(profileControllerProvider);
    } catch (_) {
      state = const AsyncData(AvailabilityStatus.failure);
    }
  }

  Future<void> goOffline() async {
    if (state.isLoading) return;
    state = const AsyncData(AvailabilityStatus.connecting);
    try {
      await ref
          .read(deliveryApiClientProvider)
          .updateAvailability(isAvailable: false);
      await _positions?.cancel();
      _positions = null;
      state = const AsyncData(AvailabilityStatus.offline);
      ref.invalidate(profileControllerProvider);
    } catch (_) {
      state = const AsyncData(AvailabilityStatus.failure);
    }
  }

  Future<void> stopForDelivery() async {
    await _positions?.cancel();
    _positions = null;
    state = const AsyncData(AvailabilityStatus.offline);
    ref.invalidate(profileControllerProvider);
  }
}
