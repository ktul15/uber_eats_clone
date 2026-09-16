import 'package:driver_app/features/deliveries/providers/availability_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  test('location-disabled state blocks going online', () {
    expect(
      availabilityBlocker(
        locationServiceEnabled: false,
        permission: LocationPermission.always,
      ),
      AvailabilityStatus.locationDisabled,
    );
  });

  test('denied permissions block going online', () {
    for (final permission in [
      LocationPermission.denied,
      LocationPermission.deniedForever,
    ]) {
      expect(
        availabilityBlocker(
          locationServiceEnabled: true,
          permission: permission,
        ),
        AvailabilityStatus.permissionDenied,
      );
    }
  });

  test('while-in-use and always permissions allow availability', () {
    for (final permission in [
      LocationPermission.whileInUse,
      LocationPermission.always,
    ]) {
      expect(
        availabilityBlocker(
          locationServiceEnabled: true,
          permission: permission,
        ),
        isNull,
      );
    }
  });
}
