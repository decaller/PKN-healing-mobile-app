/// Model Tokoh Pakar & Asatidzah (Modul 3)
class TokohItem {
  final String id;
  final String name;
  final String title;
  final String focus;
  final String works;
  final String goldenQuote;
  final String imageUrl;
  final String audioSeries;
  final List<String> expertiseTags;

  const TokohItem({
    required this.id,
    required this.name,
    required this.title,
    required this.focus,
    required this.works,
    required this.goldenQuote,
    required this.imageUrl,
    required this.audioSeries,
    this.expertiseTags = const [],
  });
}

/// Model Lembaga Mitra PKN (Modul 3)
class LembagaItem {
  final String id;
  final String name;
  final String acronym;
  final String city;
  final String type;
  final String description;
  final String partnershipProgram;
  final String imageUrl;
  final int studentsCount;

  const LembagaItem({
    required this.id,
    required this.name,
    required this.acronym,
    required this.city,
    required this.type,
    required this.description,
    required this.partnershipProgram,
    required this.imageUrl,
    required this.studentsCount,
  });
}

/// Model 4 Pilar Program Kemitraan Resmi (Modul 4)
class KemitraanServiceItem {
  final String id;
  final String title;
  final String target;
  final String duration;
  final String description;
  final List<String> deliverables;
  final String iconName;

  const KemitraanServiceItem({
    required this.id,
    required this.title,
    required this.target,
    required this.duration,
    required this.description,
    required this.deliverables,
    required this.iconName,
  });
}
