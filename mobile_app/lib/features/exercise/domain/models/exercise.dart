import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Exercise.fromDoc(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    return Exercise.fromMap(data, doc.id);
  }

  factory Exercise.fromMap(Map<String, dynamic> data, String id) {
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is DateTime) return val;
      if (val is String) return DateTime.tryParse(val) ?? DateTime.now();
      return DateTime.now();
    }

    final rawQuestions = (data['questions'] as List<dynamic>?) ?? [];
    final questions = rawQuestions.map((q) {
      if (q is Map) {
        return Question.fromJson(Map<String, dynamic>.from(q));
      }
      return Question(prompt: q.toString());
    }).toList();

    final title = data['titleFi'] as String? ?? data['title'] as String? ?? 'Harjoitus';

    return Exercise(
      id: id,
      titleFi: title,
      titleVi: data['titleVi'] as String? ?? data['title'] as String?,
      instructionFi: data['instructionFi'] as String? ?? data['instruction'] as String? ?? data['description'] as String?,
      instructionVi: data['instructionVi'] as String?,
      questions: questions,
      lessonId: data['lessonId'] as String?,
      createdAt: parseDate(data['created_at'] ?? data['createdAt']),
      updatedAt: parseDate(data['updated_at'] ?? data['updatedAt']),
    );
  }
}
