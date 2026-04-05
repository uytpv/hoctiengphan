// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GrammarImpl _$$GrammarImplFromJson(Map<String, dynamic> json) =>
    _$GrammarImpl(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String?,
      content: json['content'] as String? ?? '',
      audioUrl: json['audioUrl'] as String?,
      relatedVocabularyIds:
          (json['relatedVocabularyIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GrammarImplToJson(_$GrammarImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'content': instance.content,
      'audioUrl': instance.audioUrl,
      'relatedVocabularyIds': instance.relatedVocabularyIds,
    };
