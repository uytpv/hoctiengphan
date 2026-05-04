import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String type, // fill-in-blanks, true-false, multiple-choice, etc.
    String? readingText,
    @JsonKey(name: 'instruction') @Default('') String content,
    @Default([]) List<Question> questions,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}
