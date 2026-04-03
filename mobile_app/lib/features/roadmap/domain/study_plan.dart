import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_plan.freezed.dart';
part 'study_plan.g.dart';

@freezed
class StudyPlan with _$StudyPlan {
  const factory StudyPlan({
    required String id,
    required int month,
    required int week,
    required String title,
    required StudyDays days,
  }) = _StudyPlan;

  factory StudyPlan.fromJson(Map<String, dynamic> json) => _$StudyPlanFromJson(json);
}

@freezed
class StudyDays with _$StudyDays {
  const factory StudyDays({
    @Default([]) List<StudyTask> monday,
    @Default([]) List<StudyTask> tuesday,
    @Default([]) List<StudyTask> wednesday,
    @Default([]) List<StudyTask> thursday,
    @Default([]) List<StudyTask> friday,
    @Default([]) List<StudyTask> saturday,
    @Default([]) List<StudyTask> sunday,
  }) = _StudyDays;

  factory StudyDays.fromJson(Map<String, dynamic> json) => _$StudyDaysFromJson(json);
}

@freezed
class StudyTask with _$StudyTask {
  const factory StudyTask({
    required String id,
    required String title,
    required String detail,
    required String iconType,
    String? grammarLink,
  }) = _StudyTask;

  factory StudyTask.fromJson(Map<String, dynamic> json) => _$StudyTaskFromJson(json);
}
