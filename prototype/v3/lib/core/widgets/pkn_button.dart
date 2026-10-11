import 'package:pkn_microlearning_app/core/widgets/pkn_adaptive.dart';
import 'package:flutter/material.dart';
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
    final scheme = Theme.of(context).colorScheme;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case PknButtonVariant.primary:
        backgroundColor = scheme.primary;
        foregroundColor = scheme.onPrimary;
        break;
      case PknButtonVariant.secondary:
        backgroundColor = scheme.secondary;
        foregroundColor = scheme.onSecondary;
        break;
      case PknButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = scheme.onSurface;
        borderSide = BorderSide(
          color: scheme.outlineVariant,
          width: 1.5,
        );
        break;
      case PknButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = scheme.primary;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: PknActionButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: PknRadius.roundedSm,
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
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: foregroundColor),
                  ),
                ],
              ),
      ),
    );
  }
}
