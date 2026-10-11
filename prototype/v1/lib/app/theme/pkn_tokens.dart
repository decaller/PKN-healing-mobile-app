import 'package:flutter/material.dart';

// Earth-Tree typography; Arabic content retains the Amiri specimen.
class PknTextToken {
  const PknTextToken({required this.fontFamily, required this.fontSize,
    required this.fontWeight, required this.lineHeight, required this.letterSpacing});
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final double lineHeight;
  final double letterSpacing;
  double get height => lineHeight / fontSize;
}

class PknTypography {
  PknTypography._();
  static const display = PknTextToken(fontFamily: 'Merriweather', fontSize: 38, fontWeight: FontWeight.w700, lineHeight: 48, letterSpacing: -0.57);
  static const heading = PknTextToken(fontFamily: 'Merriweather', fontSize: 24, fontWeight: FontWeight.w700, lineHeight: 32, letterSpacing: 0);
  static const subhead = PknTextToken(fontFamily: 'Plus Jakarta Sans', fontSize: 18, fontWeight: FontWeight.w600, lineHeight: 26, letterSpacing: -0.09);
  static const body = PknTextToken(fontFamily: 'Plus Jakarta Sans', fontSize: 15, fontWeight: FontWeight.w400, lineHeight: 24, letterSpacing: 0.075);
  static const caption = PknTextToken(fontFamily: 'Plus Jakarta Sans', fontSize: 13, fontWeight: FontWeight.w400, lineHeight: 20, letterSpacing: 0.13);
  static const arabic = PknTextToken(fontFamily: 'Amiri', fontSize: 28.0, fontWeight: FontWeight.w400, lineHeight: 48.0, letterSpacing: 0.0);
}

/// PKN Design System Layout & Spacing Tokens
/// Earth-Tree spacing and accessible touch targets.
class PknSpacing {
  PknSpacing._();

  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;

  // Minimum Touch Target Dimension (WCAG 2.1 AA standard)
  static const double minTouchTarget = 48.0;
}

class PknRadius {
  PknRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double card = 16.0;
  static const double pill = 9999.0;
  static const double lg = 24.0;
  static const double sheet = 24.0;

  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius roundedCard = BorderRadius.all(Radius.circular(card));
  static const BorderRadius roundedPill = BorderRadius.all(Radius.circular(pill));
  static const BorderRadius roundedLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius roundedSheet = BorderRadius.vertical(top: Radius.circular(sheet));
}

class PknElevation {
  PknElevation._();

  static const double none = 0.0;
  static const double low = 2.0;
  static const double medium = 4.0;
  static const double high = 8.0;

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];
}

class PknDurations {
  PknDurations._();

  static const Duration quick = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}
