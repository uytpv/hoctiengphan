import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_plan.freezed.dart';
part 'study_plan.g.dart';

class ActionItemTypeConverter implements JsonConverter<ActionItemType, String> {
  const ActionItemTypeConverter();

  @override
  ActionItemType fromJson(String json) {
    switch (json) {
      case 'lesson_full':
      case 'lessonFull':
        return ActionItemType.lessonFull;
      case 'lesson_slice':
      case 'lessonSlice':
        return ActionItemType.lessonSlice;
      case 'vocabulary_set':
      case 'vocabularySet':
        return ActionItemType.vocabularySet;
      case 'grammar_point':
      case 'grammarPoint':
        return ActionItemType.grammarPoint;
      case 'exercise_set':
      case 'exerciseSet':
        return ActionItemType.exerciseSet;
      case 'immersion_music':
      case 'immersionMusic':
        return ActionItemType.immersionMusic;
      case 'immersion_movie':
      case 'immersionMovie':
        return ActionItemType.immersionMovie;
      case 'immersion_sign':
      case 'immersionSign':
        return ActionItemType.immersionSign;
      default:
        return ActionItemType.custom;
    }
  }

  @override
  String toJson(ActionItemType object) {
    switch (object) {
      case ActionItemType.lessonFull:
        return 'lesson_full';
      case ActionItemType.lessonSlice:
        return 'lesson_slice';
      case ActionItemType.vocabularySet:
        return 'vocabulary_set';
      case ActionItemType.grammarPoint:
        return 'grammar_point';
      case ActionItemType.exerciseSet:
        return 'exercise_set';
      case ActionItemType.immersionMusic:
        return 'immersion_music';
      case ActionItemType.immersionMovie:
        return 'immersion_movie';
      case ActionItemType.immersionSign:
        return 'immersion_sign';
      case ActionItemType.custom:
        return 'custom';
    }
  }
}

enum ActionItemType {
  lessonFull,
  lessonSlice,
  vocabularySet,
  grammarPoint,
  exerciseSet,
  immersionMusic,
  immersionMovie,
  immersionSign,
  custom,
}

@freezed
class ActionStep with _$ActionStep {
  const factory ActionStep({
    required int stepNumber,
    required String instruction,
    String? tip,
  }) = _ActionStep;

  factory ActionStep.fromJson(Map<String, dynamic> json) =>
      _$ActionStepFromJson(json);
}

@freezed
class DailyActionItem with _$DailyActionItem {
  const factory DailyActionItem({
    required String id,
    @ActionItemTypeConverter() required ActionItemType type,
    required String title,
    @Default('') String goal,
    @Default(15) int estimatedMinutes,
    String? targetRefId,
    @Default([]) List<String> specificItemIds,
    @Default([]) List<ActionStep> steps,
    String? externalLink,
    String? notes,
  }) = _DailyActionItem;

  factory DailyActionItem.fromJson(Map<String, dynamic> json) =>
      _$DailyActionItemFromJson(json);
}

@freezed
class StudyPlan with _$StudyPlan {
  const factory StudyPlan({
    required String id,
    required String title,
    @Default('') String description,
    @Default(26) int durationWeeks,
    @Default(true) bool isDefault,
    DateTime? createdAt,
  }) = _StudyPlan;

  factory StudyPlan.fromJson(Map<String, dynamic> json) =>
      _$StudyPlanFromJson(json);
}

@freezed
class StudyPlanWeek with _$StudyPlanWeek {
  const factory StudyPlanWeek({
    required String id,
    required String planId,
    required int weekNumber,
    required String title,
    @Default([]) List<StudyDay> days,
  }) = _StudyPlanWeek;

  factory StudyPlanWeek.fromJson(Map<String, dynamic> json) =>
      _$StudyPlanWeekFromJson(json);
}

@freezed
class StudyDay with _$StudyDay {
  const factory StudyDay({
    @Default(1) int dayIndex,
    required String dayName, // e.g., "Monday", "Tiistai"
    @Default([]) List<String> activityIds, // Deprecated fallback
    @Default([]) List<DailyActionItem> actions, // New direct polymorphic actions
  }) = _StudyDay;

  factory StudyDay.fromJson(Map<String, dynamic> json) =>
      _$StudyDayFromJson(json);
}
