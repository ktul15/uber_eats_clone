import 'package:flutter/material.dart';

class DeliveryStatusStepper extends StatelessWidget {
  final String status;

  const DeliveryStatusStepper({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentStep = _statusToStep(status);

    const steps = [
      ('Driver Assigned', Icons.local_taxi_outlined),
      ('Picking Up Order', Icons.storefront_outlined),
      ('On the Way', Icons.directions_bike_outlined),
      ('Delivered!', Icons.check_circle_outline),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: List.generate(steps.length, (i) {
          final (label, icon) = steps[i];
          final isDone = currentStep > i;
          final isCurrent = currentStep == i;
          final isPending = currentStep < i;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _StepIcon(
                    icon: icon,
                    isDone: isDone,
                    isCurrent: isCurrent,
                    theme: theme,
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 2,
                      height: 32,
                      color: isDone
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outlineVariant,
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 4,
                    bottom: i < steps.length - 1 ? 32 : 4,
                  ),
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: (isPending || currentStep == -1)
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  int _statusToStep(String status) => switch (status.toUpperCase()) {
    'ASSIGNED' => 0,
    'AT_RESTAURANT' => 1,
    'IN_TRANSIT' => 2,
    'COMPLETED' => 3,
    _ => -1,
  };
}

class _StepIcon extends StatelessWidget {
  final IconData icon;
  final bool isDone;
  final bool isCurrent;
  final ThemeData theme;

  const _StepIcon({
    required this.icon,
    required this.isDone,
    required this.isCurrent,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    if (isDone) {
      return CircleAvatar(
        radius: 16,
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.check, size: 16, color: Colors.white),
      );
    }
    if (isCurrent) {
      return CircleAvatar(
        radius: 16,
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(icon, size: 16, color: theme.colorScheme.primary),
      );
    }
    return CircleAvatar(
      radius: 16,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      child: Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
    );
  }
}
