import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';

class P3kCrisisModal extends StatefulWidget {
  const P3kCrisisModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const P3kCrisisModal(),
    );
  }

  @override
  State<P3kCrisisModal> createState() => _P3kCrisisModalState();
}

class _P3kCrisisModalState extends State<P3kCrisisModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: colors.textMuted.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colors.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: iconoir.WarningTriangle(
                        width: 22,
                        height: 22,
                        color: colors.error,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "P3K Krisis Genting",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: colors.textPrimary,
                            ),
                          ),
                          Text(
                            "SOP Tindakan Cepat < 10 Detik",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: iconoir.Xmark(
                    width: 20,
                    height: 20,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // Segmented Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.tactileBorder),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: colors.meadowCanopyContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                labelColor: colors.onMeadowCanopyContainer,
                unselectedLabelColor: colors.textSecondary,
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: "1. Anak Tantrum"),
                  Tab(text: "2. Ortu Burnout"),
                ],
              ),
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAnakTantrumTab(context, colors),
                _buildOrtuBurnoutTab(context, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnakTantrumTab(BuildContext context, EarthTreeColors colors) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        // Priority Notice
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.ancientBarkContainer.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colors.ancientBarkContainer.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              iconoir.ShieldCheck(
                width: 20,
                height: 20,
                color: colors.onAncientBarkContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Maqashid Syariah #1: Hifzhun Nafs (Lindungi Jiwa & Keselamatan Raga Terlebih Dahulu)",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        _buildStepCard(
          stepNumber: "1",
          title: "Amankan Bahaya Fisik (Hifzhun Nafs)",
          instruction: "Segera jauhkan benda keras/tajam. Pindahkan ananda ke sudut aman. Jangan biarkan anak mencederai diri atau orang lain.",
          accentColor: colors.error,
          colors: colors,
        ),
        const SizedBox(height: 10),

        _buildStepCard(
          stepNumber: "2",
          title: "Tahan Lisan Sendiri (Kazhmul Ghaizh)",
          instruction: "Hentikan bentakan & debat! Anak sedang dibajak amarah, logika tidak berfungsi. Nabi ﷺ bersabda: 'Jika marah, hendaklah diam.'",
          accentColor: colors.ancientBark,
          colors: colors,
        ),
        const SizedBox(height: 10),

        _buildStepCard(
          stepNumber: "3",
          title: "Koneksi Sebelum Koreksi (Peluk Fisik)",
          instruction: "Duduk sejajar matanya. Rentangkan tangan, tawarkan pelukan lembut: 'Ayah di sini bersamamu, kamu aman.'",
          accentColor: colors.meadowCanopy,
          colors: colors,
        ),
        const SizedBox(height: 10),

        _buildStepCard(
          stepNumber: "4",
          title: "Arahkan Akal & Nasihat (Saat Sudah Tenang)",
          instruction: "Tunggu 5-10 menit hingga detak jantung anak normal. Baru tanyakan perasaannya dan ajak beristighfar bersama.",
          accentColor: colors.celestialSky,
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildOrtuBurnoutTab(BuildContext context, EarthTreeColors colors) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        // Quick Reminder
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.meadowCanopyContainer.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colors.meadowCanopyContainer.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            children: [
              iconoir.Heart(
                width: 20,
                height: 20,
                color: colors.onMeadowCanopyContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "“Bejana cinta orang tua yang kosong tidak akan mampu mengalirkan kasih sayang kepada anak.”",
                  style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        _buildStepCard(
          stepNumber: "1",
          title: "Ubah Posisi Fisik (Sunnah Nabawiyah)",
          instruction: "Jika sedang berdiri, segeralah duduk. Jika sudah duduk dan masih emosi, berbaringlah sejenak untuk meredakan aliran adrenalin.",
          accentColor: colors.error,
          colors: colors,
        ),
        const SizedBox(height: 10),

        _buildStepCard(
          stepNumber: "2",
          title: "Ta'awwudz & Wudhu Air Dingin",
          instruction: "Ucapkan A'udzubillahi minasy-syaithanir-rajim. Segera basuh muka atau berwudhu dengan air sejuk untuk memadamkan api amarah.",
          accentColor: colors.celestialSky,
          colors: colors,
        ),
        const SizedBox(height: 10),

        _buildStepCard(
          stepNumber: "3",
          title: "Safety Time-out Ortu (Tarik Nafas 4-7-8)",
          instruction: "Menjauhlah 2-3 menit ke ruangan lain (pastikan anak aman). Tarik nafas 4 detik, tahan 7 detik, hembuskan perlahan 8 detik.",
          accentColor: colors.meadowCanopy,
          colors: colors,
        ),
        const SizedBox(height: 10),

        _buildStepCard(
          stepNumber: "4",
          title: "Munajat Fudhail bin 'Iyadh",
          instruction: "“Ya Allah, sesungguhnya aku telah berusaha mendidik anakku namun aku lemah tak berdaya, maka didiklah dia untukku.”",
          accentColor: colors.ancientBark,
          colors: colors,
        ),
      ],
    );
  }

  Widget _buildStepCard({
    required String stepNumber,
    required String title,
    required String instruction,
    required Color accentColor,
    required EarthTreeColors colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.tactileBorder,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withValues(alpha: 0.4)),
            ),
            child: Center(
              child: Text(
                stepNumber,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  instruction,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.45,
                    color: colors.textSecondary,
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
