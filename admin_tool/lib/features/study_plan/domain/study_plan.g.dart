// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyPlanImpl _$$StudyPlanImplFromJson(Map<String, dynamic> json) =>
    _$StudyPlanImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      durationWeeks: (json['durationWeeks'] as num?)?.toInt() ?? 26,
      isDefault: json['isDefault'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$StudyPlanImplToJson(_$StudyPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'durationWeeks': instance.durationWeeks,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$StudyPlanWeekImpl _$$StudyPlanWeekImplFromJson(Map<String, dynamic> json) =>
    _$StudyPlanWeekImpl(
      id: json['id'] as String,
      planId: json['planId'] as String,
      weekNumber: (json['weekNumber'] as num).toInt(),
      title: json['title'] as String,
      days:
          (json['days'] as List<dynamic>?)
              ?.map((e) => StudyDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StudyPlanWeekImplToJson(_$StudyPlanWeekImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planId': instance.planId,
      'weekNumber': instance.weekNumber,
      'title': instance.title,
      'days': instance.days.map((e) => e.toJson()).toList(),
    };

_$StudyDayImpl _$$StudyDayImplFromJson(Map<String, dynamic> json) =>
    _$StudyDayImpl(
      dayName: json['dayName'] as String,
      activityIds:
          (json['activityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StudyDayImplToJson(_$StudyDayImpl instance) =>
    <String, dynamic>{
      'dayName': instance.dayName,
      'activityIds': instance.activityIds,
    };
