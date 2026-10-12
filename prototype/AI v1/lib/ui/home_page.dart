import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../core/models/ai_models.dart';
import '../core/services/benchmark_service.dart';
import '../core/services/edge_llm_service.dart';
import '../core/theme/earth_tree_theme.dart';
import 'views/benchmark_view.dart';
import 'views/chat_session_view.dart';
import 'views/pre_chat_view.dart';
import 'views/walkie_talkie_view.dart';

class HomePage extends StatefulWidget {
  final EdgeLlmService edgeService;
  final BenchmarkService benchmarkService;

  const HomePage({
    super.key,
    required this.edgeService,
    required this.benchmarkService,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeTopTab = 0; // 0: Text/Doc, 1: Walkie-Talkie, 2: Benchmark
  String _activeModelId = 'gemma3:270m';
  bool _isGenerating = false;

  final TextEditingController _inputController = TextEditingController();
  final List<ChatMessage> _messages = [];

  ModelOption get _activeModel => EdgeLlmService.availableModels.firstWhere(
        (m) => m.id == _activeModelId,
        orElse: () => EdgeLlmService.availableModels[0],
      );

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (_isGenerating || text.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _inputController.clear();
      _isGenerating = true;
    });

    final aiMsgId = (DateTime.now().millisecondsSinceEpoch + 1).toString();
    final isRpp = text.toLowerCase().contains('rpp') ||
        text.toLowerCase().contains('dokumen') ||
        text.toLowerCase().contains('jadwal');
    final isMaghrib = text.toLowerCase().contains('maghrib') ||
        text.toLowerCase().contains('shalat') ||
        text.toLowerCase().contains('tamyiz');

    ChatMessage aiMsg = ChatMessage(
      id: aiMsgId,
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      modelName: _activeModel.name,
      isStreaming: true,
      dalil: isMaghrib ? widget.edgeService.createShalatTamyizDalil() : null,
      document: isRpp ? widget.edgeService.createRppDocumentForZaid() : null,
    );

    setState(() {
      _messages.add(aiMsg);
    });

    widget.edgeService.streamChat(
      prompt: text,
      modelId: _activeModelId,
      onMetrics: (ttftMs, totalLatencyMs, tps) {
        if (!mounted) return;
        setState(() {
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx != -1) {
            _messages[idx] = _messages[idx].copyWith(
              ttftMs: ttftMs,
              latencyMs: totalLatencyMs,
              tokensPerSec: tps,
              isStreaming: false,
            );
          }
          _isGenerating = false;
        });
      },
    ).listen(
      (chunk) {
        if (!mounted) return;
        setState(() {
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx != -1) {
            _messages[idx] = _messages[idx].copyWith(
              content: _messages[idx].content + chunk,
            );
          }
        });
      },
      onError: (err) {
        if (!mounted) return;
        setState(() {
          _isGenerating = false;
        });
      },
    );
  }

  void _showModelPickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: EarthTreeColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pilih Edge LLM On-Device',
                      style: TextStyle(
                        fontFamily: EarthTreeTheme.fontSerif,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: EarthTreeColors.onSurface,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...EdgeLlmService.availableModels.map((m) {
                  final isSelected = m.id == _activeModelId;
                  return Card(
                    color: isSelected
                        ? EarthTreeColors.primaryFixed.withValues(alpha: 0.35)
                        : EarthTreeColors.surfaceContainerLow,
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected ? EarthTreeColors.primary : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            m.name,
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: EarthTreeColors.secondaryFixed,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              m.badge,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: EarthTreeColors.onSecondaryFixed,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        '${m.description} (${m.size} • Kecepatan: ${m.speedRating})',
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 12,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: EarthTreeColors.primary)
                          : null,
                      onTap: () {
                        setState(() => _activeModelId = m.id);
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: SafeArea(
        child: Column(
          children: [
            _buildModeSwitcherPill(),
            Expanded(
              child: _buildActiveView(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavDock(),
    );
  }

  PreferredSizeWidget _buildHeader() {
    return AppBar(
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: EarthTreeColors.secondary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.Leaf(
              color: EarthTreeColors.secondary,
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Teman Curhat AI',
                style: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: EarthTreeColors.onSurface,
                ),
              ),
              Text(
                'Tazkiyatun Nafs & Pendampingan Fitrah',
                style: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 11,
                  color: EarthTreeColors.onSurfaceVariant.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: EarthTreeColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              iconoir.Shield(
                color: EarthTreeColors.secondary,
                width: 14,
                height: 14,
              ),
              SizedBox(width: 4),
              Text(
                'Amanah',
                style: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: EarthTreeColors.secondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Ganti Model Edge',
          onPressed: _showModelPickerSheet,
          icon: const iconoir.Cpu(
            color: EarthTreeColors.primary,
            width: 20,
            height: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: EarthTreeColors.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.User(
              color: Colors.white,
              width: 16,
              height: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModeSwitcherPill() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainer,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPillTab(0, 'Teks & Dokumen', const iconoir.Page(width: 16, height: 16)),
          _buildPillTab(1, 'Walkie-Talkie', const iconoir.Microphone(width: 16, height: 16)),
          _buildPillTab(2, 'Benchmark', const iconoir.GraphUp(width: 16, height: 16)),
        ],
      ),
    );
  }

  Widget _buildPillTab(int index, String label, Widget iconWidget) {
    final isSelected = _activeTopTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTopTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? EarthTreeColors.surfaceContainerLowest : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontFamily: EarthTreeTheme.fontSans,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? EarthTreeColors.primary : EarthTreeColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveView() {
    switch (_activeTopTab) {
      case 0:
        if (_messages.isEmpty) {
          return PreChatView(
            controller: _inputController,
            onSend: _sendMessage,
            onSelectVoiceTab: () => setState(() => _activeTopTab = 1),
          );
        } else {
          return ChatSessionView(
            messages: _messages,
            inputController: _inputController,
            onSend: _sendMessage,
            onResetToPreChat: () => setState(() => _messages.clear()),
            activeModelName: _activeModel.name,
            isGenerating: _isGenerating,
          );
        }
      case 1:
        return WalkieTalkieView(
          edgeService: widget.edgeService,
          activeModelId: _activeModelId,
        );
      case 2:
        return BenchmarkView(
          benchmarkService: widget.benchmarkService,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildBottomNavDock() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surface.withValues(alpha: 0.95),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: const iconoir.Home(width: 20, height: 20), label: 'Home'),
              _buildNavItem(icon: const iconoir.Calendar(width: 20, height: 20), label: 'Agenda'),
              _buildActiveNavPill(),
              _buildNavItem(icon: const iconoir.Book(width: 20, height: 20), label: 'Wiki'),
              _buildNavItem(icon: const iconoir.User(width: 20, height: 20), label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required Widget icon, required String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontFamily: EarthTreeTheme.fontSans,
            fontSize: 10,
            color: EarthTreeColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveNavPill() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: EarthTreeColors.primaryFixed,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: EarthTreeColors.primary.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const iconoir.Sparks(
            color: EarthTreeColors.primary,
            width: 18,
            height: 18,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'AI',
          style: TextStyle(
            fontFamily: EarthTreeTheme.fontSans,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: EarthTreeColors.primary,
          ),
        ),
      ],
    );
  }
}
