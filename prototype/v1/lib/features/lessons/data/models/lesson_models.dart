sealed class LessonStepCard {
  final String id;
  final String stepHeadline;

  const LessonStepCard({
    required this.id,
    required this.stepHeadline,
  });
}

class TextInsightCard extends LessonStepCard {
  final String contentMarkdown;
  final String? keyTakeaway;

  const TextInsightCard({
    required super.id,
    required super.stepHeadline,
    required this.contentMarkdown,
    this.keyTakeaway,
  });
}

class MultipleChoiceCard extends LessonStepCard {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const MultipleChoiceCard({
    required super.id,
    required super.stepHeadline,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class SwipePollCard extends LessonStepCard {
  final String statement;
  final String agreeFeedback;
  final String disagreeFeedback;

  const SwipePollCard({
    required super.id,
    required super.stepHeadline,
    required this.statement,
    required this.agreeFeedback,
    required this.disagreeFeedback,
  });
}

class FillInBlankCard extends LessonStepCard {
  final String sentenceBefore;
  final String blankExpected;
  final String sentenceAfter;
  final List<String> wordBank;
  final String explanation;

  const FillInBlankCard({
    required super.id,
    required super.stepHeadline,
    required this.sentenceBefore,
    required this.blankExpected,
    required this.sentenceAfter,
    required this.wordBank,
    required this.explanation,
  });
}

class Lesson {
  final String lessonId;
  final String title;
  final String subtitle;
  final String domain;
  final int estimatedMinutes;
  final List<LessonStepCard> cards;

  const Lesson({
    required this.lessonId,
    required this.title,
    required this.subtitle,
    required this.domain,
    required this.estimatedMinutes,
    required this.cards,
  });
}
