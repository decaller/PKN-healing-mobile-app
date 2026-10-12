import 'package:flutter/material.dart';
import 'core/services/benchmark_service.dart';
import 'core/services/edge_llm_service.dart';
import 'core/theme/earth_tree_theme.dart';
import 'ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final edgeService = EdgeLlmService();
  final benchmarkService = BenchmarkService(edgeService: edgeService);

  runApp(AiV1App(
    edgeService: edgeService,
    benchmarkService: benchmarkService,
  ));
}

class AiV1App extends StatelessWidget {
  final EdgeLlmService edgeService;
  final BenchmarkService benchmarkService;

  const AiV1App({
    super.key,
    required this.edgeService,
    required this.benchmarkService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teman Curhat AI v1',
      debugShowCheckedModeBanner: false,
      theme: EarthTreeTheme.lightTheme,
      home: HomePage(
        edgeService: edgeService,
        benchmarkService: benchmarkService,
      ),
    );
  }
}
