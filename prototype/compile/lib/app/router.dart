import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/config/feature_flags.dart';
import '../features/events/presentation/screens/events_list_screen.dart';
import '../features/mitra/presentation/screens/mitra_hub_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/pustaka/presentation/screens/pustaka_list_screen.dart';
import '../features/renungan/presentation/screens/mode_renungan_screen.dart';
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
        path: '/events',
        builder: (context, state) => EventsListScreen(onBack: () => context.pop()),
      ),
      GoRoute(
        path: '/pustaka',
        builder: (context, state) => PustakaListScreen(onBack: () => context.pop()),
      ),
      GoRoute(
        path: '/mitra',
        builder: (context, state) => MitraHubScreen(onBack: () => context.pop()),
      ),
      GoRoute(
        path: '/renungan',
        builder: (context, state) => ModeRenunganScreen(onClose: () => context.pop()),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(
          onToggleTheme: onToggleTheme,
          onBack: () => context.pop(),
        ),
      ),
    ],
  );
}
