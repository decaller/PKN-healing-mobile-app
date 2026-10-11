import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:pkn_prototype_v4/app/theme.dart';
import 'package:pkn_prototype_v4/core/theme/earth_tree_forui.dart';
import 'package:pkn_prototype_v4/features/crisis/presentation/screens/p3k_crisis_screen.dart';
import 'package:pkn_prototype_v4/features/home/presentation/widgets/bento_features_grid.dart';
import 'package:pkn_prototype_v4/features/sanctuary/presentation/screens/ai_sanctuary_screen.dart';

void main() {
  for (final brightness in Brightness.values) {
    testWidgets('Crisis fits narrow large-text viewport in $brightness',
        (tester) async {
      _narrowViewport(tester);
      await tester.pumpWidget(_screenHarness(
        const P3kCrisisScreen(),
        brightness: brightness,
      ));
      await tester.pump();
      expect(tester.takeException(), isNull);
      await _scrollToEnd(tester);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 4));
      expect(tester.takeException(), isNull);
    });

    testWidgets('Sanctuary fits narrow large-text viewport in $brightness',
        (tester) async {
      _narrowViewport(tester);
      final semantics = tester.ensureSemantics();
      try {
      await tester.pumpWidget(_screenHarness(
        const AiSanctuaryScreen(),
        brightness: brightness,
      ));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      final microphone = find.bySemanticsLabel(
        'Buka refleksi terpandu lokal. Tidak merekam suara.',
      );
      await tester.ensureVisible(microphone);
      await tester.tap(microphone);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
      for (var step = 0; step < 2; step++) {
        final next = find.text('Lanjutkan refleksi');
        await tester.ensureVisible(next);
        await tester.tap(next);
        await tester.pump();
        expect(tester.takeException(), isNull);
      }
      final finish = find.text('Selesai refleksi');
      await tester.ensureVisible(finish);
      await tester.tap(finish);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Selesai refleksi'), findsNothing);
      expect(tester.takeException(), isNull);
      await _scrollToEnd(tester);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 4));
      expect(tester.takeException(), isNull);
      expect(tester.binding.transientCallbackCount, 0);
      } finally {
        semantics.dispose();
      }
    });
  }

  testWidgets('Sanctuary route can close and reopen without a disposed ticker',
      (tester) async {
    final semantics = tester.ensureSemantics();
    try {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(_screenHarness(
      const Scaffold(body: SingleChildScrollView(child: BentoFeaturesGrid())),
      textScale: 1,
    ));

    for (var visit = 0; visit < 2; visit++) {
      await tester.ensureVisible(find.text('Mulai Sesi'));
      await tester.tap(find.text('Mulai Sesi'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(AiSanctuaryScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pump(const Duration(seconds: 3));
      await tester.tap(find.bySemanticsLabel('Kembali ke beranda'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(AiSanctuaryScreen), findsNothing);
      expect(find.byType(BentoFeaturesGrid), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
      expect(tester.takeException(), isNull);
      expect(tester.binding.transientCallbackCount, 0);
    }
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    expect(tester.takeException(), isNull);
    } finally {
      semantics.dispose();
    }
  });

  for (final screen in <Widget>[
    const AiSanctuaryScreen(),
    const P3kCrisisScreen(),
  ]) {
    testWidgets('Clipboard feedback supports failure and retry on ${screen.runtimeType}',
        (tester) async {
    _narrowViewport(tester);
    var failClipboard = false;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData' && failClipboard) {
          throw PlatformException(code: 'clipboard_unavailable');
        }
        return null;
      },
    );
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null));
    await tester.pumpWidget(_screenHarness(screen));
    final copy = find.text(screen is AiSanctuaryScreen
        ? 'Salin doa dan terjemahan'
        : 'Bagikan SOP');
    await tester.ensureVisible(copy);
    await tester.pump();
    expect(_liveFeedback(tester), isEmpty);

    await tester.tap(copy);
    await tester.pump();
    final success = _liveFeedback(tester);
    expect(success, hasLength(1));
    expect(success.single, isNotEmpty);
    expect(tester.takeException(), isNull);

    failClipboard = true;
    await tester.ensureVisible(copy);
    await tester.tap(copy);
    await tester.pump();
    final failure = _liveFeedback(tester);
    expect(failure, hasLength(1));
    expect(failure.single, isNotEmpty);
    expect(failure.single, isNot(success.single));
    expect(tester.takeException(), isNull);

    failClipboard = false;
    await tester.ensureVisible(copy);
    await tester.tap(copy);
    await tester.pump();
    expect(_liveFeedback(tester), success);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 4));
    expect(tester.takeException(), isNull);
  });
  }
}

void _narrowViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(320, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Widget _screenHarness(
  Widget screen, {
  Brightness brightness = Brightness.light,
  double textScale = 1.5,
}) => MaterialApp(
      theme: AppTheme.create(brightness),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: FTheme(
          data: brightness == Brightness.dark
              ? earthTreeForuiDark
              : earthTreeForuiLight,
          child: child!,
        ),
      ),
      home: screen,
    );

Future<void> _scrollToEnd(WidgetTester tester) async {
  final scrollable = find.byType(Scrollable).first;
  final state = tester.state<ScrollableState>(scrollable);
  for (var step = 0;
      step < 40 && state.position.pixels < state.position.maxScrollExtent;
      step++) {
    await tester.drag(scrollable, const Offset(0, -400));
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
  }
  expect(state.position.pixels, closeTo(state.position.maxScrollExtent, 1));
}

List<String> _liveFeedback(WidgetTester tester) => tester
    .widgetList<Semantics>(find.byWidgetPredicate(
      (widget) => widget is Semantics && widget.properties.liveRegion == true,
    ))
    .map((widget) => widget.child)
    .whereType<Text>()
    .map((text) => text.data ?? '')
    .toList();
