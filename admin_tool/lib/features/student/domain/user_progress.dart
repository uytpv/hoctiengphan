import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String email,
    @Default('') String displayName,
    @Default([]) List<Enrollment> enrollments,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
class Enrollment with _$Enrollment {
  const factory Enrollment({
    required String planId,
    required String planTitle,
    @Default(0) double progressPercent,
    @Default('active') String status, // active, completed
    @Default([]) List<String> completedActivityIds,
    DateTime? startDate,
    DateTime? lastAccessedAt,
  }) = _Enrollment;

  factory Enrollment.fromJson(Map<String, dynamic> json) => _$EnrollmentFromJson(json);
}
