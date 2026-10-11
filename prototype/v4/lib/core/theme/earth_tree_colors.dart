import 'package:flutter/material.dart';

/// Token warna resmi spesifikasi Earth-Tree (prototype/v2/design/earth_tree/DESIGN.md)
/// Diimplementasikan sebagai ThemeExtension agar type-safe dan mendukung animasi lerp.
@immutable
class EarthTreeColors extends ThemeExtension<EarthTreeColors> {
  final Color surface;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color celestialSky;
  final Color onCelestialSky;
  final Color celestialSkyContainer;
  final Color meadowCanopy;
  final Color onMeadowCanopy;
  final Color meadowCanopyContainer;
  final Color ancientBark;
  final Color onAncientBark;
  final Color ancientBarkContainer;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color tactileBorder;
  final Color tactileBorderFocus;
  final Color error;
  final Color errorContainer;

  const EarthTreeColors({
    required this.surface,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.celestialSky,
    required this.onCelestialSky,
    required this.celestialSkyContainer,
    required this.meadowCanopy,
    required this.onMeadowCanopy,
    required this.meadowCanopyContainer,
    required this.ancientBark,
    required this.onAncientBark,
    required this.ancientBarkContainer,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.tactileBorder,
    required this.tactileBorderFocus,
    required this.error,
    required this.errorContainer,
  });

  /// Mode Terang (Warm Sand-Ecru / River Stone / Milled Limestone)
  static const light = EarthTreeColors(
    surface: Color(0xFFFDF9F0),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF7F3EA),
    surfaceContainer: Color(0xFFF1EDE5),
    surfaceContainerHigh: Color(0xFFECE8DF),
    surfaceContainerHighest: Color(0xFFE6E2DA),
    celestialSky: Color(0xFF006194),
    onCelestialSky: Color(0xFFFFFFFF),
    celestialSkyContainer: Color(0xFFCCE5FF),
    meadowCanopy: Color(0xFF006D30),
    onMeadowCanopy: Color(0xFFFFFFFF),
    meadowCanopyContainer: Color(0xFF92F5A4),
    ancientBark: Color(0xFF7E5223),
    onAncientBark: Color(0xFFFFFFFF),
    ancientBarkContainer: Color(0xFFFFDCBE),
    textPrimary: Color(0xFF1C1C17),
    textSecondary: Color(0xFF3F4850),
    textMuted: Color(0xFF707881),
    tactileBorder: Color(0x2E707881), // 18% opacity
    tactileBorderFocus: Color(0xFF006194),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
  );

  /// Mode Gelap (Deep Igneous Basalt / Mineral Slate / Weathered Granite)
  static const dark = EarthTreeColors(
    surface: Color(0xFF161A1D),
    surfaceContainerLowest: Color(0xFF121517),
    surfaceContainerLow: Color(0xFF1E2328),
    surfaceContainer: Color(0xFF262D34),
    surfaceContainerHigh: Color(0xFF2E363E),
    surfaceContainerHighest: Color(0xFF38404A),
    celestialSky: Color(0xFF93CCFF),
    onCelestialSky: Color(0xFF001D31),
    celestialSkyContainer: Color(0xFF004B73),
    meadowCanopy: Color(0xFF79DB8D),
    onMeadowCanopy: Color(0xFF00210A),
    meadowCanopyContainer: Color(0xFF005323),
    ancientBark: Color(0xFFF6BB81),
    onAncientBark: Color(0xFF2C1600),
    ancientBarkContainer: Color(0xFF663E0F),
    textPrimary: Color(0xFFEFECE6),
    textSecondary: Color(0xFFD3CEC4),
    textMuted: Color(0xFF8C939A),
    tactileBorder: Color(0x47707881), // 28% opacity
    tactileBorderFocus: Color(0xFF93CCFF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
  );

  @override
  EarthTreeColors copyWith({
    Color? surface,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? celestialSky,
    Color? onCelestialSky,
    Color? celestialSkyContainer,
    Color? meadowCanopy,
    Color? onMeadowCanopy,
    Color? meadowCanopyContainer,
    Color? ancientBark,
    Color? onAncientBark,
    Color? ancientBarkContainer,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? tactileBorder,
    Color? tactileBorderFocus,
    Color? error,
    Color? errorContainer,
  }) {
    return EarthTreeColors(
      surface: surface ?? this.surface,
      surfaceContainerLowest: surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest ?? this.surfaceContainerHighest,
      celestialSky: celestialSky ?? this.celestialSky,
      onCelestialSky: onCelestialSky ?? this.onCelestialSky,
      celestialSkyContainer: celestialSkyContainer ?? this.celestialSkyContainer,
      meadowCanopy: meadowCanopy ?? this.meadowCanopy,
      onMeadowCanopy: onMeadowCanopy ?? this.onMeadowCanopy,
      meadowCanopyContainer: meadowCanopyContainer ?? this.meadowCanopyContainer,
      ancientBark: ancientBark ?? this.ancientBark,
      onAncientBark: onAncientBark ?? this.onAncientBark,
      ancientBarkContainer: ancientBarkContainer ?? this.ancientBarkContainer,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      tactileBorder: tactileBorder ?? this.tactileBorder,
      tactileBorderFocus: tactileBorderFocus ?? this.tactileBorderFocus,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
    );
  }

  @override
  EarthTreeColors lerp(ThemeExtension<EarthTreeColors>? other, double t) {
    if (other is! EarthTreeColors) return this;
    return EarthTreeColors(
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceContainerLowest: Color.lerp(surfaceContainerLowest, other.surfaceContainerLowest, t)!,
      surfaceContainerLow: Color.lerp(surfaceContainerLow, other.surfaceContainerLow, t)!,
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      surfaceContainerHigh: Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      surfaceContainerHighest: Color.lerp(surfaceContainerHighest, other.surfaceContainerHighest, t)!,
      celestialSky: Color.lerp(celestialSky, other.celestialSky, t)!,
      onCelestialSky: Color.lerp(onCelestialSky, other.onCelestialSky, t)!,
      celestialSkyContainer: Color.lerp(celestialSkyContainer, other.celestialSkyContainer, t)!,
      meadowCanopy: Color.lerp(meadowCanopy, other.meadowCanopy, t)!,
      onMeadowCanopy: Color.lerp(onMeadowCanopy, other.onMeadowCanopy, t)!,
      meadowCanopyContainer: Color.lerp(meadowCanopyContainer, other.meadowCanopyContainer, t)!,
      ancientBark: Color.lerp(ancientBark, other.ancientBark, t)!,
      onAncientBark: Color.lerp(onAncientBark, other.onAncientBark, t)!,
      ancientBarkContainer: Color.lerp(ancientBarkContainer, other.ancientBarkContainer, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      tactileBorder: Color.lerp(tactileBorder, other.tactileBorder, t)!,
      tactileBorderFocus: Color.lerp(tactileBorderFocus, other.tactileBorderFocus, t)!,
      error: Color.lerp(error, other.error, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
    );
  }
}
