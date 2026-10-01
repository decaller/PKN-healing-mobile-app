// ==============================================================================
// CONCEPTING PHASE: ROUTING BLUEPRINT
// ------------------------------------------------------------------------------
// This router defines the navigation shell, deep-linking contracts, and route
// boundaries for the microlearning experience (Onboarding -> Shell -> Player).
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/storage/storage_service.dart';
import '../../features/feed/presentation/screens/feed_screen.dart';
import '../../features/lessons/data/mock_lessons.dart';
import '../../features/lessons/presentation/screens/lesson_player_screen.dart';
import '../../features/lessons/presentation/screens/lessons_list_screen.dart';
import '../../features/onboarding/presentation/screens/activational_insight_screen.dart';
import '../../features/onboarding/presentation/screens/jtbd_flow_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import 'route_paths.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final storageService = ref.watch(storageServiceProvider);

  return GoRouter(
    initialLocation: storageService.isOnboardingCompleted
        ? RoutePaths.feed
        : RoutePaths.onboarding,
    routes: [
      // Onboarding diagnostic & activational card (Outside bottom nav shell)
      GoRoute(
        path: RoutePaths.onboarding,
        builder: (context, state) => const JTBDFlowScreen(),
      ),
      GoRoute(
        path: RoutePaths.activationalInsight,
        builder: (context, state) => const ActivationalInsightScreen(),
      ),

      // Fullscreen Lesson Player (Outside bottom nav shell)
      GoRoute(
        path: RoutePaths.lessonPlayer,
        builder: (context, state) {
          final lessonId = state.pathParameters['id'] ?? '';
          final lesson = MockLessonsRepository.lessons.firstWhere(
            (l) => l.lessonId == lessonId,
            orElse: () => MockLessonsRepository.lessons.first,
          );
          return LessonPlayerScreen(lesson: lesson);
        },
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) {
          return _AppNavigationScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.feed,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FeedScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.lessons,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LessonsListScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});

class _AppNavigationScaffold extends StatelessWidget {
  final Widget child;

  const _AppNavigationScaffold({required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(RoutePaths.lessons)) return 1;
    if (location.startsWith(RoutePaths.profile)) return 2;
    return 0; // Default to Feed
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RoutePaths.feed);
        break;
      case 1:
        context.go(RoutePaths.lessons);
        break;
      case 2:
        context.go(RoutePaths.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (idx) => _onItemTapped(idx, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.style_outlined),
            selectedIcon: Icon(Icons.style_rounded),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline_rounded),
            selectedIcon: Icon(Icons.play_circle_fill_rounded),
            label: 'Lessons',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
