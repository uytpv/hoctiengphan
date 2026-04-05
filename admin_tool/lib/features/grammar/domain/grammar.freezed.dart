// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grammar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Grammar _$GrammarFromJson(Map<String, dynamic> json) {
  return _Grammar.fromJson(json);
}

/// @nodoc
mixin _$Grammar {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String get content =>
      throw _privateConstructorUsedError; // Markdown or Quill JSON
  String? get audioUrl => throw _privateConstructorUsedError;
  List<String> get relatedVocabularyIds => throw _privateConstructorUsedError;

  /// Serializes this Grammar to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Grammar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GrammarCopyWith<Grammar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrammarCopyWith<$Res> {
  factory $GrammarCopyWith(Grammar value, $Res Function(Grammar) then) =
      _$GrammarCopyWithImpl<$Res, Grammar>;
  @useResult
  $Res call({
    String id,
    String title,
    String? slug,
    String content,
    String? audioUrl,
    List<String> relatedVocabularyIds,
  });
}

/// @nodoc
class _$GrammarCopyWithImpl<$Res, $Val extends Grammar>
    implements $GrammarCopyWith<$Res> {
  _$GrammarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Grammar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = freezed,
    Object? content = null,
    Object? audioUrl = freezed,
    Object? relatedVocabularyIds = null,
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
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            audioUrl: freezed == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedVocabularyIds: null == relatedVocabularyIds
                ? _value.relatedVocabularyIds
                : relatedVocabularyIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GrammarImplCopyWith<$Res> implements $GrammarCopyWith<$Res> {
  factory _$$GrammarImplCopyWith(
    _$GrammarImpl value,
    $Res Function(_$GrammarImpl) then,
  ) = __$$GrammarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? slug,
    String content,
    String? audioUrl,
    List<String> relatedVocabularyIds,
  });
}

/// @nodoc
class __$$GrammarImplCopyWithImpl<$Res>
    extends _$GrammarCopyWithImpl<$Res, _$GrammarImpl>
    implements _$$GrammarImplCopyWith<$Res> {
  __$$GrammarImplCopyWithImpl(
    _$GrammarImpl _value,
    $Res Function(_$GrammarImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Grammar
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = freezed,
    Object? content = null,
    Object? audioUrl = freezed,
    Object? relatedVocabularyIds = null,
  }) {
    return _then(
      _$GrammarImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        audioUrl: freezed == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedVocabularyIds: null == relatedVocabularyIds
            ? _value._relatedVocabularyIds
            : relatedVocabularyIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GrammarImpl implements _Grammar {
  const _$GrammarImpl({
    required this.id,
    this.title = '',
    this.slug,
    this.content = '',
    this.audioUrl,
    final List<String> relatedVocabularyIds = const [],
  }) : _relatedVocabularyIds = relatedVocabularyIds;

  factory _$GrammarImpl.fromJson(Map<String, dynamic> json) =>
      _$$GrammarImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  final String? slug;
  @override
  @JsonKey()
  final String content;
  // Markdown or Quill JSON
  @override
  final String? audioUrl;
  final List<String> _relatedVocabularyIds;
  @override
  @JsonKey()
  List<String> get relatedVocabularyIds {
    if (_relatedVocabularyIds is EqualUnmodifiableListView)
      return _relatedVocabularyIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedVocabularyIds);
  }

  @override
  String toString() {
    return 'Grammar(id: $id, title: $title, slug: $slug, content: $content, audioUrl: $audioUrl, relatedVocabularyIds: $relatedVocabularyIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrammarImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            const DeepCollectionEquality().equals(
              other._relatedVocabularyIds,
              _relatedVocabularyIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    slug,
    content,
    audioUrl,
    const DeepCollectionEquality().hash(_relatedVocabularyIds),
  );

  /// Create a copy of Grammar
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GrammarImplCopyWith<_$GrammarImpl> get copyWith =>
      __$$GrammarImplCopyWithImpl<_$GrammarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GrammarImplToJson(this);
  }
}

abstract class _Grammar implements Grammar {
  const factory _Grammar({
    required final String id,
    final String title,
    final String? slug,
    final String content,
    final String? audioUrl,
    final List<String> relatedVocabularyIds,
  }) = _$GrammarImpl;

  factory _Grammar.fromJson(Map<String, dynamic> json) = _$GrammarImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get slug;
  @override
  String get content; // Markdown or Quill JSON
  @override
  String? get audioUrl;
  @override
  List<String> get relatedVocabularyIds;

  /// Create a copy of Grammar
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GrammarImplCopyWith<_$GrammarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
