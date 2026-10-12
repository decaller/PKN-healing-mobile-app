import 'package:flutter/material.dart';
import '../../../../core/widgets/feature_gate.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../widgets/header_greeting.dart';
import '../widgets/search_ticker_bar.dart';
import '../widgets/highlights_carousel.dart';
import '../widgets/daily_activity_carousel.dart';
import '../widgets/bento_features_grid.dart';
import '../widgets/multi_serial_story_card.dart';
import '../widgets/p3k_instrument_grid.dart';
import '../widgets/recommendations_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onSwitchTheme;

  const HomeScreen({super.key, this.onSwitchTheme});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Top Header & User Greeting with Feature Flags Settings
            SliverToBoxAdapter(
              child: HeaderGreeting(
                onProfileTap: onSwitchTheme,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // 2. Full-Width Search Bar with Dynamic Ticker & PTT Button
            const SliverToBoxAdapter(
              child: SearchTickerBar(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // 3. Highlights Carousel (Events & Latest Articles)
            SliverToBoxAdapter(
              child: FeatureGate(
                isEnabled: (flags) =>
                    flags.enableEvents || flags.enableKnowledgeWiki,
                child: const Column(
                  children: [
                    HighlightsCarousel(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 4. Short-Card Carousel: Activity Suggestions
            SliverToBoxAdapter(
              child: FeatureGate(
                isEnabled: (flags) => flags.enableDailyTask,
                child: const Column(
                  children: [
                    DailyActivityCarousel(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 5. Bento Grid of Core App Features (Dynamically filtered)
            const SliverToBoxAdapter(
              child: BentoFeaturesGrid(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),

            // 6. Carousel Stories (Interactive RPG Living Rehearsal)
            SliverToBoxAdapter(
              child: FeatureGate(
                isEnabled: (flags) => flags.enableStories,
                child: const Column(
                  children: [
                    MultiSerialStoriesSection(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 7. Grid Practical Instruments (P3K SOP 10 Detik)
            SliverToBoxAdapter(
              child: FeatureGate(
                isEnabled: (flags) => flags.enableP3kCrisis,
                child: const Column(
                  children: [
                    P3kInstrumentGrid(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 8. Seksi Rekomendasi (Promotional Vertical Stack)
            const SliverToBoxAdapter(
              child: RecommendationsSection(),
            ),

            // Padding bottom agar tidak tertutup floating bottom bar
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
