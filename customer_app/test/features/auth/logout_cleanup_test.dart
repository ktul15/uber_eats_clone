import 'package:customer_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_test/flutter_test.dart';

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
