// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocabulary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vocabulary _$VocabularyFromJson(Map<String, dynamic> json) {
  return _Vocabulary.fromJson(json);
}

/// @nodoc
mixin _$Vocabulary {
  String get id => throw _privateConstructorUsedError;
  String get finnish => throw _privateConstructorUsedError;
  String? get pronunciation => throw _privateConstructorUsedError;
  String? get english => throw _privateConstructorUsedError;
  String get vietnamese => throw _privateConstructorUsedError;
  String get lessonId => throw _privateConstructorUsedError;
  bool get isGlobal => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;

  /// Serializes this Vocabulary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyCopyWith<Vocabulary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyCopyWith<$Res> {
  factory $VocabularyCopyWith(
    Vocabulary value,
    $Res Function(Vocabulary) then,
  ) = _$VocabularyCopyWithImpl<$Res, Vocabulary>;
  @useResult
  $Res call({
    String id,
    String finnish,
    String? pronunciation,
    String? english,
    String vietnamese,
    String lessonId,
    bool isGlobal,
    String? authorId,
  });
}

/// @nodoc
class _$VocabularyCopyWithImpl<$Res, $Val extends Vocabulary>
    implements $VocabularyCopyWith<$Res> {
  _$VocabularyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? finnish = null,
    Object? pronunciation = freezed,
    Object? english = freezed,
    Object? vietnamese = null,
    Object? lessonId = null,
    Object? isGlobal = null,
    Object? authorId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            finnish: null == finnish
                ? _value.finnish
                : finnish // ignore: cast_nullable_to_non_nullable
                      as String,
            pronunciation: freezed == pronunciation
                ? _value.pronunciation
                : pronunciation // ignore: cast_nullable_to_non_nullable
                      as String?,
            english: freezed == english
                ? _value.english
                : english // ignore: cast_nullable_to_non_nullable
                      as String?,
            vietnamese: null == vietnamese
                ? _value.vietnamese
                : vietnamese // ignore: cast_nullable_to_non_nullable
                      as String,
            lessonId: null == lessonId
                ? _value.lessonId
                : lessonId // ignore: cast_nullable_to_non_nullable
                      as String,
            isGlobal: null == isGlobal
                ? _value.isGlobal
                : isGlobal // ignore: cast_nullable_to_non_nullable
                      as bool,
            authorId: freezed == authorId
                ? _value.authorId
                : authorId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VocabularyImplCopyWith<$Res>
    implements $VocabularyCopyWith<$Res> {
  factory _$$VocabularyImplCopyWith(
    _$VocabularyImpl value,
    $Res Function(_$VocabularyImpl) then,
  ) = __$$VocabularyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String finnish,
    String? pronunciation,
    String? english,
    String vietnamese,
    String lessonId,
    bool isGlobal,
    String? authorId,
  });
}

/// @nodoc
class __$$VocabularyImplCopyWithImpl<$Res>
    extends _$VocabularyCopyWithImpl<$Res, _$VocabularyImpl>
    implements _$$VocabularyImplCopyWith<$Res> {
  __$$VocabularyImplCopyWithImpl(
    _$VocabularyImpl _value,
    $Res Function(_$VocabularyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? finnish = null,
    Object? pronunciation = freezed,
    Object? english = freezed,
    Object? vietnamese = null,
    Object? lessonId = null,
    Object? isGlobal = null,
    Object? authorId = freezed,
  }) {
    return _then(
      _$VocabularyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        finnish: null == finnish
            ? _value.finnish
            : finnish // ignore: cast_nullable_to_non_nullable
                  as String,
        pronunciation: freezed == pronunciation
            ? _value.pronunciation
            : pronunciation // ignore: cast_nullable_to_non_nullable
                  as String?,
        english: freezed == english
            ? _value.english
            : english // ignore: cast_nullable_to_non_nullable
                  as String?,
        vietnamese: null == vietnamese
            ? _value.vietnamese
            : vietnamese // ignore: cast_nullable_to_non_nullable
                  as String,
        lessonId: null == lessonId
            ? _value.lessonId
            : lessonId // ignore: cast_nullable_to_non_nullable
                  as String,
        isGlobal: null == isGlobal
            ? _value.isGlobal
            : isGlobal // ignore: cast_nullable_to_non_nullable
                  as bool,
        authorId: freezed == authorId
            ? _value.authorId
            : authorId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabularyImpl implements _Vocabulary {
  const _$VocabularyImpl({
    required this.id,
    required this.finnish,
    this.pronunciation,
    this.english,
    required this.vietnamese,
    required this.lessonId,
    this.isGlobal = false,
    this.authorId,
  });

  factory _$VocabularyImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabularyImplFromJson(json);

  @override
  final String id;
  @override
  final String finnish;
  @override
  final String? pronunciation;
  @override
  final String? english;
  @override
  final String vietnamese;
  @override
  final String lessonId;
  @override
  @JsonKey()
  final bool isGlobal;
  @override
  final String? authorId;

  @override
  String toString() {
    return 'Vocabulary(id: $id, finnish: $finnish, pronunciation: $pronunciation, english: $english, vietnamese: $vietnamese, lessonId: $lessonId, isGlobal: $isGlobal, authorId: $authorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.finnish, finnish) || other.finnish == finnish) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.vietnamese, vietnamese) ||
                other.vietnamese == vietnamese) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.isGlobal, isGlobal) ||
                other.isGlobal == isGlobal) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    finnish,
    pronunciation,
    english,
    vietnamese,
    lessonId,
    isGlobal,
    authorId,
  );

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyImplCopyWith<_$VocabularyImpl> get copyWith =>
      __$$VocabularyImplCopyWithImpl<_$VocabularyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabularyImplToJson(this);
  }
}

abstract class _Vocabulary implements Vocabulary {
  const factory _Vocabulary({
    required final String id,
    required final String finnish,
    final String? pronunciation,
    final String? english,
    required final String vietnamese,
    required final String lessonId,
    final bool isGlobal,
    final String? authorId,
  }) = _$VocabularyImpl;

  factory _Vocabulary.fromJson(Map<String, dynamic> json) =
      _$VocabularyImpl.fromJson;

  @override
  String get id;
  @override
  String get finnish;
  @override
  String? get pronunciation;
  @override
  String? get english;
  @override
  String get vietnamese;
  @override
  String get lessonId;
  @override
  bool get isGlobal;
  @override
  String? get authorId;

  /// Create a copy of Vocabulary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyImplCopyWith<_$VocabularyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
