// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonImpl _$$LessonImplFromJson(Map<String, dynamic> json) => _$LessonImpl(
  id: json['id'] as String,
  title: json['title'] as String? ?? '',
  chapter: json['chapter'] as String? ?? '',
  week: (json['week'] as num?)?.toInt(),
  description: json['description'] as String?,
  content: json['content'] as String? ?? '',
  vocabIds:
      (json['vocabIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  exerciseIds:
      (json['exerciseIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  audioUrls:
      (json['audioUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  grammarIds:
      (json['grammarIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'chapter': instance.chapter,
      'week': instance.week,
      'description': instance.description,
      'content': instance.content,
      'vocabIds': instance.vocabIds,
      'exerciseIds': instance.exerciseIds,
      'audioUrls': instance.audioUrls,
      'grammarIds': instance.grammarIds,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
