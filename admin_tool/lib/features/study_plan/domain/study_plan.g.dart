// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActionStepImpl _$$ActionStepImplFromJson(Map<String, dynamic> json) =>
    _$ActionStepImpl(
      stepNumber: (json['stepNumber'] as num).toInt(),
      instruction: json['instruction'] as String,
      tip: json['tip'] as String?,
    );

Map<String, dynamic> _$$ActionStepImplToJson(_$ActionStepImpl instance) =>
    <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'instruction': instance.instruction,
      'tip': instance.tip,
    };

_$DailyActionItemImpl _$$DailyActionItemImplFromJson(
  Map<String, dynamic> json,
) => _$DailyActionItemImpl(
  id: json['id'] as String,
  type: const ActionItemTypeConverter().fromJson(json['type'] as String),
  title: json['title'] as String,
  goal: json['goal'] as String? ?? '',
  estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt() ?? 15,
  targetRefId: json['targetRefId'] as String?,
  specificItemIds:
      (json['specificItemIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => ActionStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  externalLink: json['externalLink'] as String?,
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$$DailyActionItemImplToJson(
  _$DailyActionItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': const ActionItemTypeConverter().toJson(instance.type),
  'title': instance.title,
  'goal': instance.goal,
  'estimatedMinutes': instance.estimatedMinutes,
  'targetRefId': instance.targetRefId,
  'specificItemIds': instance.specificItemIds,
  'steps': instance.steps.map((e) => e.toJson()).toList(),
  'externalLink': instance.externalLink,
  'notes': instance.notes,
};

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
      dayIndex: (json['dayIndex'] as num?)?.toInt() ?? 1,
      dayName: json['dayName'] as String,
      activityIds:
          (json['activityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      actions:
          (json['actions'] as List<dynamic>?)
              ?.map((e) => DailyActionItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StudyDayImplToJson(_$StudyDayImpl instance) =>
    <String, dynamic>{
      'dayIndex': instance.dayIndex,
      'dayName': instance.dayName,
      'activityIds': instance.activityIds,
      'actions': instance.actions.map((e) => e.toJson()).toList(),
    };
