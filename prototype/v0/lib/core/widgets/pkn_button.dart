import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/pkn_tokens.dart';

enum PknButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
}

/// Standardized PKN Button with guaranteed minimum touch target of 48dp (WCAG 2.1 AA)
class PknButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final PknButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;

  const PknButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = PknButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = PknSpacing.xxxl, // 48.0 dp
  });

  factory PknButton.primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    double? width,
    double height = PknSpacing.xxxl,
  }) {
    return PknButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: PknButtonVariant.primary,
      icon: icon,
      isLoading: isLoading,
      width: width,
      height: height,
    );
  }

  factory PknButton.outline({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    bool isLoading = false,
    double? width,
    double height = PknSpacing.xxxl,
  }) {
    return PknButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: PknButtonVariant.outline,
      icon: icon,
      isLoading: isLoading,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case PknButtonVariant.primary:
        backgroundColor = AppColors.brandPrimary;
        foregroundColor = Colors.white;
        break;
      case PknButtonVariant.secondary:
        backgroundColor = AppColors.brandGold;
        foregroundColor = Colors.black87;
        break;
      case PknButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
        borderSide = BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.5,
        );
        break;
      case PknButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = AppColors.brandPrimary;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: variant == PknButtonVariant.primary ? 1 : 0,
          shadowColor: Colors.black26,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                      color: foregroundColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
