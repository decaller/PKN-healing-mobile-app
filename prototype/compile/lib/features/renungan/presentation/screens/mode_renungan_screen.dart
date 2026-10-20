import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../data/models/renungan_quote.dart';

class ModeRenunganScreen extends StatefulWidget {
  final VoidCallback? onClose;

  const ModeRenunganScreen({super.key, this.onClose});

  @override
  State<ModeRenunganScreen> createState() => _ModeRenunganScreenState();
}

class _ModeRenunganScreenState extends State<ModeRenunganScreen> {
  final List<RenunganQuote> _quotes = RenunganQuote.defaultQuotes;
  int _currentIndex = 0;
  Timer? _clockTimer;
  Timer? _slideTimer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });

    _slideTimer = Timer.periodic(const Duration(seconds: 8), (_) {
      _nextQuote();
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    _slideTimer?.cancel();
    super.dispose();
  }

  void _nextQuote() {
    if (!mounted) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _quotes.length;
    });
  }

  void _prevQuote() {
    if (!mounted) return;
    setState(() {
      _currentIndex = (_currentIndex - 1 + _quotes.length) % _quotes.length;
    });
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  String _formatDate(DateTime dt) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Ahad'];
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final dayName = days[dt.weekday - 1];
    final monthName = months[dt.month - 1];
    return '$dayName, ${dt.day} $monthName ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final quote = _quotes[_currentIndex];
    final timeStr = _formatTime(_now);
    final dateStr = _formatDate(_now);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1E19),
      body: Stack(
        children: [
          // Ambient Forest Background Layer
          Positioned.fill(
            child: Opacity(
              opacity: 0.38,
              child: Image.network(
                'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=1000&q=80',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),

          // Background Gradient & Ambient Glow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0D1B15).withValues(alpha: 0.75),
                    const Color(0xFF132A20).withValues(alpha: 0.85),
                    const Color(0xFF0B1612).withValues(alpha: 0.92),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF235347).withValues(alpha: 0.25),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD97706).withValues(alpha: 0.15),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              child: const iconoir.Spark(
                                width: 20,
                                height: 20,
                                color: Color(0xFFD97706),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mode Renungan Qalbu",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFFBF8F2),
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  Text(
                                    "Ketenangan sebelum bertindak",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onClose ?? () => Navigator.of(context).pop(),
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const iconoir.Xmark(
                            width: 20,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Center Quote Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      key: ValueKey<int>(_currentIndex),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xFF235347).withValues(alpha: 0.5),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (quote.category != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF235347).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF79DB8D).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                quote.category!.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF79DB8D),
                                ),
                              ),
                            ),

                          // Arabic Verse / Hadits (if available)
                          if (quote.arabic != null && quote.arabic!.isNotEmpty) ...[
                            Text(
                              quote.arabic!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 24,
                                height: 1.8,
                                color: Color(0xFFFBF8F2),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Divider(
                              color: Colors.white.withValues(alpha: 0.15),
                              thickness: 0.8,
                              indent: 40,
                              endIndent: 40,
                            ),
                            const SizedBox(height: 14),
                          ],

                          // Indonesian Translation / Quote Text
                          Text(
                            "“${quote.text}”",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Merriweather',
                              fontSize: 16,
                              height: 1.7,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFE2E8F0),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Source Badge
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const iconoir.Book(
                                width: 14,
                                height: 14,
                                color: Color(0xFFD97706),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  quote.source,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFD97706),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Slide Controls & Indicators
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _prevQuote,
                        icon: const iconoir.NavArrowLeft(
                          width: 22,
                          height: 22,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: List.generate(_quotes.length, (index) {
                          final isCurrent = index == _currentIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: isCurrent ? 24 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: isCurrent
                                  ? const Color(0xFF79DB8D)
                                  : Colors.white.withValues(alpha: 0.2),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _nextQuote,
                        icon: const iconoir.NavArrowRight(
                          width: 22,
                          height: 22,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Bottom Digital Clock & Date
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Large Digital Time
                      Text(
                        timeStr,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3.0,
                          color: Color(0xFFFBF8F2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$dateStr • 3 Rabi'ul Akhir 1448 H",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF94A3B8).withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
