import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../services/pustaka_service.dart';
import 'book_detail_screen.dart';

class PustakaListScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PustakaListScreen({super.key, this.onBack});

  @override
  State<PustakaListScreen> createState() => _PustakaListScreenState();
}

class _PustakaListScreenState extends State<PustakaListScreen> {
  final PustakaService _service = PustakaService();
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final allBooks = _service.getBooks();

    final categories = [
      'Semua',
      ...allBooks.map((b) => b.category).toSet(),
    ];

    final filtered = allBooks.where((book) {
      final matchesCat = _selectedCategory == 'Semua' || book.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();

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
          'Pustaka & Karya Nabawiyah',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Search Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Row(
              children: [
                iconoir.Search(
                  width: 20,
                  height: 20,
                  color: colors.textMuted,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    style: TextStyle(color: colors.textPrimary, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Cari judul buku atau nama asatidzah...",
                      hintStyle: TextStyle(color: colors.textMuted, fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _searchQuery = ''),
                    child: iconoir.Xmark(
                      width: 16,
                      height: 16,
                      color: colors.textMuted,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: colors.meadowCanopyContainer,
                    labelStyle: TextStyle(
                      color: isSelected ? colors.onMeadowCanopyContainer : colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    backgroundColor: colors.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? colors.meadowCanopy : colors.tactileBorder,
                      ),
                    ),
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 18),

          // Books List
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  "Tidak ada buku yang sesuai dengan pencarian.",
                  style: TextStyle(color: colors.textMuted, fontSize: 13),
                ),
              ),
            )
          else
            ...filtered.map((book) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors.tactileBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Cover Image Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 80,
                            height: 114,
                            color: colors.surfaceContainer,
                            child: Image.network(
                              book.coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Center(
                                child: iconoir.Book(
                                  width: 32,
                                  height: 32,
                                  color: colors.textMuted,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Book Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: colors.meadowCanopyContainer.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  book.category,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: colors.onMeadowCanopyContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                book.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textPrimary,
                                  height: 1.25,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                book.author,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: colors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded, size: 16, color: Color(0xFFD97706)),
                                      const SizedBox(width: 2),
                                      Text(
                                        "${book.rating}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${book.totalPages} hlm",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: colors.textMuted,
                                    ),
                                  ),
                                  const Spacer(),
                                  Flexible(
                                    child: Text(
                                      book.priceLabel,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colors.meadowCanopy,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
