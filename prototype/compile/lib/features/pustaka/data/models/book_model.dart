/// Model Buku & Karya Pustaka Nabawiyah PKN (Milestone 1)
class BookItem {
  final String id;
  final String title;
  final String author;
  final String category;
  final String coverUrl;
  final String synopsis;
  final String goldenQuote;
  final int totalPages;
  final String isbn;
  final String publisher;
  final double rating;
  final List<String> tableOfContents;
  final String priceLabel;

  const BookItem({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.coverUrl,
    required this.synopsis,
    required this.goldenQuote,
    required this.totalPages,
    required this.isbn,
    required this.publisher,
    this.rating = 4.9,
    this.tableOfContents = const [],
    this.priceLabel = 'Rp 95.000',
  });
}
