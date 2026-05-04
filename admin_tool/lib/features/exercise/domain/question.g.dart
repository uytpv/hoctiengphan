// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      id: json['id'] as String,
      prompt: json['text'] as String,
      type:
          $enumDecodeNullable(_$ExerciseTypeEnumMap, json['type']) ??
          ExerciseType.multipleChoice,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctAnswers: (json['correctAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctAnswer: json['correctAnswer'] as String?,
      correctIndex: (json['correctIndex'] as num?)?.toInt(),
      correctText: json['correctText'] as String?,
      imageUrl: json['imageUrl'] as String?,
      audioUrl: json['audioUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.prompt,
      'type': instance.type.toJson(),
      'options': instance.options,
      'correctAnswers': instance.correctAnswers,
      'correctAnswer': instance.correctAnswer,
      'correctIndex': instance.correctIndex,
      'correctText': instance.correctText,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
      'videoUrl': instance.videoUrl,
      'explanation': instance.explanation,
    };

const _$ExerciseTypeEnumMap = {
  ExerciseType.multipleChoice: 'multipleChoice',
  ExerciseType.fillInBlank: 'fillInBlank',
  ExerciseType.matching: 'matching',
  ExerciseType.trueFalse: 'trueFalse',
};
