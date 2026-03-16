import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/shared/theme/app_colors.dart';
import 'package:restaurant_dashboard/shared/theme/app_sizes.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;
  final bool isDense;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
    this.isDense = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isDense ? 40 : AppSizes.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary
              ? AppColors.secondary
              : AppColors.primary,
          foregroundColor: isSecondary
              ? AppColors.textPrimary
              : AppColors.textInverse,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          disabledBackgroundColor: AppColors.secondaryDark,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isSecondary
                      ? AppColors.primary
                      : AppColors.textInverse,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSecondary
                      ? AppColors.textPrimary
                      : AppColors.textInverse,
                ),
              ),
      ),
    );
  }
}
