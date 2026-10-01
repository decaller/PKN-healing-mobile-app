import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../app/theme/color_palette.dart';
import '../../../core/widgets/domain_badge.dart';
import '../../../core/widgets/takeaway_badge.dart';
import '../../data/models/idea_card.dart';

class IdeaCardWidget extends StatefulWidget {
  final IdeaCard card;
  final VoidCallback onBookmarkToggle;

  const IdeaCardWidget({
    super.key,
    required this.card,
    required this.onBookmarkToggle,
  });

  @override
  State<IdeaCardWidget> createState() => _IdeaCardWidgetState();
}

class _IdeaCardWidgetState extends State<IdeaCardWidget> {
  bool _isExampleExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final card = widget.card;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DomainBadge(domain: card.category),
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${card.readTimeMinutes} min read',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Title & Source
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              card.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 14),
            child: Text(
              card.sourceName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),

          // Core Thesis Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurfaceElevated.withOpacity(0.5)
                  : AppColors.lightSurfaceElevated,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 0.8,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TakeawayBadge(label: 'CORE THESIS'),
                const SizedBox(height: 10),
                MarkdownBody(
                  data: card.coreThesis,
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                    p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.55,
                        ),
                    strong: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                  ),
                ),
              ],
            ),
          ),

          // Real-World Example Accordion
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isExampleExpanded = !_isExampleExpanded;
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    width: 0.8,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.cases_outlined,
                              size: 16,
                              color: AppColors.brandGold,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Real-World Case Study',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        Icon(
                          _isExampleExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                      ],
                    ),
                    if (_isExampleExpanded) ...[
                      const SizedBox(height: 10),
                      Text(
                        card.realWorldExample,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Bottom Action Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Tags
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: card.tags.map((tag) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurfaceElevated
                                : AppColors.lightSurfaceElevated,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Bookmark & Share actions
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        card.isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: card.isBookmarked
                            ? AppColors.brandGold
                            : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                      ),
                      onPressed: () {
                        widget.onBookmarkToggle();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              card.isBookmarked
                                  ? 'Removed from saved ideas'
                                  : 'Saved to your executive library',
                            ),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card link copied to clipboard!'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
