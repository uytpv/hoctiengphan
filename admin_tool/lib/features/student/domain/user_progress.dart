import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    String? email,
    @Default('') String displayName,
    @Default('student') String role,
    @Default([]) List<Enrollment> enrollments,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'] as String? ?? '',
    email: json['email'] as String?,
    displayName: json['displayName'] as String? ?? '',
    role: json['role'] as String? ?? 'student',
    enrollments:
        (json['enrollments'] as List<dynamic>?)
            ?.map((e) => Enrollment.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

@freezed
class Enrollment with _$Enrollment {
  const factory Enrollment({
    required String planId,
    required String planTitle,
    @Default(0) double progressPercent,
    @Default('active') String status,
    @Default([]) List<String> completedActivityIds,
    DateTime? startDate,
    DateTime? lastAccessedAt,
  }) = _Enrollment;

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
    planId: json['planId'] as String? ?? '',
    planTitle: json['planTitle'] as String? ?? '',
    progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0.0,
    status: json['status'] as String? ?? 'active',
    completedActivityIds:
        (json['completedActivityIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    startDate: json['startDate'] != null
        ? DateTime.tryParse(json['startDate'].toString())
        : null,
    lastAccessedAt: json['lastAccessedAt'] != null
        ? DateTime.tryParse(json['lastAccessedAt'].toString())
        : null,
  );
}
