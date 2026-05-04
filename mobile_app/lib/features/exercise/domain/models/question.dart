import 'package:freezed_annotation/freezed_annotation.dart';
import 'exercise_type.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String prompt,
    @Default(ExerciseType.multipleChoice) 
    @JsonKey(
      fromJson: ExerciseType.fromJson,
      toJson: _exerciseTypeToJson,
    )
    ExerciseType type,
    List<String>? options,
    int? correctIndex,
    String? correctText,
    String? explanation,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}

String _exerciseTypeToJson(ExerciseType type) => type.toJson();
