import 'package:flutter/material.dart';

/// Earth-Tree Color Palette tokens according to design specification
class EarthTreeColors {
  static const Color surface = Color(0xFFFDF9F0);
  static const Color surfaceContainerLow = Color(0xFFF7F3EA);
  static const Color surfaceContainer = Color(0xFFF1EDE5);
  static const Color surfaceContainerHigh = Color(0xFFECE8DF);
  static const Color surfaceContainerHighest = Color(0xFFE6E2DA);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceDim = Color(0xFFDDDAD1);

  static const Color primary = Color(0xFF006194);
  static const Color primaryContainer = Color(0xFF007BB9);
  static const Color primaryFixed = Color(0xFFCCE5FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryFixed = Color(0xFF001D31);

  static const Color secondary = Color(0xFF006D30);
  static const Color secondaryContainer = Color(0xFF92F5A4);
  static const Color secondaryFixed = Color(0xFF95F8A7);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF007233);
  static const Color onSecondaryFixed = Color(0xFF00210A);

  static const Color tertiary = Color(0xFF7E5223);
  static const Color tertiaryContainer = Color(0xFF9A6A38);
  static const Color tertiaryFixed = Color(0xFFFFDCBE);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryFixed = Color(0xFF2C1600);

  static const Color onSurface = Color(0xFF1C1C17);
  static const Color onSurfaceVariant = Color(0xFF3F4850);
  static const Color outline = Color(0xFF707881);
  static const Color outlineVariant = Color(0xFFBFC7D2);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
}

class EarthTreeTheme {
  static const String fontSans = 'Plus Jakarta Sans';
  static const String fontSerif = 'Merriweather';

  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: EarthTreeColors.surface,
      colorScheme: ColorScheme.light(
        surface: EarthTreeColors.surface,
        onSurface: EarthTreeColors.onSurface,
        onSurfaceVariant: EarthTreeColors.onSurfaceVariant,
        primary: EarthTreeColors.primary,
        onPrimary: EarthTreeColors.onPrimary,
        primaryContainer: EarthTreeColors.primaryContainer,
        secondary: EarthTreeColors.secondary,
        onSecondary: EarthTreeColors.onSecondary,
        secondaryContainer: EarthTreeColors.secondaryContainer,
        tertiary: EarthTreeColors.tertiary,
        onTertiary: EarthTreeColors.onTertiary,
        error: EarthTreeColors.error,
        onError: EarthTreeColors.onError,
        outline: EarthTreeColors.outline,
        outlineVariant: EarthTreeColors.outlineVariant,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: fontSerif,
          fontSize: 32,
          height: 1.3,
          fontWeight: FontWeight.w700,
          color: EarthTreeColors.onSurface,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontSerif,
          fontSize: 24,
          height: 1.33,
          fontWeight: FontWeight.w700,
          color: EarthTreeColors.onSurface,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontSerif,
          fontSize: 20,
          height: 1.4,
          fontWeight: FontWeight.w600,
          color: EarthTreeColors.onSurface,
        ),
        titleMedium: TextStyle(
          fontFamily: fontSans,
          fontSize: 18,
          height: 1.44,
          fontWeight: FontWeight.w600,
          color: EarthTreeColors.onSurface,
        ),
        titleSmall: TextStyle(
          fontFamily: fontSans,
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w600,
          color: EarthTreeColors.onSurface,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontSans,
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w400,
          color: EarthTreeColors.onSurface,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          height: 1.5,
          fontWeight: FontWeight.w400,
          color: EarthTreeColors.onSurface,
        ),
        bodySmall: TextStyle(
          fontFamily: fontSans,
          fontSize: 12,
          height: 1.4,
          fontWeight: FontWeight.w400,
          color: EarthTreeColors.onSurfaceVariant,
        ),
        labelLarge: TextStyle(
          fontFamily: fontSans,
          fontSize: 14,
          height: 1.42,
          fontWeight: FontWeight.w600,
          color: EarthTreeColors.onSurface,
        ),
        labelSmall: TextStyle(
          fontFamily: fontSans,
          fontSize: 11,
          height: 1.45,
          fontWeight: FontWeight.w500,
          color: EarthTreeColors.onSurfaceVariant,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
    );
  }
}
