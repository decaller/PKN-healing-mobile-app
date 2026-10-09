import 'package:flutter/material.dart';
import '../../app/theme/color_palette.dart';
import '../../app/theme/pkn_tokens.dart';

enum CalloutType {
  tldr,
  warning,
  tip,
}

/// Callout container conforming to PKN Cognitive Ergonomics specification:
/// - `[!summary] TL;DR 10 Detik`: Lead solution positioned above the fold.
/// - `[!warning] Batas Toleransi Syar'i`: Sharia limits & child safety guardrails.
/// - `[!tip] Resep Praktis Lapangan`: Actionable steps for parents/teachers.
class PknCalloutBox extends StatelessWidget {
  final CalloutType type;
  final String title;
  final String content;
  final Widget? trailing;
  final VoidCallback? onTap;

  const PknCalloutBox({
    super.key,
    required this.type,
    required this.title,
    required this.content,
    this.trailing,
    this.onTap,
  });

  factory PknCalloutBox.tldr({
    Key? key,
    String title = 'Lead TL;DR 10 Detik',
    required String content,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return PknCalloutBox(
      key: key,
      type: CalloutType.tldr,
      title: title,
      content: content,
      trailing: trailing,
      onTap: onTap,
    );
  }

  factory PknCalloutBox.warning({
    Key? key,
    String title = 'Batas Toleransi Syar\'i',
    required String content,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return PknCalloutBox(
      key: key,
      type: CalloutType.warning,
      title: title,
      content: content,
      trailing: trailing,
      onTap: onTap,
    );
  }

  factory PknCalloutBox.tip({
    Key? key,
    String title = 'Resep Praktis Lapangan',
    required String content,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return PknCalloutBox(
      key: key,
      type: CalloutType.tip,
      title: title,
      content: content,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Color get _accentColor {
    switch (type) {
      case CalloutType.tldr:
        return AppColors.calloutTldr;
      case CalloutType.warning:
        return AppColors.calloutWarning;
      case CalloutType.tip:
        return AppColors.calloutTip;
    }
  }

  IconData get _icon {
    switch (type) {
      case CalloutType.tldr:
        return Icons.bolt_rounded;
      case CalloutType.warning:
        return Icons.warning_amber_rounded;
      case CalloutType.tip:
        return Icons.lightbulb_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = _accentColor;
    final bgColor = color.withValues(alpha: isDark ? 0.15 : 0.08);

    return Semantics(
      container: true,
      label: '$title: $content',
      child: InkWell(
        onTap: onTap,
        borderRadius: PknRadius.roundedCard,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: PknRadius.roundedCard,
            border: Border.all(
              color: color.withValues(alpha: isDark ? 0.35 : 0.25),
              width: 1,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Accent side pill
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(PknRadius.card),
                      bottomLeft: Radius.circular(PknRadius.card),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(PknSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(_icon, size: 18, color: color),
                            const SizedBox(width: PknSpacing.xs),
                            Expanded(
                              child: Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: color,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                    ),
                              ),
                            ),
                            if (trailing != null) trailing!,
                          ],
                        ),
                        const SizedBox(height: PknSpacing.xs),
                        Text(
                          content,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                height: 1.45,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
