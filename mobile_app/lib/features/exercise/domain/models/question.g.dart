// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      prompt: json['prompt'] as String,
      type: json['type'] == null
          ? ExerciseType.multipleChoice
          : ExerciseType.fromJson(json['type'] as String),
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      correctIndex: (json['correctIndex'] as num?)?.toInt(),
      correctText: json['correctText'] as String?,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'type': _exerciseTypeToJson(instance.type),
      'options': instance.options,
      'correctIndex': instance.correctIndex,
      'correctText': instance.correctText,
      'explanation': instance.explanation,
    };
