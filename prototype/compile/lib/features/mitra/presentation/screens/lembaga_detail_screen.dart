import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/mitra_models.dart';
import 'kemitraan_form_sheet.dart';

class LembagaDetailScreen extends StatelessWidget {
  final LembagaItem lembaga;

  const LembagaDetailScreen({super.key, required this.lembaga});

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
          'Profil Lembaga Mitra',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          border: Border(top: BorderSide(color: colors.tactileBorder)),
        ),
        child: SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {
              KemitraanFormSheet.show(
                context,
                preselectedService: "Visitasi ke ${lembaga.name}",
              );
            },
            icon: const iconoir.SendDiagonal(width: 18, height: 18, color: Colors.white),
            label: Text(
              "Ajukan Studi Banding / Kemitraan",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF235347),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 180,
              width: double.infinity,
              color: colors.surfaceContainer,
              child: Image.network(
                lembaga.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.business,
                  size: 54,
                  color: colors.textMuted,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Badge Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lembaga.city,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "${lembaga.studentsCount} Santri Terbina",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colors.meadowCanopy,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            lembaga.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            lembaga.type,
            style: TextStyle(
              fontSize: 13,
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 18),

          // Description
          Text(
            "Tentang Lembaga",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lembaga.description,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: colors.textSecondary,
            ),
          ),

          const SizedBox(height: 20),

          // Program Kerjasama
          Text(
            "Program Kerjasama Resmi",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const iconoir.Building(
                  width: 22,
                  height: 22,
                  color: Color(0xFF235347),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    lembaga.partnershipProgram,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
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
