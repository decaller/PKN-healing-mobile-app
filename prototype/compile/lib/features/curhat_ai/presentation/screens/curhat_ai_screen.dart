import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/earth_tree_colors.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../models/ai_models.dart';
import '../../services/edge_llm_service.dart';

class CurhatAiScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const CurhatAiScreen({super.key, this.onBack});

  @override
  State<CurhatAiScreen> createState() => _CurhatAiScreenState();
}

class _CurhatAiScreenState extends State<CurhatAiScreen> {
  final TextEditingController _textCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final EdgeLlmService _llmService = EdgeLlmService();

  final List<ChatMessage> _messages = [];
  bool _isGenerating = false;
  String _activeModelId = 'gemma3:270m';
  double _currentTps = 0;
  int _currentTtft = 0;

  @override
  void dispose() {
    _textCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage(String text) async {
    final query = text.trim();
    if (query.isEmpty || _isGenerating) return;

    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: MessageRole.user,
      content: query,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _textCtrl.clear();
      _isGenerating = true;
    });

    _scrollToBottom();

    final aiMsgId = (DateTime.now().millisecondsSinceEpoch + 1).toString();
    final isRpp = query.toLowerCase().contains('rpp') ||
        query.toLowerCase().contains('dokumen') ||
        query.toLowerCase().contains('jadwal');
    final isMaghrib = query.toLowerCase().contains('maghrib') ||
        query.toLowerCase().contains('shalat') ||
        query.toLowerCase().contains('tamyiz');

    ChatMessage aiMsg = ChatMessage(
      id: aiMsgId,
      role: MessageRole.assistant,
      content: '',
      timestamp: DateTime.now(),
      modelName: _activeModelId,
      isStreaming: true,
      dalil: isMaghrib ? _llmService.createShalatTamyizDalil() : null,
      document: isRpp ? _llmService.createRppDocumentForZaid() : null,
    );

    setState(() {
      _messages.add(aiMsg);
    });

    final stream = _llmService.streamChat(
      prompt: query,
      modelId: _activeModelId,
      onMetrics: (ttftMs, latencyMs, tps) {
        setState(() {
          _currentTtft = ttftMs;
          _currentTps = tps;
        });
      },
    );

    final sb = StringBuffer();
    try {
      await for (final token in stream) {
        sb.write(token);
        setState(() {
          final idx = _messages.indexWhere((m) => m.id == aiMsgId);
          if (idx != -1) {
            _messages[idx] = _messages[idx].copyWith(content: sb.toString());
          }
        });
        _scrollToBottom();
      }
    } finally {
      setState(() {
        _isGenerating = false;
        final idx = _messages.indexWhere((m) => m.id == aiMsgId);
        if (idx != -1) {
          _messages[idx] = _messages[idx].copyWith(
            isStreaming: false,
            ttftMs: _currentTtft,
            tokensPerSec: _currentTps,
          );
        }
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: widget.onBack != null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
                onPressed: widget.onBack,
              )
            : null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teman Curhat AI',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '100% On-Device • Zero Cloud Leak',
              style: TextStyle(
                color: colors.meadowCanopy,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Pilih Mesin LLM',
            initialValue: _activeModelId,
            icon: Icon(Icons.tune, color: colors.textPrimary),
            onSelected: (model) => setState(() => _activeModelId = model),
            itemBuilder: (ctx) => EdgeLlmService.availableModels
                .map((m) => PopupMenuItem(
                      value: m.id,
                      child: Text('${m.name} (${m.badge})'),
                    ))
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner Status Mesin
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: colors.tactileBorder.withOpacity(0.08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.meadowCanopy,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Model: $_activeModelId',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (_currentTps > 0)
                  Text(
                    '${_currentTps.toStringAsFixed(1)} tps • TTFT ${_currentTtft}ms',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: colors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),

          // Chat Messages
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(colors)
                : ListView.builder(
                    controller: _scrollCtrl,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      return _buildMessageBubble(msg, colors);
                    },
                  ),
          ),

          // Input Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(top: BorderSide(color: colors.tactileBorder)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textCtrl,
                    enabled: !_isGenerating,
                    decoration: InputDecoration(
                      hintText: 'Curhatkan kegelisahan pengasuhan...',
                      filled: true,
                      fillColor: colors.tactileBorder.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: iconoir.Send(
                    color: _isGenerating
                        ? colors.textSecondary
                        : colors.meadowCanopy,
                    width: 22,
                    height: 22,
                  ),
                  onPressed: _isGenerating
                      ? null
                      : () => _sendMessage(_textCtrl.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(EarthTreeColors colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.meadowCanopy.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: iconoir.ChatBubble(
                  color: colors.meadowCanopy,
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ruang Thuma\'ninah Kalbu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sampaikan keluh kesah pengasuhan. Data percakapan diproses sepenuhnya di perangkat tanpa keluar ke internet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildPromptChip('Anak 8 tahun susah lepas gadget saat Maghrib', colors),
                _buildPromptChip('SOP 10 Detik saat dada sesak marah', colors),
                _buildPromptChip('Buatkan RPP Adab Harian untuk Zaid', colors),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptChip(String prompt, EarthTreeColors colors) {
    return ActionChip(
      label: Text(
        prompt,
        style: TextStyle(fontSize: 11, color: colors.textPrimary),
      ),
      backgroundColor: colors.tactileBorder.withOpacity(0.15),
      side: BorderSide(color: colors.tactileBorder),
      onPressed: () => _sendMessage(prompt),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg, EarthTreeColors colors) {
    final isUser = msg.role == MessageRole.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 320),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUser
                  ? colors.meadowCanopy
                  : colors.tactileBorder.withOpacity(0.15),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isUser ? 16 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  msg.content.isEmpty && msg.isStreaming
                      ? 'Sedang merenungkan...'
                      : msg.content,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: isUser ? colors.onMeadowCanopy : colors.textPrimary,
                  ),
                ),
                if (msg.dalil != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.tactileBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.dalil!.arabicText,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg.dalil!.translation,
                          style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (msg.document != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.celestialSky.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.celestialSky.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dokumen RPP: ${msg.document!.title}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colors.celestialSky,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jadwal: ${msg.document!.schedule.length} langkah • Siap cetak A4',
                          style: TextStyle(
                            fontSize: 11,
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
