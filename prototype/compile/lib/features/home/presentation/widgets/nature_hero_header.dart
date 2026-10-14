import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class NatureHeroHeader extends StatelessWidget {
  final VoidCallback? onOpenRenungan;
  final VoidCallback? onToggleTheme;
  final VoidCallback? onAvatarTap;

  const NatureHeroHeader({
    super.key,
    this.onOpenRenungan,
    this.onToggleTheme,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onVerticalDragEnd: (details) {
        // Dragging down triggers Mode Renungan
        if (details.primaryVelocity != null && details.primaryVelocity! > 200) {
          onOpenRenungan?.call();
        }
      },
      child: Container(
        width: double.infinity,
        height: 275,
        decoration: const BoxDecoration(
          color: Color(0xFF0F1E19),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A1612),
              Color(0xFF132A20),
              Color(0xFF1B382B),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Ambient Tree/Nature Background Layer (with graceful offline fallback)
            Positioned.fill(
              child: Opacity(
                opacity: 0.35,
                child: Image.network(
                  'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),

            // Atmospheric Glows
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF235347).withValues(alpha: 0.35),
                ),
              ),
            ),

            // Top gradient overlay for seamless contrast
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.45),
                      Colors.transparent,
                      colors.surface.withValues(alpha: 0.95),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            // Header Content
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Clean Top Bar: Greeting on Left, Theme Toggle & Avatar on Right
                    // (Explicitly NO "Fase Tamyiz" badge and NO "Alternatif" button)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Greeting
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ahlan, Abu Zaid",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFFBF8F2),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Keluarga Tangguh • Baiti Jannati",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF94A3B8),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Actions: Theme Toggle & Avatar
                        Row(
                          children: [
                            IconButton(
                              tooltip: 'Ganti Tema',
                              onPressed: onToggleTheme,
                              icon: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.15),
                                  ),
                                ),
                                child: isDark
                                    ? const iconoir.SunLight(
                                        width: 18,
                                        height: 18,
                                        color: Color(0xFFF6BB81),
                                      )
                                    : const iconoir.HalfMoon(
                                        width: 18,
                                        height: 18,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: onAvatarTap,
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF235347),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "AZ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Integrated Nature Hero Quote Card (Tappable to Mode Renungan)
                    GestureDetector(
                      onTap: onOpenRenungan,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF79DB8D).withValues(alpha: 0.35),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const iconoir.Spark(
                                    width: 14,
                                    height: 14,
                                    color: Color(0xFFD97706),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Flexible(
                                  child: Text(
                                    "Renungan Qalbu Hari Ini",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF79DB8D),
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Row(
                                  children: [
                                    Text(
                                      "Buka Layar Penuh",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withValues(alpha: 0.75),
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 10,
                                      color: Colors.white.withValues(alpha: 0.75),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "“Koneksi Sebelum Koreksi — Tautkan hati dan penuhi bejana cinta sebelum menegakkan aturan.”",
                              style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 12.5,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFFBF8F2),
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
