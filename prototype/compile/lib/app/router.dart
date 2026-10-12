import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/config/feature_flags.dart';
import '../core/widgets/feature_gate.dart';
import '../features/charts/presentation/screens/chart_testbed_screen.dart';
import '../features/crisis/presentation/screens/p3k_crisis_screen.dart';
import '../features/curhat_ai/presentation/screens/curhat_ai_screen.dart';
import '../features/daily_task/presentation/screens/daily_task_screen.dart';
import '../features/developer/feature_flags_screen.dart';
import '../features/events/presentation/screens/events_list_screen.dart';
import '../features/knowledge/presentation/screens/knowledge_screen.dart';
import '../features/lessons/presentation/screens/lessons_list_screen.dart';
import '../features/relations/presentation/screens/relations_progress_screen.dart';
import '../features/walkie_talkie/presentation/walkie_talkie_screen.dart';
import 'shell.dart';

GoRouter createAppRouter({
  VoidCallback? onToggleTheme,
  required FeatureFlagsConfig flags,
}) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => AppShell(onToggleTheme: onToggleTheme),
      ),
      GoRoute(
        path: '/developer/flags',
        builder: (context, state) => const FeatureFlagsScreen(),
      ),
      GoRoute(
        path: '/curhat',
        builder: (context, state) => flags.enableCurhatAi
            ? CurhatAiScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Teman Curhat AI',
                flagKeyToEnable: 'enableCurhatAi',
              ),
      ),
      GoRoute(
        path: '/walkie-talkie',
        builder: (context, state) => flags.enableWalkieTalkie
            ? WalkieTalkieScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Walkie-Talkie Ruang Qalbu',
                flagKeyToEnable: 'enableWalkieTalkie',
              ),
      ),
      GoRoute(
        path: '/events',
        builder: (context, state) => flags.enableEvents
            ? EventsListScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Agenda & Majelis Parenting',
                flagKeyToEnable: 'enableEvents',
              ),
      ),
      GoRoute(
        path: '/knowledge',
        builder: (context, state) => flags.enableKnowledgeWiki
            ? KnowledgeScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Khazanah Fitrah (Wiki PKN)',
                flagKeyToEnable: 'enableKnowledgeWiki',
              ),
      ),
      GoRoute(
        path: '/lessons',
        builder: (context, state) => flags.enablePrimerLessons
            ? LessonsListScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Micro-Learning Adab',
                flagKeyToEnable: 'enablePrimerLessons',
              ),
      ),
      GoRoute(
        path: '/crisis',
        builder: (context, state) => flags.enableP3kCrisis
            ? const P3kCrisisScreen()
            : const FeatureDisabledScreen(
                featureName: 'P3K Jiwa Crisis Mode',
                flagKeyToEnable: 'enableP3kCrisis',
              ),
      ),
      GoRoute(
        path: '/charts',
        builder: (context, state) => flags.enableChartsTestbed
            ? ChartTestbedScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Mizan Fitrah Balance & Charts',
                flagKeyToEnable: 'enableChartsTestbed',
              ),
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => flags.enableDailyTask
            ? DailyTaskScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Jurnal Adab Harian',
                flagKeyToEnable: 'enableDailyTask',
              ),
      ),
      GoRoute(
        path: '/relations',
        builder: (context, state) => flags.enableRelationsProgress
            ? RelationsProgressScreen(onBack: () => context.pop())
            : const FeatureDisabledScreen(
                featureName: 'Relasi Qalbiyah',
                flagKeyToEnable: 'enableRelationsProgress',
              ),
      ),
    ],
  );
}
