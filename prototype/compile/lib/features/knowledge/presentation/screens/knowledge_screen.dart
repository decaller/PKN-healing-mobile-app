import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/knowledge_article.dart';
import '../../services/knowledge_service.dart';
import 'article_detail_screen.dart';

final knowledgeServiceProvider = Provider<KnowledgeService>((ref) => KnowledgeService());

final knowledgeArticlesProvider =
    FutureProvider.family<List<KnowledgeArticle>, ({String query, String category, bool onlyPakar})>(
  (ref, args) {
    return ref.watch(knowledgeServiceProvider).searchArticles(
          query: args.query,
          categoryFilter: args.category,
          onlyExpertVerified: args.onlyPakar ? true : null,
        );
  },
);

class KnowledgeScreen extends ConsumerStatefulWidget {
  final VoidCallback? onBack;

  const KnowledgeScreen({super.key, this.onBack});

  @override
  ConsumerState<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends ConsumerState<KnowledgeScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedCategory = 'Semua';
  bool _onlyPakar = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final articlesAsync = ref.watch(
      knowledgeArticlesProvider(
        (query: _searchCtrl.text, category: _selectedCategory, onlyPakar: _onlyPakar),
      ),
    );

    final categories = ['Semua', 'Kaidah Fitrah', 'Fase Usia', 'P3K Jiwa'];

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: widget.onBack != null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
                onPressed: widget.onBack,
              )
            : null,
        title: Text(
          'Khazanah Fitrah (Wiki PKN)',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search & Filter Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              children: [
                // Search Input with LibSQL Vector Search Indicator
                TextField(
                  controller: _searchCtrl,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Cari artikel atau tanya konsep fitrah...',
                    prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                    suffixIcon: _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: colors.tactileBorder.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: colors.tactileBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: colors.tactileBorder),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Provenance Toggle & Filter Row
                Row(
                  children: [
                    FilterChip(
                      label: Text(
                        'Pakar Non-AI Saja',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _onlyPakar ? colors.onMeadowCanopy : colors.textPrimary,
                        ),
                      ),
                      selected: _onlyPakar,
                      selectedColor: colors.meadowCanopy,
                      backgroundColor: colors.tactileBorder.withOpacity(0.12),
                      onSelected: (val) => setState(() => _onlyPakar = val),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories.map((cat) {
                            final isSel = cat == _selectedCategory;
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ChoiceChip(
                                label: Text(cat),
                                selected: isSel,
                                selectedColor: colors.celestialSky,
                                labelStyle: TextStyle(
                                  color: isSel ? Colors.white : colors.textPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                                backgroundColor: colors.tactileBorder.withOpacity(0.12),
                                onSelected: (_) =>
                                    setState(() => _selectedCategory = cat),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Article List
          Expanded(
            child: articlesAsync.when(
              loading: () => Center(
                child: CircularProgressIndicator(color: colors.meadowCanopy),
              ),
              error: (err, _) => Center(
                child: Text('Gagal memuat khazanah: $err',
                    style: TextStyle(color: colors.error)),
              ),
              data: (articles) {
                if (articles.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        iconoir.Book(
                          color: colors.textSecondary,
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Tidak ada artikel yang cocok',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final item = articles[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: colors.tactileBorder),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArticleDetailScreen(article: item),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: item.isExpertVerified
                                            ? colors.meadowCanopy.withOpacity(0.12)
                                            : colors.celestialSky.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        item.isExpertVerified
                                            ? 'Pakar Terverifikasi'
                                            : 'Wiki-AI Assisted',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: item.isExpertVerified
                                              ? colors.meadowCanopy
                                              : colors.celestialSky,
                                        ),
                                      ),
                                    ),
                                    if (item.similarityScore != null)
                                      Text(
                                        'Relevansi ${(item.similarityScore! * 100).toInt()}%',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: colors.textPrimary,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.summary,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: colors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                                if (item.author != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    'Oleh: ${item.author}',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontStyle: FontStyle.italic,
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
