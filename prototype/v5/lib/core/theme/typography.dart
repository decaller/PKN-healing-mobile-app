import 'package:flutter/material.dart';

/// Skala Tipografi resmi Earth-Tree (Merriweather Serif + Plus Jakarta Sans)
class EarthTreeTypography {
  EarthTreeTypography._();

  static TextTheme createTextTheme(Color primaryText, Color secondaryText) {
    return TextTheme(
      // Display: Merriweather 700
      displayLarge: TextStyle(
        fontFamily: 'Merriweather',
        fontSize: 38,
        fontWeight: FontWeight.w700,
        height: 48 / 38,
        letterSpacing: -0.57,
        color: primaryText,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Merriweather',
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 40 / 30,
        letterSpacing: -0.3,
        color: primaryText,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Merriweather',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
        letterSpacing: 0,
        color: primaryText,
      ),

      // Headings: Merriweather 700 / 400
      headlineLarge: TextStyle(
        fontFamily: 'Merriweather',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
        letterSpacing: 0,
        color: primaryText,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Merriweather',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 28 / 20,
        letterSpacing: 0.1,
        color: primaryText,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Merriweather',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
        letterSpacing: 0,
        color: primaryText,
      ),

      // Titles: Plus Jakarta Sans 600
      titleLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 26 / 18,
        letterSpacing: -0.09,
        color: primaryText,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 24 / 16,
        letterSpacing: 0,
        color: primaryText,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0,
        color: primaryText,
      ),

      // Body: Plus Jakarta Sans 400
      bodyLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        letterSpacing: 0,
        color: primaryText,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 24 / 15,
        letterSpacing: 0.075,
        color: primaryText,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 20 / 13,
        letterSpacing: 0.13,
        color: secondaryText,
      ),

      // Labels: Plus Jakarta Sans 500 / 600
      labelLarge: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.28,
        color: primaryText,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 18 / 12,
        letterSpacing: 0.24,
        color: secondaryText,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 16 / 11,
        letterSpacing: 0.44, // Expanded tracking for pill chips
        color: secondaryText,
      ),
    );
  }
}
