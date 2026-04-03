import 'package:freezed_annotation/freezed_annotation.dart';

part 'vocabulary.freezed.dart';
part 'vocabulary.g.dart';

@freezed
class Vocabulary with _$Vocabulary {
  const factory Vocabulary({
    required String id,
    required String finnish,
    String? english,
    required String vietnamese,
    required String lessonId,
    @Default(false) bool isGlobal,
    String? authorId,
  }) = _Vocabulary;

  factory Vocabulary.fromJson(Map<String, dynamic> json) => _$VocabularyFromJson(json);
}
