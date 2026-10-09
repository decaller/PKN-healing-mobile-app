import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_palette.dart';
import 'pkn_tokens.dart';

/// Material roles mapped explicitly to the native design typography specimens.
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

    return TextTheme(
      displayLarge: display,
      displayMedium: display,
      displaySmall: display,
      headlineLarge: display,
      headlineMedium: heading,
      headlineSmall: subhead,
      titleLarge: heading,
      titleMedium: subhead,
      titleSmall: _style(PknTypography.subhead, secondary),
      bodyLarge: body,
      bodyMedium: _style(PknTypography.body, secondary),
      bodySmall: caption,
      labelLarge: subhead,
      labelMedium: caption,
      labelSmall: caption,
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
