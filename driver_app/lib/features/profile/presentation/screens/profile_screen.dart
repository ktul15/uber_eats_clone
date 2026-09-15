import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:driver_app/app/routes.dart';
import 'package:driver_app/features/auth/providers/auth_providers.dart';
import 'package:driver_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:driver_app/features/profile/providers/profile_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _vehicleTypeController;
  late TextEditingController _licenseNumberController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _vehicleTypeController = TextEditingController();
    _licenseNumberController = TextEditingController();

    // Initialize with current data if loaded
    final profileState = ref.read(profileControllerProvider);
    if (profileState is AsyncData && profileState.value != null) {
      final user = profileState.value!;
      _nameController.text = user.profile.name;
      _phoneController.text = user.phone ?? '';
      _vehicleTypeController.text = user.profile.vehicleType ?? '';
      _licenseNumberController.text = user.profile.licenseNumber ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _vehicleTypeController.dispose();
    _licenseNumberController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(profileControllerProvider.notifier)
        .updateProfile(
          name: _nameController.text.trim(),
          phone: _phoneController.text.trim(),
          vehicleType: _vehicleTypeController.text.trim(),
          licenseNumber: _licenseNumberController.text.trim(),
        );
  }

  Future<void> _onLogout() async {
    await ref.read(logoutProvider.notifier).execute();
    if (mounted) context.goNamed(AppRoutes.loginName);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileControllerProvider);
    final theme = Theme.of(context);

    ref.listen(profileControllerProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      } else if (prev is AsyncLoading && next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _onLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Failed to load profile',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(error.toString(), style: theme.textTheme.bodySmall),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.refresh(profileControllerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (user) {
          if (user == null) return const Center(child: Text('No profile data'));

          // Update controllers if data was refreshed
          if (_nameController.text.isEmpty && user.profile.name.isNotEmpty) {
            _nameController.text = user.profile.name;
            _phoneController.text = user.phone ?? '';
            _vehicleTypeController.text = user.profile.vehicleType ?? '';
            _licenseNumberController.text = user.profile.licenseNumber ?? '';
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      user.profile.name.isNotEmpty
                          ? user.profile.name.substring(0, 1).toUpperCase()
                          : '?',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Read Only Email
                  AuthTextField(
                    controller: TextEditingController(text: user.email),
                    label: 'Email (Cannot be changed)',
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    prefixIcon: const Icon(Icons.person_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _phoneController,
                    label: 'Phone Number (optional)',
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                  const SizedBox(height: 24),

                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Vehicle Details',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _vehicleTypeController,
                    label: 'Vehicle Type (e.g. Car, Bike, Scooter)',
                    prefixIcon: const Icon(Icons.directions_car_outlined),
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _licenseNumberController,
                    label: 'License Plate / Number',
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                  const SizedBox(height: 32),

                  FilledButton(
                    onPressed: profileState.isLoading ? null : _onSave,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: profileState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
