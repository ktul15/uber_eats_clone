import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/menu_item.dart';
import 'package:restaurant_dashboard/features/menu/providers/menu_providers.dart';
import 'package:restaurant_dashboard/shared/theme/app_sizes.dart';
import 'package:restaurant_dashboard/shared/widgets/app_button.dart';
import 'package:restaurant_dashboard/shared/widgets/app_text_field.dart';

class MenuItemFormDialog extends ConsumerStatefulWidget {
  final String restaurantId;
  final MenuItem? item; // Nullable; if null, we are creating

  const MenuItemFormDialog({super.key, required this.restaurantId, this.item});

  @override
  ConsumerState<MenuItemFormDialog> createState() => _MenuItemFormDialogState();
}

class _MenuItemFormDialogState extends ConsumerState<MenuItemFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  bool _isAvailable = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _descController = TextEditingController(
      text: widget.item?.description ?? '',
    );
    _priceController = TextEditingController(
      text: widget.item?.price.toString() ?? '',
    );
    _imageController = TextEditingController(text: widget.item?.imageUrl ?? '');
    _isAvailable = widget.item?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      'name': _nameController.text.trim(),
      'description': _descController.text.trim(),
      'price': double.tryParse(_priceController.text.trim()) ?? 0.0,
      'imageUrl': _imageController.text.trim().isEmpty
          ? null
          : _imageController.text.trim(),
      'isAvailable': _isAvailable,
    };

    final notifier = ref.read(
      menuListControllerProvider(widget.restaurantId).notifier,
    );

    if (widget.item == null) {
      notifier.addMenuItem(payload);
    } else {
      notifier.updateMenuItem(widget.item!.id, payload);
    }

    Navigator.of(context).pop();
  }

  void _delete() {
    if (widget.item == null) return;
    ref
        .read(menuListControllerProvider(widget.restaurantId).notifier)
        .deleteMenuItem(widget.item!.id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;
    final theme = Theme.of(context);

    // Get loading state of the menu list
    final menuState = ref.watch(
      menuListControllerProvider(widget.restaurantId),
    );
    final isLoading = menuState.isLoading;

    return Container(
      padding: const EdgeInsets.all(AppSizes.p24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusL),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing ? 'Edit Menu Item' : 'Add Menu Item',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.p16),
            AppTextField(
              controller: _nameController,
              labelText: 'Item Name',
              validator: (val) =>
                  val == null || val.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: AppSizes.p16),
            AppTextField(
              controller: _descController,
              labelText: 'Description (Optional)',
              maxLines: 2,
            ),
            const SizedBox(height: AppSizes.p16),
            AppTextField(
              controller: _priceController,
              labelText: 'Price',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (val) {
                if (val == null || val.isEmpty) return 'Required';
                if (double.tryParse(val) == null) return 'Invalid number';
                return null;
              },
            ),
            const SizedBox(height: AppSizes.p16),
            const Text(
              'Item Image',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSizes.p8),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              child: _imageController.text.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                      child: Image.network(
                        _imageController.text,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 40, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: AppSizes.p8),
            OutlinedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Select Image'),
              onPressed: () async {
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
                    const SnackBar(content: Text('Uploading image...')),
                  );

                  final uploadedUrl = await ref
                      .read(menuRepositoryProvider)
                      .uploadImage(pickedFile.path);

                  if (mounted) {
                    setState(() {
                      _imageController.text = uploadedUrl;
                    });
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Image uploaded successfully!'),
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
              },
            ),
            const SizedBox(height: AppSizes.p16),
            SwitchListTile(
              title: const Text('Available for Order'),
              value: _isAvailable,
              onChanged: (val) => setState(() => _isAvailable = val),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: AppSizes.p24),
            Row(
              children: [
                if (isEditing) ...[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.p16,
                        ),
                      ),
                      onPressed: isLoading ? null : _delete,
                      child: const Text('Delete'),
                    ),
                  ),
                  const SizedBox(width: AppSizes.p12),
                ],
                Expanded(
                  flex: 2,
                  child: AppButton(
                    text: isEditing ? 'Save Changes' : 'Add Item',
                    isLoading: isLoading,
                    onPressed: isLoading ? () {} : _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
