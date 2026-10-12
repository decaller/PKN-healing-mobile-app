import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class WalkieTalkieScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const WalkieTalkieScreen({super.key, this.onBack});

  @override
  State<WalkieTalkieScreen> createState() => _WalkieTalkieScreenState();
}

class _WalkieTalkieScreenState extends State<WalkieTalkieScreen>
    with SingleTickerProviderStateMixin {
  bool _isHoldingPtt = false;
  String _statusText =
      'Mode Walkie-Talkie Aktif • Tahan untuk bicara, lepas untuk mendengar';

  late AnimationController _waveController;
  Timer? _simulatedVoiceTimer;

  final List<Map<String, String>> _transcript = [
    {
      'role': 'user',
      'text':
          'Assalamu’alaikum, ana merasa dada sangat sesak saat anak membantah perintah shalat sore ini...',
      'time': '16:40',
    },
    {
      'role': 'ai',
      'text':
          'Wa’alaikumussalam warahmatullah. Tarik napas dalam, Ayah. Ingatlah wasiat Rasulullah ﷺ: La taghdhob wa lakal jannah (Jangan marah, bagimu surga). Suara Ayah yang tenang adalah pelindung pertama bagi fitrah ananda.',
      'time': '16:41',
    },
  ];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveController.dispose();
    _simulatedVoiceTimer?.cancel();
    super.dispose();
  }

  void _onPttDown() {
    setState(() {
      _isHoldingPtt = true;
      _statusText = 'Merekam getaran suara kalbu... Bicara dengan tenang.';
    });
  }

  void _onPttUp() {
    if (!_isHoldingPtt) return;
    setState(() {
      _isHoldingPtt = false;
      _statusText = 'Memproses inferensi suara on-device (LiteRT Audio8)...';
    });

    _simulatedVoiceTimer = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _transcript.add({
          'role': 'user',
          'text':
              'Bagaimana memulai kalimat pertama agar anak tidak merasa dipojokkan?',
          'time': '16:43',
        });
        _statusText = 'AI menanggapi melalui transmisi audio ramah...';
      });

      Timer(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        setState(() {
          _transcript.add({
            'role': 'ai',
            'text':
                'Mulai dengan pujian fitrah: “Zaid anak hebat kesayangan Ayah, yuk sejenak kita hampari sajadah bersama.” Jadikan ajakan sebagai kehormatan, bukan interogasi.',
            'time': '16:43',
          });
          _statusText =
              'Mode Walkie-Talkie Siap • Tahan untuk bicara kembali.';
        });
      });
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
              'Ruang Qalbu Walkie-Talkie',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Push-to-Talk Audio Refleksi • 100% On-Device',
              style: TextStyle(
                color: colors.meadowCanopy,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Banner Status
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.meadowCanopy.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.meadowCanopy.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                iconoir.Microphone(
                  color: colors.meadowCanopy,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _statusText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // PTT Button Core
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTapDown: (_) => _onPttDown(),
                  onTapUp: (_) => _onPttUp(),
                  onTapCancel: () => _onPttUp(),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: _isHoldingPtt ? 140 : 130,
                    height: _isHoldingPtt ? 140 : 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHoldingPtt
                          ? colors.meadowCanopy
                          : colors.tactileBorder.withOpacity(0.2),
                      border: Border.all(
                        color: _isHoldingPtt
                            ? colors.meadowCanopy
                            : colors.tactileBorder,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _isHoldingPtt
                              ? colors.meadowCanopy.withOpacity(0.4)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: _isHoldingPtt ? 24 : 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          iconoir.Voice(
                            color: _isHoldingPtt
                                ? colors.onMeadowCanopy
                                : colors.textPrimary,
                            width: 36,
                            height: 36,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _isHoldingPtt ? 'LEPAS' : 'TAHAN',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                              color: _isHoldingPtt
                                  ? colors.onMeadowCanopy
                                  : colors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _isHoldingPtt
                      ? 'Sedang merekam...'
                      : 'Tekan & tahan tombol untuk berbicara',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Transkripsi Sesi
          Text(
            'TRANSKRIP PERCAKAPAN SUARA',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          ..._transcript.map((item) {
            final isUser = item['role'] == 'user';
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isUser
                    ? colors.tactileBorder.withOpacity(0.12)
                    : colors.meadowCanopy.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isUser
                      ? colors.tactileBorder
                      : colors.meadowCanopy.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isUser ? 'Ayah (Suara PTT)' : 'Pendamping Qalbu AI',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isUser
                              ? colors.textPrimary
                              : colors.meadowCanopy,
                        ),
                      ),
                      Text(
                        item['time'] ?? '',
                        style: TextStyle(
                          fontSize: 10,
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['text'] ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
