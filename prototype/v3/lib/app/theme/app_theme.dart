import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_palette.dart';
import 'typography.dart';
import 'pkn_tokens.dart';

class AppTheme {
  AppTheme._();
  static ThemeData create(Brightness brightness, {TargetPlatform? platform}) {
    final dark = brightness == Brightness.dark;
    final background = dark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = dark ? AppColors.darkSurface : AppColors.lightSurface;
    final elevated = dark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated;
    final border = dark ? AppColors.darkBorder : AppColors.lightBorder;
    final primary = dark ? AppColors.darkPrimary : AppColors.lightPrimary;
    final text = dark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final muted = dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final textTheme = AppTypography.textTheme(dark);
    final scheme = ColorScheme.fromSeed(seedColor: primary, brightness: brightness).copyWith(
      primary: primary, onPrimary: dark ? AppColors.darkOnPrimary : AppColors.lightOnPrimary,
      primaryContainer: dark ? AppColors.darkPrimarySoft : const Color(0xFF007BB9),
      onPrimaryContainer: dark ? const Color(0xFFCCE5FF) : const Color(0xFFFDFCFF),
      secondary: dark ? AppColors.darkSecondary : AppColors.lightSecondary,
      onSecondary: dark ? const Color(0xFF00210A) : Colors.white,
      secondaryContainer: dark ? AppColors.darkSecondaryContainer : AppColors.lightSecondaryContainer,
      onSecondaryContainer: dark ? AppColors.darkOnSecondaryContainer : AppColors.lightOnSecondaryContainer,
      tertiary: dark ? AppColors.darkTertiary : AppColors.lightTertiary,
      onTertiary: dark ? const Color(0xFF2C1600) : Colors.white,
      tertiaryContainer: dark ? const Color(0xFF663E0F) : const Color(0xFF9A6A38),
      onTertiaryContainer: dark ? const Color(0xFFFFDCBE) : const Color(0xFFFFFBFF),
      surface: background, onSurface: text, onSurfaceVariant: muted,
      surfaceDim: dark ? background : const Color(0xFFDDDAD1),
      surfaceBright: dark ? elevated : background,
      surfaceContainerLowest: dark ? background : Colors.white,
      surfaceContainerLow: surface,
      surfaceContainer: dark ? surface : const Color(0xFFF1EDE5),
      surfaceContainerHigh: dark ? elevated : const Color(0xFFECE8DF),
      surfaceContainerHighest: elevated,
      outline: dark ? const Color(0xFF76746D) : const Color(0xFF707881),
      outlineVariant: border,
      inverseSurface: dark ? const Color(0xFFF4F0E8) : const Color(0xFF31302B),
      onInverseSurface: dark ? const Color(0xFF31302B) : const Color(0xFFF4F0E8),
      inversePrimary: dark ? AppColors.lightPrimary : AppColors.darkPrimary,
      surfaceTint: dark ? primary : const Color(0xFF006398),
      error: dark ? AppColors.darkError : AppColors.lightError,
      onError: dark ? const Color(0xFF690005) : Colors.white,
      errorContainer: dark ? const Color(0xFF93000A) : const Color(0xFFFFDAD6),
      onErrorContainer: dark ? const Color(0xFFFFDAD6) : const Color(0xFF93000A),
      primaryFixed: const Color(0xFFCCE5FF), primaryFixedDim: const Color(0xFF93CCFF),
      onPrimaryFixed: const Color(0xFF001D31), onPrimaryFixedVariant: const Color(0xFF004B73),
      secondaryFixed: const Color(0xFF95F8A7), secondaryFixedDim: const Color(0xFF79DB8D),
      onSecondaryFixed: const Color(0xFF00210A), onSecondaryFixedVariant: const Color(0xFF005323),
      tertiaryFixed: const Color(0xFFFFDCBE), tertiaryFixedDim: const Color(0xFFF6BB81),
      onTertiaryFixed: const Color(0xFF2C1600), onTertiaryFixedVariant: const Color(0xFF663E0F),
    );
    final buttonShape = RoundedRectangleBorder(borderRadius: PknRadius.roundedSm);
    final inputBorder = OutlineInputBorder(borderRadius: PknRadius.roundedSm, borderSide: BorderSide(color: border, width: 1.5));
    return ThemeData(
      useMaterial3: true, brightness: brightness, platform: platform,
      scaffoldBackgroundColor: background, colorScheme: scheme, textTheme: textTheme,
      cupertinoOverrideTheme: CupertinoThemeData(brightness: brightness,
        primaryColor: primary, primaryContrastingColor: scheme.onPrimary,
        scaffoldBackgroundColor: background, barBackgroundColor: surface,
        textTheme: CupertinoTextThemeData(primaryColor: primary,
          textStyle: textTheme.bodyMedium!, navTitleTextStyle: textTheme.titleMedium!,
          navLargeTitleTextStyle: textTheme.headlineLarge!,
          pickerTextStyle: textTheme.bodyLarge!, dateTimePickerTextStyle: textTheme.bodyLarge!,
          tabLabelTextStyle: textTheme.labelSmall!,
          actionTextStyle: textTheme.labelLarge!.copyWith(color: primary))),
      cardTheme: CardTheme(color: surface, elevation: 0, margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: PknRadius.roundedCard, side: BorderSide(color: border))),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: primary, foregroundColor: scheme.onPrimary, elevation: 0,
        minimumSize: const Size(48, 48), shape: buttonShape, textStyle: textTheme.labelLarge)),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(shape: buttonShape, minimumSize: const Size(48, 48), textStyle: textTheme.labelLarge)),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(shape: buttonShape,
        minimumSize: const Size(48, 48), side: BorderSide(color: border), textStyle: textTheme.labelLarge)),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(shape: buttonShape, minimumSize: const Size(48, 48), textStyle: textTheme.labelLarge)),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: surface,
        border: inputBorder, enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(borderSide: BorderSide(color: primary, width: 1.5)),
        contentPadding: const EdgeInsets.all(12)),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: elevated,
        shape: const RoundedRectangleBorder(borderRadius: PknRadius.roundedSheet)),
      dialogTheme: DialogTheme(backgroundColor: elevated,
        shape: const RoundedRectangleBorder(borderRadius: PknRadius.roundedLg)),
      checkboxTheme: CheckboxThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? scheme.secondary : null)),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? scheme.secondary : null)),
      switchTheme: SwitchThemeData(trackColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? scheme.secondary : null)),
      appBarTheme: AppBarTheme(backgroundColor: background, surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleMedium, elevation: 0, scrolledUnderElevation: 0, centerTitle: false,
        systemOverlayStyle: dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: surface,
        selectedItemColor: primary, unselectedItemColor: muted, type: BottomNavigationBarType.fixed),
      navigationBarTheme: NavigationBarThemeData(backgroundColor: surface),
      chipTheme: ChipThemeData(backgroundColor: elevated,
        selectedColor: dark ? AppColors.darkPrimarySoft : AppColors.lightPrimarySoft,
        side: BorderSide(color: border), shape: const StadiumBorder(), labelStyle: textTheme.labelMedium),
      dividerColor: border, dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
    );
  }
}
