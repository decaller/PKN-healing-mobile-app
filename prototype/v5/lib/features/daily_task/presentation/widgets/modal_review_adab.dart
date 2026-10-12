import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/task_model.dart';

class ModalReviewAdab extends StatefulWidget {
  final DailyTaskItem task;
  final void Function(SoulResonance resonance, ChildResponse childResponse) onSubmitted;

  const ModalReviewAdab({
    super.key,
    required this.task,
    required this.onSubmitted,
  });

  static Future<void> show({
    required BuildContext context,
    required DailyTaskItem task,
    required void Function(SoulResonance resonance, ChildResponse childResponse) onSubmitted,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ModalReviewAdab(
        task: task,
        onSubmitted: onSubmitted,
      ),
    );
  }

  @override
  State<ModalReviewAdab> createState() => _ModalReviewAdabState();
}

class _ModalReviewAdabState extends State<ModalReviewAdab> {
  SoulResonance _selectedResonance = SoulResonance.muthmainnah;
  ChildResponse _selectedResponse = ChildResponse.lembut;

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F2C2825),
            offset: Offset(0, -4),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: colors.tactileBorder,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge & Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.meadowCanopy.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        iconoir.Sparks(width: 14, height: 14, color: colors.meadowCanopy),
                        const SizedBox(width: 6),
                        Text(
                          'MUHASABAH SEJENAK',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: colors.meadowCanopy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Refleksi Kualitas Amalan Adab',
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.tactileBorder),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        iconoir.CheckCircle(width: 18, height: 18, color: colors.meadowCanopy),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Menyelesaikan: "${widget.task.title}"',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pertanyaan 1
                  Text(
                    '1. Kualitas Resonansi Hati Saat Berinteraksi?',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSoulCard(
                    resonance: SoulResonance.muthmainnah,
                    title: "Muthma'innah",
                    subtitle: "Tenang & Utuh",
                    desc: "Dada lapang, tidak ada dorongan menyela, anak merasa aman merapat.",
                    accentColor: colors.meadowCanopy,
                  ),
                  const SizedBox(height: 8),
                  _buildSoulCard(
                    resonance: SoulResonance.lawwamah,
                    title: "Lawwamah",
                    subtitle: "Ada Usaha",
                    desc: "Sempat gemas atau ingin menasihati terburu-buru, namun berhasil menahan diri.",
                    accentColor: colors.ancientBark,
                  ),
                  const SizedBox(height: 8),
                  _buildSoulCard(
                    resonance: SoulResonance.ammarah,
                    title: "Ammarah",
                    subtitle: "Perlu Detoks",
                    desc: "Nada suara sempat meninggi atau terdistraksi gawai.",
                    accentColor: colors.nafsLawwamah,
                  ),

                  const SizedBox(height: 20),

                  // Pertanyaan 2
                  Text(
                    '2. Apakah Pendekatan Ini Berhasil Menyentuh Anak/Pasangan?',
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildResponsePill(
                          response: ChildResponse.lembut,
                          label: "Merespon Lembut",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildResponsePill(
                          response: ChildResponse.mulaiLunak,
                          label: "Mulai Lunak",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildResponsePill(
                          response: ChildResponse.menolak,
                          label: "Masih Menolak",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onSubmitted(_selectedResonance, _selectedResponse);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.meadowCanopy,
                        foregroundColor: colors.surfaceContainerLowest,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Simpan Refleksi & Selesaikan Amanah',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoulCard({
    required SoulResonance resonance,
    required String title,
    required String subtitle,
    required String desc,
    required Color accentColor,
  }) {
    final colors = context.earthTree;
    final isSelected = _selectedResonance == resonance;

    return GestureDetector(
      onTap: () => setState(() => _selectedResonance = resonance),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.surfaceContainerLow
              : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? accentColor : colors.tactileBorder,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 20,
                color: accentColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 12.5,
                      color: colors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsePill({
    required ChildResponse response,
    required String label,
  }) {
    final colors = context.earthTree;
    final isSelected = _selectedResponse == response;

    return GestureDetector(
      onTap: () => setState(() => _selectedResponse = response),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? colors.celestialSky : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? colors.celestialSky : colors.tactileBorder,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? colors.surfaceContainerLowest : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
