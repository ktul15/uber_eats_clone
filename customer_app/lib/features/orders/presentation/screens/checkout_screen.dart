import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/app/routes.dart';
import 'package:customer_app/features/cart/domain/models/cart.dart';
import 'package:customer_app/features/cart/providers/cart_providers.dart';
import 'package:customer_app/features/orders/providers/order_providers.dart';
import 'package:customer_app/features/profile/providers/profile_providers.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _addressController = TextEditingController();
  bool _addressPrefilled = false;

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
            isLoading: placeOrderState is AsyncLoading,
            onPlaceOrder: (address) => _onPlaceOrder(address, cart),
          );
        },
      ),
    );
  }

  Future<void> _onPlaceOrder(String address, Cart cart) async {
    if (address.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a delivery address')),
      );
      return;
    }

    // Step 1: Create PaymentIntent on backend
    final piClientSecret = await ref
        .read(createPaymentIntentProvider.notifier)
        .execute();

    if (piClientSecret == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to initialise payment')),
        );
      }
      return;
    }

    // Step 2: Confirm payment via Stripe SDK
    // Extract paymentIntentId from clientSecret (format: pi_xxx_secret_yyy)
    final paymentIntentId = piClientSecret.split('_secret_').first;

    // TODO: In a full production app integrate flutter_stripe to confirm
    // the card payment here. For portfolio demo we treat creation as success.

    // Step 3: Place the order on the backend
    await ref
        .read(placeOrderProvider.notifier)
        .execute(
          deliveryAddress: address.trim(),
          paymentIntentId: paymentIntentId,
        );
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
