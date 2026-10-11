import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import '../core/theme/earth_tree_forui.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'settings.dart';

class MicrolearningApp extends ConsumerWidget {
  const MicrolearningApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: 'PKN • Ruang Bertumbuh',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.create(Brightness.light),
    darkTheme: AppTheme.create(Brightness.dark),
    themeMode: ref.watch(themeModeProvider),
    routerConfig: ref.watch(appRouterProvider),
    builder: (context, child) => FTheme(
      data: Theme.of(context).brightness == Brightness.dark ? earthTreeDark : earthTreeLight,
      child: child!,
    ),
  );
}
