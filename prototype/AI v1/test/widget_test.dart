import 'package:flutter_test/flutter_test.dart';
import 'package:ai_v1/core/services/benchmark_service.dart';
import 'package:ai_v1/core/services/edge_llm_service.dart';
import 'package:ai_v1/main.dart';

void main() {
  test('EdgeLlmService has four configured models with valid parameters', () {
    final models = EdgeLlmService.availableModels;
    expect(models.length, 4);
    expect(models.any((m) => m.id == 'gemma3:270m'), isTrue);
    expect(models.any((m) => m.id == 'gemma3:1b'), isTrue);
    expect(models.any((m) => m.id == 'gemma4:e2b'), isTrue);
    expect(models.any((m) => m.id == 'litert:audio8'), isTrue);
  });

  test('BenchmarkService computes simulated benchmark metrics correctly', () async {
    final edge = EdgeLlmService();
    final benchmark = BenchmarkService(edgeService: edge);

    final res270m = await benchmark.runBenchmark(
      modelId: 'gemma3:270m',
      suiteId: 'suite_quick',
      forceSimulation: true,
    );

    expect(res270m.modelId, 'gemma3:270m');
    expect(res270m.tokensPerSec, greaterThan(80.0));
    expect(res270m.ttftMs, lessThan(100));

    final resLiteRt = await benchmark.runBenchmark(
      modelId: 'litert:audio8',
      suiteId: 'suite_litert',
      forceSimulation: true,
    );

    expect(resLiteRt.modelId, 'litert:audio8');
    expect(resLiteRt.category, contains('LiteRT'));
    expect(resLiteRt.memoryMb, lessThan(100));
  });

  testWidgets('App renders PreChatView and elements from template', (tester) async {
    final edge = EdgeLlmService();
    final benchmark = BenchmarkService(edgeService: edge);

    await tester.pumpWidget(AiV1App(
      edgeService: edge,
      benchmarkService: benchmark,
    ));

    expect(find.text('Teman Curhat AI'), findsWidgets);
    expect(find.text('Ahlan wa Sahlan, Abu Hafi.'), findsOneWidget);
    expect(find.text('Privasi Amanah 100% On-Device • Zero Cloud Leak'), findsOneWidget);
    expect(find.text('Ide Aktivitas'), findsOneWidget);
    expect(find.text('Ide RPP Rumah'), findsOneWidget);
    expect(find.text('Refleksi Diri'), findsOneWidget);
  });
}
