import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'app/shell.dart';
import 'app/theme.dart';
import 'core/theme/earth_tree_forui.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PknPrototypeV4App()));
}

class PknPrototypeV4App extends ConsumerWidget {
  const PknPrototypeV4App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'PKN • Earth-Tree Prototype v4',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.create(Brightness.light),
      darkTheme: AppTheme.create(Brightness.dark),
      themeMode: themeMode,
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return FTheme(
          data: isDark ? earthTreeForuiDark : earthTreeForuiLight,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: AppShell(
        onToggleTheme: () {
          final current = ref.read(themeModeProvider);
          ref.read(themeModeProvider.notifier).state =
              current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
        },
      ),
    );
  }
}
