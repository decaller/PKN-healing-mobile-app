import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pkn_microlearning_app/app/router/app_router.dart';
import 'package:pkn_microlearning_app/app/settings.dart';
import 'package:pkn_microlearning_app/core/storage/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('fresh router starts at home without an onboarding gate', () async {
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [sharedPreferencesProvider.overrideWithValue(preferences)]);
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    addTearDown(router.dispose);
    expect(router.routeInformationProvider.value.uri.path, '/feed');
  });

  testWidgets('genuine theme setting persists across provider recreation', (tester) async {
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [sharedPreferencesProvider.overrideWithValue(preferences)]);
    addTearDown(container.dispose);
    expect(container.read(themeModeProvider), ThemeMode.system);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp(home: Consumer(builder: (context, ref, _) => TextButton(onPressed: () => setAppTheme(ref, ThemeMode.dark), child: const Text('Gelap'))))));
    await tester.tap(find.text('Gelap'));
    await tester.pump();
    expect(container.read(themeModeProvider), ThemeMode.dark);
    expect(preferences.getString('v3_theme'), 'dark');
    final restored = ProviderContainer(overrides: [sharedPreferencesProvider.overrideWithValue(preferences)]);
    addTearDown(restored.dispose);
    expect(restored.read(themeModeProvider), ThemeMode.dark);
  });
}
