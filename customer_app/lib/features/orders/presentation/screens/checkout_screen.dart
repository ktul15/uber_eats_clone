import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/app/routes.dart';
import 'package:customer_app/features/cart/domain/models/cart.dart';
import 'package:customer_app/features/cart/providers/cart_providers.dart';
import 'package:customer_app/features/orders/providers/order_providers.dart';
import 'package:customer_app/features/profile/providers/profile_providers.dart';
import 'package:customer_app/features/orders/data/checkout_session_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _addressController = TextEditingController();
  bool _addressPrefilled = false;
  bool _submitting = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartAsync = ref.watch(cartProvider);
    final profileAsync = ref.watch(profileControllerProvider);
    final placeOrderState = ref.watch(placeOrderProvider);

    // Pre-fill address from profile once
    if (!_addressPrefilled) {
      profileAsync.whenData((profile) {
        if (profile?.profile.defaultAddress != null &&
            _addressController.text.isEmpty) {
          _addressController.text = profile!.profile.defaultAddress!;
          _addressPrefilled = true;
        }
      });
    }

    // Navigate to confirmation once order is placed
    ref.listen(placeOrderProvider, (_, next) {
      next.whenData((order) {
        if (order != null) {
          context.pushReplacement(AppRoutes.orderConfirmation, extra: order.id);
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (cart) {
          if (cart == null || cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Your cart is empty.'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: const Text('Browse Restaurants'),
                  ),
                ],
              ),
            );
          }
          return _CheckoutBody(
            cart: cart,
            addressController: _addressController,
            isLoading: _submitting || placeOrderState is AsyncLoading,
            onPlaceOrder: (address) => _onPlaceOrder(address, cart),
          );
        },
      ),
    );
  }

  Future<void> _onPlaceOrder(String address, Cart cart) async {
    if (_submitting) return;
    if (address.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a delivery address')),
      );
      return;
    }

    const publishableKey = String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');
    if (publishableKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card payments are not configured for this build.'),
        ),
      );
      return;
    }

    setState(() => _submitting = true);
    final sessionStorage = ref.read(checkoutSessionStorageProvider);
    final cartSignature = _cartSignature(cart);
    final paymentSheetStyle = Theme.of(context).brightness == Brightness.dark
        ? ThemeMode.dark
        : ThemeMode.light;
    try {
      var pending = await sessionStorage.read(cart.customerId);
      if (pending != null &&
          (pending.customerId != cart.customerId ||
              pending.cartId != cart.id ||
              pending.cartSignature != cartSignature ||
              pending.deliveryAddress.trim() != address.trim())) {
        await sessionStorage.clear(cart.customerId);
        pending = null;
      }
      if (pending != null) {
        final recovered = await ref
            .read(placeOrderProvider.notifier)
            .execute(
              deliveryAddress: pending.deliveryAddress,
              paymentIntentId: pending.paymentIntentId,
            );
        if (recovered != null) {
          await sessionStorage.clear(cart.customerId);
          return;
        }
        final recoveryError = ref.read(placeOrderProvider).error;
        if (_isStaleCheckoutError(recoveryError)) {
          await sessionStorage.clear(cart.customerId);
          pending = null;
        }
      }

      if (pending == null) {
        final paymentIntent = await ref
            .read(createPaymentIntentProvider.notifier)
            .execute();
        if (paymentIntent == null) {
          _showMessage('Unable to start payment. Please try again.');
          return;
        }
        pending = PendingCheckout(
          clientSecret: paymentIntent.clientSecret,
          paymentIntentId: paymentIntent.paymentIntentId,
          deliveryAddress: address.trim(),
          customerId: cart.customerId,
          cartId: cart.id,
          cartSignature: cartSignature,
        );
        await sessionStorage.write(pending);
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: pending.clientSecret,
          merchantDisplayName: 'Uber Eats Clone',
          returnURL: 'ubereatsclone://stripe-redirect',
          allowsDelayedPaymentMethods: false,
          style: paymentSheetStyle,
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      final order = await ref
          .read(placeOrderProvider.notifier)
          .execute(
            deliveryAddress: pending.deliveryAddress,
            paymentIntentId: pending.paymentIntentId,
          );
      if (order != null) {
        await sessionStorage.clear(cart.customerId);
      } else {
        _showMessage(
          'Payment succeeded, but the order could not be saved. Tap Place Order to retry safely.',
        );
      }
    } on StripeException catch (error) {
      if (error.error.code == FailureCode.Canceled) {
        await sessionStorage.clear(cart.customerId);
        _showMessage('Payment cancelled. No order was placed.');
      } else {
        _showMessage(
          error.error.localizedMessage ??
              'Payment was not completed. Check your card and try again.',
        );
      }
    } catch (_) {
      _showMessage('Checkout failed. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String _cartSignature(Cart cart) {
    final items =
        cart.items
            .map(
              (item) =>
                  '${item.menuItemId}:${item.quantity}:${(item.menuItem.price * 100).round()}',
            )
            .toList()
          ..sort();
    return '${cart.restaurantId}|${items.join('|')}';
  }

  bool _isStaleCheckoutError(Object? error) {
    if (error is! DioException) return false;
    final status = error.response?.statusCode;
    final body = error.response?.data;
    final message = body is Map
        ? ((body['error'] as Map?)?['message']?.toString() ?? '')
        : '';
    return status == 409 || message.contains('does not match the current cart');
  }
}

// ---------------------------------------------------------------------------
// Checkout Body
// ---------------------------------------------------------------------------

class _CheckoutBody extends StatelessWidget {
  final Cart cart;
  final TextEditingController addressController;
  final bool isLoading;
  final void Function(String address) onPlaceOrder;

  const _CheckoutBody({
    required this.cart,
    required this.addressController,
    required this.isLoading,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // --- Delivery Address ---
              Text(
                'Delivery Address',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: 'Enter your delivery address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // --- Order Summary ---
              Text(
                'Order Summary',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Restaurant row
                    ListTile(
                      leading: const Icon(Icons.store_outlined),
                      title: Text(cart.restaurant.name),
                      dense: true,
                    ),
                    const Divider(height: 1),
                    // Items
                    ...cart.items.map(
                      (item) => ListTile(
                        title: Text(item.menuItem.name),
                        subtitle: Text(
                          '\$${item.menuItem.price.toStringAsFixed(2)} × ${item.quantity}',
                        ),
                        trailing: Text(
                          '\$${(item.menuItem.price * item.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        dense: true,
                      ),
                    ),
                    const Divider(height: 1),
                    // Total
                    ListTile(
                      title: const Text('Total'),
                      trailing: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      dense: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- Payment note ---
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Payments are secured by Stripe',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --- CTA ---
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
          ),
          padding: EdgeInsets.fromLTRB(
            16,
            12,
            16,
            MediaQuery.of(context).padding.bottom + 12,
          ),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: isLoading
                  ? null
                  : () => onPlaceOrder(addressController.text),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Place Order  •  \$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
