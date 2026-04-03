import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/app/routes.dart';
import 'package:customer_app/features/cart/providers/cart_providers.dart';
import 'package:customer_app/features/restaurants/domain/models/menu_item.dart';
import 'package:customer_app/features/restaurants/domain/models/restaurant_detail.dart';
import 'package:customer_app/features/restaurants/presentation/widgets/menu_item_card.dart';
import 'package:customer_app/features/restaurants/providers/restaurant_providers.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(restaurantDetailProvider(restaurantId));

    return detailAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load restaurant',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    ref.refresh(restaurantDetailProvider(restaurantId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (detail) => _RestaurantDetailView(detail: detail),
    );
  }
}

class _RestaurantDetailView extends ConsumerWidget {
  final RestaurantDetail detail;

  const _RestaurantDetailView({required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cartAsync = ref.watch(cartProvider);
    final cart = cartAsync.value;
    final availableItems = detail.menuItems
        .where((item) => item.isAvailable)
        .toList();
    final unavailableItems = detail.menuItems
        .where((item) => !item.isAvailable)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible header with restaurant image
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                detail.name,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
              background: detail.imageUrl != null
                  ? Image.network(
                      detail.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _headerPlaceholder(),
                    )
                  : _headerPlaceholder(),
            ),
          ),

          // Restaurant info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        detail.rating.toStringAsFixed(1),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          detail.address,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (detail.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      detail.description!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),
            ),
          ),

          // Menu section header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Menu',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Empty state
          if (detail.menuItems.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.no_food, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No menu items yet',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            )
          else ...[
            // Available items
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = availableItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      MenuItemCard(
                        menuItem: item,
                        onAddToCart: () => _addToCart(context, ref, item),
                      ),
                      if (index < availableItems.length - 1)
                        const Divider(height: 1),
                    ],
                  ),
                );
              }, childCount: availableItems.length),
            ),

            // Unavailable items section
            if (unavailableItems.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                  child: Text(
                    'Currently Unavailable',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = unavailableItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        MenuItemCard(menuItem: item),
                        if (index < unavailableItems.length - 1)
                          const Divider(height: 1),
                      ],
                    ),
                  );
                }, childCount: unavailableItems.length),
              ),
            ],

            // Extra bottom padding so cart bar doesn't overlap last item
            const SliverToBoxAdapter(child: SizedBox(height: 96)),
          ],
        ],
      ),
      // Floating cart summary bar
      bottomNavigationBar: cart != null && cart.items.isNotEmpty
          ? _CartSummaryBar(
              itemCount: cart.totalItems,
              total: cart.totalAmount,
              onViewCart: () => context.push(AppRoutes.cart),
            )
          : null,
    );
  }

  Future<void> _addToCart(
    BuildContext context,
    WidgetRef ref,
    MenuItem item,
  ) async {
    final notifier = ref.read(cartProvider.notifier);
    final cart = ref.read(cartProvider).value;

    // Warn if cart is from a different restaurant
    if (cart != null &&
        cart.restaurantId != item.restaurantId &&
        context.mounted) {
      final replace = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Start new cart?'),
          content: const Text(
            'Your cart has items from another restaurant. Adding this item will clear your current cart.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Replace'),
            ),
          ],
        ),
      );
      if (replace != true) return;
      await notifier.clearCart();
    }

    await notifier.addItem(menuItemId: item.id, quantity: 1);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} added to cart'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _headerPlaceholder() {
    return Container(
      color: const Color(0xFFEEEEEE),
      child: const Center(
        child: Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cart Summary Bottom Bar
// ---------------------------------------------------------------------------

class _CartSummaryBar extends StatelessWidget {
  final int itemCount;
  final double total;
  final VoidCallback onViewCart;

  const _CartSummaryBar({
    required this.itemCount,
    required this.total,
    required this.onViewCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
      child: FilledButton(
        onPressed: onViewCart,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$itemCount',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'View Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
