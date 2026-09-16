import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_dashboard/app/routes.dart';
import 'package:restaurant_dashboard/features/auth/providers/auth_providers.dart';
import 'package:restaurant_dashboard/features/menu/domain/models/restaurant.dart';
import 'package:restaurant_dashboard/features/menu/providers/menu_providers.dart';

class HomeDashboardScreen extends ConsumerWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurants = ref.watch(myRestaurantsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(logoutProvider.notifier).execute();
              ref.invalidate(isAuthenticatedProvider);
            },
          ),
        ],
      ),
      body: restaurants.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _ErrorState(
          onRetry: () => ref.invalidate(myRestaurantsControllerProvider),
        ),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.refresh(myRestaurantsControllerProvider.future),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              if (items.isEmpty) ...[
                const _EmptyRestaurantHeader(),
                const SizedBox(height: 24),
                const RestaurantCreationForm(),
              ] else ...[
                _OwnerWideActions(onCreate: () => _showCreateDialog(context)),
                const SizedBox(height: 16),
                for (final restaurant in items) ...[
                  _RestaurantCard(restaurant: restaurant),
                  const SizedBox(height: 16),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context) => showDialog<void>(
    context: context,
    builder: (_) => const Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: RestaurantCreationForm(showHeading: true),
      ),
    ),
  );
}

class _OwnerWideActions extends StatelessWidget {
  const _OwnerWideActions({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      FilledButton.icon(
        onPressed: () => context.pushNamed(AppRoutes.activeOrdersName),
        icon: const Icon(Icons.receipt_long_outlined),
        label: const Text('Active orders'),
      ),
      OutlinedButton.icon(
        onPressed: () => context.pushNamed(AppRoutes.orderHistoryName),
        icon: const Icon(Icons.history),
        label: const Text('Order history'),
      ),
      OutlinedButton.icon(
        onPressed: onCreate,
        icon: const Icon(Icons.add_business),
        label: const Text('Add restaurant'),
      ),
    ],
  );
}

class _RestaurantCard extends ConsumerStatefulWidget {
  const _RestaurantCard({required this.restaurant});

  final Restaurant restaurant;

  @override
  ConsumerState<_RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends ConsumerState<_RestaurantCard> {
  bool _updating = false;

  Future<void> _setStatus(bool value) async {
    if (_updating) return;
    setState(() => _updating = true);
    await ref
        .read(myRestaurantsControllerProvider.notifier)
        .updateRestaurantStatus(widget.restaurant.id, value);
    if (mounted) setState(() => _updating = false);
  }

  Future<void> _uploadCover() async {
    if (_updating) return;
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 2000,
    );
    if (image == null || !mounted) return;
    setState(() => _updating = true);
    try {
      final url = await ref
          .read(menuRepositoryProvider)
          .uploadImage(image.path);
      await ref
          .read(myRestaurantsControllerProvider.notifier)
          .updateRestaurantImage(widget.restaurant.id, url);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to upload that image.')),
        );
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = widget.restaurant;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            image: true,
            label: '${restaurant.name} cover image',
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                if (restaurant.imageUrl != null)
                  Image.network(
                    restaurant.imageUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const _CoverPlaceholder(),
                  )
                else
                  const _CoverPlaceholder(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: IconButton.filledTonal(
                    tooltip: 'Change ${restaurant.name} cover image',
                    onPressed: _updating ? null : _uploadCover,
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(restaurant.isActive ? 'Open' : 'Closed'),
                    Switch(
                      value: restaurant.isActive,
                      onChanged: _updating ? null : _setStatus,
                    ),
                  ],
                ),
                if ((restaurant.description ?? '').isNotEmpty)
                  Text(restaurant.description!),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(restaurant.address ?? 'No address')),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.tonalIcon(
                    onPressed: () => context.pushNamed(
                      AppRoutes.menuName,
                      pathParameters: {'restaurantId': restaurant.id},
                    ),
                    icon: const Icon(Icons.restaurant_menu),
                    label: Text('Manage ${restaurant.name} menu'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantCreationForm extends ConsumerStatefulWidget {
  const RestaurantCreationForm({super.key, this.showHeading = false});

  final bool showHeading;

  @override
  ConsumerState<RestaurantCreationForm> createState() =>
      _RestaurantCreationFormState();
}

class _RestaurantCreationFormState
    extends ConsumerState<RestaurantCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _address = TextEditingController();
  final _lat = TextEditingController();
  final _lng = TextEditingController();
  final _imageUrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _description,
      _address,
      _lat,
      _lng,
      _imageUrl,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _required(String? value, String label) =>
      value == null || value.trim().isEmpty ? '$label is required' : null;

  String? _coordinate(String? value, {required bool latitude}) {
    final parsed = double.tryParse(value ?? '');
    final limit = latitude ? 90 : 180;
    return parsed == null || parsed < -limit || parsed > limit
        ? 'Enter a value from -$limit to $limit'
        : null;
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final success = await ref
        .read(myRestaurantsControllerProvider.notifier)
        .createRestaurant({
          'name': _name.text.trim(),
          'description': _description.text.trim(),
          'address': _address.text.trim(),
          'lat': double.parse(_lat.text),
          'lng': double.parse(_lng.text),
          if (_imageUrl.text.trim().isNotEmpty)
            'imageUrl': _imageUrl.text.trim(),
        });
    if (!mounted) return;
    setState(() => _submitting = false);
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Restaurant created.')));
      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to create restaurant.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.showHeading)
          Text(
            'Add restaurant',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        if (widget.showHeading) const SizedBox(height: 16),
        TextFormField(
          controller: _name,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Name'),
          validator: (value) => _required(value, 'Name'),
        ),
        TextFormField(
          controller: _description,
          textInputAction: TextInputAction.next,
          maxLength: 1000,
          decoration: const InputDecoration(labelText: 'Description'),
        ),
        TextFormField(
          controller: _address,
          textInputAction: TextInputAction.next,
          maxLines: 2,
          decoration: const InputDecoration(labelText: 'Address'),
          validator: (value) => _required(value, 'Address'),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _lat,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Latitude'),
                validator: (value) => _coordinate(value, latitude: true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _lng,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Longitude'),
                validator: (value) => _coordinate(value, latitude: false),
              ),
            ),
          ],
        ),
        TextFormField(
          controller: _imageUrl,
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Cover image URL (optional)',
          ),
          onFieldSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: _submitting ? null : _submit,
          icon: _submitting
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.add_business),
          label: const Text('Create restaurant'),
        ),
      ],
    ),
  );
}

class _EmptyRestaurantHeader extends StatelessWidget {
  const _EmptyRestaurantHeader();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Icon(
        Icons.storefront_outlined,
        size: 64,
        color: Theme.of(context).colorScheme.primary,
      ),
      const SizedBox(height: 12),
      Text(
        'Create your first restaurant',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const Text('Add the details customers and drivers need.'),
    ],
  );
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) => Container(
    height: 160,
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    alignment: Alignment.center,
    child: const Icon(Icons.restaurant, size: 48),
  );
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Unable to load your restaurants.'),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    ),
  );
}
