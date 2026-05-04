import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exercise_notifier.dart';
import '../domain/models/exercise_type.dart';

class QuestionResult {
  final String prompt;
  final bool isCorrect;
  final String userAnswer;
  final String correctAnswer;
  final String? explanation;

  QuestionResult({
    required this.prompt,
    required this.isCorrect,
    required this.userAnswer,
    required this.correctAnswer,
    this.explanation,
  });
}

class ExerciseSummary {
  final int score;
  final int total;
  final List<QuestionResult> details;

  ExerciseSummary({
    required this.score,
    required this.total,
    required this.details,
  });

  double get percentage => total > 0 ? (score / total) * 100 : 0;
}

final exerciseResultProvider = Provider.family<ExerciseSummary?, ({String exerciseId, String? planId, String? activityId})>((ref, params) {
  final state = ref.watch(exerciseNotifierProvider(params));
  final exercise = state.exercise;
  
  if (exercise == null || state.result == null) return null;

  final details = <QuestionResult>[];
  int score = 0;

  for (int i = 0; i < exercise.questions.length; i++) {
    final question = exercise.questions[i];
    final userAnswer = state.answers[i.toString()];
    bool isCorrect = false;
    String userAnswerStr = '';
    String correctAnswerStr = '';

    if (question.type == ExerciseType.multipleChoice) {
      final selectedIndex = userAnswer as int?;
      isCorrect = selectedIndex == question.correctIndex;
      userAnswerStr = selectedIndex != null && question.options != null && selectedIndex < question.options!.length 
          ? question.options![selectedIndex] 
          : 'Chưa trả lời';
      correctAnswerStr = question.correctIndex != null && question.options != null && question.correctIndex! < question.options!.length
          ? question.options![question.correctIndex!]
          : '';
    } else if (question.type == ExerciseType.fillInBlank) {
      final answer = (userAnswer as String? ?? '').trim().toLowerCase();
      final correct = (question.correctText ?? '').trim().toLowerCase();
      isCorrect = answer == correct;
      userAnswerStr = userAnswer ?? 'Chưa trả lời';
      correctAnswerStr = question.correctText ?? '';
    }

    if (isCorrect) score++;

    details.add(QuestionResult(
      prompt: question.prompt,
      isCorrect: isCorrect,
      userAnswer: userAnswerStr,
      correctAnswer: correctAnswerStr,
      explanation: question.explanation,
    ));
  }

  return ExerciseSummary(
    score: score,
    total: exercise.questions.length,
    details: details,
  );
});
