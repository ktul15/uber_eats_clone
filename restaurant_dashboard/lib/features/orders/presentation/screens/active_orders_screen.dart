import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:restaurant_dashboard/features/auth/providers/auth_providers.dart';
import 'package:restaurant_dashboard/features/menu/providers/menu_providers.dart';
import 'package:restaurant_dashboard/features/orders/data/models/order_dto.dart';
import 'package:restaurant_dashboard/features/orders/data/models/order_item_dto.dart';
import 'package:restaurant_dashboard/features/orders/providers/order_providers.dart';
import 'package:restaurant_dashboard/shared/constants/api_constants.dart';
import 'package:restaurant_dashboard/shared/theme/app_colors.dart';

class ActiveOrdersScreen extends ConsumerStatefulWidget {
  const ActiveOrdersScreen({super.key});

  @override
  ConsumerState<ActiveOrdersScreen> createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends ConsumerState<ActiveOrdersScreen> {
  io.Socket? _socket;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupSocket());
  }

  @override
  void dispose() {
    _socket?.off('order:new');
    _socket?.dispose();
    super.dispose();
  }

  Future<void> _setupSocket() async {
    final token = await ref.read(authRepositoryProvider).getToken();
    if (token == null || !mounted) return;

    final restaurants = await ref.read(myRestaurantsControllerProvider.future);
    if (!mounted || restaurants.isEmpty) return;

    final restaurantRooms = restaurants
        .map((restaurant) => 'restaurant:${restaurant.id}')
        .toList(growable: false);

    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );

    _socket!.onConnect((_) {
      _socket!.emit('join', restaurantRooms);
    });

    _socket!.on('order:new', (_) {
      if (mounted) {
        ref.read(activeOrdersControllerProvider.notifier).refresh();
      }
    });

    _socket!.connect();
  }

  @override
  Widget build(BuildContext context) {
    final ordersAsync = ref.watch(activeOrdersControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(activeOrdersControllerProvider.notifier).refresh(),
          ),
        ],
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load orders', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () =>
                    ref.read(activeOrdersControllerProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (orders) {
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active orders',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'New orders will appear here in real-time',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(activeOrdersControllerProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _OrderCard(
                key: ValueKey(orders[index].id),
                order: orders[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order Card
// ---------------------------------------------------------------------------

class _OrderCard extends ConsumerStatefulWidget {
  final OrderDto order;

  const _OrderCard({super.key, required this.order});

  @override
  ConsumerState<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<_OrderCard> {
  bool _expanded = false;
  bool _updating = false;

  static const _nextStatus = {
    'PENDING': 'ACCEPTED',
    'ACCEPTED': 'PREPARING',
    'PREPARING': 'READY',
  };

  static const _nextStatusLabel = {
    'PENDING': 'Accept',
    'ACCEPTED': 'Start Preparing',
    'PREPARING': 'Mark Ready',
  };

  bool get _canCancel =>
      widget.order.status != 'READY' && widget.order.status != 'PICKED_UP';

  Future<void> _updateStatus(String newStatus) async {
    if (!mounted) return;
    setState(() => _updating = true);
    try {
      await ref
          .read(activeOrdersControllerProvider.notifier)
          .updateStatus(widget.order.id, newStatus);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update order: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  Future<void> _cancel() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Order?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Cancel Order'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) await _updateStatus('CANCELLED');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order = widget.order;
    final hasItems = order.orderItems.isNotEmpty;
    final itemCount = order.orderItems.length;
    final next = _nextStatus[order.status];
    final nextLabel = _nextStatusLabel[order.status];
    final orderId = order.id.length >= 8
        ? order.id.substring(0, 8).toUpperCase()
        : order.id.toUpperCase();
    final showActions = next != null || _canCancel;

    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #$orderId',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order.deliveryAddress,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                _StatusChip(status: order.status),
              ],
            ),
            const SizedBox(height: 12),
            // Summary row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: hasItems
                      ? () => setState(() => _expanded = !_expanded)
                      : null,
                  borderRadius: BorderRadius.circular(4),
                  child: Row(
                    children: [
                      Text(
                        '$itemCount item${itemCount == 1 ? '' : 's'}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (hasItems)
                        Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                    ],
                  ),
                ),
                Text(
                  '\$${order.totalAmount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            // Expanded item list
            if (_expanded && hasItems) ...[
              const Divider(height: 24),
              ...order.orderItems.map((item) => _OrderItemRow(item: item)),
            ],
            // Action buttons
            if (_updating) ...[
              const SizedBox(height: 12),
              const Center(child: CircularProgressIndicator()),
            ] else if (showActions) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (_canCancel) ...[
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                        ),
                        onPressed: _cancel,
                        child: const Text('Cancel'),
                      ),
                    ),
                    if (next != null) const SizedBox(width: 8),
                  ],
                  if (next != null)
                    Expanded(
                      child: FilledButton(
                        onPressed: () => _updateStatus(next),
                        child: Text(nextLabel!),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order Item Row
// ---------------------------------------------------------------------------

class _OrderItemRow extends StatelessWidget {
  final OrderItemDto item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${item.menuItem.name} × ${item.quantity}',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Text(
            '\$${(item.priceAtTime * item.quantity).toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Status Chip
// ---------------------------------------------------------------------------

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final (color, label) = switch (status.toUpperCase()) {
      'PENDING' => (const Color(0xFFE65100), 'Pending'),
      'ACCEPTED' => (const Color(0xFF1565C0), 'Accepted'),
      'PREPARING' => (const Color(0xFF6A1B9A), 'Preparing'),
      'READY' => (const Color(0xFF00695C), 'Ready'),
      'PICKED_UP' => (const Color(0xFF283593), 'Picked Up'),
      _ => (const Color(0xFF546E7A), status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
