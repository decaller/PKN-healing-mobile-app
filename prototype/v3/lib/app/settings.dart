import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/storage_service.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final value = ref.watch(sharedPreferencesProvider).getString('v3_theme');
  return ThemeMode.values.firstWhere((mode) => mode.name == value, orElse: () => ThemeMode.system);
});

void setAppTheme(WidgetRef ref, ThemeMode mode) {
  ref.read(themeModeProvider.notifier).state = mode;
  ref.read(sharedPreferencesProvider).setString('v3_theme', mode.name);
}
