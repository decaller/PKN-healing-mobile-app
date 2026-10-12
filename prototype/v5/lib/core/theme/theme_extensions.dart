import 'package:flutter/material.dart';
import 'earth_tree_colors.dart';
export 'earth_tree_colors.dart';

extension BuildContextEarthTreeX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  bool get isDark => theme.brightness == Brightness.dark;

  /// Akses type-safe ke warna Earth-Tree
  EarthTreeColors get earthTree =>
      theme.extension<EarthTreeColors>() ?? (isDark ? EarthTreeColors.dark : EarthTreeColors.light);

  /// Helper responsif breakpoint mobile
  bool get isCompactMobile => MediaQuery.of(this).size.width < 380;
  double get screenWidth => MediaQuery.of(this).size.width;
}
