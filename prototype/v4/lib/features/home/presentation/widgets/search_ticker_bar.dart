import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class SearchTickerBar extends StatefulWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onCurhatTap;

  const SearchTickerBar({super.key, this.onSearchTap, this.onCurhatTap});

  @override
  State<SearchTickerBar> createState() => _SearchTickerBarState();
}

class _SearchTickerBarState extends State<SearchTickerBar> {
  static const _questions = [
    "Bagaimana merespon anak tantrum saat maghrib?",
    "Cara menumbuhkan fitrah kepemimpinan anak?",
    "SOP mengatasi anak mogok shalat berjamaah?",
    "Menangani kecemasan ibu saat balita menolak makan?",
    "Kapan saat tepat memulai dialog fitrah seksualitas?",
  ];

  int _currentIndex = 0;
  Timer? _tickerTimer;

  @override
  void initState() {
    super.initState();
    _tickerTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _questions.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }

  void _showCurhatModal(BuildContext context) {
    HapticFeedback.mediumImpact();
    final colors = context.earthTree;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: colors.tactileBorder),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colors.tactileBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconoir.Voice(
                    width: 22,
                    height: 22,
                    color: colors.celestialSky,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "AI Sanctuary • Curhat Cepat",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Ruang aman dan hening untuk menyuarakan rasa lelah pengasuhan. Dilindungi etika kerahasiaan on-device tanpa pelacakan.",
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              // Tombol Mic Pulsing
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.celestialSky,
                  boxShadow: [
                    BoxShadow(
                      color: colors.celestialSky.withValues(alpha: 0.3),
                      blurRadius: 18,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const iconoir.Microphone(
                    width: 32,
                    height: 32,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    Navigator.pop(ctx);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Ketuk untuk mulai berbicara langsung",
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.tactileBorder),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A2C2825),
              offset: Offset(0, 4),
              blurRadius: 16,
            ),
          ],
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            const SizedBox(width: 8),
            // Ikon Search dari Iconoir
            iconoir.Search(
              width: 20,
              height: 20,
              color: colors.textMuted,
            ),
            const SizedBox(width: 10),
            // Ticker Pertanyaan Dinamis
            Expanded(
              child: GestureDetector(
                onTap: widget.onSearchTap,
                child: SizedBox(
                  height: 28,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.25),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      key: ValueKey<int>(_currentIndex),
                      child: Text(
                        _questions[_currentIndex],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Tombol Walkie-Talkie Curhat Cepat
            Material(
              color: colors.celestialSky,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (widget.onCurhatTap != null) {
                    widget.onCurhatTap!();
                  } else {
                    _showCurhatModal(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const iconoir.Voice(
                        width: 18,
                        height: 18,
                        color: Colors.white,
                      ),
                      if (!context.isCompactMobile) ...[
                        const SizedBox(width: 6),
                        Text(
                          "Curhat Cepat",
                          style: context.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
