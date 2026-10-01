import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/route_paths.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/widgets/domain_badge.dart';
import '../controllers/onboarding_controller.dart';

class ActivationalInsightScreen extends ConsumerWidget {
  const ActivationalInsightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Header Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.brandGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'EXECUTIVE DIAGNOSTIC COMPLETE',
                  style: TextStyle(
                    color: AppColors.brandGold,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your Executive Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 6),
              Text(
                'Based on your inputs, we generated your daily microlearning trajectory.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // The Activational Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                              const Color(0xFF1E222B),
                              const Color(0xFF12141A),
                            ]
                          : [
                              Colors.white,
                              const Color(0xFFF1F3F9),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.brandGold.withOpacity(0.35),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DomainBadge(domain: state.primaryDomain),
                          const Icon(
                            Icons.auto_awesome_rounded,
                            color: AppColors.brandGold,
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'ARCHETYPE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.personaArchetype,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.brandGold,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.recommendedFocusDescription,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                      ),
                      const Divider(height: 36),
                      Text(
                        'CURATED REPERTOIRE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildPillRow(context, Icons.bolt_rounded, '3-5 min daily Primer decks'),
                      const SizedBox(height: 8),
                      _buildPillRow(context, Icons.bookmark_border_rounded, 'Deepstash thesis cards & mental models'),
                      const SizedBox(height: 8),
                      _buildPillRow(context, Icons.trending_up_rounded, 'Weekly compounding executive streak'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Unlock CTA
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brandGold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    await controller.finalizeOnboarding();
                    if (context.mounted) {
                      context.go(RoutePaths.feed);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Personalized Feed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPillRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.brandGold),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}
