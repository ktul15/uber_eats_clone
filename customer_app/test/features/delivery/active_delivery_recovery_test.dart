import 'package:customer_app/features/delivery/domain/active_delivery_state.dart';
import 'package:customer_app/features/delivery/providers/active_delivery_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'persisted delivery snapshot restores missed assignment and location',
    () {
      final restored =
          hydrateDeliverySnapshot(const ActiveDeliveryState(), '1 Main St', {
            'deliveryId': 'delivery-1',
            'status': 'IN_TRANSIT',
            'driverName': 'Dana',
            'driverVehicleType': 'Bike',
            'driverLat': 12.5,
            'driverLng': 77.5,
          });

      expect(restored.deliveryId, 'delivery-1');
      expect(restored.status, 'IN_TRANSIT');
      expect(restored.driverName, 'Dana');
      expect(restored.driverLat, 12.5);
      expect(restored.deliveryAddress, '1 Main St');
    },
  );

  test('a null snapshot cannot clear newer socket assignment state', () {
    const assigned = ActiveDeliveryState(
      deliveryId: 'delivery-1',
      status: 'ASSIGNED',
      driverName: 'Dana',
      driverLat: 12.5,
      driverLng: 77.5,
    );

    final restored = hydrateDeliverySnapshot(assigned, '1 Main St', null);

    expect(restored.deliveryId, 'delivery-1');
    expect(restored.driverName, 'Dana');
    expect(restored.driverLat, 12.5);
  });
}
