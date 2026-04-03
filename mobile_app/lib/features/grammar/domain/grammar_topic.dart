import 'package:freezed_annotation/freezed_annotation.dart';

part 'grammar_topic.freezed.dart';
part 'grammar_topic.g.dart';

@freezed
class GrammarTopic with _$GrammarTopic {
  const factory GrammarTopic({
    required String id,
    required String chapter,
    required String title,
    String? desc,
    dynamic content,
  }) = _GrammarTopic;

  factory GrammarTopic.fromJson(Map<String, dynamic> json) => _$GrammarTopicFromJson(json);
}
