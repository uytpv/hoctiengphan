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
  String? get description =>
      throw _privateConstructorUsedError; // Mô tả ngắn gọn nội dung bài học
  LessonContent get lessonContent =>
      throw _privateConstructorUsedError; // Phần 1: Bài học
  LessonGrammar get grammar =>
      throw _privateConstructorUsedError; // Phần 2: Ngữ pháp
  LessonSpeaking get speaking =>
      throw _privateConstructorUsedError; // Phần 3: Bài nói
  List<String> get exerciseIds => throw _privateConstructorUsedError;

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
    String? description,
    LessonContent lessonContent,
    LessonGrammar grammar,
    LessonSpeaking speaking,
    List<String> exerciseIds,
  });

  $LessonContentCopyWith<$Res> get lessonContent;
  $LessonGrammarCopyWith<$Res> get grammar;
  $LessonSpeakingCopyWith<$Res> get speaking;
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
    Object? description = freezed,
    Object? lessonContent = null,
    Object? grammar = null,
    Object? speaking = null,
    Object? exerciseIds = null,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            lessonContent: null == lessonContent
                ? _value.lessonContent
                : lessonContent // ignore: cast_nullable_to_non_nullable
                      as LessonContent,
            grammar: null == grammar
                ? _value.grammar
                : grammar // ignore: cast_nullable_to_non_nullable
                      as LessonGrammar,
            speaking: null == speaking
                ? _value.speaking
                : speaking // ignore: cast_nullable_to_non_nullable
                      as LessonSpeaking,
            exerciseIds: null == exerciseIds
                ? _value.exerciseIds
                : exerciseIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LessonContentCopyWith<$Res> get lessonContent {
    return $LessonContentCopyWith<$Res>(_value.lessonContent, (value) {
      return _then(_value.copyWith(lessonContent: value) as $Val);
    });
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LessonGrammarCopyWith<$Res> get grammar {
    return $LessonGrammarCopyWith<$Res>(_value.grammar, (value) {
      return _then(_value.copyWith(grammar: value) as $Val);
    });
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LessonSpeakingCopyWith<$Res> get speaking {
    return $LessonSpeakingCopyWith<$Res>(_value.speaking, (value) {
      return _then(_value.copyWith(speaking: value) as $Val);
    });
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
    String? description,
    LessonContent lessonContent,
    LessonGrammar grammar,
    LessonSpeaking speaking,
    List<String> exerciseIds,
  });

  @override
  $LessonContentCopyWith<$Res> get lessonContent;
  @override
  $LessonGrammarCopyWith<$Res> get grammar;
  @override
  $LessonSpeakingCopyWith<$Res> get speaking;
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
    Object? description = freezed,
    Object? lessonContent = null,
    Object? grammar = null,
    Object? speaking = null,
    Object? exerciseIds = null,
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
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        lessonContent: null == lessonContent
            ? _value.lessonContent
            : lessonContent // ignore: cast_nullable_to_non_nullable
                  as LessonContent,
        grammar: null == grammar
            ? _value.grammar
            : grammar // ignore: cast_nullable_to_non_nullable
                  as LessonGrammar,
        speaking: null == speaking
            ? _value.speaking
            : speaking // ignore: cast_nullable_to_non_nullable
                  as LessonSpeaking,
        exerciseIds: null == exerciseIds
            ? _value._exerciseIds
            : exerciseIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
    this.description,
    this.lessonContent = const LessonContent(),
    this.grammar = const LessonGrammar(),
    this.speaking = const LessonSpeaking(),
    final List<String> exerciseIds = const [],
  }) : _exerciseIds = exerciseIds;

  factory _$LessonImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  final String? description;
  // Mô tả ngắn gọn nội dung bài học
  @override
  @JsonKey()
  final LessonContent lessonContent;
  // Phần 1: Bài học
  @override
  @JsonKey()
  final LessonGrammar grammar;
  // Phần 2: Ngữ pháp
  @override
  @JsonKey()
  final LessonSpeaking speaking;
  // Phần 3: Bài nói
  final List<String> _exerciseIds;
  // Phần 3: Bài nói
  @override
  @JsonKey()
  List<String> get exerciseIds {
    if (_exerciseIds is EqualUnmodifiableListView) return _exerciseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exerciseIds);
  }

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, description: $description, lessonContent: $lessonContent, grammar: $grammar, speaking: $speaking, exerciseIds: $exerciseIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lessonContent, lessonContent) ||
                other.lessonContent == lessonContent) &&
            (identical(other.grammar, grammar) || other.grammar == grammar) &&
            (identical(other.speaking, speaking) ||
                other.speaking == speaking) &&
            const DeepCollectionEquality().equals(
              other._exerciseIds,
              _exerciseIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    lessonContent,
    grammar,
    speaking,
    const DeepCollectionEquality().hash(_exerciseIds),
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
    final String? description,
    final LessonContent lessonContent,
    final LessonGrammar grammar,
    final LessonSpeaking speaking,
    final List<String> exerciseIds,
  }) = _$LessonImpl;

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$LessonImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description; // Mô tả ngắn gọn nội dung bài học
  @override
  LessonContent get lessonContent; // Phần 1: Bài học
  @override
  LessonGrammar get grammar; // Phần 2: Ngữ pháp
  @override
  LessonSpeaking get speaking; // Phần 3: Bài nói
  @override
  List<String> get exerciseIds;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LessonContent _$LessonContentFromJson(Map<String, dynamic> json) {
  return _LessonContent.fromJson(json);
}

/// @nodoc
mixin _$LessonContent {
  String get text =>
      throw _privateConstructorUsedError; // Nội dung bài học (Markdown/HTML)
  String? get videoUrl =>
      throw _privateConstructorUsedError; // Link video bài giảng (nếu có)
  List<String> get imageIds => throw _privateConstructorUsedError;

  /// Serializes this LessonContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonContentCopyWith<LessonContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonContentCopyWith<$Res> {
  factory $LessonContentCopyWith(
    LessonContent value,
    $Res Function(LessonContent) then,
  ) = _$LessonContentCopyWithImpl<$Res, LessonContent>;
  @useResult
  $Res call({String text, String? videoUrl, List<String> imageIds});
}

/// @nodoc
class _$LessonContentCopyWithImpl<$Res, $Val extends LessonContent>
    implements $LessonContentCopyWith<$Res> {
  _$LessonContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? videoUrl = freezed,
    Object? imageIds = null,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageIds: null == imageIds
                ? _value.imageIds
                : imageIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonContentImplCopyWith<$Res>
    implements $LessonContentCopyWith<$Res> {
  factory _$$LessonContentImplCopyWith(
    _$LessonContentImpl value,
    $Res Function(_$LessonContentImpl) then,
  ) = __$$LessonContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? videoUrl, List<String> imageIds});
}

/// @nodoc
class __$$LessonContentImplCopyWithImpl<$Res>
    extends _$LessonContentCopyWithImpl<$Res, _$LessonContentImpl>
    implements _$$LessonContentImplCopyWith<$Res> {
  __$$LessonContentImplCopyWithImpl(
    _$LessonContentImpl _value,
    $Res Function(_$LessonContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? videoUrl = freezed,
    Object? imageIds = null,
  }) {
    return _then(
      _$LessonContentImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageIds: null == imageIds
            ? _value._imageIds
            : imageIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonContentImpl implements _LessonContent {
  const _$LessonContentImpl({
    this.text = '',
    this.videoUrl,
    final List<String> imageIds = const [],
  }) : _imageIds = imageIds;

  factory _$LessonContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonContentImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  // Nội dung bài học (Markdown/HTML)
  @override
  final String? videoUrl;
  // Link video bài giảng (nếu có)
  final List<String> _imageIds;
  // Link video bài giảng (nếu có)
  @override
  @JsonKey()
  List<String> get imageIds {
    if (_imageIds is EqualUnmodifiableListView) return _imageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageIds);
  }

  @override
  String toString() {
    return 'LessonContent(text: $text, videoUrl: $videoUrl, imageIds: $imageIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonContentImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            const DeepCollectionEquality().equals(other._imageIds, _imageIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    text,
    videoUrl,
    const DeepCollectionEquality().hash(_imageIds),
  );

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonContentImplCopyWith<_$LessonContentImpl> get copyWith =>
      __$$LessonContentImplCopyWithImpl<_$LessonContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonContentImplToJson(this);
  }
}

abstract class _LessonContent implements LessonContent {
  const factory _LessonContent({
    final String text,
    final String? videoUrl,
    final List<String> imageIds,
  }) = _$LessonContentImpl;

  factory _LessonContent.fromJson(Map<String, dynamic> json) =
      _$LessonContentImpl.fromJson;

  @override
  String get text; // Nội dung bài học (Markdown/HTML)
  @override
  String? get videoUrl; // Link video bài giảng (nếu có)
  @override
  List<String> get imageIds;

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonContentImplCopyWith<_$LessonContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LessonGrammar _$LessonGrammarFromJson(Map<String, dynamic> json) {
  return _LessonGrammar.fromJson(json);
}

/// @nodoc
mixin _$LessonGrammar {
  String get text =>
      throw _privateConstructorUsedError; // Nội dung giải thích ngữ pháp
  String? get audioUrl => throw _privateConstructorUsedError;

  /// Serializes this LessonGrammar to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonGrammar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonGrammarCopyWith<LessonGrammar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonGrammarCopyWith<$Res> {
  factory $LessonGrammarCopyWith(
    LessonGrammar value,
    $Res Function(LessonGrammar) then,
  ) = _$LessonGrammarCopyWithImpl<$Res, LessonGrammar>;
  @useResult
  $Res call({String text, String? audioUrl});
}

/// @nodoc
class _$LessonGrammarCopyWithImpl<$Res, $Val extends LessonGrammar>
    implements $LessonGrammarCopyWith<$Res> {
  _$LessonGrammarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonGrammar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? audioUrl = freezed}) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonGrammarImplCopyWith<$Res>
    implements $LessonGrammarCopyWith<$Res> {
  factory _$$LessonGrammarImplCopyWith(
    _$LessonGrammarImpl value,
    $Res Function(_$LessonGrammarImpl) then,
  ) = __$$LessonGrammarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? audioUrl});
}

/// @nodoc
class __$$LessonGrammarImplCopyWithImpl<$Res>
    extends _$LessonGrammarCopyWithImpl<$Res, _$LessonGrammarImpl>
    implements _$$LessonGrammarImplCopyWith<$Res> {
  __$$LessonGrammarImplCopyWithImpl(
    _$LessonGrammarImpl _value,
    $Res Function(_$LessonGrammarImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LessonGrammar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? text = null, Object? audioUrl = freezed}) {
    return _then(
      _$LessonGrammarImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonGrammarImpl implements _LessonGrammar {
  const _$LessonGrammarImpl({this.text = '', this.audioUrl});

  factory _$LessonGrammarImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonGrammarImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  // Nội dung giải thích ngữ pháp
  @override
  final String? audioUrl;

  @override
  String toString() {
    return 'LessonGrammar(text: $text, audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonGrammarImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, audioUrl);

  /// Create a copy of LessonGrammar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonGrammarImplCopyWith<_$LessonGrammarImpl> get copyWith =>
      __$$LessonGrammarImplCopyWithImpl<_$LessonGrammarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonGrammarImplToJson(this);
  }
}

abstract class _LessonGrammar implements LessonGrammar {
  const factory _LessonGrammar({final String text, final String? audioUrl}) =
      _$LessonGrammarImpl;

  factory _LessonGrammar.fromJson(Map<String, dynamic> json) =
      _$LessonGrammarImpl.fromJson;

  @override
  String get text; // Nội dung giải thích ngữ pháp
  @override
  String? get audioUrl;

  /// Create a copy of LessonGrammar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonGrammarImplCopyWith<_$LessonGrammarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LessonSpeaking _$LessonSpeakingFromJson(Map<String, dynamic> json) {
  return _LessonSpeaking.fromJson(json);
}

/// @nodoc
mixin _$LessonSpeaking {
  String get text =>
      throw _privateConstructorUsedError; // Nội dung bài mẫu/hội thoại
  String? get audioUrl => throw _privateConstructorUsedError; // Audio nghe mẫu
  String? get conversationUrl => throw _privateConstructorUsedError;

  /// Serializes this LessonSpeaking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonSpeaking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonSpeakingCopyWith<LessonSpeaking> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonSpeakingCopyWith<$Res> {
  factory $LessonSpeakingCopyWith(
    LessonSpeaking value,
    $Res Function(LessonSpeaking) then,
  ) = _$LessonSpeakingCopyWithImpl<$Res, LessonSpeaking>;
  @useResult
  $Res call({String text, String? audioUrl, String? conversationUrl});
}

/// @nodoc
class _$LessonSpeakingCopyWithImpl<$Res, $Val extends LessonSpeaking>
    implements $LessonSpeakingCopyWith<$Res> {
  _$LessonSpeakingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonSpeaking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? audioUrl = freezed,
    Object? conversationUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            conversationUrl: freezed == conversationUrl
                ? _value.conversationUrl
                : conversationUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonSpeakingImplCopyWith<$Res>
    implements $LessonSpeakingCopyWith<$Res> {
  factory _$$LessonSpeakingImplCopyWith(
    _$LessonSpeakingImpl value,
    $Res Function(_$LessonSpeakingImpl) then,
  ) = __$$LessonSpeakingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, String? audioUrl, String? conversationUrl});
}

/// @nodoc
class __$$LessonSpeakingImplCopyWithImpl<$Res>
    extends _$LessonSpeakingCopyWithImpl<$Res, _$LessonSpeakingImpl>
    implements _$$LessonSpeakingImplCopyWith<$Res> {
  __$$LessonSpeakingImplCopyWithImpl(
    _$LessonSpeakingImpl _value,
    $Res Function(_$LessonSpeakingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LessonSpeaking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? audioUrl = freezed,
    Object? conversationUrl = freezed,
  }) {
    return _then(
      _$LessonSpeakingImpl(
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        conversationUrl: freezed == conversationUrl
            ? _value.conversationUrl
            : conversationUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonSpeakingImpl implements _LessonSpeaking {
  const _$LessonSpeakingImpl({
    this.text = '',
    this.audioUrl,
    this.conversationUrl,
  });

  factory _$LessonSpeakingImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonSpeakingImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  // Nội dung bài mẫu/hội thoại
  @override
  final String? audioUrl;
  // Audio nghe mẫu
  @override
  final String? conversationUrl;

  @override
  String toString() {
    return 'LessonSpeaking(text: $text, audioUrl: $audioUrl, conversationUrl: $conversationUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonSpeakingImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.conversationUrl, conversationUrl) ||
                other.conversationUrl == conversationUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, audioUrl, conversationUrl);

  /// Create a copy of LessonSpeaking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonSpeakingImplCopyWith<_$LessonSpeakingImpl> get copyWith =>
      __$$LessonSpeakingImplCopyWithImpl<_$LessonSpeakingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonSpeakingImplToJson(this);
  }
}

abstract class _LessonSpeaking implements LessonSpeaking {
  const factory _LessonSpeaking({
    final String text,
    final String? audioUrl,
    final String? conversationUrl,
  }) = _$LessonSpeakingImpl;

  factory _LessonSpeaking.fromJson(Map<String, dynamic> json) =
      _$LessonSpeakingImpl.fromJson;

  @override
  String get text; // Nội dung bài mẫu/hội thoại
  @override
  String? get audioUrl; // Audio nghe mẫu
  @override
  String? get conversationUrl;

  /// Create a copy of LessonSpeaking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonSpeakingImplCopyWith<_$LessonSpeakingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
