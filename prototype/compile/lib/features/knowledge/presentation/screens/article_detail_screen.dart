import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/knowledge_article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final KnowledgeArticle article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Artikel Khazanah',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: article.isExpertVerified
                      ? colors.meadowCanopy.withOpacity(0.12)
                      : colors.celestialSky.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  article.isExpertVerified
                      ? 'Pakar Terverifikasi (Alexandria)'
                      : 'Wiki-AI Corpus',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: article.isExpertVerified
                        ? colors.meadowCanopy
                        : colors.celestialSky,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.tactileBorder.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  article.category,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            article.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              height: 1.3,
            ),
          ),
          if (article.author != null) ...[
            const SizedBox(height: 8),
            Text(
              'Penulis: ${article.author}',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: colors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 16),

          // Summary Callout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.celestialSky.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.celestialSky.withOpacity(0.2)),
            ),
            child: Text(
              article.summary,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: colors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Body
          Text(
            article.body,
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),

          // Tags
          if (article.tags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: article.tags.map((t) {
                return Chip(
                  label: Text('#$t'),
                  labelStyle: TextStyle(
                    fontSize: 11,
                    color: colors.textSecondary,
                  ),
                  backgroundColor: colors.tactileBorder.withOpacity(0.12),
                  side: BorderSide(color: colors.tactileBorder),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
          ],
        ],
      ),
    );
  }
}
