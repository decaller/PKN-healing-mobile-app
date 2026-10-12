import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../core/models/ai_models.dart';
import '../../core/theme/earth_tree_theme.dart';

class ChatSessionView extends StatelessWidget {
  final List<ChatMessage> messages;
  final TextEditingController inputController;
  final ValueChanged<String> onSend;
  final VoidCallback onResetToPreChat;
  final String activeModelName;
  final bool isGenerating;

  const ChatSessionView({
    super.key,
    required this.messages,
    required this.inputController,
    required this.onSend,
    required this.onResetToPreChat,
    required this.activeModelName,
    required this.isGenerating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Live Security & Model Status Banner
        _buildEncryptionStatusBar(context),

        // Messages list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: messages.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildTimeDivider(context);
              }
              final message = messages[index - 1];
              if (message.role == MessageRole.user) {
                return _buildUserBubble(context, message);
              } else {
                return _buildAiBubble(context, message);
              }
            },
          ),
        ),

        // Bottom input row
        _buildBottomInputBar(context),
      ],
    );
  }

  Widget _buildEncryptionStatusBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: EarthTreeColors.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const iconoir.Lock(
                  color: EarthTreeColors.onSecondaryContainer,
                  width: 14,
                  height: 14,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Ruang Konsultasi Fitrah',
                        style: TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: EarthTreeColors.onSurface,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: EarthTreeColors.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Enkripsi Berkelanjutan • Zero Cloud Retention',
                    style: TextStyle(
                      fontFamily: EarthTreeTheme.fontSans,
                      fontSize: 11,
                      color: EarthTreeColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: EarthTreeColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const iconoir.Spark(
                  color: EarthTreeColors.secondary,
                  width: 12,
                  height: 12,
                ),
                const SizedBox(width: 4),
                Text(
                  activeModelName,
                  style: const TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
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

  Widget _buildTimeDivider(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: EarthTreeColors.surfaceContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Hari ini • Menjelang Maghrib',
          style: TextStyle(
            fontFamily: EarthTreeTheme.fontSans,
            fontSize: 11,
            color: EarthTreeColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildUserBubble(BuildContext context, ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 520),
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: EarthTreeColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x15000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Abu Hafi • Ayah',
                            style: TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 11,
                              color: EarthTreeColors.primaryFixed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 11,
                              color: EarthTreeColors.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        msg.content,
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 14,
                          height: 1.45,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconoir.Check(
                      color: EarthTreeColors.secondary,
                      width: 14,
                      height: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Tersampaikan amanah',
                      style: TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 11,
                        color: EarthTreeColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 2),
            decoration: const BoxDecoration(
              color: EarthTreeColors.primaryFixed,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.User(
              color: EarthTreeColors.primary,
              width: 18,
              height: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiBubble(BuildContext context, ChatMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: EarthTreeColors.secondary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.Sparks(
              color: Colors.white,
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 620),
              decoration: BoxDecoration(
                color: EarthTreeColors.surfaceContainer,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Teman Curhat AI',
                            style: TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: EarthTreeColors.onSurface,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: EarthTreeColors.secondaryFixed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Tazkiyah Guide',
                              style: TextStyle(
                                fontFamily: EarthTreeTheme.fontSans,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: EarthTreeColors.onSecondaryFixed,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 11,
                          color: EarthTreeColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Main Text Content
                  Text(
                    msg.content,
                    style: const TextStyle(
                      fontFamily: EarthTreeTheme.fontSans,
                      fontSize: 14,
                      height: 1.5,
                      color: EarthTreeColors.onSurface,
                    ),
                  ),

                  // Optional Dalil Card
                  if (msg.dalil != null) ...[
                    const SizedBox(height: 12),
                    _buildDalilCard(context, msg.dalil!),
                  ],

                  // Optional Embedded Document Card
                  if (msg.document != null) ...[
                    const SizedBox(height: 14),
                    _buildEmbeddedDocumentCard(context, msg.document!),
                  ],

                  // Live Metric Badges
                  if (msg.ttftMs != null || msg.tokensPerSec != null) ...[
                    const SizedBox(height: 12),
                    _buildMetricsBadge(context, msg),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDalilCard(BuildContext context, DalilCallout dalil) {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const iconoir.Book(
                color: EarthTreeColors.tertiary,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 6),
              const Text(
                'Tuntunan Welas Asih Nabawiyah',
                style: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: EarthTreeColors.tertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            dalil.arabicText,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSerif,
              fontSize: 18,
              height: 2.0,
              fontWeight: FontWeight.w700,
              color: EarthTreeColors.onSurface,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            dalil.translation,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.45,
              color: EarthTreeColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            dalil.explanation,
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

  Widget _buildEmbeddedDocumentCard(BuildContext context, RppDocument doc) {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: EarthTreeColors.primary.withValues(alpha: 0.2),
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: EarthTreeColors.primaryFixed,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const iconoir.Page(
                  color: EarthTreeColors.primary,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RPP ADAB FITRAH TERAPAN',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: EarthTreeColors.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                    ),
                    Text(
                      doc.title,
                      style: const TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: EarthTreeColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${doc.targetChild} • ${doc.phase} • ${doc.version}',
                      style: const TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 11,
                        color: EarthTreeColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 10),

          // Jadwal Transisi
          const Text(
            'Jadwal Transisi Senja:',
            style: TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: EarthTreeColors.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          ...doc.schedule.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.time} : ',
                      style: const TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: EarthTreeColors.primary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.activity} (${item.adabFocus})',
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 12,
                          color: EarthTreeColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: 10),
          // Ceklis Adab
          const Text(
            'Ceklis Amalan Karakter (5 Butir):',
            style: TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: EarthTreeColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          ...doc.checklist.map((c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    const iconoir.CheckCircle(
                      color: EarthTreeColors.secondary,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        c,
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 12,
                          color: EarthTreeColors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: 12),
          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  final text =
                      '${doc.title}\n${doc.subtitle}\n\nJadwal:\n${doc.schedule.map((s) => '${s.time}: ${s.activity}').join('\n')}\n\nCeklis:\n${doc.checklist.join('\n')}';
                  Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dokumen RPP disalin ke clipboard!')),
                  );
                },
                icon: const iconoir.Copy(
                  color: EarthTreeColors.primary,
                  width: 16,
                  height: 16,
                ),
                label: const Text(
                  'Salin Teks',
                  style: TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 12,
                    color: EarthTreeColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: EarthTreeColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Menyiapkan format A4 PDF siap cetak on-device...'),
                    ),
                  );
                },
                icon: const iconoir.Printer(
                  color: Colors.white,
                  width: 16,
                  height: 16,
                ),
                label: const Text(
                  'Cetak PDF',
                  style: TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsBadge(BuildContext context, ChatMessage msg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const iconoir.GraphUp(
            color: EarthTreeColors.secondary,
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 6),
          Text(
            'Edge Metric: TTFT ${msg.ttftMs ?? 0}ms • ${msg.tokensPerSec?.toStringAsFixed(1) ?? '0'} tokens/s • ${msg.modelName ?? activeModelName}',
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: EarthTreeColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: BoxDecoration(
        color: EarthTreeColors.surface,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Kembali ke Pijakan Permulaan',
            onPressed: onResetToPreChat,
            icon: const iconoir.Home(
              color: EarthTreeColors.onSurfaceVariant,
              width: 20,
              height: 20,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: EarthTreeColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: EarthTreeColors.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                  hintText: 'Tuliskan lanjutan curhat...',
                  hintStyle: TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 13,
                    color: EarthTreeColors.onSurfaceVariant,
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (val) {
                  if (val.trim().isNotEmpty && !isGenerating) {
                    onSend(val.trim());
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: EarthTreeColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final text = inputController.text.trim();
              if (text.isNotEmpty && !isGenerating) {
                onSend(text);
              }
            },
            icon: isGenerating
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const iconoir.Send(
                    color: Colors.white,
                    width: 18,
                    height: 18,
                  ),
          ),
        ],
      ),
    );
  }
}
