// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return _Lesson.fromJson(json);
}

/// @nodoc
mixin _$Lesson {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get chapter => throw _privateConstructorUsedError; // e.g., "Kappale 1"
  int? get week =>
      throw _privateConstructorUsedError; // Optionally link trực tiếp tới tuần học
  String? get description =>
      throw _privateConstructorUsedError; // Mô tả ngắn gọn
  String get content =>
      throw _privateConstructorUsedError; // Nội dung Markdown chứa các shortcode nhúng
  List<String> get vocabIds =>
      throw _privateConstructorUsedError; // Danh sách ID từ vựng nhúng
  List<String> get exerciseIds =>
      throw _privateConstructorUsedError; // Danh sách ID bài tập nhúng
  List<String> get audioUrls =>
      throw _privateConstructorUsedError; // Danh sách link audio nhúng
  List<String> get grammarIds =>
      throw _privateConstructorUsedError; // Danh sách ID ngữ pháp nhúng hoặc liên kết
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Lesson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonCopyWith<Lesson> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res, Lesson>;
  @useResult
  $Res call({
    String id,
    String title,
    String chapter,
    int? week,
    String? description,
    String content,
    List<String> vocabIds,
    List<String> exerciseIds,
    List<String> audioUrls,
    List<String> grammarIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$LessonCopyWithImpl<$Res, $Val extends Lesson>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? chapter = null,
    Object? week = freezed,
    Object? description = freezed,
    Object? content = null,
    Object? vocabIds = null,
    Object? exerciseIds = null,
    Object? audioUrls = null,
    Object? grammarIds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            chapter: null == chapter
                ? _value.chapter
                : chapter // ignore: cast_nullable_to_non_nullable
                      as String,
            week: freezed == week
                ? _value.week
                : week // ignore: cast_nullable_to_non_nullable
                      as int?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            vocabIds: null == vocabIds
                ? _value.vocabIds
                : vocabIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            exerciseIds: null == exerciseIds
                ? _value.exerciseIds
                : exerciseIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            audioUrls: null == audioUrls
                ? _value.audioUrls
                : audioUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            grammarIds: null == grammarIds
                ? _value.grammarIds
                : grammarIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonImplCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$$LessonImplCopyWith(
    _$LessonImpl value,
    $Res Function(_$LessonImpl) then,
  ) = __$$LessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String chapter,
    int? week,
    String? description,
    String content,
    List<String> vocabIds,
    List<String> exerciseIds,
    List<String> audioUrls,
    List<String> grammarIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$LessonImplCopyWithImpl<$Res>
    extends _$LessonCopyWithImpl<$Res, _$LessonImpl>
    implements _$$LessonImplCopyWith<$Res> {
  __$$LessonImplCopyWithImpl(
    _$LessonImpl _value,
    $Res Function(_$LessonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? chapter = null,
    Object? week = freezed,
    Object? description = freezed,
    Object? content = null,
    Object? vocabIds = null,
    Object? exerciseIds = null,
    Object? audioUrls = null,
    Object? grammarIds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$LessonImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        chapter: null == chapter
            ? _value.chapter
            : chapter // ignore: cast_nullable_to_non_nullable
                  as String,
        week: freezed == week
            ? _value.week
            : week // ignore: cast_nullable_to_non_nullable
                  as int?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        vocabIds: null == vocabIds
            ? _value._vocabIds
            : vocabIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        exerciseIds: null == exerciseIds
            ? _value._exerciseIds
            : exerciseIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        audioUrls: null == audioUrls
            ? _value._audioUrls
            : audioUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        grammarIds: null == grammarIds
            ? _value._grammarIds
            : grammarIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonImpl implements _Lesson {
  const _$LessonImpl({
    required this.id,
    this.title = '',
    this.chapter = '',
    this.week,
    this.description,
    this.content = '',
    final List<String> vocabIds = const [],
    final List<String> exerciseIds = const [],
    final List<String> audioUrls = const [],
    final List<String> grammarIds = const [],
    this.createdAt,
    this.updatedAt,
  }) : _vocabIds = vocabIds,
       _exerciseIds = exerciseIds,
       _audioUrls = audioUrls,
       _grammarIds = grammarIds;

  factory _$LessonImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String chapter;
  // e.g., "Kappale 1"
  @override
  final int? week;
  // Optionally link trực tiếp tới tuần học
  @override
  final String? description;
  // Mô tả ngắn gọn
  @override
  @JsonKey()
  final String content;
  // Nội dung Markdown chứa các shortcode nhúng
  final List<String> _vocabIds;
  // Nội dung Markdown chứa các shortcode nhúng
  @override
  @JsonKey()
  List<String> get vocabIds {
    if (_vocabIds is EqualUnmodifiableListView) return _vocabIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vocabIds);
  }

  // Danh sách ID từ vựng nhúng
  final List<String> _exerciseIds;
  // Danh sách ID từ vựng nhúng
  @override
  @JsonKey()
  List<String> get exerciseIds {
    if (_exerciseIds is EqualUnmodifiableListView) return _exerciseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseIds);
  }

  // Danh sách ID bài tập nhúng
  final List<String> _audioUrls;
  // Danh sách ID bài tập nhúng
  @override
  @JsonKey()
  List<String> get audioUrls {
    if (_audioUrls is EqualUnmodifiableListView) return _audioUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audioUrls);
  }

  // Danh sách link audio nhúng
  final List<String> _grammarIds;
  // Danh sách link audio nhúng
  @override
  @JsonKey()
  List<String> get grammarIds {
    if (_grammarIds is EqualUnmodifiableListView) return _grammarIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grammarIds);
  }

  // Danh sách ID ngữ pháp nhúng hoặc liên kết
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, chapter: $chapter, week: $week, description: $description, content: $content, vocabIds: $vocabIds, exerciseIds: $exerciseIds, audioUrls: $audioUrls, grammarIds: $grammarIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._vocabIds, _vocabIds) &&
            const DeepCollectionEquality().equals(
              other._exerciseIds,
              _exerciseIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._audioUrls,
              _audioUrls,
            ) &&
            const DeepCollectionEquality().equals(
              other._grammarIds,
              _grammarIds,
            ) &&
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
    title,
    chapter,
    week,
    description,
    content,
    const DeepCollectionEquality().hash(_vocabIds),
    const DeepCollectionEquality().hash(_exerciseIds),
    const DeepCollectionEquality().hash(_audioUrls),
    const DeepCollectionEquality().hash(_grammarIds),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      __$$LessonImplCopyWithImpl<_$LessonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonImplToJson(this);
  }
}

abstract class _Lesson implements Lesson {
  const factory _Lesson({
    required final String id,
    final String title,
    final String chapter,
    final int? week,
    final String? description,
    final String content,
    final List<String> vocabIds,
    final List<String> exerciseIds,
    final List<String> audioUrls,
    final List<String> grammarIds,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$LessonImpl;

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$LessonImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get chapter; // e.g., "Kappale 1"
  @override
  int? get week; // Optionally link trực tiếp tới tuần học
  @override
  String? get description; // Mô tả ngắn gọn
  @override
  String get content; // Nội dung Markdown chứa các shortcode nhúng
  @override
  List<String> get vocabIds; // Danh sách ID từ vựng nhúng
  @override
  List<String> get exerciseIds; // Danh sách ID bài tập nhúng
  @override
  List<String> get audioUrls; // Danh sách link audio nhúng
  @override
  List<String> get grammarIds; // Danh sách ID ngữ pháp nhúng hoặc liên kết
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
