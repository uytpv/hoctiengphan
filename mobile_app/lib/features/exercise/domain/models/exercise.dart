import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    @JsonKey(name: 'titleFi') required String titleFi,
    @JsonKey(name: 'titleVi') String? titleVi,
    @JsonKey(name: 'instructionFi') String? instructionFi,
    @JsonKey(name: 'instructionVi') String? instructionVi,
    @Default([]) List<Question> questions,
    String? lessonId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}
