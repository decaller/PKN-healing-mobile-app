import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_palette.dart';
import 'pkn_tokens.dart';

/// Earth-Tree roles loaded through the existing Google Fonts mechanism.
class AppTypography {
  AppTypography._();

  static TextStyle _style(PknTextToken token, Color? color) {
    return GoogleFonts.getFont(
      token.fontFamily,
      fontSize: token.fontSize,
      fontWeight: token.fontWeight,
      height: token.height,
      letterSpacing: token.letterSpacing,
      color: color,
    );
  }

  static TextTheme textTheme(bool isDark) {
    final primary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final secondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final display = _style(PknTypography.display, primary);
    final heading = _style(PknTypography.heading, primary);
    final subhead = _style(PknTypography.subhead, primary);
    final body = _style(PknTypography.body, primary);
    final caption = _style(PknTypography.caption, secondary);

    TextStyle headingStyle(double size, double lineHeight, FontWeight weight, {double spacing = 0}) =>
      GoogleFonts.merriweather(color: primary, fontSize: size, height: lineHeight / size,
        fontWeight: weight, letterSpacing: spacing);
    return TextTheme(
      displayLarge: headingStyle(56, 68, FontWeight.w700, spacing: -1.12),
      displayMedium: headingStyle(40, 52, FontWeight.w700, spacing: -0.6),
      displaySmall: display,
      headlineLarge: headingStyle(32, 42, FontWeight.w400, spacing: -0.32),
      headlineMedium: heading,
      headlineSmall: headingStyle(20, 28, FontWeight.w400, spacing: 0.1),
      titleLarge: subhead,
      titleMedium: subhead.copyWith(fontSize: 16, height: 1.5, letterSpacing: 0),
      titleSmall: subhead.copyWith(fontSize: 14, height: 20 / 14),
      bodyLarge: body.copyWith(fontSize: 18, height: 28 / 18, letterSpacing: 0),
      bodyMedium: body,
      bodySmall: caption,
      labelLarge: body.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500, letterSpacing: 0.28),
      labelMedium: caption.copyWith(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500, letterSpacing: 0.28),
      labelSmall: caption.copyWith(fontSize: 11, height: 16 / 11, fontWeight: FontWeight.w600, letterSpacing: 0.44),
    );
  }

  /// Uses the native Arabic specimen by default; explicit caller overrides remain supported.
  static TextStyle arabicText({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
  }) {
    return _style(PknTypography.arabic, color).copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }
}
