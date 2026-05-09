import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/features/orders/data/models/order_dto.dart';
import 'package:customer_app/features/orders/data/models/order_item_dto.dart';
import 'package:customer_app/features/orders/providers/order_providers.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(orderHistoryProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load orders', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.refresh(orderHistoryProvider.future),
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
                    'No orders yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your order history will appear here',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(orderHistoryProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _OrderCard(order: orders[index]),
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

  const _OrderCard({required this.order});

  @override
  ConsumerState<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends ConsumerState<_OrderCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order = widget.order;
    final hasItems = order.orderItems.isNotEmpty;
    final date = _formatDate(order.createdAt);
    final itemCount = order.orderItems.length;
    final isDelivered = order.status.toUpperCase() == 'DELIVERED';

    return Semantics(
      button: hasItems,
      label:
          '${order.restaurant.name}, ${order.status}, '
          '\$${order.totalAmount.toStringAsFixed(2)}, '
          '$itemCount item${itemCount == 1 ? '' : 's'}. '
          '${hasItems ? 'Tap to ${_expanded ? 'collapse' : 'expand'} order items.' : ''}',
      excludeSemantics: true,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        child: InkWell(
          onTap: hasItems ? () => setState(() => _expanded = !_expanded) : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: restaurant name + date + status chip + chevron
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.restaurant.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusChip(status: order.status),
                    if (hasItems) ...[
                      const SizedBox(width: 4),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                // Summary row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$itemCount item${itemCount == 1 ? '' : 's'}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
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
                // Track button for active orders
                if (_isActiveDelivery(order.status)) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      onPressed: () => context.push(
                        '/active-delivery/${order.id}',
                        extra: {
                          'restaurantName': order.restaurant.name,
                          'itemCount': order.orderItems.length,
                          'total': order.totalAmount,
                        },
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text('Track Order'),
                    ),
                  ),
                ],
                if (isDelivered) ...[
                  const SizedBox(height: 12),
                  _ReviewSection(
                    order: order,
                    onReview: order.review == null
                        ? () => _handleReview(context, order)
                        : null,
                  ),
                ],
                // Expanded item list
                if (_expanded && hasItems) ...[
                  const Divider(height: 24),
                  ...order.orderItems.map((item) => _OrderItemRow(item: item)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleReview(BuildContext context, OrderDto order) async {
    final submission = await showModalBottomSheet<_ReviewSubmission>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ReviewSheet(restaurantName: order.restaurant.name),
    );

    if (submission == null || !context.mounted) return;

    await ref
        .read(submitReviewProvider.notifier)
        .execute(
          orderId: order.id,
          rating: submission.rating,
          comment: submission.comment,
        );

    if (!context.mounted) return;
    final submitState = ref.read(submitReviewProvider);
    final messenger = ScaffoldMessenger.of(context);

    if (submitState.hasError) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to submit review: ${submitState.error}'),
        ),
      );
      return;
    }

    messenger.showSnackBar(const SnackBar(content: Text('Review submitted')));
  }
}

class _ReviewSection extends StatelessWidget {
  final OrderDto order;
  final VoidCallback? onReview;

  const _ReviewSection({required this.order, required this.onReview});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final review = order.review;

    if (review != null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StarRating(value: review.rating),
                const SizedBox(width: 8),
                Text(
                  'Reviewed',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            if (review.comment?.trim().isNotEmpty ?? false) ...[
              const SizedBox(height: 8),
              Text(review.comment!, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onReview,
        icon: const Icon(Icons.star_outline),
        label: const Text('Rate Order'),
      ),
    );
  }
}

class _ReviewSubmission {
  final int rating;
  final String? comment;

  const _ReviewSubmission({required this.rating, this.comment});
}

class _ReviewSheet extends StatefulWidget {
  final String restaurantName;

  const _ReviewSheet({required this.restaurantName});

  @override
  State<_ReviewSheet> createState() => _ReviewSheetState();
}

class _ReviewSheetState extends State<_ReviewSheet> {
  final _commentController = TextEditingController();
  int _rating = 0;
  bool _showRatingError = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomInset + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rate ${widget.restaurantName}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final value = index + 1;
              return IconButton(
                tooltip: '$value star${value == 1 ? '' : 's'}',
                onPressed: () {
                  setState(() {
                    _rating = value;
                    _showRatingError = false;
                  });
                },
                icon: Icon(
                  value <= _rating ? Icons.star : Icons.star_border,
                  size: 36,
                  color: theme.colorScheme.primary,
                ),
              );
            }),
          ),
          if (_showRatingError)
            Center(
              child: Text(
                'Select a rating',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            minLines: 3,
            maxLines: 5,
            textInputAction: TextInputAction.newline,
            decoration: const InputDecoration(
              labelText: 'Review',
              hintText: 'Share your experience',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_rating == 0) {
      setState(() => _showRatingError = true);
      return;
    }

    Navigator.pop(
      context,
      _ReviewSubmission(rating: _rating, comment: _commentController.text),
    );
  }
}

class _StarRating extends StatelessWidget {
  final int value;

  const _StarRating({required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < value ? Icons.star : Icons.star_border,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
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
// Helpers
// ---------------------------------------------------------------------------

bool _isActiveDelivery(String status) {
  const activeStatuses = {'ACCEPTED', 'PREPARING', 'READY', 'PICKED_UP'};
  return activeStatuses.contains(status.toUpperCase());
}

String _formatDate(DateTime dateTime) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final local = dateTime.toLocal();
  return '${months[local.month - 1]} ${local.day}, ${local.year}';
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

    final (baseColor, label) = switch (status.toUpperCase()) {
      'PENDING' => (const Color(0xFFE65100), 'Pending'),
      'ACCEPTED' => (const Color(0xFF1565C0), 'Accepted'),
      'PREPARING' => (const Color(0xFF1565C0), 'Preparing'),
      'READY' => (const Color(0xFF00695C), 'Ready'),
      'PICKED_UP' => (const Color(0xFF283593), 'On the way'),
      'DELIVERED' => (const Color(0xFF2E7D32), 'Delivered'),
      'CANCELLED' => (const Color(0xFFC62828), 'Cancelled'),
      _ => (const Color(0xFF546E7A), status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: baseColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
