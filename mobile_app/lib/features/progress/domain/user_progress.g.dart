// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgressImpl _$$UserProgressImplFromJson(Map<String, dynamic> json) =>
    _$UserProgressImpl(
      weekId: json['weekId'] as String,
      completedTasks:
          (json['completedTasks'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
      progressPercentage:
          (json['progressPercentage'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$UserProgressImplToJson(_$UserProgressImpl instance) =>
    <String, dynamic>{
      'weekId': instance.weekId,
      'completedTasks': instance.completedTasks,
      'progressPercentage': instance.progressPercentage,
    };
