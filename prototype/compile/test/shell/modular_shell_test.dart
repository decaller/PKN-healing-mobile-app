import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:pkn_prototype_compile/app/shell.dart';
import 'package:pkn_prototype_compile/app/theme.dart';
import 'package:pkn_prototype_compile/core/config/feature_flags.dart';
import 'package:pkn_prototype_compile/core/theme/earth_tree_forui.dart';

Widget _buildTestApp({
  required FeatureFlagsConfig flags,
  WidgetRef Function(BuildContext context)? onRef,
}) {
  return ProviderScope(
    overrides: [
      featureFlagsProvider.overrideWith(
        (ref) => FeatureFlagsNotifier(flags),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.create(Brightness.light),
      builder: (context, child) => FTheme(
        data: earthTreeForuiLight,
        child: child!,
      ),
      home: const AppShell(),
    ),
  );
}

void main() {
  group('Modular AppShell Tests', () {
    testWidgets('Renders all 5 destinations when full preset is enabled',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _buildTestApp(flags: FeatureFlagsConfig.allEnabled()),
      );
      await tester.pumpAndSettle();

      // Verify Dock items exist
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Khazanah'), findsOneWidget);
      expect(find.text('Agenda'), findsOneWidget);
      expect(find.text('Curhat AI'), findsOneWidget);
      expect(find.text('Amanah'), findsOneWidget);
    });

    testWidgets('Gracefully renders Minimal Core without crashing',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _buildTestApp(flags: FeatureFlagsConfig.minimalCore()),
      );
      await tester.pumpAndSettle();

      // In minimal core, only Beranda and Modul appear
      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Khazanah'), findsNothing);
      expect(find.text('Agenda'), findsNothing);
      expect(find.text('Curhat AI'), findsNothing);
      expect(find.text('Amanah'), findsNothing);
      expect(find.text('Modul'), findsOneWidget);
    });

    testWidgets('Tapping on dock tabs transitions views cleanly',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _buildTestApp(flags: FeatureFlagsConfig.allEnabled()),
      );
      await tester.pumpAndSettle();

      // Tap on Khazanah tab
      await tester.tap(find.text('Khazanah'));
      await tester.pumpAndSettle();

      // Verify KnowledgeScreen header rendered
      expect(find.text('Khazanah Fitrah (Wiki PKN)'), findsOneWidget);

      // Tap on Agenda tab
      await tester.tap(find.text('Agenda'));
      await tester.pumpAndSettle();

      // Verify EventsListScreen header rendered
      expect(find.text('Agenda & Majelis Akbar'), findsOneWidget);

      // Tap back to Beranda
      await tester.tap(find.text('Beranda'));
      await tester.pumpAndSettle();

      expect(find.text("Assalamu'alaykum"), findsOneWidget);
    });

    testWidgets('AI focused preset hides non-AI tabs seamlessly',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(430, 932));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _buildTestApp(flags: FeatureFlagsConfig.aiFocused()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Beranda'), findsOneWidget);
      expect(find.text('Curhat AI'), findsOneWidget);
      expect(find.text('Khazanah'), findsNothing);
      expect(find.text('Agenda'), findsNothing);
      expect(find.text('Amanah'), findsNothing);
    });
  });
}
