import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PendingCheckout {
  const PendingCheckout({
    required this.clientSecret,
    required this.paymentIntentId,
    required this.deliveryAddress,
    required this.customerId,
    required this.cartId,
    required this.cartSignature,
  });

  final String clientSecret;
  final String paymentIntentId;
  final String deliveryAddress;
  final String customerId;
  final String cartId;
  final String cartSignature;
}

class CheckoutSessionStorage {
  CheckoutSessionStorage(this._storage);

  static const _legacyKey = 'pending_checkout';
  static const _activeCustomerKey = 'pending_checkout_customer';
  final FlutterSecureStorage _storage;

  String _key(String customerId) => 'pending_checkout_$customerId';

  Future<PendingCheckout?> read(String customerId) async {
    final encoded = await _storage.read(key: _key(customerId));
    if (encoded == null) return null;
    try {
      final value = jsonDecode(encoded) as Map<String, dynamic>;
      return PendingCheckout(
        clientSecret: value['clientSecret'] as String,
        paymentIntentId: value['paymentIntentId'] as String,
        deliveryAddress: value['deliveryAddress'] as String,
        customerId: value['customerId'] as String,
        cartId: value['cartId'] as String,
        cartSignature: value['cartSignature'] as String,
      );
    } catch (_) {
      await clear(customerId);
      return null;
    }
  }

  Future<void> write(PendingCheckout checkout) async {
    await _storage.write(
      key: _key(checkout.customerId),
      value: jsonEncode({
        'clientSecret': checkout.clientSecret,
        'paymentIntentId': checkout.paymentIntentId,
        'deliveryAddress': checkout.deliveryAddress,
        'customerId': checkout.customerId,
        'cartId': checkout.cartId,
        'cartSignature': checkout.cartSignature,
      }),
    );
    await _storage.write(key: _activeCustomerKey, value: checkout.customerId);
  }

  Future<void> clear(String customerId) async {
    await _storage.delete(key: _key(customerId));
    if (await _storage.read(key: _activeCustomerKey) == customerId) {
      await _storage.delete(key: _activeCustomerKey);
    }
  }

  Future<void> clearActive() async {
    final customerId = await _storage.read(key: _activeCustomerKey);
    if (customerId != null) await _storage.delete(key: _key(customerId));
    await _storage.delete(key: _activeCustomerKey);
    await clearLegacy();
  }

  Future<void> clearLegacy() => _storage.delete(key: _legacyKey);
}
