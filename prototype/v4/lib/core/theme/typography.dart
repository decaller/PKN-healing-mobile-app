import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Skala Tipografi resmi Earth-Tree (Merriweather Serif + Plus Jakarta Sans)
class EarthTreeTypography {
  EarthTreeTypography._();

  static TextTheme createTextTheme(Color primaryText, Color secondaryText) {
    return TextTheme(
      // Display: Merriweather 700
      displayLarge: GoogleFonts.merriweather(
        fontSize: 38,
        fontWeight: FontWeight.w700,
        height: 48 / 38,
        letterSpacing: -0.57,
        color: primaryText,
      ),
      displayMedium: GoogleFonts.merriweather(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 40 / 30,
        letterSpacing: -0.3,
        color: primaryText,
      ),
      displaySmall: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
        letterSpacing: 0,
        color: primaryText,
      ),

      // Headings: Merriweather 700 / 400
      headlineLarge: GoogleFonts.merriweather(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
        letterSpacing: 0,
        color: primaryText,
      ),
      headlineMedium: GoogleFonts.merriweather(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 28 / 20,
        letterSpacing: 0.1,
        color: primaryText,
      ),
      headlineSmall: GoogleFonts.merriweather(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
        letterSpacing: 0,
        color: primaryText,
      ),

      // Titles: Plus Jakarta Sans 600
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 26 / 18,
        letterSpacing: -0.09,
        color: primaryText,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 24 / 16,
        letterSpacing: 0,
        color: primaryText,
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0,
        color: primaryText,
      ),

      // Body: Plus Jakarta Sans 400
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 28 / 18,
        letterSpacing: 0,
        color: primaryText,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 24 / 15,
        letterSpacing: 0.075,
        color: primaryText,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 20 / 13,
        letterSpacing: 0.13,
        color: secondaryText,
      ),

      // Labels: Plus Jakarta Sans 500 / 600
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.28,
        color: primaryText,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 18 / 12,
        letterSpacing: 0.24,
        color: secondaryText,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 16 / 11,
        letterSpacing: 0.44, // Expanded tracking for pill chips
        color: secondaryText,
      ),
    );
  }
}
