import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pkn_microlearning_app/app/router/route_paths.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/storage/storage_service.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_audio_player_sheet.dart';
import 'package:pkn_microlearning_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:pkn_microlearning_app/features/feed/presentation/widgets/idea_card_widget.dart';
import 'package:pkn_microlearning_app/features/lessons/data/mock_lessons.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isChildSafeMode = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final storageService = ref.watch(storageServiceProvider);
    final feedState = ref.watch(feedControllerProvider);
    final feedNotifier = ref.read(feedControllerProvider.notifier);

    final completedLessons = storageService.getCompletedLessonIds();
    final bookmarkedIdeas = feedState.allIdeas.where((i) => i.isBookmarked).toList();
    final userRole = storageService.getUserRole() ?? 'ayah';
    final userFocus = storageService.getUserFocus() ?? 'Praktik Keluarga';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROFIL TARBIYAH NABAWIYAH',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                letterSpacing: 1.0,
                fontWeight: FontWeight.w800,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headphones_rounded, color: AppColors.brandGold),
            tooltip: 'Audio Sirah & Tazkiyah',
            onPressed: () => PknAudioPlayerSheet.show(context),
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Ganti Peran & Fase',
            onPressed: () {
              context.go(RoutePaths.onboarding);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(PknSpacing.lg),
        children: [
          // Profile Card
          Container(
            padding: const EdgeInsets.all(PknSpacing.xl),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: PknRadius.roundedCard,
              border: Border.all(
                color: AppColors.brandGold.withValues(alpha: 0.35),
                width: 1.2,
              ),
              boxShadow: PknElevation.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.brandGold.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(_getRoleEmoji(userRole), style: const TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatRole(userRole),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Fokus Pilar: ${userFocus.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.getDomainColor(userFocus),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn(context, '7', 'Hari Istiqamah', '🌟'),
                    _buildStatColumn(
                      context,
                      '${completedLessons.length}/${MockLessonsRepository.lessons.length}',
                      'Modul Tuntas',
                      '🎯',
                    ),
                    _buildStatColumn(
                      context,
                      '${bookmarkedIdeas.length}',
                      'Tersimpan',
                      '📌',
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Child-Safe Mode Toggle (Rambu Khusus Perlindungan Anak)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated,
              borderRadius: PknRadius.roundedCard,
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.child_care_rounded, color: AppColors.brandPrimary, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mode Khusus Anak (TB-40 Kids)',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Antarmuka visual ramah anak, bebas formulir & tanpa vonis',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isChildSafeMode,
                  activeColor: AppColors.brandPrimary,
                  onChanged: (val) {
                    setState(() => _isChildSafeMode = val);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          val
                              ? 'Mode Anak Aktif: Menampilkan kartu bergambar dan stiker amal.'
                              : 'Kembali ke Mode Pengasuh Dewasa.',
                        ),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Saved Ideas Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Materi Tarbiyah Tersimpan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Text(
                '${bookmarkedIdeas.length} materi',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 14),

          if (bookmarkedIdeas.isEmpty)
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: PknRadius.roundedCard,
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.bookmark_add_outlined,
                      size: 40,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Belum ada materi tersimpan',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tekan ikon simpan pada kartu di beranda untuk referensi cepat kapan saja.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            )
          else
            ...bookmarkedIdeas.map((idea) {
              return IdeaCardWidget(
                key: ValueKey(idea.id),
                card: idea,
                onBookmarkToggle: () => feedNotifier.toggleBookmark(idea.id),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context,
    String value,
    String label,
    String emoji,
  ) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.brandGold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  String _formatRole(String role) {
    switch (role) {
      case 'bunda':
        return 'Ibu / Bunda • Madrasah Utama';
      case 'guru':
        return 'Guru & Pendidik Karakter';
      case 'pembelajar_santri':
        return 'Santri & Pembelajar Mandiri';
      case 'ayah':
      default:
        return 'Ayah • Qawwamun Keluarga';
    }
  }

  String _getRoleEmoji(String role) {
    switch (role) {
      case 'bunda':
        return '🏡';
      case 'guru':
        return '🏫';
      case 'pembelajar_santri':
        return '🎒';
      case 'ayah':
      default:
        return '🛡️';
    }
  }
}
