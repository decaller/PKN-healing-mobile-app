import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pkn_prototype_v4/main.dart';

void main() {
  testWidgets('Prototype v4 smoke test renders AppShell', (WidgetTester tester) async {
    // Set screen size representatif ponsel modern (390 x 844 dp)
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(const ProviderScope(child: PknPrototypeV4App()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text("Abu Hafi"), findsOneWidget);
    expect(find.text("Highlights"), findsOneWidget);
    expect(find.text("Curhat Cepat"), findsOneWidget);
  });
}
