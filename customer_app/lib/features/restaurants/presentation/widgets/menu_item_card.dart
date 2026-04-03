import 'package:flutter/material.dart';
import 'package:customer_app/features/restaurants/domain/models/menu_item.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const MenuItemCard({
    super.key,
    required this.menuItem,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: menuItem.isAvailable ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menuItem.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: menuItem.isAvailable
                          ? null
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (menuItem.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      menuItem.description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '\$${menuItem.price.toStringAsFixed(2)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: menuItem.isAvailable
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (!menuItem.isAvailable)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Unavailable',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Thumbnail + Add button
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(width: 80, height: 80, child: _buildImage()),
                ),
                if (menuItem.isAvailable && onAddToCart != null)
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: GestureDetector(
                      onTap: onAddToCart,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (menuItem.imageUrl == null) return _placeholder();

    return Image.network(
      menuItem.imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFFEEEEEE),
      child: const Center(
        child: Icon(Icons.fastfood, size: 32, color: Colors.grey),
      ),
    );
  }
}
