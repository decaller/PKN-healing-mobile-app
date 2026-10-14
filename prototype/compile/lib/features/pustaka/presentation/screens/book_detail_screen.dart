import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../data/models/book_model.dart';

class BookDetailScreen extends StatelessWidget {
  final BookItem book;

  const BookDetailScreen({super.key, required this.book});

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detail Pustaka',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          border: Border(top: BorderSide(color: colors.tactileBorder)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Membuka cuplikan Bab 1: ${book.title}"),
                        backgroundColor: colors.meadowCanopyContainer,
                      ),
                    );
                  },
                  icon: iconoir.Page(
                    width: 18,
                    height: 18,
                    color: colors.textPrimary,
                  ),
                  label: Text(
                    "Baca Cuplikan",
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: colors.tactileBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Mengarahkan ke pemesanan resmi: ${book.title}"),
                        backgroundColor: const Color(0xFF235347),
                      ),
                    );
                  },
                  icon: const iconoir.Cart(
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Pesan Buku",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF235347),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        children: [
          // Book Hero Display
          Center(
            child: Container(
              width: 140,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  book.coverUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: colors.surfaceContainer,
                    child: Center(
                      child: iconoir.Book(
                        width: 48,
                        height: 48,
                        color: colors.textMuted,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Category Badge
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colors.meadowCanopyContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: colors.meadowCanopy.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                book.category.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w700,
                  color: colors.onMeadowCanopyContainer,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Title
          Text(
            book.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 6),

          // Author
          Text(
            book.author,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colors.textSecondary,
            ),
          ),

          const SizedBox(height: 18),

          // Stats Bar (Rating, Halaman, Harga)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Rating", "${book.rating} ★", colors),
                _buildDivider(colors),
                _buildStatItem("Tebal", "${book.totalPages} hlm", colors),
                _buildDivider(colors),
                _buildStatItem("Harga", book.priceLabel, colors),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Golden Quote Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD97706).withValues(alpha: 0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const iconoir.Spark(
                      width: 16,
                      height: 16,
                      color: Color(0xFFD97706),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Kutipan Emas Buku",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  book.goldenQuote,
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Synopsis
          Text(
            "Sinopsis",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.synopsis,
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: colors.textSecondary,
            ),
          ),

          const SizedBox(height: 20),

          // Table of Contents
          if (book.tableOfContents.isNotEmpty) ...[
            Text(
              "Daftar Isi & Pembahasan Bab",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            ...book.tableOfContents.map((bab) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colors.meadowCanopy,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bab,
                        style: TextStyle(
                          fontSize: 13,
                          color: colors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],

          const SizedBox(height: 20),

          // Specifications Metadata
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.tactileBorder),
            ),
            child: Column(
              children: [
                _buildMetaRow("Penerbit", book.publisher, colors),
                const Divider(height: 16),
                _buildMetaRow("ISBN", book.isbn, colors),
                const Divider(height: 16),
                _buildMetaRow("Bahasa", "Indonesia (dengan Dalil Arab)", colors),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, EarthTreeColors colors) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: colors.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(EarthTreeColors colors) {
    return Container(
      width: 1,
      height: 24,
      color: colors.tactileBorder,
    );
  }

  Widget _buildMetaRow(String label, String value, EarthTreeColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: colors.textMuted),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
