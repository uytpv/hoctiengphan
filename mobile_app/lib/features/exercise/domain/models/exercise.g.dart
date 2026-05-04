// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: json['id'] as String,
      titleFi: json['titleFi'] as String,
      titleVi: json['titleVi'] as String?,
      instructionFi: json['instructionFi'] as String?,
      instructionVi: json['instructionVi'] as String?,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lessonId: json['lessonId'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleFi': instance.titleFi,
      'titleVi': instance.titleVi,
      'instructionFi': instance.instructionFi,
      'instructionVi': instance.instructionVi,
      'questions': instance.questions,
      'lessonId': instance.lessonId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
