import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_plan.freezed.dart';
part 'study_plan.g.dart';

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
    required String dayName, // e.g., "Monday", "Tiistai"
    @Default([]) List<String> activityIds, // IDs of activities to perform
  }) = _StudyDay;

  factory StudyDay.fromJson(Map<String, dynamic> json) =>
      _$StudyDayFromJson(json);
}
