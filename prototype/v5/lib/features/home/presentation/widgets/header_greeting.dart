import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

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
          // Avatar dengan notification badge
          GestureDetector(
            onTap: onProfileTap,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.surfaceContainer,
                    border: Border.all(color: colors.tactileBorder, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A2C2825),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuATYdxE5c_PLPvonWeWf_YBSXKwMqJxQhMQJJAiXUc0FEgmClA6G6GIdOZx-h1fGLmZHXav_Q_WXFtMexe0-YFeGg4Ggz3xpLaE92r5Qf_J9rasJfU9urW0s9u5poOp1xPdJWMkoQfjrQGFmDkfz4UBaIK7aTHqeIKcvgCAIIx9LC0l4tHyzzZGBGWz8DUWHhFYdU-Z5R4gGQMlS-WheMGbnhFKiub8VIWAPb1NLh2MjgWLgNmJnOquZQ',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          "AH",
                          style: context.textTheme.labelLarge?.copyWith(
                            color: colors.celestialSky,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: colors.meadowCanopy,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1F000000),
                          offset: Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "3",
                      style: TextStyle(
                        color: colors.onMeadowCanopy,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
