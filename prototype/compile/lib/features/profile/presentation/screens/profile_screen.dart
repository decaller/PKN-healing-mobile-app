import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../renungan/presentation/screens/mode_renungan_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onToggleTheme;
  final VoidCallback? onBack;

  const ProfileScreen({
    super.key,
    this.onToggleTheme,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: onBack != null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
                onPressed: onBack,
              )
            : null,
        title: Text(
          'Profil & Pengaturan',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // User Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF235347),
                    border: Border.all(
                      color: colors.meadowCanopy.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "AZ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Abu Zaid",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Ayah Peduli Adab • Fase Tamyiz",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colors.meadowCanopyContainer.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Akun Wali Santri Mitra PKN",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: colors.onMeadowCanopyContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Shortcut Mode Renungan
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF132A20), Color(0xFF235347)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ModeRenunganScreen(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle,
                        ),
                        child: iconoir.Spark(
                          width: 20,
                          height: 20,
                          color: Color(0xFFF6BB81),
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Buka Mode Renungan",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Layar penuh quote nabawiyah & jam digital",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white70),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Pengaturan Tampilan
          Text(
            "Preferensi & Tampilan",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: ListTile(
              leading: isDark
                  ? const iconoir.HalfMoon(width: 22, height: 22, color: Color(0xFFF6BB81))
                  : const iconoir.SunLight(width: 22, height: 22, color: Color(0xFFD97706)),
              title: Text(
                "Tema Tampilan",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              subtitle: Text(
                isDark ? "Mode Gelap (Mineral Basalt)" : "Mode Terang (Sand Ecru)",
                style: TextStyle(fontSize: 12, color: colors.textMuted),
              ),
              trailing: Switch(
                value: isDark,
                activeColor: const Color(0xFF235347),
                onChanged: (_) => onToggleTheme?.call(),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Milestone 1 Status Card
          Text(
            "Cakupan Milestone 1 (Fase 1)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMilestoneItem("Modul 1: Agenda Daurah", "List & Detail kajian asatidzah", true, colors),
                const Divider(height: 16),
                _buildMilestoneItem("Modul 2: Pustaka Nabawiyah", "Katalog buku karya PKN", true, colors),
                const Divider(height: 16),
                _buildMilestoneItem("Modul 3: Tokoh & Mitra", "Profil 4 asatidzah & 6 lembaga", true, colors),
                const Divider(height: 16),
                _buildMilestoneItem("Modul 4: Kemitraan Lembaga", "4 pilar layanan & form pengajuan", true, colors),
                const Divider(height: 16),
                _buildMilestoneItem("Home 1/3 Nature Tree Hero", "Mode Renungan + P3K Krisis <10s", true, colors),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Center(
            child: Text(
              "PKN Mobile App v1.0.0 (Milestone 1 Flutter Web)\nManhaj Karakter Nabawiyah",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: colors.textMuted,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(
    String title,
    String desc,
    bool done,
    EarthTreeColors colors,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF235347).withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            size: 14,
            color: Color(0xFF235347),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
