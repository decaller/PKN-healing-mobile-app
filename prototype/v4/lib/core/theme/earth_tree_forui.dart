import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'earth_tree_colors.dart';
import 'typography.dart';

/// Integrasi Forui Theme dengan Desain Sistem Earth-Tree
final earthTreeForuiLight = _buildForuiTheme(Brightness.light);
final earthTreeForuiDark = _buildForuiTheme(Brightness.dark);

FThemeData _buildForuiTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final treeColors = isDark ? EarthTreeColors.dark : EarthTreeColors.light;

  final colors = FColors(
    brightness: brightness,
    barrier: const Color(0xA6161A1D),
    background: treeColors.surface,
    foreground: treeColors.textPrimary,
    primary: treeColors.celestialSky,
    primaryForeground: treeColors.onCelestialSky,
    secondary: treeColors.meadowCanopy,
    secondaryForeground: treeColors.onMeadowCanopy,
    muted: treeColors.surfaceContainerLow,
    mutedForeground: treeColors.textSecondary,
    destructive: treeColors.error,
    destructiveForeground: treeColors.onError,
    error: treeColors.error,
    errorForeground: treeColors.onError,
    border: treeColors.tactileBorder,
  );

  final textTheme = EarthTreeTypography.createTextTheme(
    treeColors.textPrimary,
    treeColors.textSecondary,
  );

  final typography = FTypography(
    xs: textTheme.labelSmall!,
    sm: textTheme.bodySmall!,
    base: textTheme.bodyMedium!,
    lg: textTheme.bodyLarge!,
    xl: textTheme.headlineSmall!,
    xl2: textTheme.headlineMedium!,
    defaultFontFamily: 'Plus Jakarta Sans',
    xl3: textTheme.headlineLarge!,
    xl4: textTheme.displaySmall!,
    xl5: textTheme.displayMedium!,
    xl6: textTheme.displayLarge!,
    xl7: textTheme.displayLarge!,
    xl8: textTheme.displayLarge!,
  );

  return FThemeData(
    colors: colors,
    typography: typography,
    style: FStyle(
      formFieldStyle: FFormFieldStyle.inherit(colors: colors, typography: typography),
      focusedOutlineStyle: FFocusedOutlineStyle(
        color: colors.primary,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      iconStyle: IconThemeData(color: colors.primary, size: 20),
      tappableStyle: FTappableStyle(),
      borderRadius: const FLerpBorderRadius.all(Radius.circular(12), min: 24),
      borderWidth: 1,
      pagePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shadow: const [
        BoxShadow(
          color: Color(0x0A2C2825),
          offset: Offset(0, 8),
          blurRadius: 24,
          spreadRadius: -6,
        ),
      ],
    ),
  );
}
