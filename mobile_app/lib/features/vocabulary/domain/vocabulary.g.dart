// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VocabularyImpl _$$VocabularyImplFromJson(Map<String, dynamic> json) =>
    _$VocabularyImpl(
      id: json['id'] as String,
      finnish: json['finnish'] as String,
      english: json['english'] as String?,
      vietnamese: json['vietnamese'] as String,
      lessonId: json['lessonId'] as String,
      isGlobal: json['isGlobal'] as bool? ?? false,
      authorId: json['authorId'] as String?,
    );

Map<String, dynamic> _$$VocabularyImplToJson(_$VocabularyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'finnish': instance.finnish,
      'english': instance.english,
      'vietnamese': instance.vietnamese,
      'lessonId': instance.lessonId,
      'isGlobal': instance.isGlobal,
      'authorId': instance.authorId,
    };
