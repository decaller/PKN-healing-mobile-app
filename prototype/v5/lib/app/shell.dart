import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../core/theme/theme_extensions.dart';
import '../features/charts/presentation/screens/chart_testbed_screen.dart';
import '../features/daily_task/presentation/screens/daily_task_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/relations/presentation/screens/relations_progress_screen.dart';
import '../features/sanctuary/presentation/screens/ai_sanctuary_screen.dart';

class AppShell extends StatefulWidget {
  final VoidCallback? onToggleTheme;

  const AppShell({super.key, this.onToggleTheme});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return PopScope<void>(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentIndex != 0) {
          setState(() => _currentIndex = 0);
        }
      },
      child: Scaffold(
      backgroundColor: colors.surface,
      body: Stack(
        children: [
          // Screen View
          IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(onSwitchTheme: widget.onToggleTheme),
              DailyTaskScreen(
                onBack: () => setState(() => _currentIndex = 0),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 72 + MediaQuery.of(context).padding.bottom),
                child: AiSanctuaryScreen(
                  onBack: () => setState(() => _currentIndex = 0),
                ),
              ),
              ChartTestbedScreen(
                onBack: () => setState(() => _currentIndex = 0),
              ),
              RelationsProgressScreen(
                onBack: () => setState(() => _currentIndex = 0),
              ),
            ],
          ),

          // Floating Frosted Glass Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom > 0
                        ? MediaQuery.of(context).padding.bottom
                        : 12,
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: context.isDark ? 0.85 : 0.88),
                    border: Border(
                      top: BorderSide(color: colors.tactileBorder, width: 1),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0C2C2825),
                        offset: Offset(0, -2),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(0, "Beranda", iconoir.Home(width: 22, height: 22, color: _getNavColor(0))),
                      _buildNavItem(1, "Amanah", iconoir.CheckCircle(width: 22, height: 22, color: _getNavColor(1))),
                      _buildNavItem(2, "Curhat AI", iconoir.Voice(width: 22, height: 22, color: _getNavColor(2))),
                      _buildNavItem(3, "Lab Chart", iconoir.StatsReport(width: 22, height: 22, color: _getNavColor(3))),
                      _buildNavItem(4, "Relasi", iconoir.Community(width: 22, height: 22, color: _getNavColor(4)), badgeText: "3"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Color _getNavColor(int index) {
    final colors = context.earthTree;
    return _currentIndex == index ? colors.meadowCanopy : colors.textMuted;
  }

  Widget _buildNavItem(int index, String label, Widget icon, {String? badgeText}) {
    final colors = context.earthTree;
    final isSelected = _currentIndex == index;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      onTap: () => setState(() => _currentIndex = index),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _currentIndex = index),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                child: icon,
              ),
              if (badgeText != null)
                Positioned(
                  top: -2,
                  right: -4,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: colors.meadowCanopy,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: colors.onMeadowCanopy,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? colors.meadowCanopy : colors.textMuted,
            ),
          ),
        ],
      ),
    ),
  ),
);
  }
}
