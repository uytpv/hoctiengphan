import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise_type.dart';

part 'question.freezed.dart';
part 'question.g.dart';

ExerciseType _typeFromJson(dynamic value) {
  if (value == null) return ExerciseType.multipleChoice;
  final str = value.toString().toUpperCase().replaceAll('-', '_');
  switch (str) {
    case 'MULTIPLE_CHOICE':
    case 'MULTIPLECHOICE':
      return ExerciseType.multipleChoice;
    case 'FILL_IN_BLANK':
    case 'FILLINBLANK':
      return ExerciseType.fillInBlank;
    case 'MATCHING':
      return ExerciseType.matching;
    case 'TRUE_FALSE':
    case 'TRUEFALSE':
      return ExerciseType.trueFalse;
    default:
      return ExerciseType.multipleChoice;
  }
}

String _typeToJson(ExerciseType type) => type.toJson();

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    @JsonKey(name: 'text') required String prompt,
    @JsonKey(fromJson: _typeFromJson, toJson: _typeToJson)
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
