import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkn_prototype_compile/app/theme.dart';
import 'package:pkn_prototype_compile/core/config/feature_flags.dart';
import 'package:pkn_prototype_compile/core/widgets/feature_gate.dart';

void main() {
  group('FeatureGate Widget Tests', () {
    testWidgets('Renders child when flag is enabled', (tester) async {
      final container = ProviderContainer(
        overrides: [
          featureFlagsProvider.overrideWith(
            (ref) => FeatureFlagsNotifier(
              const FeatureFlagsConfig(enableCurhatAi: true),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.create(Brightness.light),
            home: Scaffold(
              body: FeatureGate(
                isEnabled: (flags) => flags.enableCurhatAi,
                fallback: const Text('Fallback: Fitur Mati'),
                child: const Text('Child: Fitur Aktif'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Child: Fitur Aktif'), findsOneWidget);
      expect(find.text('Fallback: Fitur Mati'), findsNothing);
    });

    testWidgets('Renders fallback when flag is disabled', (tester) async {
      final container = ProviderContainer(
        overrides: [
          featureFlagsProvider.overrideWith(
            (ref) => FeatureFlagsNotifier(
              const FeatureFlagsConfig(enableCurhatAi: false),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.create(Brightness.light),
            home: Scaffold(
              body: FeatureGate(
                isEnabled: (flags) => flags.enableCurhatAi,
                fallback: const Text('Fallback: Fitur Mati'),
                child: const Text('Child: Fitur Aktif'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Child: Fitur Aktif'), findsNothing);
      expect(find.text('Fallback: Fitur Mati'), findsOneWidget);
    });

    testWidgets('FeatureDisabledScreen renders title and instructions', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.create(Brightness.light),
            home: const FeatureDisabledScreen(
              featureName: 'Teman Curhat AI',
              description: 'Modul ini dinonaktifkan.',
              flagKeyToEnable: 'enableCurhatAi',
            ),
          ),
        ),
      );

      expect(find.text('Teman Curhat AI'), findsOneWidget);
      expect(find.text('Modul ini dinonaktifkan.'), findsOneWidget);
      expect(find.text('Aktifkan Modul Ini'), findsOneWidget);
    });
  });
}
