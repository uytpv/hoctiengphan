// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyPlanImpl _$$StudyPlanImplFromJson(Map<String, dynamic> json) =>
    _$StudyPlanImpl(
      id: json['id'] as String,
      month: (json['month'] as num).toInt(),
      week: (json['week'] as num).toInt(),
      title: json['title'] as String,
      days: StudyDays.fromJson(json['days'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StudyPlanImplToJson(_$StudyPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'month': instance.month,
      'week': instance.week,
      'title': instance.title,
      'days': instance.days,
    };

_$StudyDaysImpl _$$StudyDaysImplFromJson(Map<String, dynamic> json) =>
    _$StudyDaysImpl(
      monday:
          (json['monday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tuesday:
          (json['tuesday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      wednesday:
          (json['wednesday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      thursday:
          (json['thursday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      friday:
          (json['friday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      saturday:
          (json['saturday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      sunday:
          (json['sunday'] as List<dynamic>?)
              ?.map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StudyDaysImplToJson(_$StudyDaysImpl instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };

_$StudyTaskImpl _$$StudyTaskImplFromJson(Map<String, dynamic> json) =>
    _$StudyTaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      detail: json['detail'] as String,
      iconType: json['iconType'] as String,
      grammarLink: json['grammarLink'] as String?,
    );

Map<String, dynamic> _$$StudyTaskImplToJson(_$StudyTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'detail': instance.detail,
      'iconType': instance.iconType,
      'grammarLink': instance.grammarLink,
    };
