import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

class _QuestionsConverter
    implements JsonConverter<List<Map<String, dynamic>>, List<dynamic>> {
  const _QuestionsConverter();

  @override
  List<Map<String, dynamic>> fromJson(List<dynamic> json) {
    return json.map((e) {
      if (e is Map) {
        return Map<String, dynamic>.from(e);
      } else if (e is String) {
        // Handle cases where questions were imported as simple strings
        return {'text': e};
      }
      return <String, dynamic>{};
    }).toList();
  }

  @override
  List<dynamic> toJson(List<Map<String, dynamic>> object) => object;
}

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    @Default('') String title,
    @Default('') String description,
    @Default('')
    String type, // fill-in-blanks, true-false, multiple-choice, etc.
    String? readingText,
    @JsonKey(name: 'instruction')
    @Default('')
    String content, // Instructions/Markdown (mapped to 'instruction' in Firestore)
    @_QuestionsConverter() @Default([]) List<Map<String, dynamic>> questions,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) {
    // Legacy support for 'content' field if it was already saved
    final map = Map<String, dynamic>.from(json);
    if (map['content'] != null &&
        (map['instruction'] == null || map['instruction'] == '')) {
      map['instruction'] = map['content'];
    }
    return _$ExerciseFromJson(map);
  }
}
