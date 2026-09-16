import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_dashboard/features/auth/providers/auth_providers.dart';

void main() {
  test('FCM token lookup and removal failures are best-effort', () async {
    await expectLater(
      bestEffortFcmUnregister(
        getToken: () async => throw StateError('firebase unavailable'),
        removeToken: (_) async {},
      ),
      completes,
    );
    await expectLater(
      bestEffortFcmUnregister(
        getToken: () async => 'token',
        removeToken: (_) async => throw StateError('network unavailable'),
      ),
      completes,
    );
  });
}
