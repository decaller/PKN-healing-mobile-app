import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pkn_microlearning_app/app/router/route_paths.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_audio_player_sheet.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_callout_box.dart';
import 'package:pkn_microlearning_app/features/feed/presentation/controllers/feed_controller.dart';
import 'package:pkn_microlearning_app/features/feed/presentation/widgets/idea_card_widget.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  final List<String> _categories = [
    'Semua',
    'Praktik Keluarga',
    'Fase Tumbuh Kembang',
    'Fitrah & Bakat',
    'Mulai di Sini',
    'Lembaga & Guru',
    'Khazanah Dalil',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(feedControllerProvider);
    final feedNotifier = ref.read(feedControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ideas = feedState.filteredIdeas;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Cari hadits, solusi tantrum, fitrah TB-40...',
                  border: InputBorder.none,
                ),
                onChanged: (val) => feedNotifier.updateSearch(val),
              )
            : Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.brandGold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.brandGold,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'PKN HEALING FEED',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
        actions: [
          IconButton(
            tooltip: 'Audio Sirah & Tazkiyah',
            icon: const Icon(Icons.headphones_rounded, color: AppColors.brandGold),
            onPressed: () => PknAudioPlayerSheet.show(context),
          ),
          IconButton(
            icon: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  feedNotifier.updateSearch('');
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () => context.go(RoutePaths.profile),
          ),
        ],
      ),
      body: Column(
        children: [
          // Domain Category Chips Bar (6 Pilar MOC)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _categories.map((cat) {
                final isSelected =
                    feedState.selectedCategory.toLowerCase() == cat.toLowerCase() ||
                    (cat == 'Semua' && feedState.selectedCategory.toLowerCase() == 'all');

                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (_) {
                      final target = cat == 'Semua' ? 'All' : cat;
                      feedNotifier.selectCategory(target);
                    },
                    showCheckmark: false,
                    selectedColor: AppColors.brandPrimary.withValues(alpha: 0.22),
                    backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.brandPrimary
                          : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? (isDark ? Colors.white : AppColors.brandPrimaryDark)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Cards Feed & Urgent Crisis Banner
          Expanded(
            child: ideas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Materi belum ditemukan',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Coba cari dengan kata kunci lain atau pilih pilar lain',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    itemCount: ideas.length + 1, // +1 for Urgent Crisis Banner at top
                    itemBuilder: (context, index) {
                      // Index 0: Urgent Crisis Emergency Hub Banner (Modeled on Education Apps Node 0:774 Opt card)
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: PknCalloutBox.tldr(
                            title: '⚡ Respon Cepat Krisis Anak (10 Detik)',
                            content:
                                'Anak sedang tantrum atau mogok shalat? Jangan mendebat logika di puncak amarah. Dekati, duduk sejajar mata, dan hadirkan pelukan penenteram jiwa.',
                            trailing: TextButton(
                              onPressed: () => _showCrisisModal(context),
                              child: const Text(
                                'Buka Hub Krisis',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ),
                            onTap: () => _showCrisisModal(context),
                          ),
                        );
                      }

                      final idea = ideas[index - 1];
                      return IdeaCardWidget(
                        key: ValueKey(idea.id),
                        card: idea,
                        onBookmarkToggle: () =>
                            feedNotifier.toggleBookmark(idea.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showCrisisModal(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(PknSpacing.lg),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: AppColors.calloutTldr, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Pusat Respon Kilat Krisis Anak',
                    style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _buildCrisisTile(
                ctx,
                '🌪️ Anak Balita Tantrum di Tempat Umum',
                'Validasi emosi, duduk sejajar mata, bawa ke tempat tenang, jangan mendebat logika.',
              ),
              _buildCrisisTile(
                ctx,
                '🕌 Anak Tamyiz Menolak Shalat',
                'Hadirkan teladan fisik wudhu riang (Bahasa Tangan). Larangan keras memukul sebelum usia 10 tahun.',
              ),
              _buildCrisisTile(
                ctx,
                '📱 Mogok Melepaskan Gawai (Gadget)',
                'Gunakan kesepakatan waktu di awal, alihkan ke aktivitas fisik bersama, peluk saat ia marah.',
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCrisisTile(BuildContext context, String title, String solution) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: PknRadius.roundedMd,
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            solution,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}
