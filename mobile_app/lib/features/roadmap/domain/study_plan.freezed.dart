// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StudyPlan _$StudyPlanFromJson(Map<String, dynamic> json) {
  return _StudyPlan.fromJson(json);
}

/// @nodoc
mixin _$StudyPlan {
  String get id => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get week => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  StudyDays get days => throw _privateConstructorUsedError;

  /// Serializes this StudyPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyPlanCopyWith<StudyPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyPlanCopyWith<$Res> {
  factory $StudyPlanCopyWith(StudyPlan value, $Res Function(StudyPlan) then) =
      _$StudyPlanCopyWithImpl<$Res, StudyPlan>;
  @useResult
  $Res call({String id, int month, int week, String title, StudyDays days});

  $StudyDaysCopyWith<$Res> get days;
}

/// @nodoc
class _$StudyPlanCopyWithImpl<$Res, $Val extends StudyPlan>
    implements $StudyPlanCopyWith<$Res> {
  _$StudyPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? week = null,
    Object? title = null,
    Object? days = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            month: null == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                      as int,
            week: null == week
                ? _value.week
                : week // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as StudyDays,
          )
          as $Val,
    );
  }

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StudyDaysCopyWith<$Res> get days {
    return $StudyDaysCopyWith<$Res>(_value.days, (value) {
      return _then(_value.copyWith(days: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudyPlanImplCopyWith<$Res>
    implements $StudyPlanCopyWith<$Res> {
  factory _$$StudyPlanImplCopyWith(
    _$StudyPlanImpl value,
    $Res Function(_$StudyPlanImpl) then,
  ) = __$$StudyPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, int month, int week, String title, StudyDays days});

  @override
  $StudyDaysCopyWith<$Res> get days;
}

/// @nodoc
class __$$StudyPlanImplCopyWithImpl<$Res>
    extends _$StudyPlanCopyWithImpl<$Res, _$StudyPlanImpl>
    implements _$$StudyPlanImplCopyWith<$Res> {
  __$$StudyPlanImplCopyWithImpl(
    _$StudyPlanImpl _value,
    $Res Function(_$StudyPlanImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? month = null,
    Object? week = null,
    Object? title = null,
    Object? days = null,
  }) {
    return _then(
      _$StudyPlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        month: null == month
            ? _value.month
            : month // ignore: cast_nullable_to_non_nullable
                  as int,
        week: null == week
            ? _value.week
            : week // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        days: null == days
            ? _value.days
            : days // ignore: cast_nullable_to_non_nullable
                  as StudyDays,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyPlanImpl implements _StudyPlan {
  const _$StudyPlanImpl({
    required this.id,
    required this.month,
    required this.week,
    required this.title,
    required this.days,
  });

  factory _$StudyPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyPlanImplFromJson(json);

  @override
  final String id;
  @override
  final int month;
  @override
  final int week;
  @override
  final String title;
  @override
  final StudyDays days;

  @override
  String toString() {
    return 'StudyPlan(id: $id, month: $month, week: $week, title: $title, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.days, days) || other.days == days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, month, week, title, days);

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyPlanImplCopyWith<_$StudyPlanImpl> get copyWith =>
      __$$StudyPlanImplCopyWithImpl<_$StudyPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyPlanImplToJson(this);
  }
}

abstract class _StudyPlan implements StudyPlan {
  const factory _StudyPlan({
    required final String id,
    required final int month,
    required final int week,
    required final String title,
    required final StudyDays days,
  }) = _$StudyPlanImpl;

  factory _StudyPlan.fromJson(Map<String, dynamic> json) =
      _$StudyPlanImpl.fromJson;

  @override
  String get id;
  @override
  int get month;
  @override
  int get week;
  @override
  String get title;
  @override
  StudyDays get days;

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyPlanImplCopyWith<_$StudyPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudyDays _$StudyDaysFromJson(Map<String, dynamic> json) {
  return _StudyDays.fromJson(json);
}

/// @nodoc
mixin _$StudyDays {
  List<StudyTask> get monday => throw _privateConstructorUsedError;
  List<StudyTask> get tuesday => throw _privateConstructorUsedError;
  List<StudyTask> get wednesday => throw _privateConstructorUsedError;
  List<StudyTask> get thursday => throw _privateConstructorUsedError;
  List<StudyTask> get friday => throw _privateConstructorUsedError;
  List<StudyTask> get saturday => throw _privateConstructorUsedError;
  List<StudyTask> get sunday => throw _privateConstructorUsedError;

  /// Serializes this StudyDays to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyDays
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyDaysCopyWith<StudyDays> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyDaysCopyWith<$Res> {
  factory $StudyDaysCopyWith(StudyDays value, $Res Function(StudyDays) then) =
      _$StudyDaysCopyWithImpl<$Res, StudyDays>;
  @useResult
  $Res call({
    List<StudyTask> monday,
    List<StudyTask> tuesday,
    List<StudyTask> wednesday,
    List<StudyTask> thursday,
    List<StudyTask> friday,
    List<StudyTask> saturday,
    List<StudyTask> sunday,
  });
}

/// @nodoc
class _$StudyDaysCopyWithImpl<$Res, $Val extends StudyDays>
    implements $StudyDaysCopyWith<$Res> {
  _$StudyDaysCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyDays
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monday = null,
    Object? tuesday = null,
    Object? wednesday = null,
    Object? thursday = null,
    Object? friday = null,
    Object? saturday = null,
    Object? sunday = null,
  }) {
    return _then(
      _value.copyWith(
            monday: null == monday
                ? _value.monday
                : monday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
            tuesday: null == tuesday
                ? _value.tuesday
                : tuesday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
            wednesday: null == wednesday
                ? _value.wednesday
                : wednesday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
            thursday: null == thursday
                ? _value.thursday
                : thursday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
            friday: null == friday
                ? _value.friday
                : friday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
            saturday: null == saturday
                ? _value.saturday
                : saturday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
            sunday: null == sunday
                ? _value.sunday
                : sunday // ignore: cast_nullable_to_non_nullable
                      as List<StudyTask>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudyDaysImplCopyWith<$Res>
    implements $StudyDaysCopyWith<$Res> {
  factory _$$StudyDaysImplCopyWith(
    _$StudyDaysImpl value,
    $Res Function(_$StudyDaysImpl) then,
  ) = __$$StudyDaysImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<StudyTask> monday,
    List<StudyTask> tuesday,
    List<StudyTask> wednesday,
    List<StudyTask> thursday,
    List<StudyTask> friday,
    List<StudyTask> saturday,
    List<StudyTask> sunday,
  });
}

/// @nodoc
class __$$StudyDaysImplCopyWithImpl<$Res>
    extends _$StudyDaysCopyWithImpl<$Res, _$StudyDaysImpl>
    implements _$$StudyDaysImplCopyWith<$Res> {
  __$$StudyDaysImplCopyWithImpl(
    _$StudyDaysImpl _value,
    $Res Function(_$StudyDaysImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyDays
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? monday = null,
    Object? tuesday = null,
    Object? wednesday = null,
    Object? thursday = null,
    Object? friday = null,
    Object? saturday = null,
    Object? sunday = null,
  }) {
    return _then(
      _$StudyDaysImpl(
        monday: null == monday
            ? _value._monday
            : monday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
        tuesday: null == tuesday
            ? _value._tuesday
            : tuesday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
        wednesday: null == wednesday
            ? _value._wednesday
            : wednesday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
        thursday: null == thursday
            ? _value._thursday
            : thursday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
        friday: null == friday
            ? _value._friday
            : friday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
        saturday: null == saturday
            ? _value._saturday
            : saturday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
        sunday: null == sunday
            ? _value._sunday
            : sunday // ignore: cast_nullable_to_non_nullable
                  as List<StudyTask>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyDaysImpl implements _StudyDays {
  const _$StudyDaysImpl({
    final List<StudyTask> monday = const [],
    final List<StudyTask> tuesday = const [],
    final List<StudyTask> wednesday = const [],
    final List<StudyTask> thursday = const [],
    final List<StudyTask> friday = const [],
    final List<StudyTask> saturday = const [],
    final List<StudyTask> sunday = const [],
  }) : _monday = monday,
       _tuesday = tuesday,
       _wednesday = wednesday,
       _thursday = thursday,
       _friday = friday,
       _saturday = saturday,
       _sunday = sunday;

  factory _$StudyDaysImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyDaysImplFromJson(json);

  final List<StudyTask> _monday;
  @override
  @JsonKey()
  List<StudyTask> get monday {
    if (_monday is EqualUnmodifiableListView) return _monday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monday);
  }

  final List<StudyTask> _tuesday;
  @override
  @JsonKey()
  List<StudyTask> get tuesday {
    if (_tuesday is EqualUnmodifiableListView) return _tuesday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tuesday);
  }

  final List<StudyTask> _wednesday;
  @override
  @JsonKey()
  List<StudyTask> get wednesday {
    if (_wednesday is EqualUnmodifiableListView) return _wednesday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wednesday);
  }

  final List<StudyTask> _thursday;
  @override
  @JsonKey()
  List<StudyTask> get thursday {
    if (_thursday is EqualUnmodifiableListView) return _thursday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_thursday);
  }

  final List<StudyTask> _friday;
  @override
  @JsonKey()
  List<StudyTask> get friday {
    if (_friday is EqualUnmodifiableListView) return _friday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friday);
  }

  final List<StudyTask> _saturday;
  @override
  @JsonKey()
  List<StudyTask> get saturday {
    if (_saturday is EqualUnmodifiableListView) return _saturday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_saturday);
  }

  final List<StudyTask> _sunday;
  @override
  @JsonKey()
  List<StudyTask> get sunday {
    if (_sunday is EqualUnmodifiableListView) return _sunday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sunday);
  }

  @override
  String toString() {
    return 'StudyDays(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyDaysImpl &&
            const DeepCollectionEquality().equals(other._monday, _monday) &&
            const DeepCollectionEquality().equals(other._tuesday, _tuesday) &&
            const DeepCollectionEquality().equals(
              other._wednesday,
              _wednesday,
            ) &&
            const DeepCollectionEquality().equals(other._thursday, _thursday) &&
            const DeepCollectionEquality().equals(other._friday, _friday) &&
            const DeepCollectionEquality().equals(other._saturday, _saturday) &&
            const DeepCollectionEquality().equals(other._sunday, _sunday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_monday),
    const DeepCollectionEquality().hash(_tuesday),
    const DeepCollectionEquality().hash(_wednesday),
    const DeepCollectionEquality().hash(_thursday),
    const DeepCollectionEquality().hash(_friday),
    const DeepCollectionEquality().hash(_saturday),
    const DeepCollectionEquality().hash(_sunday),
  );

  /// Create a copy of StudyDays
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyDaysImplCopyWith<_$StudyDaysImpl> get copyWith =>
      __$$StudyDaysImplCopyWithImpl<_$StudyDaysImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyDaysImplToJson(this);
  }
}

abstract class _StudyDays implements StudyDays {
  const factory _StudyDays({
    final List<StudyTask> monday,
    final List<StudyTask> tuesday,
    final List<StudyTask> wednesday,
    final List<StudyTask> thursday,
    final List<StudyTask> friday,
    final List<StudyTask> saturday,
    final List<StudyTask> sunday,
  }) = _$StudyDaysImpl;

  factory _StudyDays.fromJson(Map<String, dynamic> json) =
      _$StudyDaysImpl.fromJson;

  @override
  List<StudyTask> get monday;
  @override
  List<StudyTask> get tuesday;
  @override
  List<StudyTask> get wednesday;
  @override
  List<StudyTask> get thursday;
  @override
  List<StudyTask> get friday;
  @override
  List<StudyTask> get saturday;
  @override
  List<StudyTask> get sunday;

  /// Create a copy of StudyDays
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyDaysImplCopyWith<_$StudyDaysImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudyTask _$StudyTaskFromJson(Map<String, dynamic> json) {
  return _StudyTask.fromJson(json);
}

/// @nodoc
mixin _$StudyTask {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;
  String get iconType => throw _privateConstructorUsedError;
  String? get grammarLink => throw _privateConstructorUsedError;

  /// Serializes this StudyTask to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyTaskCopyWith<StudyTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyTaskCopyWith<$Res> {
  factory $StudyTaskCopyWith(StudyTask value, $Res Function(StudyTask) then) =
      _$StudyTaskCopyWithImpl<$Res, StudyTask>;
  @useResult
  $Res call({
    String id,
    String title,
    String detail,
    String iconType,
    String? grammarLink,
  });
}

/// @nodoc
class _$StudyTaskCopyWithImpl<$Res, $Val extends StudyTask>
    implements $StudyTaskCopyWith<$Res> {
  _$StudyTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? detail = null,
    Object? iconType = null,
    Object? grammarLink = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            detail: null == detail
                ? _value.detail
                : detail // ignore: cast_nullable_to_non_nullable
                      as String,
            iconType: null == iconType
                ? _value.iconType
                : iconType // ignore: cast_nullable_to_non_nullable
                      as String,
            grammarLink: freezed == grammarLink
                ? _value.grammarLink
                : grammarLink // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudyTaskImplCopyWith<$Res>
    implements $StudyTaskCopyWith<$Res> {
  factory _$$StudyTaskImplCopyWith(
    _$StudyTaskImpl value,
    $Res Function(_$StudyTaskImpl) then,
  ) = __$$StudyTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String detail,
    String iconType,
    String? grammarLink,
  });
}

/// @nodoc
class __$$StudyTaskImplCopyWithImpl<$Res>
    extends _$StudyTaskCopyWithImpl<$Res, _$StudyTaskImpl>
    implements _$$StudyTaskImplCopyWith<$Res> {
  __$$StudyTaskImplCopyWithImpl(
    _$StudyTaskImpl _value,
    $Res Function(_$StudyTaskImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyTask
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? detail = null,
    Object? iconType = null,
    Object? grammarLink = freezed,
  }) {
    return _then(
      _$StudyTaskImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        detail: null == detail
            ? _value.detail
            : detail // ignore: cast_nullable_to_non_nullable
                  as String,
        iconType: null == iconType
            ? _value.iconType
            : iconType // ignore: cast_nullable_to_non_nullable
                  as String,
        grammarLink: freezed == grammarLink
            ? _value.grammarLink
            : grammarLink // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyTaskImpl implements _StudyTask {
  const _$StudyTaskImpl({
    required this.id,
    required this.title,
    required this.detail,
    required this.iconType,
    this.grammarLink,
  });

  factory _$StudyTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyTaskImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String detail;
  @override
  final String iconType;
  @override
  final String? grammarLink;

  @override
  String toString() {
    return 'StudyTask(id: $id, title: $title, detail: $detail, iconType: $iconType, grammarLink: $grammarLink)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.detail, detail) || other.detail == detail) &&
            (identical(other.iconType, iconType) ||
                other.iconType == iconType) &&
            (identical(other.grammarLink, grammarLink) ||
                other.grammarLink == grammarLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, detail, iconType, grammarLink);

  /// Create a copy of StudyTask
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyTaskImplCopyWith<_$StudyTaskImpl> get copyWith =>
      __$$StudyTaskImplCopyWithImpl<_$StudyTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyTaskImplToJson(this);
  }
}

abstract class _StudyTask implements StudyTask {
  const factory _StudyTask({
    required final String id,
    required final String title,
    required final String detail,
    required final String iconType,
    final String? grammarLink,
  }) = _$StudyTaskImpl;

  factory _StudyTask.fromJson(Map<String, dynamic> json) =
      _$StudyTaskImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get detail;
  @override
  String get iconType;
  @override
  String? get grammarLink;

  /// Create a copy of StudyTask
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyTaskImplCopyWith<_$StudyTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
