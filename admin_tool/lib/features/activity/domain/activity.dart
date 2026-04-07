import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

enum ActivityType {
  lesson,
  music,
  exercise,
  communication,
  writing,
  observation,
  movie,
  breakTime,
}

@freezed
class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String title,
    @Default('') String description,
    required ActivityType type,
    String? lessonId,
    String? exerciseId,
    String? mediaUrl,
    String? linkUrl,
    @Default(false) bool isPublic,
    DateTime? createdAt,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}
