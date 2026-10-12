import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../core/services/edge_llm_service.dart';
import '../../core/theme/earth_tree_theme.dart';

class WalkieTalkieView extends StatefulWidget {
  final EdgeLlmService edgeService;
  final String activeModelId;

  const WalkieTalkieView({
    super.key,
    required this.edgeService,
    required this.activeModelId,
  });

  @override
  State<WalkieTalkieView> createState() => _WalkieTalkieViewState();
}

class _WalkieTalkieViewState extends State<WalkieTalkieView>
    with SingleTickerProviderStateMixin {
  bool _isHoldingPtt = false;
  bool _isLoudspeaker = true;
  bool _isNoiseFilterOn = true;
  bool _isMuted = false;
  String _statusText = 'Mode Walkie-Talkie Aktif • Tahan untuk bicara, lepas untuk mendengar';

  late AnimationController _waveController;
  Timer? _simulatedVoiceTimer;

  final List<Map<String, String>> _transcript = [
    {
      'role': 'user',
      'text': 'Assalamu’alaikum, ana merasa dada sangat sesak saat anak membantah perintah shalat sore ini...',
      'time': '16:40',
    },
    {
      'role': 'ai',
      'text': 'Wa’alaikumussalam warahmatullah. Tarik napas dalam, Ayah. Ingatlah wasiat Rasulullah ﷺ: La taghdhob wa lakal jannah (Jangan marah, bagimu surga). Suara Ayah yang tenang adalah pelindung pertama bagi fitrah ananda.',
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
      _statusText = 'Memproses inferensi suara on-device (LiteRT / Edge)...';
    });

    _simulatedVoiceTimer = Timer(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _transcript.add({
          'role': 'user',
          'text': 'Bagaimana memulai kalimat pertama agar anak tidak merasa dipojokkan?',
          'time': '16:43',
        });
        _statusText = 'AI menanggapi melalui transmisi audio ramah...';
      });

      Timer(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        setState(() {
          _transcript.add({
            'role': 'ai',
            'text': 'Mulai dengan pujian fitrah: “Zaid anak hebat kesayangan Ayah, yuk sejenak kita hampari sajadah bersama.” Jadikan ajakan sebagai kehormatan, bukan interogasi.',
            'time': '16:43',
          });
          _statusText = 'Mode Walkie-Talkie Siap • Tahan untuk bicara kembali.';
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildContextBanner(),
          const SizedBox(height: 16),
          _buildDeviceMonolith(),
          const SizedBox(height: 20),
          _buildTranscriptSection(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildContextBanner() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: EarthTreeColors.secondary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const iconoir.Voice(
              color: EarthTreeColors.secondary,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: EarthTreeColors.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'TAZKIYAH SESSION',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: EarthTreeColors.secondary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Walkie-Talkie Ruang Qalbu',
                  style: TextStyle(
                    fontFamily: EarthTreeTheme.fontSerif,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: EarthTreeColors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sampaikan gundah gulana sejenak dengan nafas teratur. Dekatkan ponsel, tekan untuk bertutur.',
                  style: TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 12,
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

  Widget _buildDeviceMonolith() {
    return Container(
      decoration: BoxDecoration(
        color: EarthTreeColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: EarthTreeColors.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: EarthTreeColors.surfaceContainerLowest.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: EarthTreeColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Resonansi Qalbu • 142.4 MHz',
                      style: TextStyle(
                        fontFamily: EarthTreeTheme.fontSans,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: EarthTreeColors.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  iconoir.Antenna(
                    color: EarthTreeColors.secondary,
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Fitrah Link',
                    style: TextStyle(
                      fontFamily: EarthTreeTheme.fontSans,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: EarthTreeColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          Column(
            children: [
              _buildGrillLine(0.75),
              const SizedBox(height: 3),
              _buildGrillLine(0.65),
              const SizedBox(height: 3),
              _buildGrillLine(0.75),
              const SizedBox(height: 3),
              _buildGrillLine(0.50),
            ],
          ),
          const SizedBox(height: 14),

          Container(
            height: 64,
            width: double.infinity,
            decoration: BoxDecoration(
              color: EarthTreeColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (context, _) {
                final factor = _isHoldingPtt ? 1.8 : 0.8;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWaveBar(14 * factor, EarthTreeColors.secondary),
                    _buildWaveBar(26 * factor, EarthTreeColors.secondary.withValues(alpha: 0.8)),
                    _buildWaveBar(40 * factor, EarthTreeColors.primary.withValues(alpha: 0.7)),
                    _buildWaveBar(50 * factor, EarthTreeColors.primary),
                    _buildWaveBar(32 * factor, EarthTreeColors.secondary),
                    _buildWaveBar(44 * factor, EarthTreeColors.primary),
                    _buildWaveBar(20 * factor, EarthTreeColors.secondary.withValues(alpha: 0.7)),
                    _buildWaveBar(36 * factor, EarthTreeColors.primary),
                    _buildWaveBar(46 * factor, EarthTreeColors.secondary),
                    _buildWaveBar(16 * factor, EarthTreeColors.secondary.withValues(alpha: 0.6)),
                    _buildWaveBar(28 * factor, EarthTreeColors.primary.withValues(alpha: 0.8)),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          Text(
            _statusText,
            style: const TextStyle(
              fontFamily: EarthTreeTheme.fontSans,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: EarthTreeColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTapDown: (_) => _onPttDown(),
            onTapUp: (_) => _onPttUp(),
            onTapCancel: () => _onPttUp(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _isHoldingPtt ? 150 : 110,
                  height: _isHoldingPtt ? 150 : 110,
                  decoration: BoxDecoration(
                    color: EarthTreeColors.primary.withValues(alpha: _isHoldingPtt ? 0.18 : 0.06),
                    shape: BoxShape.circle,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isHoldingPtt ? 124 : 100,
                  height: _isHoldingPtt ? 124 : 100,
                  decoration: BoxDecoration(
                    color: EarthTreeColors.secondaryFixed.withValues(alpha: _isHoldingPtt ? 0.45 : 0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: _isHoldingPtt ? EarthTreeColors.secondary : EarthTreeColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isHoldingPtt ? EarthTreeColors.secondary : EarthTreeColors.primary)
                            .withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const iconoir.Microphone(
                        color: Colors.white,
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isHoldingPtt ? 'BICARA' : 'TAHAN',
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ActionChip(
                backgroundColor: EarthTreeColors.surfaceContainerLow,
                avatar: iconoir.SoundHigh(
                  color: _isLoudspeaker ? EarthTreeColors.primary : EarthTreeColors.onSurfaceVariant,
                  width: 16,
                  height: 16,
                ),
                label: Text(
                  _isLoudspeaker ? 'Loudspeaker' : 'Earpiece',
                  style: const TextStyle(
                    fontFamily: EarthTreeTheme.fontSans,
                    fontSize: 11,
                  ),
                ),
                onPressed: () {
                  setState(() => _isNoiseFilterOn = !_isNoiseFilterOn);
                  setState(() => _isLoudspeaker = !_isLoudspeaker);
                },
              ),
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _isNoiseFilterOn ? EarthTreeColors.secondary : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Noise Filter Fitrah',
                    style: TextStyle(
                      fontFamily: EarthTreeTheme.fontSans,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _isNoiseFilterOn
                          ? EarthTreeColors.secondary
                          : EarthTreeColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: EarthTreeColors.surfaceContainerLow,
                ),
                onPressed: () {
                  setState(() => _isNoiseFilterOn = !_isNoiseFilterOn);
                  setState(() => _isMuted = !_isMuted);
                },
                icon: iconoir.MicrophoneMute(
                  color: _isMuted ? EarthTreeColors.error : EarthTreeColors.onSurfaceVariant,
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

  Widget _buildGrillLine(double widthFraction) {
    return FractionallySizedBox(
      widthFactor: widthFraction,
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: EarthTreeColors.surfaceDim,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildWaveBar(double height, Color color) {
    final clampedHeight = height.clamp(4.0, 56.0);
    return Container(
      width: 5,
      height: clampedHeight,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildTranscriptSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const iconoir.ChatBubble(
                  color: EarthTreeColors.secondary,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'Transkripsi & Dialog Hati',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontFamily: EarthTreeTheme.fontSerif,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: EarthTreeColors.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Real-time Stream',
                style: TextStyle(
                  fontFamily: EarthTreeTheme.fontSans,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: EarthTreeColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._transcript.map((item) {
          final isUser = item['role'] == 'user';
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser
                  ? EarthTreeColors.surfaceContainerLow
                  : EarthTreeColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: EarthTreeColors.outlineVariant.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isUser ? Icons.person_outline : Icons.auto_awesome,
                  size: 16,
                  color: isUser ? EarthTreeColors.primary : EarthTreeColors.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isUser ? 'Abu Hafi (Suara)' : 'Teman Curhat AI (Audio8 Respon)',
                            style: TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isUser ? EarthTreeColors.primary : EarthTreeColors.secondary,
                            ),
                          ),
                          Text(
                            item['time']!,
                            style: const TextStyle(
                              fontFamily: EarthTreeTheme.fontSans,
                              fontSize: 10,
                              color: EarthTreeColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['text']!,
                        style: const TextStyle(
                          fontFamily: EarthTreeTheme.fontSans,
                          fontSize: 13,
                          height: 1.4,
                          color: EarthTreeColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
