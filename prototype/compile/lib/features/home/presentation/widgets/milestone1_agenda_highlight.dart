import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../events/data/models/event_model.dart';
import '../../../events/presentation/screens/event_detail_screen.dart';

class Milestone1AgendaHighlight extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const Milestone1AgendaHighlight({super.key, this.onSeeAll});

  static const List<EventItem> _highlightedEvents = [
    EventItem(
      id: 'evt_1',
      title: 'Majelis Akbar Parenting Nabawiyah: Menemani Balita Tanpa Bentakan',
      summary:
          'Kajian intensif bersama Ustadz Adriano Rusfi & Tim Ahli tentang seni thuma\'ninah menyikapi masa keemasan fitrah anak usia 0-7 tahun.',
      dateLabel: 'Sabtu, 24 Oktober 2026',
      timeLabel: '08:30 - 11:45 WIB',
      location: 'Masjid Agung Al-Azhar, Jakarta & Siaran Khusus',
      category: 'Majelis Akbar',
      speakers: ['Ustadz Adriano Rusfi, S.Psi', 'dr. Fitriani Sp.A'],
      facilities: ['Buku Panduan Adab A4', 'Sertifikat Kehadiran', 'Rekaman Kajian'],
      prices: ['Gratis / Infaq Sukarela'],
      content: [
        'Materi 1: Otak limbik balita dan cara meredam amarah orang tua saat lelah.',
        'Materi 2: Kaidah syar\'i larangan pukulan fisik pada fase thufulah awal.',
        'Sesi Tanya Jawab Interaktif & Praktik Komunikasi Lembut.',
      ],
    ),
    EventItem(
      id: 'evt_2',
      title: 'Workshop Tamyiz: Membangun Kedisiplinan Shalat Usia 7-10 Tahun',
      summary:
          'Strategi transisi hijrah gawai, penataan ritme senja, dan sentuhan hati membangun kerinduan sujud pada ananda.',
      dateLabel: 'Ahad, 8 November 2026',
      timeLabel: '09:00 - 12:00 WIB',
      location: 'Aula Pusat Khazanah Nabawiyah, Bandung',
      category: 'Workshop Khusus',
      speakers: ['Ustadz Harry Santosa', 'Kak Erlan'],
      facilities: ['Lembar Observasi 19 Butir', 'Konsumsi & Snack', 'Konsultasi Privat'],
      prices: ['Rp 150.000 / Pasutri'],
      content: [
        'Materi 1: Seni menanamkan keteladanan shalat tanpa amarah.',
        'Materi 2: Matriks 19 Butir Observasi Adab Tamyiz.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const iconoir.Calendar(
                    width: 18,
                    height: 18,
                    color: Color(0xFF235347),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Agenda Daurah Terdekat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Row(
                children: [
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colors.meadowCanopy,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: colors.meadowCanopy,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // 2 Vertical Stacked Event Cards (Atas-Bawah)
        ..._highlightedEvents.map((event) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.tactileBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => EventDetailScreen(event: event),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: colors.celestialSkyContainer.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            event.category,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: colors.onCelestialSkyContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            event.dateLabel ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: colors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            event.prices.firstOrNull ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: colors.meadowCanopy,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Title
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Speakers & Venue
                    Row(
                      children: [
                        const iconoir.User(
                          width: 14,
                          height: 14,
                          color: Color(0xFFD97706),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.speakers.join(' & '),
                            style: TextStyle(
                              fontSize: 11,
                              color: colors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: colors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.location ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              color: colors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF235347),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Detail",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
