import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/app/routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Driver App Home'))),
    ),
  ],
);
