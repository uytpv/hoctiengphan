import 'package:freezed_annotation/freezed_annotation.dart';

part 'grammar.freezed.dart';
part 'grammar.g.dart';

@freezed
class Grammar with _$Grammar {
  const factory Grammar({
    required String id,
    @Default('') String title,
    String? slug,
    @Default('') String content, // Markdown or Quill JSON
    String? audioUrl,
    @Default([]) List<String> relatedVocabularyIds,
  }) = _Grammar;

  factory Grammar.fromJson(Map<String, dynamic> json) => _$GrammarFromJson(json);
}
