import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/routes.dart';
import 'package:restaurant_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:restaurant_dashboard/features/auth/presentation/screens/register_screen.dart';

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
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Restaurant Dashboard Home')),
      ),
    ),
  ],
);
