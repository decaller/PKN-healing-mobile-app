import 'package:flutter/material.dart';

/// PKN Design System Layout & Spacing Tokens
/// Based on 8-point spatial grid system & WCAG 2.1 AA accessibility standards.
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
  static const double pill = 20.0;
  static const double lg = 24.0;
  static const double sheet = 28.0;

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
