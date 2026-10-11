import 'package:forui/forui.dart';
import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/typography.dart';
import '../../app/theme/pkn_tokens.dart';

/// Earth-Tree customization of the Forui CLI blue theme.
/// Shared application tokens keep native and Forui widgets in sync.
final earthTreeLight = _theme(Brightness.light);
final earthTreeDark = _theme(Brightness.dark);

FThemeData _theme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final colors = FColors(
    brightness: brightness,
    barrier: const Color(0xA6161A1D),
    background: dark ? AppColors.darkBackground : AppColors.lightBackground,
    foreground: dark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
    primary: dark ? AppColors.darkPrimary : AppColors.lightPrimary,
    primaryForeground: dark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
    secondary: dark ? AppColors.darkSecondary : AppColors.lightSecondary,
    secondaryForeground: dark ? const Color(0xFF00210A) : Colors.white,
    muted: dark ? AppColors.darkSurface : AppColors.lightSurface,
    mutedForeground: dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    destructive: dark ? AppColors.darkError : AppColors.lightError,
    destructiveForeground: dark ? const Color(0xFF690005) : Colors.white,
    error: dark ? AppColors.darkError : AppColors.lightError,
    errorForeground: dark ? const Color(0xFF690005) : Colors.white,
    border: dark ? AppColors.darkBorder : AppColors.lightBorder,
  );
  final text = AppTypography.textTheme(dark);
  final typography = FTypography(
    xs: text.labelSmall!, sm: text.bodySmall!, base: text.bodyMedium!,
    lg: text.bodyLarge!, xl: text.headlineSmall!, xl2: text.headlineMedium!,
    defaultFontFamily: text.bodyMedium!.fontFamily!,
    xl3: text.headlineLarge!, xl4: text.displaySmall!, xl5: text.displayMedium!,
    xl6: text.displayLarge!, xl7: text.displayLarge!, xl8: text.displayLarge!,
  );
  return FThemeData(colors: colors, typography: typography, style: FStyle(
    formFieldStyle: FFormFieldStyle.inherit(colors: colors, typography: typography),
    focusedOutlineStyle: FFocusedOutlineStyle(color: colors.primary, borderRadius: PknRadius.roundedSm),
    iconStyle: IconThemeData(color: colors.primary, size: 20),
    tappableStyle: FTappableStyle(),
    borderRadius: const FLerpBorderRadius.all(Radius.circular(PknRadius.sm), min: PknRadius.lg),
    borderWidth: 1,
    pagePadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    shadow: const [BoxShadow(color: Color(0x0A2C2825), offset: Offset(0, 8), blurRadius: 24, spreadRadius: -6)],
  ));
}
