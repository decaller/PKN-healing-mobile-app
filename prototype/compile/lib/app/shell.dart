import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../core/theme/theme_extensions.dart';
import '../features/events/presentation/screens/events_list_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/mitra/presentation/screens/mitra_hub_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/pustaka/presentation/screens/pustaka_list_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  final VoidCallback? onToggleTheme;

  const AppShell({super.key, this.onToggleTheme});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _currentIndex = 0;
  int _mitraInitialTab = 0;

  void _switchTab(int index, {int mitraSubTab = 0}) {
    setState(() {
      _currentIndex = index;
      _mitraInitialTab = mitraSubTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    // Destinasi 5 Tab Kanonikal Milestone 1
    final List<_NavDestination> destinations = [
      _NavDestination(
        id: 'home',
        label: "Beranda",
        icon: (color) => iconoir.Home(width: 22, height: 22, color: color),
        screen: HomeScreen(
          onSwitchTheme: widget.onToggleTheme,
          onOpenEvents: () => _switchTab(1),
          onOpenPustaka: () => _switchTab(2),
          onOpenMitra: (subTab) => _switchTab(3, mitraSubTab: subTab),
          onOpenProfile: () => _switchTab(4),
        ),
      ),
      _NavDestination(
        id: 'events',
        label: "Agenda",
        icon: (color) => iconoir.Calendar(width: 22, height: 22, color: color),
        screen: EventsListScreen(
          onBack: () => _switchTab(0),
        ),
      ),
      _NavDestination(
        id: 'pustaka',
        label: "Pustaka",
        icon: (color) => iconoir.Book(width: 22, height: 22, color: color),
        screen: PustakaListScreen(
          onBack: () => _switchTab(0),
        ),
      ),
      _NavDestination(
        id: 'mitra',
        label: "Mitra",
        icon: (color) => iconoir.Community(width: 22, height: 22, color: color),
        screen: MitraHubScreen(
          key: ValueKey<int>(_mitraInitialTab),
          onBack: () => _switchTab(0),
          initialTabIndex: _mitraInitialTab,
        ),
      ),
      _NavDestination(
        id: 'profile',
        label: "Profil",
        icon: (color) => iconoir.User(width: 22, height: 22, color: color),
        screen: ProfileScreen(
          onToggleTheme: widget.onToggleTheme,
          onBack: () => _switchTab(0),
        ),
      ),
    ];

    if (_currentIndex >= destinations.length) {
      _currentIndex = 0;
    }

    return PopScope<void>(
      canPop: _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _currentIndex != 0) {
          setState(() => _currentIndex = 0);
        }
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Scaffold(
            backgroundColor: colors.surface,
            body: Stack(
              children: [
                // Active Screen View
                IndexedStack(
                  index: _currentIndex,
                  children: destinations.map((d) => d.screen).toList(),
                ),

                // Floating Frosted Acrylic Navigation Bar (5 Tab)
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
                              : 10,
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          color: colors.surface.withValues(
                            alpha: context.isDark ? 0.88 : 0.90,
                          ),
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
                          children: List.generate(destinations.length, (idx) {
                            final dest = destinations[idx];
                            final isSelected = _currentIndex == idx;
                            final itemColor = isSelected
                                ? const Color(0xFF235347)
                                : colors.textMuted;

                            return Semantics(
                              button: true,
                              selected: isSelected,
                              label: dest.label,
                              onTap: () => setState(() => _currentIndex = idx),
                              excludeSemantics: true,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => setState(() => _currentIndex = idx),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 48,
                                    minHeight: 48,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      dest.icon(itemColor),
                                      const SizedBox(height: 2),
                                      Text(
                                        dest.label,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: isSelected
                                              ? FontWeight.w800
                                              : FontWeight.w500,
                                          color: itemColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavDestination {
  final String id;
  final String label;
  final Widget Function(Color color) icon;
  final Widget screen;

  _NavDestination({
    required this.id,
    required this.label,
    required this.icon,
    required this.screen,
  });
}
