import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_prototype_v4/core/theme/earth_tree_colors.dart';

double _linearize(double component) {
  if (component <= 0.03928) {
    return component / 12.92;
  }
  return pow((component + 0.055) / 1.055, 2.4).toDouble();
}

double _luminance(Color color) {
  final r = _linearize(color.r);
  final g = _linearize(color.g);
  final b = _linearize(color.b);
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

double _contrastRatio(Color c1, Color c2) {
  final l1 = _luminance(c1);
  final l2 = _luminance(c2);
  final lighter = max(l1, l2);
  final darker = min(l1, l2);
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  group('EarthTree Theme Contrast Ratio (WCAG)', () {
    test('Light theme tokens satisfy minimum contrast', () {
      final c = EarthTreeColors.light;

      // Surface text contrast (WCAG AAA >= 7.0, AA >= 4.5)
      final primaryTextRatio = _contrastRatio(c.surface, c.textPrimary);
      final secondaryTextRatio = _contrastRatio(c.surface, c.textSecondary);
      expect(primaryTextRatio, greaterThanOrEqualTo(7.0),
          reason: 'textPrimary on surface must achieve AAA');
      expect(secondaryTextRatio, greaterThanOrEqualTo(4.5),
          reason: 'textSecondary on surface must achieve AA');

      // Accent button pairings (>= 4.5:1)
      expect(_contrastRatio(c.celestialSky, c.onCelestialSky), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.meadowCanopy, c.onMeadowCanopy), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.ancientBark, c.onAncientBark), greaterThanOrEqualTo(4.5));

      // Container pairings (>= 4.5:1)
      expect(_contrastRatio(c.celestialSkyContainer, c.onCelestialSkyContainer), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.meadowCanopyContainer, c.onMeadowCanopyContainer), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.ancientBarkContainer, c.onAncientBarkContainer), greaterThanOrEqualTo(4.5));

      // Error pairings
      expect(_contrastRatio(c.error, c.onError), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.errorContainer, c.onErrorContainer), greaterThanOrEqualTo(4.5));
    });

    test('Dark theme tokens satisfy minimum contrast', () {
      final c = EarthTreeColors.dark;

      // Surface text contrast
      final primaryTextRatio = _contrastRatio(c.surface, c.textPrimary);
      final secondaryTextRatio = _contrastRatio(c.surface, c.textSecondary);
      expect(primaryTextRatio, greaterThanOrEqualTo(7.0),
          reason: 'textPrimary on surface must achieve AAA in dark mode');
      expect(secondaryTextRatio, greaterThanOrEqualTo(4.5),
          reason: 'textSecondary on surface must achieve AA in dark mode');

      // Accent button pairings (>= 4.5:1)
      expect(_contrastRatio(c.celestialSky, c.onCelestialSky), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.meadowCanopy, c.onMeadowCanopy), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.ancientBark, c.onAncientBark), greaterThanOrEqualTo(4.5));

      // Container pairings (>= 4.5:1)
      expect(_contrastRatio(c.celestialSkyContainer, c.onCelestialSkyContainer), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.meadowCanopyContainer, c.onMeadowCanopyContainer), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.ancientBarkContainer, c.onAncientBarkContainer), greaterThanOrEqualTo(4.5));

      // Error pairings
      expect(_contrastRatio(c.error, c.onError), greaterThanOrEqualTo(4.5));
      expect(_contrastRatio(c.errorContainer, c.onErrorContainer), greaterThanOrEqualTo(4.5));
    });

    test('Demonstrate contrast failure of old mismatched token pairings', () {
      final cLight = EarthTreeColors.light;
      final cDark = EarthTreeColors.dark;

      // Old bug: onMeadowCanopy on meadowCanopyContainer
      final lightMismatch = _contrastRatio(cLight.meadowCanopyContainer, cLight.onMeadowCanopy);
      final darkMismatch = _contrastRatio(cDark.meadowCanopyContainer, cDark.onMeadowCanopy);

      // Pastikan pairing lama memang gagal kontras (< 2.0:1)
      expect(lightMismatch, lessThan(2.0),
          reason: 'White text on light mint container had terrible contrast (~1.3:1)');
      expect(darkMismatch, lessThan(2.0),
          reason: 'Dark green text on dark green container had terrible contrast (~1.2:1)');

      // Bandingkan dengan pairing baru yang fix (>= 7.0:1)
      final lightFixed = _contrastRatio(cLight.meadowCanopyContainer, cLight.onMeadowCanopyContainer);
      final darkFixed = _contrastRatio(cDark.meadowCanopyContainer, cDark.onMeadowCanopyContainer);
      expect(lightFixed, greaterThanOrEqualTo(7.0));
      expect(darkFixed, greaterThanOrEqualTo(6.5));
    });
  });
}
