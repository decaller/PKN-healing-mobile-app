import 'package:flutter/material.dart';
import '../core/theme/earth_tree_colors.dart';
import '../core/theme/typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData create(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final treeColors = isDark ? EarthTreeColors.dark : EarthTreeColors.light;
    final textTheme = EarthTreeTypography.createTextTheme(
      treeColors.textPrimary,
      treeColors.textSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: treeColors.surface,
      primaryColor: treeColors.celestialSky,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: treeColors.celestialSky,
        onPrimary: treeColors.onCelestialSky,
        secondary: treeColors.meadowCanopy,
        onSecondary: treeColors.onMeadowCanopy,
        surface: treeColors.surface,
        onSurface: treeColors.textPrimary,
        error: treeColors.error,
        onError: Colors.white,
      ),
      textTheme: textTheme,
      extensions: [treeColors],
      // Menghilangkan ripple agresif bawaan Material demi thuma'ninah visual
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      dividerColor: treeColors.tactileBorder,
    );
  }
}
