import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:restaurant_dashboard/app/routes.dart';
import 'package:restaurant_dashboard/features/auth/providers/auth_providers.dart';
import 'package:restaurant_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:restaurant_dashboard/features/auth/presentation/screens/register_screen.dart';
import 'package:restaurant_dashboard/features/profile/presentation/screens/profile_screen.dart';
import 'package:restaurant_dashboard/features/menu/presentation/screens/home_dashboard_screen.dart';
import 'package:restaurant_dashboard/features/menu/presentation/screens/menu_management_screen.dart';
import 'package:restaurant_dashboard/features/orders/presentation/screens/active_orders_screen.dart';
import 'package:restaurant_dashboard/features/orders/presentation/screens/order_history_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authNotifier = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref.listen(isAuthenticatedProvider, (_, next) {
    authNotifier.value = next;
  }, fireImmediately: true);

  final router = GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = authNotifier.value;

      if (authState is AsyncLoading) return AppRoutes.login;

      final isAuth = authState.value ?? false;
      final isGoingToAuth =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register;

      if (!isAuth && !isGoingToAuth) return AppRoutes.login;
      if (isAuth && isGoingToAuth) return AppRoutes.home;

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.registerName,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomeDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.menu,
        name: AppRoutes.menuName,
        builder: (context, state) {
          final restaurantId = state.pathParameters['restaurantId']!;
          return MenuManagementScreen(restaurantId: restaurantId);
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profileName,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.activeOrders,
        name: AppRoutes.activeOrdersName,
        builder: (context, state) => const ActiveOrdersScreen(),
      ),
      GoRoute(
        path: AppRoutes.orderHistory,
        name: AppRoutes.orderHistoryName,
        builder: (context, state) => const OrderHistoryScreen(),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}
