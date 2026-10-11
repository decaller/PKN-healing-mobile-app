// ==============================================================================
// CONCEPTING PHASE: PRIMER LESSON ENGINE STATE MACHINE BLUEPRINT
// ------------------------------------------------------------------------------
// Enforces strict immutability for active micro-lesson decks. Separates
// card progression, answer validation, and deck completion from presentation.
// ==============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents the immutable state of an active lesson session
class LessonSessionState {
  final int currentIndex;
  final Map<String, String> userAnswers; // stepId -> selectedOptionId
  final bool isCompleted;

  const LessonSessionState({
    this.currentIndex = 0,
    this.userAnswers = const {},
    this.isCompleted = false,
  });

  LessonSessionState copyWith({
    int? currentIndex,
    Map<String, String>? userAnswers,
    bool? isCompleted,
  }) {
    return LessonSessionState(
      currentIndex: currentIndex ?? this.currentIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Riverpod Provider for managing lesson session navigation and answers.
/// Parameterized by the total number of cards in the active deck.
final lessonPlayerProvider = StateNotifierProvider.autoDispose
    .family<LessonPlayerNotifier, LessonSessionState, int>((ref, totalCards) {
  return LessonPlayerNotifier(totalCards);
});

class LessonPlayerNotifier extends StateNotifier<LessonSessionState> {
  final int totalCards;

  LessonPlayerNotifier(this.totalCards) : super(const LessonSessionState());

  void nextCard() {
    if (state.currentIndex < totalCards - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      state = state.copyWith(isCompleted: true);
    }
  }

  void previousCard() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }

  void answerQuestion(String stepId, String optionId) {
    final updatedAnswers = Map<String, String>.from(state.userAnswers)
      ..[stepId] = optionId;
    state = state.copyWith(userAnswers: updatedAnswers);
  }

  void reset() {
    state = const LessonSessionState();
  }
}
