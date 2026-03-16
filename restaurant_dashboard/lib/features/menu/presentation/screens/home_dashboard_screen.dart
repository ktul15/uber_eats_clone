import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_dashboard/app/routes.dart';
import 'package:restaurant_dashboard/features/auth/providers/auth_providers.dart';
import 'package:restaurant_dashboard/features/menu/providers/menu_providers.dart';
import 'package:restaurant_dashboard/shared/theme/app_colors.dart';
import 'package:restaurant_dashboard/shared/theme/app_sizes.dart';
import 'package:restaurant_dashboard/shared/widgets/app_button.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsAsync = ref.watch(myRestaurantsControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authRepositoryProvider).logout();
              ref.invalidate(isAuthenticatedProvider);
            },
          ),
        ],
      ),
      body: restaurantsAsync.when(
        data: (restaurants) {
          if (restaurants.isEmpty) {
            return const Center(
              child: Text(
                'You have no restaurants yet.\nPlease use the backend API to create one.',
                textAlign: TextAlign.center,
              ),
            );
          }

          final restaurant = restaurants.first; // Assume they manage 1 for now

          return RefreshIndicator(
            onRefresh: () =>
                ref.refresh(myRestaurantsControllerProvider.future),
            child: ListView(
              padding: const EdgeInsets.all(AppSizes.p16),
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusL),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.p24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                restaurant.name,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.p12,
                                vertical: AppSizes.p4,
                              ),
                              decoration: BoxDecoration(
                                color: restaurant.isActive
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : AppColors.error.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radiusS,
                                ),
                              ),
                              child: Text(
                                restaurant.isActive ? 'Active' : 'Inactive',
                                style: TextStyle(
                                  color: restaurant.isActive
                                      ? AppColors.success
                                      : AppColors.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (restaurant.description != null) ...[
                          const SizedBox(height: AppSizes.p8),
                          Text(
                            restaurant.description!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        const SizedBox(height: AppSizes.p24),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: AppSizes.p8),
                            Expanded(
                              child: Text(
                                restaurant.address ?? 'No address provided',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.p24),
                AppButton(
                  text: 'Manage Menu Options',
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.menuName,
                      pathParameters: {'restaurantId': restaurant.id},
                    );
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Failed to load dashboard: $error',
            style: const TextStyle(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
