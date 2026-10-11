import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../stories/presentation/screens/serial_detail_episode_screen.dart';

enum StepStatus { completed, inProgress, locked }

class StoryStep {
  final String label;
  final StepStatus status;

  const StoryStep({required this.label, required this.status});
}

class SerialStoryData {
  final String serialTag;
  final String statusTag;
  final String episodeTitle;
  final String synopsis;
  final String milestoneLabel;
  final double progress;
  final List<StoryStep> steps;
  final String ctaLabel;
  final bool isStarted;
  final String imageUrl;

  const SerialStoryData({
    required this.serialTag,
    required this.statusTag,
    required this.episodeTitle,
    required this.synopsis,
    required this.milestoneLabel,
    required this.progress,
    required this.steps,
    required this.ctaLabel,
    required this.isStarted,
    required this.imageUrl,
  });
}

class MultiSerialStoriesSection extends StatefulWidget {

  const MultiSerialStoriesSection({super.key});

  @override
  State<MultiSerialStoriesSection> createState() => _MultiSerialStoriesSectionState();
}

class _MultiSerialStoriesSectionState extends State<MultiSerialStoriesSection> {
  final PageController _pageController = PageController(viewportFraction: 0.88);

  static const List<SerialStoryData> _stories = [
    SerialStoryData(
      serialTag: "Serial 1: Kemarahan Zaid",
      statusTag: "Sedang Berjalan • Ep 3/4",
      episodeTitle: "Episode 3: Suara Hati di Balik Bentakan",
      synopsis:
          "Zaid menolak shalat dan membentak saat lelah sepulang TPA. Bangun koneksi fisik dan sejajarkan pandangan sebelum menuntut kepatuhan.",
      milestoneLabel: "3 dari 5 Selesai",
      progress: 0.60,
      steps: [
        StoryStep(label: "Validasi Emosi", status: StepStatus.completed),
        StoryStep(label: "Kontak Mata", status: StepStatus.completed),
        StoryStep(label: "Dialog TB-40", status: StepStatus.inProgress),
        StoryStep(label: "Islah & Shalat", status: StepStatus.locked),
      ],
      ctaLabel: "Lanjutkan Episode 3",
      isStarted: true,
      imageUrl:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAbo213Qip5_8M7hHW07Wcqfn600ty9hINhDqLnTT5SlZ9_KA6kssT9L1kxJQJB3f4m3tuH2vN11-mb6a8T7YnwoVq-Nj5yroEUz5-Ua7kcuj-boeTdjiclXmoK0VHrPbIdlvlKaN7Ai_rAIrn_xMjEBF-d6uFtjRfANKOUyTtU4IFnvfm-7W8VIqGLgQuHeZwr2o-u8bQz31HUFlZ8rG9WHMFJLoaShgoN1uZEN_rJylXzVeaoz2dgyw",
    ),
    SerialStoryData(
      serialTag: "Serial 2: Meluruskan Syakilah",
      statusTag: "Mulai Ep 1/6",
      episodeTitle: "Episode 1: Saat Ananda Mempertanyakan Keadilan",
      synopsis:
          "Menata dialog logika nabawi saat anak kritis membandingkan aturan dengan saudara, tanpa membungkam fitrah belajarnya.",
      milestoneLabel: "1 dari 4 Selesai",
      progress: 0.25,
      steps: [
        StoryStep(label: "Sambut Tanya", status: StepStatus.completed),
        StoryStep(label: "Analogi Fitrah", status: StepStatus.inProgress),
        StoryStep(label: "Refleksi Quran", status: StepStatus.locked),
      ],
      ctaLabel: "Mulai Episode 1",
      isStarted: true,
      imageUrl:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAGXdc1elsOdW8HkNqNIHtsVO0Y16GPpXfQuhX2vKP7sKlJY4-omahQyabzby_YGtFwC3igCt_cB7qBQWGEjv6vc-hmuYOMhryo4P-1Qi5x3DKF_4pCQ8ZhrEJ0ZnndrvgvEuODwdIP5yUSRaJ5DUmDfKBjaLVNzUl0ZS5oIYkCc6qPAUsConU1J5I-z6f6l_JcmO193b9pF8jVfTn3l7fAIqtEt61H34S-K_L2-LHyFOZdGS-3e2JxUw",
    ),
    SerialStoryData(
      serialTag: "Serial 3: Transisi Tamyiz",
      statusTag: "Prolog • Ep 0/5",
      episodeTitle: "Episode Prolog: Menanam Tanggung Jawab Mandiri",
      synopsis:
          "Membimbing pembiasaan shalat 5 waktu di usia 10 tahun dengan keteladanan cinta dan wibawa tanpa ancaman kekerasan lisan.",
      milestoneLabel: "Belum Dimulai",
      progress: 0.0,
      steps: [
        StoryStep(label: "Pemetaan Adab", status: StepStatus.inProgress),
        StoryStep(label: "Kontrak Cinta", status: StepStatus.locked),
        StoryStep(label: "Ta'awun Harian", status: StepStatus.locked),
      ],
      ctaLabel: "Buka Serial Ini",
      isStarted: false,
      imageUrl:
          "https://lh3.googleusercontent.com/aida-public/AB6AXuBD833QoTjr-W4IHYIXbTpHnThE0k8wRS2Vri4WEOmG2FyOwOmfnM0Ya-5RwLub3-LEX38ZJX6SyO62FQtrexN5ddf5InbYTe-8LL10y392qTlXgDZ8lD6vOtGvnKQrrScJbhFbmRzv7W9EL3VqBE-kUvUJqGuUAfOhQe_URxUlc8j6zsygPO5ERn6Koh3DWttboJQbxKBtFmPwRPGoGEA3zW7Xs9fooQ0EE943acNdYSwD9x5b3NlvYw",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openSerial() {
    Navigator.of(context).push<void>(MaterialPageRoute<void>(
      builder: (_) => const SerialDetailEpisodeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    iconoir.Gamepad(
                      width: 20,
                      height: 20,
                      color: colors.celestialSky,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        "Cerita Interaktif",
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.meadowCanopyContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  "Lihat Semua",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.onMeadowCanopy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 485 + (MediaQuery.textScalerOf(context).scale(16) - 16).clamp(0, 24).toDouble() * 24,
          child: PageView.builder(
            controller: _pageController,
            padEnds: false,
            itemCount: _stories.length,
            itemBuilder: (context, index) {
              final story = _stories[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16 : 6,
                  right: index == _stories.length - 1 ? 16 : 6,
                ),
                child: _buildStoryCard(context, story),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dots indicator menggunakan smooth_page_indicator
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: _stories.length,
            effect: ExpandingDotsEffect(
              expansionFactor: 3.5,
              dotWidth: 6,
              dotHeight: 6,
              spacing: 6,
              activeDotColor: colors.celestialSky,
              dotColor: colors.tactileBorder,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoryCard(BuildContext context, SerialStoryData story) {
    final colors = context.earthTree;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.tactileBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A2C2825),
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Banner with Vignette & Floating Tags
            AspectRatio(
              aspectRatio: 16 / 7.2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    story.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: colors.surfaceContainerHighest,
                      alignment: Alignment.center,
                      child: iconoir.MediaImage(
                        width: 28,
                        height: 28,
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.35),
                          Colors.black.withValues(alpha: 0.05),
                          Colors.black.withValues(alpha: 0.65),
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              story.serialTag.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white, // ignore_theme_linter: photo_scrim
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: colors.meadowCanopyContainer.withValues(alpha: 0.92),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              story.statusTag,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colors.onMeadowCanopy,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Card Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title and Synopsis
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.episodeTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colors.textPrimary,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          story.synopsis,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                            height: 1.35,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Milestone Progress Subcard
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerLowest.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.tactileBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Milestone: ${story.milestoneLabel}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: colors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${(story.progress * 100).toInt()}%",
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: colors.celestialSky,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: story.progress,
                              minHeight: 5,
                              backgroundColor: colors.surfaceContainerHighest,
                              valueColor: AlwaysStoppedAnimation<Color>(colors.celestialSky),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Chips status matrix
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: story.steps.map((step) => _buildStepChip(context, step)).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 46),
                            child: FButton.raw(
                              onPress: _openSerial,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(child: Text(
                                      story.ctaLabel,
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colors.onCelestialSky,
                                      ),
                                    )),
                                    const SizedBox(width: 4),
                                    iconoir.Play(width: 16, height: 16, color: colors.onCelestialSky),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: colors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: colors.tactileBorder),
                          ),
                          child: SizedBox(
                            width: 46,
                            height: 46,
                            child: Semantics(
                              label: 'Lihat daftar episode serial',
                              child: FButton.raw(
                                onPress: _openSerial,
                                child: iconoir.Menu(width: 20, height: 20, color: colors.textSecondary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepChip(BuildContext context, StoryStep step) {
    final colors = context.earthTree;

    Color bg;
    Color border;
    Color textCol;
    Widget icon;

    switch (step.status) {
      case StepStatus.completed:
        bg = colors.meadowCanopyContainer.withValues(alpha: 0.3);
        border = colors.meadowCanopy.withValues(alpha: 0.3);
        textCol = colors.onMeadowCanopy;
        icon = iconoir.CheckCircle(width: 13, height: 13, color: colors.meadowCanopy);
        break;
      case StepStatus.inProgress:
        bg = colors.celestialSkyContainer.withValues(alpha: 0.3);
        border = colors.celestialSky.withValues(alpha: 0.4);
        textCol = colors.celestialSky;
        icon = iconoir.Hourglass(width: 13, height: 13, color: colors.celestialSky);
        break;
      case StepStatus.locked:
        bg = colors.surfaceContainerHighest.withValues(alpha: 0.5);
        border = colors.tactileBorder;
        textCol = colors.textMuted;
        icon = iconoir.Lock(width: 13, height: 13, color: colors.textMuted);
        break;
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              step.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: textCol,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
