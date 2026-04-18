import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:customer_app/app/routes.dart';
import 'package:customer_app/features/auth/providers/auth_providers.dart';
import 'package:customer_app/features/auth/presentation/screens/login_screen.dart';
import 'package:customer_app/features/auth/presentation/screens/register_screen.dart';
import 'package:customer_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:customer_app/features/orders/presentation/screens/checkout_screen.dart';
import 'package:customer_app/features/orders/presentation/screens/order_confirmation_screen.dart';
import 'package:customer_app/features/orders/presentation/screens/orders_screen.dart';
import 'package:customer_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:customer_app/features/restaurants/presentation/screens/home_screen.dart';
import 'package:customer_app/features/restaurants/presentation/screens/restaurant_detail_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authNotifier = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref.listen(isAuthenticatedProvider, (_, next) {
    authNotifier.value = next;
  }, fireImmediately: true);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
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
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profileName,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.restaurantDetail,
        name: AppRoutes.restaurantDetailName,
        builder: (context, state) =>
            RestaurantDetailScreen(restaurantId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.cart,
        name: AppRoutes.cartName,
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        name: AppRoutes.checkoutName,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: AppRoutes.orderConfirmation,
        name: AppRoutes.orderConfirmationName,
        builder: (context, state) =>
            OrderConfirmationScreen(orderId: state.extra as String),
      ),
      GoRoute(
        path: AppRoutes.orders,
        name: AppRoutes.ordersName,
        builder: (context, state) => const OrdersScreen(),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}
