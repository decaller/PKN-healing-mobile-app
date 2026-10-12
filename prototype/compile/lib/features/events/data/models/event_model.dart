/// Model Agenda & Majelis Akbar Parenting Nabawiyah
class EventItem {
  final String id;
  final String title;
  final String? summary;
  final String? imageUrl;
  final String? dateLabel;
  final String? timeLabel;
  final String? location;
  final String category;
  final List<String> speakers;
  final List<String> facilities;
  final List<String> prices;
  final List<String> content;
  final String? registrationUrl;

  const EventItem({
    required this.id,
    required this.title,
    this.summary,
    this.imageUrl,
    this.dateLabel,
    this.timeLabel,
    this.location,
    required this.category,
    this.speakers = const [],
    this.facilities = const [],
    this.prices = const [],
    this.content = const [],
    this.registrationUrl,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Agenda Tanpa Judul',
      summary: json['summary']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      dateLabel: json['dateLabel']?.toString(),
      timeLabel: json['timeLabel']?.toString(),
      location: json['location']?.toString(),
      category: json['category']?.toString() ?? 'Umum',
      speakers: (json['speakers'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      facilities: (json['facilities'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      prices: (json['prices'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      content: (json['content'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      registrationUrl: json['registrationUrl']?.toString(),
    );
  }
}
