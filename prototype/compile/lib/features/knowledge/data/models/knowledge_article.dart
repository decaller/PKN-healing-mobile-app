class KnowledgeArticle {
  final String id;
  final String title;
  final String category;
  final String contentType;
  final String provenance; // 'expert_verified' (Pakar Non-AI) atau 'ai_assisted' (Wiki-AI)
  final String? author;
  final String summary;
  final String body;
  final List<String> tags;
  final double? similarityScore;

  const KnowledgeArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.contentType,
    required this.provenance,
    this.author,
    required this.summary,
    required this.body,
    this.tags = const [],
    this.similarityScore,
  });

  bool get isExpertVerified => provenance == 'expert_verified';
  bool get isAiAssisted => provenance == 'ai_assisted';

  factory KnowledgeArticle.fromJson(Map<String, dynamic> json) {
    return KnowledgeArticle(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? 'Kaidah Fitrah',
      contentType: json['content_type']?.toString() ?? 'article',
      provenance: json['provenance']?.toString() ?? 'expert_verified',
      author: json['author']?.toString(),
      summary: json['summary']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      similarityScore: (json['score'] as num?)?.toDouble(),
    );
  }
}
