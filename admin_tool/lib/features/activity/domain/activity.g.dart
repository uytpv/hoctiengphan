// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      lessonId: json['lessonId'] as String?,
      exerciseId: json['exerciseId'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      isPublic: json['isPublic'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'lessonId': instance.lessonId,
      'exerciseId': instance.exerciseId,
      'mediaUrl': instance.mediaUrl,
      'linkUrl': instance.linkUrl,
      'isPublic': instance.isPublic,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ActivityTypeEnumMap = {
  ActivityType.lesson: 'lesson',
  ActivityType.music: 'music',
  ActivityType.exercise: 'exercise',
  ActivityType.communication: 'communication',
  ActivityType.writing: 'writing',
  ActivityType.observation: 'observation',
  ActivityType.movie: 'movie',
  ActivityType.breakTime: 'breakTime',
};
