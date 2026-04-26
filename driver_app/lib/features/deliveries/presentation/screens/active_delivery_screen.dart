import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:driver_app/app/routes.dart';
import 'package:driver_app/features/deliveries/domain/models/active_delivery.dart';
import 'package:driver_app/features/deliveries/providers/delivery_providers.dart';

class ActiveDeliveryScreen extends ConsumerWidget {
  const ActiveDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryAsync = ref.watch(activeDeliveryProvider);

    ref.listen(activeDeliveryProvider, (prev, next) {
      if (next.hasValue) {
        final wasActive = prev?.value != null;
        final isGone = next.value == null;
        if (isGone && wasActive) {
          // Backend excludes COMPLETED deliveries from getActiveDelivery,
          // so null after a non-null value means delivery was just completed.
          context.goNamed(AppRoutes.homeName);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Active Delivery')),
      body: deliveryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _ErrorBody(
          message: error.toString(),
          onRetry: () => ref.invalidate(activeDeliveryProvider),
        ),
        data: (delivery) {
          if (delivery == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No active delivery found.'),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.goNamed(AppRoutes.homeName),
                    child: const Text('Go Home'),
                  ),
                ],
              ),
            );
          }
          return _DeliveryBody(delivery: delivery);
        },
      ),
    );
  }
}

class _DeliveryBody extends ConsumerWidget {
  final ActiveDelivery delivery;

  const _DeliveryBody({required this.delivery});

  String get _headerTitle => switch (delivery.status) {
        DeliveryStatus.assigned => 'Head to Restaurant',
        DeliveryStatus.atRestaurant => 'Collect the Order',
        DeliveryStatus.inTransit => 'En Route to Customer',
        DeliveryStatus.completed => 'Delivered',
      };

  IconData get _headerIcon => switch (delivery.status) {
        DeliveryStatus.assigned => Icons.directions_car,
        DeliveryStatus.atRestaurant => Icons.restaurant,
        DeliveryStatus.inTransit => Icons.delivery_dining,
        DeliveryStatus.completed => Icons.check_circle,
      };

  String get _actionLabel => switch (delivery.status) {
        DeliveryStatus.assigned => "I've Arrived at Restaurant",
        DeliveryStatus.atRestaurant => 'Confirm Pickup',
        DeliveryStatus.inTransit => 'Confirm Delivery',
        DeliveryStatus.completed => 'Done',
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final updateState = ref.watch(updateDeliveryStatusProvider);
    final isLoading = updateState is AsyncLoading;

    ref.listen(updateDeliveryStatusProvider, (_, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: ${next.error}'),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PhaseHeader(icon: _headerIcon, title: _headerTitle, theme: theme),
          const SizedBox(height: 24),
          _StatusChip(status: delivery.status, theme: theme),
          const SizedBox(height: 28),
          if (delivery.status == DeliveryStatus.assigned) ...[
            _SectionLabel('Restaurant', theme),
            const SizedBox(height: 12),
            _InfoRow(icon: Icons.storefront, value: delivery.restaurantName),
            const SizedBox(height: 8),
            _InfoRow(icon: Icons.location_on, value: delivery.restaurantAddress),
          ],
          if (delivery.status == DeliveryStatus.atRestaurant) ...[
            _SectionLabel('Order Items', theme),
            const SizedBox(height: 12),
            ...delivery.orderItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _InfoRow(
                  icon: Icons.fastfood,
                  value: '${item.quantity}× ${item.name}',
                ),
              ),
            ),
            const SizedBox(height: 16),
            _SectionLabel('Deliver to', theme),
            const SizedBox(height: 12),
            _InfoRow(icon: Icons.location_on, value: delivery.deliveryAddress),
          ],
          if (delivery.status == DeliveryStatus.inTransit) ...[
            _SectionLabel('Delivering to', theme),
            const SizedBox(height: 12),
            _InfoRow(icon: Icons.location_on, value: delivery.deliveryAddress),
          ],
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.attach_money,
            value: '\$${delivery.totalAmount.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 36),
          if (delivery.status != DeliveryStatus.completed)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: isLoading
                    ? null
                    : () {
                        final next = delivery.status.next;
                        if (next != null) {
                          ref
                              .read(updateDeliveryStatusProvider.notifier)
                              .execute(delivery.id, next);
                        }
                      },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_actionLabel),
              ),
            ),
        ],
      ),
    );
  }
}

class _PhaseHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final ThemeData theme;

  const _PhaseHeader({required this.icon, required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 32, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final DeliveryStatus status;
  final ThemeData theme;

  const _StatusChip({required this.status, required this.theme});

  String get _label => switch (status) {
        DeliveryStatus.assigned => 'ASSIGNED',
        DeliveryStatus.atRestaurant => 'AT RESTAURANT',
        DeliveryStatus.inTransit => 'IN TRANSIT',
        DeliveryStatus.completed => 'COMPLETED',
      };

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(_label, style: theme.textTheme.labelSmall),
      backgroundColor: theme.colorScheme.primaryContainer,
      side: BorderSide.none,
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final ThemeData theme;

  const _SectionLabel(this.text, this.theme);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Text(value, style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }
}

class _ErrorBody extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBody({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
