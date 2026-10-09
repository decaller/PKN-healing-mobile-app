import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pkn_microlearning_app/app/router/route_paths.dart';
import 'package:pkn_microlearning_app/app/theme/color_palette.dart';
import 'package:pkn_microlearning_app/app/theme/pkn_tokens.dart';
import 'package:pkn_microlearning_app/core/widgets/moc_pilar_chip.dart';
import 'package:pkn_microlearning_app/core/widgets/pkn_button.dart';
import 'package:pkn_microlearning_app/features/onboarding/presentation/controllers/onboarding_controller.dart';

class ActivationalInsightScreen extends ConsumerWidget {
  const ActivationalInsightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pilarMoc = MocPilar.fromText(state.recommendedPilarMoc) ?? MocPilar.p4;

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
                  color: AppColors.brandGold.withValues(alpha: 0.15),
                  borderRadius: PknRadius.roundedPill,
                ),
                child: const Text(
                  'PROFIL TARBIYAH NABAWIYAH SIAP',
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
                'Trajektori Pendampingan Anda',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 6),
              Text(
                'Berdasarkan amanah peran dan fase anak yang Anda pilih, kami menyesuaikan feed harian & modul primer 5 menit.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // The Activational Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(PknSpacing.lg),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: PknRadius.roundedLg,
                    border: Border.all(
                      color: AppColors.brandGold.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: PknElevation.cardShadow,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MocPilarChip(
                              pilar: pilarMoc,
                              isSelected: true,
                            ),
                            const Icon(
                              Icons.auto_awesome_rounded,
                              color: AppColors.brandGold,
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'AMANAH PERAN & ARKETIPE',
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
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                          'PANDUAN YANG DISIAPKAN UNTUK ANDA',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildPillRow(
                          context,
                          Icons.bolt_rounded,
                          'Respon Kilat 10 Detik (Lead TL;DR saat krisis di lapangan)',
                        ),
                        const SizedBox(height: 8),
                        _buildPillRow(
                          context,
                          Icons.touch_app_rounded,
                          '5-Menit Primer Decks (Latihan studi kasus & do\'a harian)',
                        ),
                        const SizedBox(height: 8),
                        _buildPillRow(
                          context,
                          Icons.psychology_rounded,
                          'Pemetaan Bakat TB-40 & Pengamatan Adab Kualitatif (BT-MT-BK-MM)',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Unlock CTA Button
              PknButton.primary(
                width: double.infinity,
                height: 52,
                text: 'Masuk ke Beranda Tarbiyah',
                icon: Icons.arrow_forward_rounded,
                onPressed: () async {
                  await controller.finalizeOnboarding();
                  if (context.mounted) {
                    context.go(RoutePaths.feed);
                  }
                },
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
