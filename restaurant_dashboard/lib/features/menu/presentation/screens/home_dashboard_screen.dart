import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_dashboard/app/routes.dart';
import 'package:restaurant_dashboard/features/auth/providers/auth_providers.dart';
import 'package:restaurant_dashboard/features/menu/providers/menu_providers.dart';
import 'package:restaurant_dashboard/shared/theme/app_colors.dart';
import 'package:restaurant_dashboard/shared/theme/app_sizes.dart';
import 'package:restaurant_dashboard/shared/widgets/app_button.dart';

class HomeDashboardScreen extends ConsumerStatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  ConsumerState<HomeDashboardScreen> createState() =>
      _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends ConsumerState<HomeDashboardScreen> {
  Future<void> _uploadCoverImage(String restaurantId) async {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) return;

      messenger.showSnackBar(
        const SnackBar(content: Text('Uploading cover image...')),
      );

      final uploadedUrl = await ref
          .read(menuRepositoryProvider)
          .uploadImage(pickedFile.path);

      await ref
          .read(myRestaurantsControllerProvider.notifier)
          .updateRestaurantImage(restaurantId, uploadedUrl);

      if (mounted) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Cover image updated!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        messenger.showSnackBar(
          SnackBar(
            content: const Text('Photo library access denied.'),
            action: SnackBarAction(
              label: 'Open Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Cover Image
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(AppSizes.radiusL),
                            ),
                            child: restaurant.imageUrl != null
                                ? Image.network(
                                    restaurant.imageUrl!,
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _CoverImagePlaceholder(
                                              height: 160,
                                            ),
                                  )
                                : _CoverImagePlaceholder(height: 160),
                          ),
                          Positioned(
                            bottom: AppSizes.p8,
                            right: AppSizes.p8,
                            child: FloatingActionButton.small(
                              heroTag: 'cover_image_upload',
                              onPressed: () =>
                                  _uploadCoverImage(restaurant.id),
                              tooltip: 'Change cover image',
                              child: const Icon(Icons.camera_alt, size: 18),
                            ),
                          ),
                        ],
                      ),
                      Padding(
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
                            Row(
                              children: [
                                Text(
                                  restaurant.isActive ? 'Active' : 'Inactive',
                                  style: TextStyle(
                                    color: restaurant.isActive
                                        ? AppColors.success
                                        : AppColors.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: AppSizes.p8),
                                Switch(
                                  value: restaurant.isActive,
                                  activeThumbColor: AppColors.success,
                                  inactiveThumbColor: AppColors.error,
                                  onChanged: (value) {
                                    ref
                                        .read(
                                          myRestaurantsControllerProvider
                                              .notifier,
                                        )
                                        .updateRestaurantStatus(
                                          restaurant.id,
                                          value,
                                        );
                                  },
                                ),
                              ],
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
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.p24),
                AppButton(
                  text: 'Active Orders',
                  onPressed: () {
                    context.pushNamed(AppRoutes.activeOrdersName);
                  },
                ),
                const SizedBox(height: AppSizes.p12),
                AppButton(
                  text: 'Order History',
                  isSecondary: true,
                  onPressed: () {
                    context.pushNamed(AppRoutes.orderHistoryName);
                  },
                ),
                const SizedBox(height: AppSizes.p12),
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

class _CoverImagePlaceholder extends StatelessWidget {
  final double height;

  const _CoverImagePlaceholder({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: AppColors.textSecondary.withValues(alpha: 0.1),
      child: const Icon(Icons.restaurant, size: 48, color: AppColors.textSecondary),
    );
  }
}
