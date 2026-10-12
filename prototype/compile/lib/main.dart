import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/config/feature_flags.dart';
import 'core/theme/earth_tree_forui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: PknCompiledApp(),
    ),
  );
}

class PknCompiledApp extends ConsumerStatefulWidget {
  const PknCompiledApp({super.key});

  @override
  ConsumerState<PknCompiledApp> createState() => _PknCompiledAppState();
}

class _PknCompiledAppState extends ConsumerState<PknCompiledApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flags = ref.watch(featureFlagsProvider);
    final router = createAppRouter(
      onToggleTheme: _toggleTheme,
      flags: flags,
    );

    return MaterialApp.router(
      title: 'PKN Mobile App - Compiled Modular',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.create(Brightness.light),
      darkTheme: AppTheme.create(Brightness.dark),
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return FTheme(
          data: isDark ? earthTreeForuiDark : earthTreeForuiLight,
          child: child ?? const SizedBox.shrink(),
        );
      },
      routerConfig: router,
    );
  }
}
