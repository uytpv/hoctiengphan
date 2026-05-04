// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return _Question.fromJson(json);
}

/// @nodoc
mixin _$Question {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String get prompt => throw _privateConstructorUsedError;
  ExerciseType get type => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;
  List<String>? get correctAnswers => throw _privateConstructorUsedError;
  String? get correctAnswer => throw _privateConstructorUsedError;
  int? get correctIndex => throw _privateConstructorUsedError;
  String? get correctText => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get audioUrl => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuestionCopyWith<Question> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionCopyWith<$Res> {
  factory $QuestionCopyWith(Question value, $Res Function(Question) then) =
      _$QuestionCopyWithImpl<$Res, Question>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'text') String prompt,
    ExerciseType type,
    List<String>? options,
    List<String>? correctAnswers,
    String? correctAnswer,
    int? correctIndex,
    String? correctText,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? explanation,
  });
}

/// @nodoc
class _$QuestionCopyWithImpl<$Res, $Val extends Question>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? prompt = null,
    Object? type = null,
    Object? options = freezed,
    Object? correctAnswers = freezed,
    Object? correctAnswer = freezed,
    Object? correctIndex = freezed,
    Object? correctText = freezed,
    Object? imageUrl = freezed,
    Object? audioUrl = freezed,
    Object? videoUrl = freezed,
    Object? explanation = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            prompt: null == prompt
                ? _value.prompt
                : prompt // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ExerciseType,
            options: freezed == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            correctAnswers: freezed == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            correctAnswer: freezed == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as String?,
            correctIndex: freezed == correctIndex
                ? _value.correctIndex
                : correctIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            correctText: freezed == correctText
                ? _value.correctText
                : correctText // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            explanation: freezed == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuestionImplCopyWith<$Res>
    implements $QuestionCopyWith<$Res> {
  factory _$$QuestionImplCopyWith(
    _$QuestionImpl value,
    $Res Function(_$QuestionImpl) then,
  ) = __$$QuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'text') String prompt,
    ExerciseType type,
    List<String>? options,
    List<String>? correctAnswers,
    String? correctAnswer,
    int? correctIndex,
    String? correctText,
    String? imageUrl,
    String? audioUrl,
    String? videoUrl,
    String? explanation,
  });
}

/// @nodoc
class __$$QuestionImplCopyWithImpl<$Res>
    extends _$QuestionCopyWithImpl<$Res, _$QuestionImpl>
    implements _$$QuestionImplCopyWith<$Res> {
  __$$QuestionImplCopyWithImpl(
    _$QuestionImpl _value,
    $Res Function(_$QuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? prompt = null,
    Object? type = null,
    Object? options = freezed,
    Object? correctAnswers = freezed,
    Object? correctAnswer = freezed,
    Object? correctIndex = freezed,
    Object? correctText = freezed,
    Object? imageUrl = freezed,
    Object? audioUrl = freezed,
    Object? videoUrl = freezed,
    Object? explanation = freezed,
  }) {
    return _then(
      _$QuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        prompt: null == prompt
            ? _value.prompt
            : prompt // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ExerciseType,
        options: freezed == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        correctAnswers: freezed == correctAnswers
            ? _value._correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        correctAnswer: freezed == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as String?,
        correctIndex: freezed == correctIndex
            ? _value.correctIndex
            : correctIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        correctText: freezed == correctText
            ? _value.correctText
            : correctText // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        explanation: freezed == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuestionImpl implements _Question {
  const _$QuestionImpl({
    required this.id,
    @JsonKey(name: 'text') required this.prompt,
    this.type = ExerciseType.multipleChoice,
    final List<String>? options,
    final List<String>? correctAnswers,
    this.correctAnswer,
    this.correctIndex,
    this.correctText,
    this.imageUrl,
    this.audioUrl,
    this.videoUrl,
    this.explanation,
  }) : _options = options,
       _correctAnswers = correctAnswers;

  factory _$QuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuestionImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'text')
  final String prompt;
  @override
  @JsonKey()
  final ExerciseType type;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _correctAnswers;
  @override
  List<String>? get correctAnswers {
    final value = _correctAnswers;
    if (value == null) return null;
    if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? correctAnswer;
  @override
  final int? correctIndex;
  @override
  final String? correctText;
  @override
  final String? imageUrl;
  @override
  final String? audioUrl;
  @override
  final String? videoUrl;
  @override
  final String? explanation;

  @override
  String toString() {
    return 'Question(id: $id, prompt: $prompt, type: $type, options: $options, correctAnswers: $correctAnswers, correctAnswer: $correctAnswer, correctIndex: $correctIndex, correctText: $correctText, imageUrl: $imageUrl, audioUrl: $audioUrl, videoUrl: $videoUrl, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(
              other._correctAnswers,
              _correctAnswers,
            ) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.correctIndex, correctIndex) ||
                other.correctIndex == correctIndex) &&
            (identical(other.correctText, correctText) ||
                other.correctText == correctText) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    prompt,
    type,
    const DeepCollectionEquality().hash(_options),
    const DeepCollectionEquality().hash(_correctAnswers),
    correctAnswer,
    correctIndex,
    correctText,
    imageUrl,
    audioUrl,
    videoUrl,
    explanation,
  );

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      __$$QuestionImplCopyWithImpl<_$QuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuestionImplToJson(this);
  }
}

abstract class _Question implements Question {
  const factory _Question({
    required final String id,
    @JsonKey(name: 'text') required final String prompt,
    final ExerciseType type,
    final List<String>? options,
    final List<String>? correctAnswers,
    final String? correctAnswer,
    final int? correctIndex,
    final String? correctText,
    final String? imageUrl,
    final String? audioUrl,
    final String? videoUrl,
    final String? explanation,
  }) = _$QuestionImpl;

  factory _Question.fromJson(Map<String, dynamic> json) =
      _$QuestionImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'text')
  String get prompt;
  @override
  ExerciseType get type;
  @override
  List<String>? get options;
  @override
  List<String>? get correctAnswers;
  @override
  String? get correctAnswer;
  @override
  int? get correctIndex;
  @override
  String? get correctText;
  @override
  String? get imageUrl;
  @override
  String? get audioUrl;
  @override
  String? get videoUrl;
  @override
  String? get explanation;

  /// Create a copy of Question
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionImplCopyWith<_$QuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
