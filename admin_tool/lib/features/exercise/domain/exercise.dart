import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';
import 'exercise_type.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

List<Question> _questionsFromJson(dynamic json) {
  if (json is List) {
    return json.map((item) {
      if (item is String) {
        return Question(
          id: item.hashCode.toString(),
          prompt: item,
          type: ExerciseType.multipleChoice,
          options: const [],
          correctAnswers: const [],
        );
      } else if (item is Map) {
        return Question.fromJson(Map<String, dynamic>.from(item));
      }
      return Question(
        id: item.toString().hashCode.toString(),
        prompt: item.toString(),
        type: ExerciseType.multipleChoice,
      );
    }).toList();
  }
  return const [];
}

List<Map<String, dynamic>> _questionsToJson(List<Question> questions) {
  return questions.map((q) => q.toJson()).toList();
}

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String type, // fill-in-blanks, true-false, multiple-choice, etc.
    String? readingText,
    @JsonKey(name: 'instruction') @Default('') String content,
    @JsonKey(fromJson: _questionsFromJson, toJson: _questionsToJson)
    @Default([]) List<Question> questions,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}
