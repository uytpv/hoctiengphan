// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grammar_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GrammarTopic _$GrammarTopicFromJson(Map<String, dynamic> json) {
  return _GrammarTopic.fromJson(json);
}

/// @nodoc
mixin _$GrammarTopic {
  String get id => throw _privateConstructorUsedError;
  String get chapter => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  dynamic get content => throw _privateConstructorUsedError;

  /// Serializes this GrammarTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GrammarTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GrammarTopicCopyWith<GrammarTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GrammarTopicCopyWith<$Res> {
  factory $GrammarTopicCopyWith(
    GrammarTopic value,
    $Res Function(GrammarTopic) then,
  ) = _$GrammarTopicCopyWithImpl<$Res, GrammarTopic>;
  @useResult
  $Res call({
    String id,
    String chapter,
    String title,
    String? desc,
    dynamic content,
  });
}

/// @nodoc
class _$GrammarTopicCopyWithImpl<$Res, $Val extends GrammarTopic>
    implements $GrammarTopicCopyWith<$Res> {
  _$GrammarTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GrammarTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapter = null,
    Object? title = null,
    Object? desc = freezed,
    Object? content = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            chapter: null == chapter
                ? _value.chapter
                : chapter // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            desc: freezed == desc
                ? _value.desc
                : desc // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as dynamic,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GrammarTopicImplCopyWith<$Res>
    implements $GrammarTopicCopyWith<$Res> {
  factory _$$GrammarTopicImplCopyWith(
    _$GrammarTopicImpl value,
    $Res Function(_$GrammarTopicImpl) then,
  ) = __$$GrammarTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String chapter,
    String title,
    String? desc,
    dynamic content,
  });
}

/// @nodoc
class __$$GrammarTopicImplCopyWithImpl<$Res>
    extends _$GrammarTopicCopyWithImpl<$Res, _$GrammarTopicImpl>
    implements _$$GrammarTopicImplCopyWith<$Res> {
  __$$GrammarTopicImplCopyWithImpl(
    _$GrammarTopicImpl _value,
    $Res Function(_$GrammarTopicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GrammarTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chapter = null,
    Object? title = null,
    Object? desc = freezed,
    Object? content = freezed,
  }) {
    return _then(
      _$GrammarTopicImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        chapter: null == chapter
            ? _value.chapter
            : chapter // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        desc: freezed == desc
            ? _value.desc
            : desc // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as dynamic,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GrammarTopicImpl implements _GrammarTopic {
  const _$GrammarTopicImpl({
    required this.id,
    required this.chapter,
    required this.title,
    this.desc,
    this.content,
  });

  factory _$GrammarTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$GrammarTopicImplFromJson(json);

  @override
  final String id;
  @override
  final String chapter;
  @override
  final String title;
  @override
  final String? desc;
  @override
  final dynamic content;

  @override
  String toString() {
    return 'GrammarTopic(id: $id, chapter: $chapter, title: $title, desc: $desc, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GrammarTopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            const DeepCollectionEquality().equals(other.content, content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    chapter,
    title,
    desc,
    const DeepCollectionEquality().hash(content),
  );

  /// Create a copy of GrammarTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GrammarTopicImplCopyWith<_$GrammarTopicImpl> get copyWith =>
      __$$GrammarTopicImplCopyWithImpl<_$GrammarTopicImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GrammarTopicImplToJson(this);
  }
}

abstract class _GrammarTopic implements GrammarTopic {
  const factory _GrammarTopic({
    required final String id,
    required final String chapter,
    required final String title,
    final String? desc,
    final dynamic content,
  }) = _$GrammarTopicImpl;

  factory _GrammarTopic.fromJson(Map<String, dynamic> json) =
      _$GrammarTopicImpl.fromJson;

  @override
  String get id;
  @override
  String get chapter;
  @override
  String get title;
  @override
  String? get desc;
  @override
  dynamic get content;

  /// Create a copy of GrammarTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GrammarTopicImplCopyWith<_$GrammarTopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
