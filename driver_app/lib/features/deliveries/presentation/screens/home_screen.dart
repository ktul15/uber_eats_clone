import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:driver_app/app/routes.dart';
import 'package:driver_app/features/auth/providers/auth_providers.dart';
import 'package:driver_app/features/deliveries/domain/models/available_order.dart';
import 'package:driver_app/features/deliveries/presentation/widgets/incoming_order_sheet.dart';
import 'package:driver_app/features/profile/providers/profile_providers.dart';
import 'package:driver_app/shared/constants/api_constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

enum _SocketState { connecting, connected, disconnected, error }

class _HomeScreenState extends ConsumerState<HomeScreen> {
  io.Socket? _socket;
  _SocketState _socketState = _SocketState.connecting;
  bool _sheetVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setupSocket());
  }

  @override
  void dispose() {
    _socket?.off('order:available');
    _socket?.dispose();
    super.dispose();
  }

  Future<void> _setupSocket() async {
    if (mounted) setState(() => _socketState = _SocketState.connecting);

    String? token;
    String? userId;

    try {
      token = await ref.read(authRepositoryProvider).getToken();
      if (!mounted) return;
      if (token == null) {
        setState(() => _socketState = _SocketState.error);
        return;
      }

      final profile = await ref.read(profileControllerProvider.future);
      if (!mounted) return;
      if (profile == null) {
        setState(() => _socketState = _SocketState.error);
        return;
      }
      userId = profile.id;
    } catch (_) {
      if (mounted) setState(() => _socketState = _SocketState.error);
      return;
    }

    _socket?.dispose();

    _socket = io.io(
      ApiConstants.baseUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .build(),
    );

    _socket!.onConnect((_) {
      _socket!.emit('join', 'driver:$userId');
      if (mounted) setState(() => _socketState = _SocketState.connected);
    });

    _socket!.onDisconnect((_) {
      if (mounted) setState(() => _socketState = _SocketState.disconnected);
    });

    _socket!.onConnectError((_) {
      if (mounted) setState(() => _socketState = _SocketState.error);
    });

    _socket!.onError((_) {
      if (mounted) setState(() => _socketState = _SocketState.error);
    });

    _socket!.on('order:available', (data) {
      if (!mounted || _sheetVisible) return;
      final map = Map<String, dynamic>.from(data as Map);
      final order = AvailableOrder(
        orderId: map['orderId'] as String,
        restaurantId: map['restaurantId'] as String,
        restaurantName: map['restaurantName'] as String,
        deliveryAddress: map['deliveryAddress'] as String,
        totalAmount: (map['totalAmount'] as num).toDouble(),
      );
      _showIncomingOrder(order);
    });

    _socket!.connect();
  }

  void _showIncomingOrder(AvailableOrder order) {
    _sheetVisible = true;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (_) => IncomingOrderSheet(order: order),
    ).whenComplete(() => _sheetVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isConnected = _socketState == _SocketState.connected;
    final isError = _socketState == _SocketState.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.goNamed(AppRoutes.profileName),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isConnected ? Icons.wifi : isError ? Icons.wifi_off : Icons.wifi_find,
                size: 64,
                color: isConnected
                    ? theme.colorScheme.primary
                    : isError
                        ? theme.colorScheme.error
                        : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                switch (_socketState) {
                  _SocketState.connected => 'Online — Waiting for orders',
                  _SocketState.connecting => 'Connecting...',
                  _SocketState.disconnected => 'Disconnected',
                  _SocketState.error => 'Connection failed',
                },
                style: theme.textTheme.titleMedium?.copyWith(
                  color: isConnected
                      ? theme.colorScheme.primary
                      : isError
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (isConnected) ...[
                const SizedBox(height: 8),
                Text(
                  'You will be notified when a delivery is available',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (isError || _socketState == _SocketState.disconnected) ...[
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: _setupSocket,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
