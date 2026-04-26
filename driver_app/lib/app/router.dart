import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:driver_app/app/routes.dart';
import 'package:driver_app/features/auth/providers/auth_providers.dart';
import 'package:driver_app/features/auth/presentation/screens/login_screen.dart';
import 'package:driver_app/features/auth/presentation/screens/register_screen.dart';
import 'package:driver_app/features/deliveries/presentation/screens/home_screen.dart';
import 'package:driver_app/features/deliveries/presentation/screens/active_delivery_screen.dart';
import 'package:driver_app/features/profile/presentation/screens/profile_screen.dart';

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
        path: AppRoutes.activeDelivery,
        name: AppRoutes.activeDeliveryName,
        builder: (context, state) => const ActiveDeliveryScreen(),
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}
