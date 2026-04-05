// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  List<Enrollment> get enrollments => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    String email,
    String displayName,
    List<Enrollment> enrollments,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? enrollments = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            enrollments: null == enrollments
                ? _value.enrollments
                : enrollments // ignore: cast_nullable_to_non_nullable
                      as List<Enrollment>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String displayName,
    List<Enrollment> enrollments,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? enrollments = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        enrollments: null == enrollments
            ? _value._enrollments
            : enrollments // ignore: cast_nullable_to_non_nullable
                  as List<Enrollment>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    required this.email,
    this.displayName = '',
    final List<Enrollment> enrollments = const [],
  }) : _enrollments = enrollments;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  @JsonKey()
  final String displayName;
  final List<Enrollment> _enrollments;
  @override
  @JsonKey()
  List<Enrollment> get enrollments {
    if (_enrollments is EqualUnmodifiableListView) return _enrollments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_enrollments);
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, email: $email, displayName: $displayName, enrollments: $enrollments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            const DeepCollectionEquality().equals(
              other._enrollments,
              _enrollments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    displayName,
    const DeepCollectionEquality().hash(_enrollments),
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    required final String email,
    final String displayName,
    final List<Enrollment> enrollments,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get displayName;
  @override
  List<Enrollment> get enrollments;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Enrollment _$EnrollmentFromJson(Map<String, dynamic> json) {
  return _Enrollment.fromJson(json);
}

/// @nodoc
mixin _$Enrollment {
  String get planId => throw _privateConstructorUsedError;
  String get planTitle => throw _privateConstructorUsedError;
  double get progressPercent => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError; // active, completed
  List<String> get completedActivityIds => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get lastAccessedAt => throw _privateConstructorUsedError;

  /// Serializes this Enrollment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Enrollment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnrollmentCopyWith<Enrollment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnrollmentCopyWith<$Res> {
  factory $EnrollmentCopyWith(
    Enrollment value,
    $Res Function(Enrollment) then,
  ) = _$EnrollmentCopyWithImpl<$Res, Enrollment>;
  @useResult
  $Res call({
    String planId,
    String planTitle,
    double progressPercent,
    String status,
    List<String> completedActivityIds,
    DateTime? startDate,
    DateTime? lastAccessedAt,
  });
}

/// @nodoc
class _$EnrollmentCopyWithImpl<$Res, $Val extends Enrollment>
    implements $EnrollmentCopyWith<$Res> {
  _$EnrollmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Enrollment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? planId = null,
    Object? planTitle = null,
    Object? progressPercent = null,
    Object? status = null,
    Object? completedActivityIds = null,
    Object? startDate = freezed,
    Object? lastAccessedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            planId: null == planId
                ? _value.planId
                : planId // ignore: cast_nullable_to_non_nullable
                      as String,
            planTitle: null == planTitle
                ? _value.planTitle
                : planTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            progressPercent: null == progressPercent
                ? _value.progressPercent
                : progressPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            completedActivityIds: null == completedActivityIds
                ? _value.completedActivityIds
                : completedActivityIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastAccessedAt: freezed == lastAccessedAt
                ? _value.lastAccessedAt
                : lastAccessedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EnrollmentImplCopyWith<$Res>
    implements $EnrollmentCopyWith<$Res> {
  factory _$$EnrollmentImplCopyWith(
    _$EnrollmentImpl value,
    $Res Function(_$EnrollmentImpl) then,
  ) = __$$EnrollmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String planId,
    String planTitle,
    double progressPercent,
    String status,
    List<String> completedActivityIds,
    DateTime? startDate,
    DateTime? lastAccessedAt,
  });
}

/// @nodoc
class __$$EnrollmentImplCopyWithImpl<$Res>
    extends _$EnrollmentCopyWithImpl<$Res, _$EnrollmentImpl>
    implements _$$EnrollmentImplCopyWith<$Res> {
  __$$EnrollmentImplCopyWithImpl(
    _$EnrollmentImpl _value,
    $Res Function(_$EnrollmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Enrollment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? planId = null,
    Object? planTitle = null,
    Object? progressPercent = null,
    Object? status = null,
    Object? completedActivityIds = null,
    Object? startDate = freezed,
    Object? lastAccessedAt = freezed,
  }) {
    return _then(
      _$EnrollmentImpl(
        planId: null == planId
            ? _value.planId
            : planId // ignore: cast_nullable_to_non_nullable
                  as String,
        planTitle: null == planTitle
            ? _value.planTitle
            : planTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        progressPercent: null == progressPercent
            ? _value.progressPercent
            : progressPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        completedActivityIds: null == completedActivityIds
            ? _value._completedActivityIds
            : completedActivityIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastAccessedAt: freezed == lastAccessedAt
            ? _value.lastAccessedAt
            : lastAccessedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EnrollmentImpl implements _Enrollment {
  const _$EnrollmentImpl({
    required this.planId,
    required this.planTitle,
    this.progressPercent = 0,
    this.status = 'active',
    final List<String> completedActivityIds = const [],
    this.startDate,
    this.lastAccessedAt,
  }) : _completedActivityIds = completedActivityIds;

  factory _$EnrollmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnrollmentImplFromJson(json);

  @override
  final String planId;
  @override
  final String planTitle;
  @override
  @JsonKey()
  final double progressPercent;
  @override
  @JsonKey()
  final String status;
  // active, completed
  final List<String> _completedActivityIds;
  // active, completed
  @override
  @JsonKey()
  List<String> get completedActivityIds {
    if (_completedActivityIds is EqualUnmodifiableListView)
      return _completedActivityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedActivityIds);
  }

  @override
  final DateTime? startDate;
  @override
  final DateTime? lastAccessedAt;

  @override
  String toString() {
    return 'Enrollment(planId: $planId, planTitle: $planTitle, progressPercent: $progressPercent, status: $status, completedActivityIds: $completedActivityIds, startDate: $startDate, lastAccessedAt: $lastAccessedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrollmentImpl &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.planTitle, planTitle) ||
                other.planTitle == planTitle) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._completedActivityIds,
              _completedActivityIds,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    planId,
    planTitle,
    progressPercent,
    status,
    const DeepCollectionEquality().hash(_completedActivityIds),
    startDate,
    lastAccessedAt,
  );

  /// Create a copy of Enrollment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrollmentImplCopyWith<_$EnrollmentImpl> get copyWith =>
      __$$EnrollmentImplCopyWithImpl<_$EnrollmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnrollmentImplToJson(this);
  }
}

abstract class _Enrollment implements Enrollment {
  const factory _Enrollment({
    required final String planId,
    required final String planTitle,
    final double progressPercent,
    final String status,
    final List<String> completedActivityIds,
    final DateTime? startDate,
    final DateTime? lastAccessedAt,
  }) = _$EnrollmentImpl;

  factory _Enrollment.fromJson(Map<String, dynamic> json) =
      _$EnrollmentImpl.fromJson;

  @override
  String get planId;
  @override
  String get planTitle;
  @override
  double get progressPercent;
  @override
  String get status; // active, completed
  @override
  List<String> get completedActivityIds;
  @override
  DateTime? get startDate;
  @override
  DateTime? get lastAccessedAt;

  /// Create a copy of Enrollment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrollmentImplCopyWith<_$EnrollmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
