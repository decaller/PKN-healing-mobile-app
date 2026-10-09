import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/pkn_tokens.dart';

class AudioSirahTrack {
  final String id;
  final String title;
  final String subtitle;
  final String narrator;
  final String duration;
  final String pilarMoc;

  const AudioSirahTrack({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.narrator,
    required this.duration,
    required this.pilarMoc,
  });
}

/// Audio Sirah & Tazkiyah Player Bottom Sheet
/// Faithfully adapted from Figma template "13 Screen Online Course.fig" (Node 0:142 - Learning)
class PknAudioPlayerSheet extends StatefulWidget {
  final List<AudioSirahTrack> playlist;
  final int initialIndex;

  const PknAudioPlayerSheet({
    super.key,
    required this.playlist,
    this.initialIndex = 0,
  });

  static void show(
    BuildContext context, {
    List<AudioSirahTrack>? customPlaylist,
    int initialIndex = 0,
  }) {
    final defaultPlaylist = [
      const AudioSirahTrack(
        id: 'sirah_1',
        title: 'Kelembutan Nabi ﷺ Saat Sujud Bersama Cucu',
        subtitle: 'Validasi fitrah bermain anak & akhlak pendidik nabawiyah',
        narrator: 'Ustadz Abdul Kholiq (SOTAB HEBAT)',
        duration: '06:45',
        pilarMoc: 'P4: Praktik Keluarga',
      ),
      const AudioSirahTrack(
        id: 'sirah_2',
        title: 'Tazkiyatun Nafs Bunda: Memulihkan Tangki Cinta',
        subtitle: 'Muhasabah 5 menit penenang batin saat caregiver burnout',
        narrator: 'Kajian Nabawiyah',
        duration: '05:30',
        pilarMoc: 'P4: Praktik Keluarga',
      ),
      const AudioSirahTrack(
        id: 'sirah_3',
        title: 'Kisah Sahabat Abu Dzar: Keagungan Fitrah Tafakkur',
        subtitle: 'Memahami fitrah introvert (As-Sirr) dalam Tafsir Bakat TB-40',
        narrator: 'Ustadz Abdul Kholiq',
        duration: '08:15',
        pilarMoc: 'P3: Fitrah & Bakat TB-40',
      ),
      const AudioSirahTrack(
        id: 'sirah_4',
        title: 'Hadits Shalat 7 vs 10 Tahun: Rambu Syar\'i Disiplin',
        subtitle: 'Kaidah pembiasaan riang sebelum ketegasan mendidik',
        narrator: 'Ustadz Abdul Kholiq',
        duration: '07:20',
        pilarMoc: 'P2: Fase Tumbuh Kembang',
      ),
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PknAudioPlayerSheet(
        playlist: customPlaylist ?? defaultPlaylist,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<PknAudioPlayerSheet> createState() => _PknAudioPlayerSheetState();
}

class _PknAudioPlayerSheetState extends State<PknAudioPlayerSheet> {
  late int _currentIndex;
  bool _isPlaying = true;
  double _progress = 0.35; // 35% elapsed

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  AudioSirahTrack get _currentTrack => widget.playlist[_currentIndex];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final track = _currentTrack;

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        borderRadius: PknRadius.roundedSheet,
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    'Audio Sirah & Tazkiyah',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, size: 20),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Player Card (Modeled on Node 0:142 Card)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Container(
              padding: const EdgeInsets.all(PknSpacing.lg),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.brandPrimaryDark,
                    AppColors.brandPrimary,
                  ],
                ),
                borderRadius: PknRadius.roundedLg,
                boxShadow: PknElevation.elevatedShadow,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: PknRadius.roundedPill,
                        ),
                        child: Text(
                          track.pilarMoc,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.volume_up_rounded, color: Colors.white, size: 20),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Track Title & Narrator
                  Text(
                    track.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    track.narrator,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Time Scrubber (Derived from Node 0:142 Group 1018)
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                      trackHeight: 4,
                      activeTrackColor: AppColors.brandGold,
                      inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                      thumbColor: AppColors.brandGold,
                    ),
                    child: Slider(
                      value: _progress,
                      onChanged: (val) => setState(() => _progress = val),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '02:22',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          track.duration,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Playback Controls (Center 64x64 dp button)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 30),
                        onPressed: _currentIndex > 0
                            ? () => setState(() => _currentIndex--)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Semantics(
                        button: true,
                        label: _isPlaying ? 'Jeda Audio' : 'Putar Audio',
                        child: InkWell(
                          onTap: () => setState(() => _isPlaying = !_isPlaying),
                          borderRadius: BorderRadius.circular(32),
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: AppColors.brandGold,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                              color: Colors.black87,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 30),
                        onPressed: _currentIndex < widget.playlist.length - 1
                            ? () => setState(() => _currentIndex++)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Playlist Header (Derived from Node 0:142 "Chapters")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Row(
              children: [
                Text(
                  'DAFTAR KAJIAN & SIRAH',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.playlist.length} Materi',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Playlist Items (Derived from Node 0:142 Component 28)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              itemCount: widget.playlist.length,
              itemBuilder: (ctx, idx) {
                final item = widget.playlist[idx];
                final isCurrent = idx == _currentIndex;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () => setState(() {
                      _currentIndex = idx;
                      _isPlaying = true;
                    }),
                    borderRadius: PknRadius.roundedCard,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? (isDark
                                ? AppColors.brandPrimary.withValues(alpha: 0.18)
                                : AppColors.brandPrimary.withValues(alpha: 0.08))
                            : (isDark
                                ? AppColors.darkSurface
                                : AppColors.lightSurface),
                        borderRadius: PknRadius.roundedCard,
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.brandPrimary
                              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                          width: isCurrent ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Number Badge (Derived from Node 0:142 Group 984)
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? AppColors.brandPrimary
                                  : (isDark
                                      ? AppColors.darkSurfaceElevated
                                      : AppColors.lightSurfaceElevated),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${idx + 1}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: isCurrent
                                    ? Colors.white
                                    : (isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: isCurrent ? AppColors.brandPrimary : null,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.subtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            isCurrent && _isPlaying
                                ? Icons.equalizer_rounded
                                : Icons.play_circle_outline_rounded,
                            color: isCurrent
                                ? AppColors.brandPrimary
                                : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
