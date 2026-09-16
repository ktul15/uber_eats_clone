import 'package:customer_app/features/orders/data/checkout_session_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('pending checkout sessions are isolated by customer', () async {
    const secureStorage = FlutterSecureStorage();
    final storage = CheckoutSessionStorage(secureStorage);
    const checkout = PendingCheckout(
      clientSecret: 'secret',
      paymentIntentId: 'pi_1',
      deliveryAddress: '1 Main St',
      customerId: 'customer-1',
      cartId: 'cart-1',
      cartSignature: 'restaurant-1|item-1:1:500',
    );

    await storage.write(checkout);

    expect(await storage.read('customer-2'), isNull);
    final restored = await storage.read('customer-1');
    expect(restored?.paymentIntentId, 'pi_1');
    expect(restored?.cartSignature, checkout.cartSignature);
  });

  test('malformed sessions are discarded', () async {
    FlutterSecureStorage.setMockInitialValues({
      'pending_checkout_customer-1': '{not-json',
    });
    final storage = CheckoutSessionStorage(const FlutterSecureStorage());

    expect(await storage.read('customer-1'), isNull);
    expect(
      await const FlutterSecureStorage().read(
        key: 'pending_checkout_customer-1',
      ),
      isNull,
    );
  });

  test(
    'active checkout cleanup does not depend on cart provider state',
    () async {
      final storage = CheckoutSessionStorage(const FlutterSecureStorage());
      await storage.write(
        const PendingCheckout(
          clientSecret: 'secret',
          paymentIntentId: 'pi_1',
          deliveryAddress: '1 Main St',
          customerId: 'customer-1',
          cartId: 'cart-1',
          cartSignature: 'signature',
        ),
      );

      await storage.clearActive();

      expect(await storage.read('customer-1'), isNull);
    },
  );
}
