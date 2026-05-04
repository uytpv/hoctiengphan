// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'titleFi')
  String get titleFi => throw _privateConstructorUsedError;
  @JsonKey(name: 'titleVi')
  String? get titleVi => throw _privateConstructorUsedError;
  @JsonKey(name: 'instructionFi')
  String? get instructionFi => throw _privateConstructorUsedError;
  @JsonKey(name: 'instructionVi')
  String? get instructionVi => throw _privateConstructorUsedError;
  List<Question> get questions => throw _privateConstructorUsedError;
  String? get lessonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'titleFi') String titleFi,
      @JsonKey(name: 'titleVi') String? titleVi,
      @JsonKey(name: 'instructionFi') String? instructionFi,
      @JsonKey(name: 'instructionVi') String? instructionVi,
      List<Question> questions,
      String? lessonId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleFi = null,
    Object? titleVi = freezed,
    Object? instructionFi = freezed,
    Object? instructionVi = freezed,
    Object? questions = null,
    Object? lessonId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titleFi: null == titleFi
          ? _value.titleFi
          : titleFi // ignore: cast_nullable_to_non_nullable
              as String,
      titleVi: freezed == titleVi
          ? _value.titleVi
          : titleVi // ignore: cast_nullable_to_non_nullable
              as String?,
      instructionFi: freezed == instructionFi
          ? _value.instructionFi
          : instructionFi // ignore: cast_nullable_to_non_nullable
              as String?,
      instructionVi: freezed == instructionVi
          ? _value.instructionVi
          : instructionVi // ignore: cast_nullable_to_non_nullable
              as String?,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      lessonId: freezed == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'titleFi') String titleFi,
      @JsonKey(name: 'titleVi') String? titleVi,
      @JsonKey(name: 'instructionFi') String? instructionFi,
      @JsonKey(name: 'instructionVi') String? instructionVi,
      List<Question> questions,
      String? lessonId,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? titleFi = null,
    Object? titleVi = freezed,
    Object? instructionFi = freezed,
    Object? instructionVi = freezed,
    Object? questions = null,
    Object? lessonId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      titleFi: null == titleFi
          ? _value.titleFi
          : titleFi // ignore: cast_nullable_to_non_nullable
              as String,
      titleVi: freezed == titleVi
          ? _value.titleVi
          : titleVi // ignore: cast_nullable_to_non_nullable
              as String?,
      instructionFi: freezed == instructionFi
          ? _value.instructionFi
          : instructionFi // ignore: cast_nullable_to_non_nullable
              as String?,
      instructionVi: freezed == instructionVi
          ? _value.instructionVi
          : instructionVi // ignore: cast_nullable_to_non_nullable
              as String?,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      lessonId: freezed == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
      {required this.id,
      @JsonKey(name: 'titleFi') required this.titleFi,
      @JsonKey(name: 'titleVi') this.titleVi,
      @JsonKey(name: 'instructionFi') this.instructionFi,
      @JsonKey(name: 'instructionVi') this.instructionVi,
      final List<Question> questions = const [],
      this.lessonId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : _questions = questions;

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'titleFi')
  final String titleFi;
  @override
  @JsonKey(name: 'titleVi')
  final String? titleVi;
  @override
  @JsonKey(name: 'instructionFi')
  final String? instructionFi;
  @override
  @JsonKey(name: 'instructionVi')
  final String? instructionVi;
  final List<Question> _questions;
  @override
  @JsonKey()
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final String? lessonId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Exercise(id: $id, titleFi: $titleFi, titleVi: $titleVi, instructionFi: $instructionFi, instructionVi: $instructionVi, questions: $questions, lessonId: $lessonId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.titleFi, titleFi) || other.titleFi == titleFi) &&
            (identical(other.titleVi, titleVi) || other.titleVi == titleVi) &&
            (identical(other.instructionFi, instructionFi) ||
                other.instructionFi == instructionFi) &&
            (identical(other.instructionVi, instructionVi) ||
                other.instructionVi == instructionVi) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      titleFi,
      titleVi,
      instructionFi,
      instructionVi,
      const DeepCollectionEquality().hash(_questions),
      lessonId,
      createdAt,
      updatedAt);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
          {required final String id,
          @JsonKey(name: 'titleFi') required final String titleFi,
          @JsonKey(name: 'titleVi') final String? titleVi,
          @JsonKey(name: 'instructionFi') final String? instructionFi,
          @JsonKey(name: 'instructionVi') final String? instructionVi,
          final List<Question> questions,
          final String? lessonId,
          @JsonKey(name: 'created_at') required final DateTime createdAt,
          @JsonKey(name: 'updated_at') required final DateTime updatedAt}) =
      _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'titleFi')
  String get titleFi;
  @override
  @JsonKey(name: 'titleVi')
  String? get titleVi;
  @override
  @JsonKey(name: 'instructionFi')
  String? get instructionFi;
  @override
  @JsonKey(name: 'instructionVi')
  String? get instructionVi;
  @override
  List<Question> get questions;
  @override
  String? get lessonId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
