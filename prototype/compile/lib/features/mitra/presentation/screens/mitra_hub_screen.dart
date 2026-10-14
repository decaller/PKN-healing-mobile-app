import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../services/mitra_service.dart';
import 'kemitraan_form_sheet.dart';
import 'lembaga_detail_screen.dart';
import 'tokoh_detail_screen.dart';

class MitraHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final int initialTabIndex;

  const MitraHubScreen({
    super.key,
    this.onBack,
    this.initialTabIndex = 0,
  });

  @override
  State<MitraHubScreen> createState() => _MitraHubScreenState();
}

class _MitraHubScreenState extends State<MitraHubScreen>
    with SingleTickerProviderStateMixin {
  final MitraService _service = MitraService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        title: Text(
          'Tokoh & Kemitraan Lembaga',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          // Segmented Tab Switcher
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
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: "Tokoh Pakar"),
                  Tab(text: "Lembaga Mitra"),
                  Tab(text: "Kemitraan"),
                ],
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTokohTab(colors),
                _buildLembagaTab(colors),
                _buildKemitraanTab(colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokohTab(EarthTreeColors colors) {
    final list = _service.getTokohList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final tokoh = list[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.tactileBorder),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => TokohDetailScreen(tokoh: tokoh),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 68,
                      height: 68,
                      color: colors.surfaceContainer,
                      child: Image.network(
                        tokoh.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.person,
                          size: 36,
                          color: colors.textMuted,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tokoh.name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          tokoh.title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colors.meadowCanopy,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          tokoh.focus,
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.textSecondary,
                            height: 1.35,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const iconoir.Headset(
                              width: 14,
                              height: 14,
                              color: Color(0xFFD97706),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                tokoh.audioSeries,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFD97706),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLembagaTab(EarthTreeColors colors) {
    final list = _service.getLembagaList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final lembaga = list[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.tactileBorder),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => LembagaDetailScreen(lembaga: lembaga),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colors.ancientBarkContainer.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          lembaga.acronym,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: colors.onAncientBarkContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "• ${lembaga.city}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.textMuted,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          iconoir.Group(
                            width: 14,
                            height: 14,
                            color: colors.textMuted,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${lembaga.studentsCount} santri",
                            style: TextStyle(
                              fontSize: 11,
                              color: colors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lembaga.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lembaga.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const iconoir.Building(
                          width: 14,
                          height: 14,
                          color: Color(0xFF235347),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Program: ${lembaga.partnershipProgram}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildKemitraanTab(EarthTreeColors colors) {
    final list = _service.getKemitraanServices();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        // Header Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF235347),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  iconoir.Spark(width: 18, height: 18, color: Color(0xFFD97706)),
                  SizedBox(width: 8),
                  Text(
                    "4 Format Layanan Resmi PKN",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Mendampingi sekolah, kuttab, pesantren, dan komunitas parenting membangun ekosistem adab sebelum ilmu.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        ...list.map((serv) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colors.meadowCanopyContainer.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const iconoir.CheckCircle(
                        width: 22,
                        height: 22,
                        color: Color(0xFF235347),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serv.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "${serv.target} • ${serv.duration}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colors.meadowCanopy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  serv.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSecondary,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Output & Fasilitas:",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                ...serv.deliverables.map((d) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(
                            d,
                            style: TextStyle(fontSize: 11, color: colors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      KemitraanFormSheet.show(context, preselectedService: serv.title);
                    },
                    icon: const iconoir.SendDiagonal(width: 16, height: 16, color: Colors.white),
                    label: const Text(
                      "Ajukan Kerjasama Layanan Ini",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF235347),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
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
