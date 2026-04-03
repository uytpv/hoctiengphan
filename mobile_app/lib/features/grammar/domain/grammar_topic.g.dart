// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grammar_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GrammarTopicImpl _$$GrammarTopicImplFromJson(Map<String, dynamic> json) =>
    _$GrammarTopicImpl(
      id: json['id'] as String,
      chapter: json['chapter'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String?,
      content: json['content'],
    );

Map<String, dynamic> _$$GrammarTopicImplToJson(_$GrammarTopicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chapter': instance.chapter,
      'title': instance.title,
      'desc': instance.desc,
      'content': instance.content,
    };
