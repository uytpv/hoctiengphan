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
  lessonContent: json['lessonContent'] == null
      ? const LessonContent()
      : LessonContent.fromJson(json['lessonContent'] as Map<String, dynamic>),
  grammarIds:
      (json['grammarIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  speaking: json['speaking'] == null
      ? const LessonSpeaking()
      : LessonSpeaking.fromJson(json['speaking'] as Map<String, dynamic>),
  exerciseIds:
      (json['exerciseIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'chapter': instance.chapter,
      'week': instance.week,
      'description': instance.description,
      'lessonContent': instance.lessonContent.toJson(),
      'grammarIds': instance.grammarIds,
      'speaking': instance.speaking.toJson(),
      'exerciseIds': instance.exerciseIds,
    };

_$LessonContentImpl _$$LessonContentImplFromJson(Map<String, dynamic> json) =>
    _$LessonContentImpl(
      text: json['text'] as String? ?? '',
      videoUrl: json['videoUrl'] as String?,
      imageIds:
          (json['imageIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LessonContentImplToJson(_$LessonContentImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'videoUrl': instance.videoUrl,
      'imageIds': instance.imageIds,
    };

_$LessonSpeakingImpl _$$LessonSpeakingImplFromJson(Map<String, dynamic> json) =>
    _$LessonSpeakingImpl(
      text: json['text'] as String? ?? '',
      audioUrl: json['audioUrl'] as String?,
      conversationUrl: json['conversationUrl'] as String?,
    );

Map<String, dynamic> _$$LessonSpeakingImplToJson(
  _$LessonSpeakingImpl instance,
) => <String, dynamic>{
  'text': instance.text,
  'audioUrl': instance.audioUrl,
  'conversationUrl': instance.conversationUrl,
};
