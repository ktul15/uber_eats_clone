import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:customer_app/app/routes.dart';
import 'package:customer_app/features/delivery/domain/active_delivery_state.dart';
import 'package:customer_app/features/delivery/presentation/widgets/delivery_status_stepper.dart';
import 'package:customer_app/features/delivery/presentation/widgets/driver_info_card.dart';
import 'package:customer_app/features/delivery/providers/active_delivery_providers.dart';

class ActiveDeliveryScreen extends ConsumerStatefulWidget {
  final String orderId;
  final Map<String, dynamic>? extra;

  const ActiveDeliveryScreen({
    super.key,
    required this.orderId,
    this.extra,
  });

  @override
  ConsumerState<ActiveDeliveryScreen> createState() =>
      _ActiveDeliveryScreenState();
}

class _ActiveDeliveryScreenState extends ConsumerState<ActiveDeliveryScreen>
    with SingleTickerProviderStateMixin {
  final _mapController = Completer<GoogleMapController>();

  late AnimationController _markerAnimController;
  late Animation<double> _markerAnim;

  LatLng? _animatedDriverPos;
  LatLng? _animStart;
  LatLng? _animEnd;

  @override
  void initState() {
    super.initState();
    _markerAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _markerAnim = CurvedAnimation(
      parent: _markerAnimController,
      curve: Curves.easeInOut,
    );
    _markerAnim.addListener(_onAnimTick);
  }

  @override
  void dispose() {
    _markerAnim.removeListener(_onAnimTick);
    _markerAnimController.dispose();
    super.dispose();
  }

  void _onAnimTick() {
    if (_animStart == null || _animEnd == null) return;
    setState(() {
      _animatedDriverPos = _lerpLatLng(_animStart!, _animEnd!, _markerAnim.value);
    });
  }

  static LatLng _lerpLatLng(LatLng a, LatLng b, double t) {
    return LatLng(
      a.latitude + (b.latitude - a.latitude) * t,
      a.longitude + (b.longitude - a.longitude) * t,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deliveryState =
        ref.watch(activeDeliveryProvider(widget.orderId));
    final restaurantName =
        widget.extra?['restaurantName'] as String? ?? 'Order Tracking';

    ref.listen(activeDeliveryProvider(widget.orderId), (_, next) {
      final lat = next.driverLat;
      final lng = next.driverLng;
      if (lat == null || lng == null) return;
      final newTarget = LatLng(lat, lng);

      if (_animatedDriverPos == null) {
        setState(() {
          _animatedDriverPos = newTarget;
          _animStart = newTarget;
          _animEnd = newTarget;
        });
        _mapController.future.then((c) =>
            c.animateCamera(CameraUpdate.newLatLng(newTarget)));
        return;
      }

      setState(() {
        _animStart = _animatedDriverPos;
        _animEnd = newTarget;
      });
      _markerAnimController
        ..stop()
        ..reset()
        ..forward();

      _mapController.future.then((c) =>
          c.animateCamera(CameraUpdate.newLatLng(newTarget)));
    });

    final isDelivered = deliveryState.status == 'COMPLETED';
    final statusSubtitle = _statusSubtitle(deliveryState.status);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurantName),
            Text(
              statusSubtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      body: Column(
        children: [
          // Delivered banner
          if (isDelivered)
            Container(
              width: double.infinity,
              color: theme.colorScheme.primaryContainer,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Your order has been delivered!',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          // Map
          SizedBox(
            height: 260,
            child: _buildMap(deliveryState, theme),
          ),
          // Scrollable content below map
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Delivery Status',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DeliveryStatusStepper(status: deliveryState.status),
                  Divider(
                    height: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Your Driver',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  DriverInfoCard(
                    driverName: deliveryState.driverName,
                    vehicleType: deliveryState.driverVehicleType,
                  ),
                  if (widget.extra != null) ...[
                    Divider(
                      height: 1,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    _OrderSummaryRow(extra: widget.extra!),
                  ],
                  if (isDelivered) ...[
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => context.go(AppRoutes.home),
                          child: const Text('Back to Home'),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap(ActiveDeliveryState deliveryState, ThemeData theme) {
    if (_animatedDriverPos == null) {
      return Container(
        color: theme.colorScheme.surfaceContainerLowest,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_searching,
                size: 40,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                'Waiting for driver location…',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GoogleMap(
      onMapCreated: (controller) {
        if (!_mapController.isCompleted) {
          _mapController.complete(controller);
        }
      },
      initialCameraPosition: CameraPosition(
        target: _animatedDriverPos!,
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('driver'),
          position: _animatedDriverPos!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          infoWindow: InfoWindow(
            title: deliveryState.driverName ?? 'Your Driver',
          ),
        ),
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }

  String _statusSubtitle(String status) => switch (status.toUpperCase()) {
        'ASSIGNED' => 'Driver is heading to the restaurant',
        'AT_RESTAURANT' => 'Driver is picking up your order',
        'IN_TRANSIT' => 'Driver is on the way to you',
        'COMPLETED' => 'Order delivered!',
        _ => 'Waiting for driver assignment…',
      };
}

class _OrderSummaryRow extends StatelessWidget {
  final Map<String, dynamic> extra;

  const _OrderSummaryRow({required this.extra});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final restaurantName = extra['restaurantName'] as String? ?? '';
    final itemCount = extra['itemCount'] as int? ?? 0;
    final total = extra['total'] as double? ?? 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              restaurantName,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '$itemCount item${itemCount == 1 ? '' : 's'} · \$${total.toStringAsFixed(2)}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
