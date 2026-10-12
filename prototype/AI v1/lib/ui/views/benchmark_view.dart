import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../core/models/ai_models.dart';
import '../../core/services/benchmark_service.dart';
import '../../core/services/edge_llm_service.dart';
import '../../core/theme/earth_tree_theme.dart';

class BenchmarkView extends StatefulWidget {
  final BenchmarkService benchmarkService;

  const BenchmarkView({super.key, required this.benchmarkService});

  @override
  State<BenchmarkView> createState() => _BenchmarkViewState();
}

class _BenchmarkViewState extends State<BenchmarkView> {
  String _selectedModel = 'gemma3:270m';
  String _selectedSuite = 'suite_quick';
  bool _forceSimulation = false;
  bool _isRunning = false;
  BenchmarkResult? _lastResult;

  @override
  void initState() {
    super.initState();
    if (widget.benchmarkService.history.isNotEmpty) {
      _lastResult = widget.benchmarkService.history.first;
    }
  }

  Future<void> _executeBenchmark() async {
    setState(() => _isRunning = true);
    try {
      final res = await widget.benchmarkService.runBenchmark(
        modelId: _selectedModel,
        suiteId: _selectedSuite,
        forceSimulation: _forceSimulation,
      );
      if (mounted) {
        setState(() {
          _lastResult = res;
          _isRunning = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isRunning = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menjalankan benchmark: $e')),
        );
      }
    }
  }

  void _copyReport() {
    final report = widget.benchmarkService.generateMarkdownReport();
    Clipboard.setData(ClipboardData(text: report));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Laporan benchmark disalin ke clipboard (Markdown)!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner
          _buildHeaderBanner(),
          const SizedBox(height: 16),

          // Configuration Box
          _buildConfigurationBox(),
          const SizedBox(height: 16),

          // Key Metrics Cards
          if (_lastResult != null) ...[
            _buildMetricsGrid(_lastResult!),
            const SizedBox(height: 16),
            _buildSampleOutputCard(_lastResult!),
            const SizedBox(height: 20),
          ],

          // History Table
          _buildHistorySection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: EarthTreeColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.GraphUp(
              color: EarthTreeColors.primary,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edge LLM & LiteRT Benchmark Console',
                  style: TextStyle(
                    fontFamily: EarthTreeTheme.fontSerif,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: EarthTreeColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Uji empiris TTFT, Throughput, dan efisiensi memori model lokal on-device.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: EarthTreeColors.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationBox() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.25),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Target Model On-Device:',
            style: TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: EarthTreeColors.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: EdgeLlmService.availableModels.map((m) {
              final isSelected = _selectedModel == m.id;
              return ChoiceChip(
                selected: isSelected,
                label: Text('${m.name} (${m.size})'),
                labelStyle: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : EarthTreeColors.onSurface,
                ),
                selectedColor: EarthTreeColors.primary,
                backgroundColor: EarthTreeColors.surfaceContainerLow,
                onSelected: (val) {
                  if (val) setState(() => _selectedModel = m.id);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          const Text(
            'Skenario Pengujian:',
            style: TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: EarthTreeColors.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedSuite,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              filled: true,
              fillColor: EarthTreeColors.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            items: BenchmarkService.benchmarkSuites.map((s) {
              return DropdownMenuItem<String>(
                value: s['id'],
                child: Text(
                  s['title']!,
                  style: const TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 13,
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedSuite = val);
            },
          ),
          const SizedBox(height: 12),

          // Simulation toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  iconoir.Cpu(
                    color: EarthTreeColors.tertiary,
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Paksa Mode Simulasi On-Device',
                    style: TextStyle(
                      fontFamily: EarthTreeTheme.fontSans,
                      fontSize: 12,
                      color: EarthTreeColors.onSurface,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _forceSimulation,
                activeColor: EarthTreeColors.secondary,
                onChanged: (val) => setState(() => _forceSimulation = val),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Run Button
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EarthTreeColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: _isRunning ? null : _executeBenchmark,
                  icon: _isRunning
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const iconoir.Play(
                          color: Colors.white,
                          width: 18,
                          height: 18,
                        ),
                  label: Text(
                    _isRunning ? 'Sedang Menguji...' : 'Jalankan Benchmark',
                    style: const TextStyle(
                      fontFamily: EarthTreeTheme.fontSans,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Salin Laporan Markdown',
                style: IconButton.styleFrom(
                  backgroundColor: EarthTreeColors.surfaceContainerHigh,
                ),
                onPressed: _copyReport,
                icon: const iconoir.Copy(
                  color: EarthTreeColors.onSurface,
                  width: 18,
                  height: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BenchmarkResult res) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HASIL TERAKHIR: ${res.modelName}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.9,
                    color: EarthTreeColors.onSurfaceVariant,
                  ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: res.isSimulation
                    ? EarthTreeColors.tertiaryFixed
                    : EarthTreeColors.secondaryFixed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                res.isSimulation ? 'Simulasi Edge' : 'Live Ollama / LiteRT',
                style: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: res.isSimulation
                      ? EarthTreeColors.onTertiaryFixed
                      : EarthTreeColors.onSecondaryFixed,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: 'TTFT (Time to First)',
                value: '${res.ttftMs} ms',
                subtitle: 'Latensi respon awal',
                color: EarthTreeColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildMetricTile(
                title: 'Throughput',
                value: '${res.tokensPerSec.toStringAsFixed(1)} tps',
                subtitle: '${res.completionTokens} token terbit',
                color: EarthTreeColors.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: 'Total Latensi',
                value: '${res.totalDurationMs} ms',
                subtitle: 'Durasi komputasi',
                color: EarthTreeColors.tertiary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildMetricTile(
                title: 'Memori RAM',
                value: '${res.memoryMb} MB',
                subtitle: 'Jejak on-device',
                color: EarthTreeColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 11,
              color: EarthTreeColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 10,
              color: EarthTreeColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleOutputCard(BenchmarkResult res) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const iconoir.MessageText(
                color: EarthTreeColors.tertiary,
                width: 14,
                height: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'Cuplikan Respon (${res.promptTitle}):',
                style: const TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: EarthTreeColors.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            res.sampleOutput,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 12,
              height: 1.4,
              color: EarthTreeColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    final history = widget.benchmarkService.history;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Riwayat Uji Komparasi',
              style: TextStyle(
                fontFamily: EarthTreeTheme.fontSerif,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: EarthTreeColors.onSurface,
              ),
            ),
            Text(
              '${history.length} pengujian',
              style: const TextStyle(
                fontFamily: EarthTreeTheme.fontSans,
                fontSize: 11,
                color: EarthTreeColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (history.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: EarthTreeColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Belum ada riwayat uji. Tekan "Jalankan Benchmark" di atas.',
              style: TextStyle(
                fontFamily: EarthTreeTheme.fontSans,
                fontSize: 12,
                color: EarthTreeColors.onSurfaceVariant,
              ),
            ),
          )
        else
          ...history.map((h) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: EarthTreeColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: EarthTreeColors.outlineVariant.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            h.modelName,
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: EarthTreeColors.onSurface,
                            ),
                          ),
                          Text(
                            h.promptTitle,
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 11,
                              color: EarthTreeColors.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${h.tokensPerSec.toStringAsFixed(1)} tps',
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: EarthTreeColors.secondary,
                            ),
                          ),
                          Text(
                            'TTFT: ${h.ttftMs}ms',
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 10,
                              color: EarthTreeColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }
}
