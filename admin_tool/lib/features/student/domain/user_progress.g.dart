// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String? ?? '',
      enrollments:
          (json['enrollments'] as List<dynamic>?)
              ?.map((e) => Enrollment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'enrollments': instance.enrollments.map((e) => e.toJson()).toList(),
    };

_$EnrollmentImpl _$$EnrollmentImplFromJson(Map<String, dynamic> json) =>
    _$EnrollmentImpl(
      planId: json['planId'] as String,
      planTitle: json['planTitle'] as String,
      progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'active',
      completedActivityIds:
          (json['completedActivityIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      lastAccessedAt: json['lastAccessedAt'] == null
          ? null
          : DateTime.parse(json['lastAccessedAt'] as String),
    );

Map<String, dynamic> _$$EnrollmentImplToJson(_$EnrollmentImpl instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'planTitle': instance.planTitle,
      'progressPercent': instance.progressPercent,
      'status': instance.status,
      'completedActivityIds': instance.completedActivityIds,
      'startDate': instance.startDate?.toIso8601String(),
      'lastAccessedAt': instance.lastAccessedAt?.toIso8601String(),
    };
