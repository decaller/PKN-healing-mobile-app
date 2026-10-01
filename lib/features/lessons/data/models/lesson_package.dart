// ==============================================================================
// CONCEPTING PHASE: CONTENT PIPELINE JSON CONTRACT
// ------------------------------------------------------------------------------
// Defines the offline-first JSON schema contract for multi-format snackable decks.
// Allows modular content authoring independent from app compilation.
// ==============================================================================

/// Models matching the JSON Schema specification for the snackable lesson engine.
class LessonPackage {
  final String lessonId;
  final String title;
  final String category;
  final int estimatedMinutes;
  final List<LessonPackageCard> cards;

  const LessonPackage({
    required this.lessonId,
    required this.title,
    required this.category,
    required this.estimatedMinutes,
    required this.cards,
  });

  factory LessonPackage.fromJson(Map<String, dynamic> json) {
    return LessonPackage(
      lessonId: json['lessonId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      estimatedMinutes: json['estimatedMinutes'] as int? ?? 3,
      cards: (json['cards'] as List<dynamic>? ?? [])
          .map((c) => LessonPackageCard.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'title': title,
      'category': category,
      'estimatedMinutes': estimatedMinutes,
      'cards': cards.map((c) => c.toJson()).toList(),
    };
  }
}

class LessonPackageCard {
  final String stepId;
  final String type; // 'text', 'multiple_choice', 'summary'
  final String? title;
  final String? body;
  final String? question;
  final List<LessonPackageOption> options;
  final String? explanation;

  const LessonPackageCard({
    required this.stepId,
    required this.type,
    this.title,
    this.body,
    this.question,
    this.options = const [],
    this.explanation,
  });

  factory LessonPackageCard.fromJson(Map<String, dynamic> json) {
    return LessonPackageCard(
      stepId: json['stepId'] as String? ?? '',
      type: json['type'] as String? ?? 'text',
      title: json['title'] as String?,
      body: json['body'] as String?,
      question: json['question'] as String?,
      options: (json['options'] as List<dynamic>? ?? [])
          .map((o) => LessonPackageOption.fromJson(o as Map<String, dynamic>))
          .toList(),
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stepId': stepId,
      'type': type,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (question != null) 'question': question,
      if (options.isNotEmpty) 'options': options.map((o) => o.toJson()).toList(),
      if (explanation != null) 'explanation': explanation,
    };
  }
}

class LessonPackageOption {
  final String id;
  final String text;
  final bool isCorrect;

  const LessonPackageOption({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory LessonPackageOption.fromJson(Map<String, dynamic> json) {
    return LessonPackageOption(
      id: json['id'] as String? ?? '',
      text: json['text'] as String? ?? '',
      isCorrect: json['isCorrect'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
    };
  }
}
