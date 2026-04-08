import 'package:cloud_firestore/cloud_firestore.dart';

enum ActivityType { lesson, exercise, grammar, vocabulary }

enum ActivityStatus { todo, inProgress, done }

class Activity {
  const Activity({
    required this.id,
    required this.type,
    required this.title,
    this.refId = '',
    this.description = '',
    this.status = ActivityStatus.todo,
    this.order = 0,
  });

  final String id;
  final ActivityType type;
  final String refId; // lessonId or exerciseId
  final String title;
  final String description;
  final ActivityStatus status;
  final int order;

  /// Alias for referencing the lesson/exercise document
  String get referenceId => refId;

  // For backwards compatibility – show title in any language
  String get titleFi => title;
  String get titleVi => title;
  String get titleEn => title;
  String titleFor(String lang) => title;

  Activity copyWith({ActivityStatus? status}) {
    return Activity(
      id: id,
      type: type,
      refId: refId,
      title: title,
      description: description,
      status: status ?? this.status,
      order: order,
    );
  }

  factory Activity.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Activity(
      id: doc.id,
      type: ActivityType.values.firstWhere(
        (e) => e.name == (data['type'] ?? 'lesson'),
        orElse: () => ActivityType.lesson,
      ),
      refId: data['lessonId'] ?? data['exerciseId'] ?? data['refId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }
}

class Day {
  const Day({
    required this.id,
    required this.dayNumber,
    required this.name,
    this.activityIds = const [],
    this.activities = const [],
  });

  final String id;
  final int dayNumber;
  final String name; // e.g. "Thứ 2", "Thứ 3"
  final List<String> activityIds;
  final List<Activity> activities;

  // For UI display
  String get titleFi => name;
  String get titleVi => name;
  String get titleEn => name;
  String titleFor(String lang) => name;

  double get progress {
    if (activities.isEmpty) return 0;
    final done =
        activities.where((a) => a.status == ActivityStatus.done).length;
    return done / activities.length;
  }

  Day copyWith({List<Activity>? activities}) {
    return Day(
      id: id,
      dayNumber: dayNumber,
      name: name,
      activityIds: activityIds,
      activities: activities ?? this.activities,
    );
  }

  factory Day.fromMap(int index, Map<String, dynamic> map) {
    final rawIds = (map['activityIds'] as List<dynamic>?) ?? [];
    return Day(
      id: '${map['dayName'] ?? index}',
      dayNumber: index,
      name: map['dayName'] as String? ?? 'Ngày ${index + 1}',
      activityIds: rawIds.map((e) => e.toString()).toList(),
    );
  }
}

class StudyPlanWeek {
  const StudyPlanWeek({
    required this.id,
    required this.weekNumber,
    required this.title,
    this.days = const [],
  });

  final String id;
  final int weekNumber;
  final String title; // e.g. "Tuần 1"
  final List<Day> days;

  // For UI compatibility
  String get titleFi => title;
  String get titleVi => title;
  String get titleEn => title;
  String titleFor(String lang) => title;

  double get progress {
    if (days.isEmpty) return 0;
    final total =
        days.fold<double>(0, (acc, d) => acc + d.progress);
    return total / days.length;
  }

  StudyPlanWeek copyWith({List<Day>? days}) {
    return StudyPlanWeek(
      id: id,
      weekNumber: weekNumber,
      title: title,
      days: days ?? this.days,
    );
  }

  factory StudyPlanWeek.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final rawDays = (data['days'] as List<dynamic>?) ?? [];
    return StudyPlanWeek(
      id: doc.id,
      weekNumber: (data['weekNumber'] as num?)?.toInt() ?? 0,
      title: data['title'] as String? ??
          data['titleVi'] as String? ??
          'Tuần ${(data['weekNumber'] as num?)?.toInt() ?? 0}',
      days: rawDays
          .asMap()
          .entries
          .map((e) => Day.fromMap(
              e.key, Map<String, dynamic>.from(e.value as Map)))
          .toList(),
    );
  }
}

class StudyPlan {
  const StudyPlan({
    required this.id,
    required this.titleFi,
    required this.titleVi,
    required this.titleEn,
    required this.descriptionFi,
    required this.descriptionVi,
    required this.descriptionEn,
    this.level = 'A1',
    this.totalWeeks = 0,
    this.weeks = const [],
    this.colorIndex = 0,
  });

  final String id;
  final String titleFi;
  final String titleVi;
  final String titleEn;
  final String descriptionFi;
  final String descriptionVi;
  final String descriptionEn;
  final String level;
  final int totalWeeks;
  final List<StudyPlanWeek> weeks;
  final int colorIndex;

  String titleFor(String lang) =>
      lang == 'vi' ? titleVi : titleEn;

  String descriptionFor(String lang) =>
      lang == 'vi' ? descriptionVi : descriptionEn;

  double get progress {
    if (weeks.isEmpty) return 0;
    final total =
        weeks.fold<double>(0, (acc, w) => acc + w.progress);
    return total / weeks.length;
  }

  factory StudyPlan.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final title = data['title'] as String? ?? '';
    return StudyPlan(
      id: doc.id,
      titleFi: data['titleFi'] as String? ?? title,
      titleVi: data['titleVi'] as String? ?? title,
      titleEn: data['titleEn'] as String? ?? title,
      descriptionFi:
          data['descriptionFi'] as String? ??
          data['description'] as String? ?? '',
      descriptionVi:
          data['descriptionVi'] as String? ??
          data['description'] as String? ?? '',
      descriptionEn:
          data['descriptionEn'] as String? ??
          data['description'] as String? ?? '',
      level: data['level'] as String? ?? 'A1',
      totalWeeks: (data['durationWeeks'] as num?)?.toInt() ??
          (data['totalWeeks'] as num?)?.toInt() ?? 0,
      colorIndex: (data['colorIndex'] as num?)?.toInt() ?? 0,
    );
  }
}
