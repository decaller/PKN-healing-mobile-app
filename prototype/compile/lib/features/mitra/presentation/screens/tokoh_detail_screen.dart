import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/mitra_models.dart';

class TokohDetailScreen extends StatelessWidget {
  final TokohItem tokoh;

  const TokohDetailScreen({super.key, required this.tokoh});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profil Tokoh Pakar',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Profile Photo & Name
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: colors.surfaceContainer,
                    child: Image.network(
                      tokoh.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.person,
                        size: 54,
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  tokoh.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tokoh.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.meadowCanopy,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Quote Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD97706).withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    iconoir.Spark(
                      width: 16,
                      height: 16,
                      color: Color(0xFFD97706),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Prinsip Tarbiyah Utama",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  tokoh.goldenQuote,
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Focus & Expertise
          Text(
            "Fokus & Keahlian",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tokoh.focus,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: colors.textSecondary,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tokoh.expertiseTags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: colors.meadowCanopyContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colors.meadowCanopy.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.onMeadowCanopyContainer,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Audio Kajian / Daurah
          Text(
            "Serial Daurah & Rekaman Audio",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD97706).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const iconoir.Headset(
                    width: 20,
                    height: 20,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tokoh.audioSeries,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "Format Audio M4A High Quality • Eksklusif",
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Works & Contributions
          Text(
            "Karya & Portofolio",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const iconoir.Book(
                  width: 20,
                  height: 20,
                  color: Color(0xFF235347),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tokoh.works,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
