import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/menu_item.dart';
import 'package:restaurant_dashboard/features/menu/providers/menu_providers.dart';
import 'package:restaurant_dashboard/shared/theme/app_colors.dart';
import 'package:restaurant_dashboard/shared/theme/app_sizes.dart';
import 'package:restaurant_dashboard/features/menu/presentation/widgets/menu_item_form_dialog.dart';

class MenuManagementScreen extends ConsumerWidget {
  final String restaurantId;

  const MenuManagementScreen({super.key, required this.restaurantId});

  void _showMenuForm(BuildContext context, {MenuItem? item}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: MenuItemFormDialog(restaurantId: restaurantId, item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAsync = ref.watch(menuListControllerProvider(restaurantId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.refresh(menuListControllerProvider(restaurantId).future),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showMenuForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
      body: menuAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    size: 64,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(height: AppSizes.p16),
                  Text(
                    'Your menu is empty',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSizes.p8),
                  const Text('Tap the + button below to add an item.'),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(
              left: AppSizes.p16,
              right: AppSizes.p16,
              top: AppSizes.p16,
              bottom: 100, // padding for FAB
            ),
            itemCount: items.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppSizes.p12),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(AppSizes.p12),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundAlt,
                      borderRadius: BorderRadius.circular(AppSizes.radiusS),
                      image: item.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(item.imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: item.imageUrl == null
                        ? const Icon(Icons.fastfood, color: AppColors.primary)
                        : null,
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: AppSizes.p4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (item.description != null) ...[
                          const SizedBox(height: AppSizes.p4),
                          Text(
                            item.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        value: item.isAvailable,
                        activeThumbColor: AppColors.primary,
                        onChanged: (val) {
                          ref
                              .read(
                                menuListControllerProvider(
                                  restaurantId,
                                ).notifier,
                              )
                              .updateMenuItem(item.id, {'isAvailable': val});
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => _showMenuForm(context, item: item),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Failed to load menu: $error',
            style: const TextStyle(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
