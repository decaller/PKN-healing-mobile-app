import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import '../../../../core/theme/theme_extensions.dart';
import '../../../pustaka/presentation/screens/book_detail_screen.dart';
import '../../../pustaka/services/pustaka_service.dart';

class Milestone1PustakaCarousel extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const Milestone1PustakaCarousel({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final colors = context.earthTree;
    final books = PustakaService().getBooks();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const iconoir.Book(
                    width: 18,
                    height: 18,
                    color: Color(0xFF235347),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Pustaka & Karya Pilihan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: Row(
                children: [
                  Text(
                    "Katalog Buku",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colors.meadowCanopy,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: colors.meadowCanopy,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Horizontal Carousel
        SizedBox(
          height: 195,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Container(
                width: 130,
                margin: const EdgeInsets.only(right: 14),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => BookDetailScreen(book: book),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book Cover Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 130,
                          height: 130,
                          color: colors.surfaceContainer,
                          child: Image.network(
                            book.coverUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Center(
                              child: iconoir.Book(
                                width: 36,
                                height: 36,
                                color: colors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 10,
                          color: colors.textMuted,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
