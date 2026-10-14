import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../developer/feature_flags_screen.dart';

class HeaderGreeting extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const HeaderGreeting({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamu'alaykum",
                style: context.textTheme.labelMedium?.copyWith(
                  color: colors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Abu Hafi",
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Tombol Pengaturan Modular Feature Flags
              IconButton(
                tooltip: 'Pengaturan Modul (Feature Flags)',
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colors.tactileBorder.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: iconoir.Settings(
                    color: colors.textPrimary,
                    width: 20,
                    height: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const FeatureFlagsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
              // Avatar dengan toggle tema
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.surfaceContainer,
                    border: Border.all(color: colors.tactileBorder, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      "AH",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
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
}
