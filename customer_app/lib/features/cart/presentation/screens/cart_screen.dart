import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/app/routes.dart';
import 'package:customer_app/features/cart/domain/models/cart.dart';
import 'package:customer_app/features/cart/domain/models/cart_item.dart';
import 'package:customer_app/features/cart/providers/cart_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          cartAsync.whenOrNull(
                data: (cart) {
                  if (cart == null || cart.items.isEmpty) return null;
                  return TextButton(
                    onPressed: () async {
                      final confirm = await _showClearDialog(context);
                      if (confirm == true) {
                        await ref.read(cartProvider.notifier).clearCart();
                      }
                    },
                    child: const Text('Clear'),
                  );
                },
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.grey),
              const SizedBox(height: 12),
              Text(
                'Failed to load cart',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.invalidate(cartProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (cart) {
          if (cart == null || cart.items.isEmpty) {
            return _EmptyCartView(onBrowse: () => context.go(AppRoutes.home));
          }
          return _CartView(cart: cart);
        },
      ),
    );
  }

  Future<bool?> _showClearDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear cart?'),
        content: const Text('All items will be removed from your cart.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty State
// ---------------------------------------------------------------------------

class _EmptyCartView extends StatelessWidget {
  final VoidCallback onBrowse;

  const _EmptyCartView({required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add items from a restaurant to get started.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onBrowse,
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Browse Restaurants'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cart with items
// ---------------------------------------------------------------------------

class _CartView extends ConsumerWidget {
  final Cart cart;

  const _CartView({required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Restaurant banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: theme.colorScheme.surfaceContainerHighest,
          child: Row(
            children: [
              const Icon(Icons.store_outlined, size: 18),
              const SizedBox(width: 8),
              Text(
                cart.restaurant.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        // Items list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: cart.items.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, indent: 16),
            itemBuilder: (context, index) {
              return _CartItemTile(item: cart.items[index]);
            },
          ),
        ),
        // Order summary + CTA
        _OrderSummary(cart: cart),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Cart Item Tile
// ---------------------------------------------------------------------------

class _CartItemTile extends ConsumerWidget {
  final CartItem item;

  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notifier = ref.read(cartProvider.notifier);
    final isLoading = ref.watch(cartProvider) is AsyncLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 64,
              height: 64,
              child: item.menuItem.imageUrl != null
                  ? Image.network(
                      item.menuItem.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) =>
                          _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
          ),
          const SizedBox(width: 12),
          // Name + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.menuItem.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${(item.menuItem.price * item.quantity).toStringAsFixed(2)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Quantity stepper
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StepperButton(
                icon: item.quantity == 1 ? Icons.delete_outline : Icons.remove,
                color: item.quantity == 1 ? theme.colorScheme.error : null,
                onPressed: isLoading
                    ? null
                    : () async {
                        if (item.quantity == 1) {
                          await notifier.removeItem(cartItemId: item.id);
                        } else {
                          await notifier.updateItem(
                            cartItemId: item.id,
                            quantity: item.quantity - 1,
                          );
                        }
                      },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${item.quantity}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _StepperButton(
                icon: Icons.add,
                onPressed: isLoading
                    ? null
                    : () async {
                        await notifier.updateItem(
                          cartItemId: item.id,
                          quantity: item.quantity + 1,
                        );
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFFEEEEEE),
      child: const Center(
        child: Icon(Icons.fastfood, size: 24, color: Colors.grey),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;

  const _StepperButton({
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton.outlined(
        padding: EdgeInsets.zero,
        iconSize: 16,
        icon: Icon(icon, color: color ?? theme.colorScheme.primary),
        onPressed: onPressed,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order Summary + CTA
// ---------------------------------------------------------------------------

class _OrderSummary extends StatelessWidget {
  final Cart cart;

  const _OrderSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cart.totalItems} item${cart.totalItems == 1 ? '' : 's'}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Subtotal: \$${cart.totalAmount.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => context.push(AppRoutes.checkout),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Proceed to Checkout  •  \$${cart.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
