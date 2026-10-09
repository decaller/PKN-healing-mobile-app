import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/storage_service.dart';
import '../../data/models/lesson_models.dart';

class LessonPlayerState {
  final Lesson lesson;
  final int currentStepIndex;
  final int? selectedOptionIndex;
  final bool? pollChoice; // true = agree, false = disagree
  final String? selectedBlankWord;
  final bool isAnswerChecked;
  final bool isAnswerCorrect;
  final bool isDeckCompleted;

  const LessonPlayerState({
    required this.lesson,
    this.currentStepIndex = 0,
    this.selectedOptionIndex,
    this.pollChoice,
    this.selectedBlankWord,
    this.isAnswerChecked = false,
    this.isAnswerCorrect = false,
    this.isDeckCompleted = false,
  });

  LessonStepCard get currentCard => lesson.cards[currentStepIndex];
  bool get isLastStep => currentStepIndex == lesson.cards.length - 1;

  LessonPlayerState copyWith({
    Lesson? lesson,
    int? currentStepIndex,
    int? selectedOptionIndex,
    bool? pollChoice,
    String? selectedBlankWord,
    bool? isAnswerChecked,
    bool? isAnswerCorrect,
    bool? isDeckCompleted,
    bool clearAnswers = false,
  }) {
    return LessonPlayerState(
      lesson: lesson ?? this.lesson,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      selectedOptionIndex:
          clearAnswers ? null : (selectedOptionIndex ?? this.selectedOptionIndex),
      pollChoice: clearAnswers ? null : (pollChoice ?? this.pollChoice),
      selectedBlankWord:
          clearAnswers ? null : (selectedBlankWord ?? this.selectedBlankWord),
      isAnswerChecked: clearAnswers ? false : (isAnswerChecked ?? this.isAnswerChecked),
      isAnswerCorrect: clearAnswers ? false : (isAnswerCorrect ?? this.isAnswerCorrect),
      isDeckCompleted: isDeckCompleted ?? this.isDeckCompleted,
    );
  }
}

final lessonPlayerControllerProvider = StateNotifierProvider.autoDispose
    .family<LessonPlayerController, LessonPlayerState, Lesson>((ref, lesson) {
  final storageService = ref.watch(storageServiceProvider);
  return LessonPlayerController(storageService, lesson);
});

class LessonPlayerController extends StateNotifier<LessonPlayerState> {
  final StorageService _storageService;

  LessonPlayerController(this._storageService, Lesson lesson)
      : super(LessonPlayerState(lesson: lesson));

  void selectMultipleChoiceOption(int index) {
    if (state.isAnswerChecked) return;
    state = state.copyWith(selectedOptionIndex: index);
  }

  void choosePoll(bool agree) {
    state = state.copyWith(pollChoice: agree, isAnswerChecked: true);
  }

  void selectBlankWord(String word) {
    if (state.isAnswerChecked) return;
    state = state.copyWith(selectedBlankWord: word);
  }

  void checkAnswer() {
    final card = state.currentCard;

    if (card is MultipleChoiceCard) {
      final isCorrect = state.selectedOptionIndex == card.correctIndex;
      state = state.copyWith(
        isAnswerChecked: true,
        isAnswerCorrect: isCorrect,
      );
    } else if (card is FillInBlankCard) {
      final isCorrect = state.selectedBlankWord?.trim().toLowerCase() ==
          card.blankExpected.trim().toLowerCase();
      state = state.copyWith(
        isAnswerChecked: true,
        isAnswerCorrect: isCorrect,
      );
    }
  }

  Future<bool> proceedNext() async {
    if (state.isLastStep) {
      await _storageService.markLessonCompleted(state.lesson.lessonId);
      state = state.copyWith(isDeckCompleted: true);
      return true; // Finished
    } else {
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex + 1,
        clearAnswers: true,
      );
      return false; // Continuing deck
    }
  }
}
