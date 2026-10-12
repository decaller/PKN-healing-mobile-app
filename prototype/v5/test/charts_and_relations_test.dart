import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:pkn_prototype_v5/app/theme.dart';
import 'package:pkn_prototype_v5/core/theme/earth_tree_forui.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/screens/chart_testbed_screen.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/widgets/mizan_fitrah_balance_scale.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/widgets/multi_segment_progress_pill.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/widgets/tb40_talents_radar_chart.dart';
import 'package:pkn_prototype_v5/features/charts/presentation/widgets/weekly_stacked_bar_chart.dart';
import 'package:pkn_prototype_v5/features/daily_task/presentation/screens/daily_task_screen.dart';
import 'package:pkn_prototype_v5/features/relations/presentation/screens/relations_progress_screen.dart';

Widget _buildTestApp(Widget child, {Brightness brightness = Brightness.light}) {
  final fTheme = brightness == Brightness.dark ? earthTreeForuiDark : earthTreeForuiLight;
  return ProviderScope(
    child: MaterialApp(
      theme: AppTheme.create(brightness),
      builder: (context, widget) => FTheme(
        data: fTheme,
        child: widget!,
      ),
      home: child,
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Chart Widgets Rendering Tests', () {
    testWidgets('WeeklyStackedBarChart renders without crashing', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(_buildTestApp(
        const Scaffold(body: WeeklyStackedBarChart(isInteractive: false)),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(WeeklyStackedBarChart), findsOneWidget);
    });

    testWidgets('Tb40TalentsRadarChart renders without crashing', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(_buildTestApp(
        const Scaffold(body: Tb40TalentsRadarChart()),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(Tb40TalentsRadarChart), findsOneWidget);
    });

    testWidgets('MizanFitrahBalanceScale renders and animates on tap', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(_buildTestApp(
        const Scaffold(body: MizanFitrahBalanceScale()),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(MizanFitrahBalanceScale), findsOneWidget);
      expect(find.textContaining('Sakinah & Thuma\'ninah'), findsOneWidget);

      // Tap to trigger tilt animation
      await tester.tap(find.descendant(
        of: find.byType(MizanFitrahBalanceScale),
        matching: find.byType(GestureDetector),
      ));
      await tester.pump();
      await tester.pumpAndSettle();
    });

    testWidgets('MultiSegmentProgressPill renders correct percentages', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 640));
      await tester.pumpWidget(_buildTestApp(
        const Scaffold(body: MultiSegmentProgressPill()),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Diri (48%)'), findsOneWidget);
      expect(find.text('Hati (32%)'), findsOneWidget);
      expect(find.text('Ilmu (8%)'), findsOneWidget);
      expect(find.text('Total: 88%'), findsOneWidget);
    });

    testWidgets('ChartTestbedScreen renders all benchmark cases', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      await tester.pumpWidget(_buildTestApp(const ChartTestbedScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Lab Evaluasi Chart PKN'), findsOneWidget);
      expect(find.textContaining('Case 1: Aktivitas Sepekan'), findsOneWidget);
      expect(find.textContaining('Case 2: Ketercapaian Amanah'), findsOneWidget);
    });
  });

  group('DailyTaskScreen & RelationsProgressScreen Tests', () {
    testWidgets('DailyTaskScreen renders tasks and filter chips', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      await tester.pumpWidget(_buildTestApp(const DailyTaskScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Amanah Harian Abu Hafi'), findsOneWidget);
      expect(find.textContaining('4/5 Tuntas'), findsOneWidget);
      expect(find.textContaining('Dialog Pundak Senja'), findsOneWidget);

      // Tap filter chip "Relasi Hati"
      await tester.tap(find.textContaining('Relasi Hati'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Dialog Pundak Senja'), findsOneWidget);
    });

    testWidgets('RelationsProgressScreen renders person cards and timeframe pills', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      await tester.pumpWidget(_buildTestApp(const RelationsProgressScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Neraca Jiwa & Relasi'), findsOneWidget);
      expect(find.text('Ananda Zaid'), findsOneWidget);
      expect(find.text('Ananda Maryam'), findsOneWidget);
      expect(find.text('Ummu Zaid'), findsOneWidget);
      expect(find.text('“Ayah Penyejuk Qalbu”'), findsOneWidget);

      // Tap timeframe "Bulan Ini"
      await tester.tap(find.text('Bulan Ini'));
      await tester.pumpAndSettle();

      // Tap "+ Jadwalkan ke Daily Task Besok"
      final scheduleBtn = find.text('+ Jadwalkan ke Daily Task Besok');
      expect(scheduleBtn, findsOneWidget);
      await tester.scrollUntilVisible(scheduleBtn, 200);
      await tester.tap(scheduleBtn);
      await tester.pumpAndSettle();

      expect(find.text('Telah Dijadwalkan ke Daily Task'), findsOneWidget);
    });
  });
}
