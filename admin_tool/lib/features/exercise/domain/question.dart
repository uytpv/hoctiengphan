import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise_type.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    @JsonKey(name: 'text') required String prompt,
    @Default(ExerciseType.multipleChoice) ExerciseType type,
    List<String>? options,
    List<String>? correctAnswers,
    String? correctAnswer,
    int? correctIndex,
    String? correctText,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? explanation,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}
