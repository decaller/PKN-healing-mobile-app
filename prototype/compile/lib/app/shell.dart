import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../core/config/feature_flags.dart';
import '../core/theme/theme_extensions.dart';
import '../features/curhat_ai/presentation/screens/curhat_ai_screen.dart';
import '../features/daily_task/presentation/screens/daily_task_screen.dart';
import '../features/developer/feature_flags_screen.dart';
import '../features/events/presentation/screens/events_list_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/knowledge/presentation/screens/knowledge_screen.dart';
import '../features/lessons/presentation/screens/lessons_list_screen.dart';
import '../features/relations/presentation/screens/relations_progress_screen.dart';

class AppShell extends ConsumerStatefulWidget {
  final VoidCallback? onToggleTheme;

  const AppShell({super.key, this.onToggleTheme});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final flags = ref.watch(featureFlagsProvider);

    // Hitung destinasi navigasi aktif secara dinamis berdasarkan FeatureFlags
    final List<_NavDestination> destinations = [
      _NavDestination(
        id: 'home',
        label: "Beranda",
        icon: (color) => iconoir.Home(width: 22, height: 22, color: color),
        screen: HomeScreen(onSwitchTheme: widget.onToggleTheme),
      ),
      if (flags.enableKnowledgeWiki)
        _NavDestination(
          id: 'knowledge',
          label: "Khazanah",
          icon: (color) => iconoir.Book(width: 22, height: 22, color: color),
          screen: KnowledgeScreen(
            onBack: () => setState(() => _currentIndex = 0),
          ),
        ),
      if (flags.enableEvents)
        _NavDestination(
          id: 'events',
          label: "Agenda",
          icon: (color) =>
              iconoir.Calendar(width: 22, height: 22, color: color),
          screen: EventsListScreen(
            onBack: () => setState(() => _currentIndex = 0),
          ),
        ),
      if (flags.enableCurhatAi)
        _NavDestination(
          id: 'curhat',
          label: "Curhat AI",
          icon: (color) =>
              iconoir.ChatBubble(width: 22, height: 22, color: color),
          screen: CurhatAiScreen(
            onBack: () => setState(() => _currentIndex = 0),
          ),
        ),
      if (flags.enableDailyTask)
        _NavDestination(
          id: 'task',
          label: "Amanah",
          icon: (color) =>
              iconoir.CheckCircle(width: 22, height: 22, color: color),
          screen: DailyTaskScreen(
            onBack: () => setState(() => _currentIndex = 0),
          ),
        )
      else if (flags.enableRelationsProgress)
        _NavDestination(
          id: 'relations',
          label: "Relasi",
          icon: (color) =>
              iconoir.Community(width: 22, height: 22, color: color),
          screen: RelationsProgressScreen(
            onBack: () => setState(() => _currentIndex = 0),
          ),
        )
      else if (flags.enablePrimerLessons)
        _NavDestination(
          id: 'lessons',
          label: "Belajar",
          icon: (color) =>
              iconoir.Bookmark(width: 22, height: 22, color: color),
          screen: LessonsListScreen(
            onBack: () => setState(() => _currentIndex = 0),
          ),
        ),
      // Jika semua fitur opsional mati, sediakan tab Modul agar navigasi tetap seimbang
      if (destinations_length(flags) == 1)
        _NavDestination(
          id: 'modules',
          label: "Modul",
          icon: (color) =>
              iconoir.Settings(width: 22, height: 22, color: color),
          screen: const FeatureFlagsScreen(),
        ),
    ];

    // Jamin index selalu berada dalam batas valid
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
      child: Scaffold(
        backgroundColor: colors.surface,
        body: Stack(
          children: [
            // Konten Layar Aktif
            IndexedStack(
              index: _currentIndex,
              children: destinations.map((d) => d.screen).toList(),
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
                      color: colors.surface.withValues(
                          alpha: context.isDark ? 0.85 : 0.88),
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
                            ? colors.meadowCanopy
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
                                          ? FontWeight.bold
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
    );
  }

  int destinations_length(FeatureFlagsConfig flags) {
    int count = 1;
    if (flags.enableKnowledgeWiki) count++;
    if (flags.enableEvents) count++;
    if (flags.enableCurhatAi) count++;
    if (flags.enableDailyTask ||
        flags.enableRelationsProgress ||
        flags.enablePrimerLessons) count++;
    return count;
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
