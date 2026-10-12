import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../sanctuary/presentation/screens/ai_sanctuary_screen.dart';

class RecommendationsSection extends StatelessWidget {
  final VoidCallback? onCurhatTap;
  final VoidCallback? onDaurahTap;
  final VoidCallback? onBakatTap;
  final VoidCallback? onGeneratorTap;

  const RecommendationsSection({
    super.key,
    this.onCurhatTap,
    this.onDaurahTap,
    this.onBakatTap,
    this.onGeneratorTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rekomendasi",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Promo 1 (AI Curhat)
          _buildCard(
            context,
            icon: iconoir.Lock(width: 22, height: 22, color: colors.onCelestialSky),
            iconBg: colors.celestialSky,
            badgeText: "Zero Cloud • 100% Amanah",
            badgeColor: colors.celestialSky,
            badgeBg: colors.celestialSkyContainer.withValues(alpha: 0.4),
            title: "Curhat Batin AI 24 Jam Bebas Penghakiman",
            desc:
                "Ekspresikan lelah dan kegelisahan ayah-bunda secara privat. Tanpa riwayat tersimpan ke server.",
            buttonText: "Mulai Curhat Mandiri",
            buttonIcon: iconoir.ChatBubble(width: 16, height: 16, color: colors.onCelestialSky),
            buttonBg: colors.celestialSky,
            buttonTextColor: colors.onCelestialSky,
            gradientEnd: colors.celestialSkyContainer.withValues(alpha: 0.25),
            onTap: onCurhatTap ??
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const AiSanctuaryScreen()),
                  );
                },
          ),
          const SizedBox(height: 12),

          // Promo 2 (Daurah)
          _buildCard(
            context,
            icon: iconoir.Calendar(width: 22, height: 22, color: colors.onMeadowCanopy),
            iconBg: colors.meadowCanopy,
            badgeText: "Sisa 12 Kursi",
            badgeColor: colors.error,
            badgeBg: colors.errorContainer,
            title: "Daurah Eksklusif Cikarang: Khusus Ayah Penggerak",
            desc:
                "Bedah kurikulum thariqah peradaban keluarga bersama asatidz & praktisi fitrah.",
            buttonText: "Klaim Tiket Pass",
            buttonIcon: iconoir.ArrowRight(width: 16, height: 16, color: colors.onMeadowCanopy),
            buttonBg: colors.meadowCanopy,
            buttonTextColor: colors.onMeadowCanopy,
            gradientEnd: colors.meadowCanopyContainer.withValues(alpha: 0.2),
            onTap: onDaurahTap ?? () {},
          ),
          const SizedBox(height: 12),

          // Promo 3 (Pemetaan Syakilah)
          _buildCard(
            context,
            icon: iconoir.Brain(width: 22, height: 22, color: colors.onAncientBark),
            iconBg: colors.ancientBark,
            badgeText: "Pemetaan Syakilah",
            badgeColor: colors.ancientBark,
            badgeBg: colors.ancientBarkContainer.withValues(alpha: 0.4),
            title: "Tafsir Bakat 40",
            desc:
                "Pemetaan komprehensif 40 ragam bakat dan fitrah kepemimpinan ananda berdasarkan taksonomi Syakilah nabawiyah.",
            buttonText: "Mulai Pemetaan Bakat",
            buttonIcon: iconoir.ArrowRight(width: 16, height: 16, color: colors.onAncientBark),
            buttonBg: colors.ancientBark,
            buttonTextColor: colors.onAncientBark,
            onTap: onBakatTap ?? () {},
          ),
          const SizedBox(height: 12),

          // Promo 4 (Program Generator Siap Cetak)
          _buildCard(
            context,
            icon: iconoir.Printer(width: 22, height: 22, color: colors.textSecondary),
            iconBg: colors.surfaceContainerHighest,
            title: "Program Generator (siap cetak)",
            desc:
                "Generator program adab harian dan kurikulum keluarga dan sekolah yang siap diunduh dan dicetak mandiri.",
            buttonText: "Buat Program Siap Cetak",
            buttonIcon: iconoir.Printer(width: 16, height: 16, color: colors.celestialSky),
            isOutlineButton: true,
            buttonTextColor: colors.celestialSky,
            onTap: onGeneratorTap ?? () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required Widget icon,
    required Color iconBg,
    String? badgeText,
    Color? badgeColor,
    Color? badgeBg,
    required String title,
    required String desc,
    required String buttonText,
    required Widget buttonIcon,
    Color? buttonBg,
    Color? buttonTextColor,
    bool isOutlineButton = false,
    Color? gradientEnd,
    required VoidCallback onTap,
  }) {
    final colors = context.earthTree;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        gradient: gradientEnd != null
            ? LinearGradient(
                colors: [colors.surfaceContainer, gradientEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.tactileBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x082C2825),
            offset: Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBg,
            ),
            child: Center(child: icon),
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badgeText != null && badgeColor != null && badgeBg != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: badgeColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 13,
                    height: 1.5,
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                if (isOutlineButton)
                  FButton.raw(
                    onPress: onTap,
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 38),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: colors.celestialSky.withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              buttonText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: buttonTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          buttonIcon,
                        ],
                      ),
                    ),
                  )
                else
                  FButton.raw(
                    onPress: onTap,
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 38),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: buttonBg,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: (buttonBg ?? Colors.black).withValues(alpha: 0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              buttonText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: buttonTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          buttonIcon,
                        ],
                      ),
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
