import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/app/routes.dart';
import 'package:driver_app/features/auth/presentation/screens/login_screen.dart';
import 'package:driver_app/features/auth/presentation/screens/register_screen.dart';
import 'package:driver_app/features/profile/presentation/screens/profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
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
      builder: (context, state) => Scaffold(
        body: const Center(child: Text('Driver App Home')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.goNamed(AppRoutes.profileName),
          child: const Icon(Icons.person),
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: AppRoutes.profileName,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
