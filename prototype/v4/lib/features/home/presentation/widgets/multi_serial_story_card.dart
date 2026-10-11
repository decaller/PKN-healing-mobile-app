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
              Row(
                children: [
                  iconoir.Gamepad(
                    width: 20,
                    height: 20,
                    color: colors.celestialSky,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Cerita Interaktif",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
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
          height: 380 + (MediaQuery.textScalerOf(context).scale(16) - 16).clamp(0, 24).toDouble() * 24,
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
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header Tags
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colors.celestialSky.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        story.serialTag.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.celestialSky,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: colors.meadowCanopyContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      story.statusTag,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.onMeadowCanopy,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 6),
              Text(
                story.synopsis,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  height: 1.4,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          // Milestone Progress Subcard
          Container(
            padding: const EdgeInsets.all(10),
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
                    Text(
                      "Milestone: ${story.milestoneLabel}",
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                  constraints: const BoxConstraints(minHeight: 48),
                  child: FButton.raw(
                    onPress: _openSerial,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(
                            story.ctaLabel,
                            textAlign: TextAlign.center,
                            style: context.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(width: 4),
                          iconoir.Play(width: 16, height: 16, color: colors.textPrimary),
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
                  width: 48,
                  height: 48,
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
          Text(
            step.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: textCol,
            ),
          ),
        ],
      ),
    );
  }
}
