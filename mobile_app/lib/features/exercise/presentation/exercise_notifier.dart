import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/exercise_repository.dart';
import '../domain/models/exercise.dart';

class ExerciseState {
  final bool isLoading;
  final Exercise? exercise;
  final Map<String, dynamic> answers;
  final bool isSubmitting;
  final Map<String, dynamic>? result;
  final String? error;
  final int currentIndex;
  final int timeElapsed;
  final bool isCompleted;
  final int score;

  ExerciseState({
    this.isLoading = false,
    this.exercise,
    this.answers = const {},
    this.isSubmitting = false,
    this.result,
    this.error,
    this.currentIndex = 0,
    this.timeElapsed = 0,
    this.isCompleted = false,
    this.score = 0,
  });

  ExerciseState copyWith({
    bool? isLoading,
    Exercise? exercise,
    Map<String, dynamic>? answers,
    bool? isSubmitting,
    Map<String, dynamic>? result,
    String? error,
    int? currentIndex,
    int? timeElapsed,
    bool? isCompleted,
    int? score,
  }) {
    return ExerciseState(
      isLoading: isLoading ?? this.isLoading,
      exercise: exercise ?? this.exercise,
      answers: answers ?? this.answers,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      result: result ?? this.result,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
    );
  }
}

class ExerciseNotifier extends StateNotifier<ExerciseState> {
  final ExerciseRepository _repository;
  final String _exerciseId;
  final String? _planId;
  final String? _activityId;
  Timer? _timer;

  ExerciseNotifier(this._repository, this._exerciseId, this._planId, this._activityId) : super(ExerciseState()) {
    loadExercise();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> loadExercise() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final exercise = await _repository.getExerciseById(_exerciseId);
      state = state.copyWith(isLoading: false, exercise: exercise);
      _startTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(timeElapsed: state.timeElapsed + 1);
    });
  }

  void submitCurrentAnswer(dynamic answer) {
    if (state.exercise == null) return;
    
    final question = state.exercise!.questions[state.currentIndex];
    final isCorrect = _checkAnswer(question, answer);
    
    final newAnswers = Map<String, dynamic>.from(state.answers);
    newAnswers[state.currentIndex.toString()] = answer;
    
    final newScore = isCorrect ? state.score + 1 : state.score;
    
    state = state.copyWith(
      answers: newAnswers,
      score: newScore,
    );

    if (state.currentIndex < state.exercise!.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    } else {
      _submitFinal();
    }
  }

  bool _checkAnswer(dynamic question, dynamic answer) {
    // Basic check logic - should be more robust depending on ExerciseType
    if (question.correctIndex != null) {
      return answer == question.correctIndex;
    }
    if (question.correctText != null) {
      return answer.toString().trim().toLowerCase() == question.correctText!.toLowerCase();
    }
    return false;
  }

  Future<void> _submitFinal() async {
    _timer?.cancel();
    state = state.copyWith(isSubmitting: true);
    try {
      final result = await _repository.submitAnswer(
        exerciseId: _exerciseId,
        answers: state.answers,
        planId: _planId,
        activityId: _activityId,
      );
      state = state.copyWith(
        isSubmitting: false, 
        result: result,
        isCompleted: true,
      );
    } catch (e) {
      state = state.copyWith(isSubmitting: false, error: e.toString());
    }
  }

  void reset() {
    state = ExerciseState();
    loadExercise();
  }
}

final exerciseNotifierProvider = StateNotifierProvider.autoDispose.family<ExerciseNotifier, ExerciseState, ({String exerciseId, String? planId, String? activityId})>((ref, params) {
  final repository = ref.watch(exerciseRepositoryProvider);
  return ExerciseNotifier(repository, params.exerciseId, params.planId, params.activityId);
});
