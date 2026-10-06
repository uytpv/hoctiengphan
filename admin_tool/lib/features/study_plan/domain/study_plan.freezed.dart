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

ActionStep _$ActionStepFromJson(Map<String, dynamic> json) {
  return _ActionStep.fromJson(json);
}

/// @nodoc
mixin _$ActionStep {
  int get stepNumber => throw _privateConstructorUsedError;
  String get instruction => throw _privateConstructorUsedError;
  String? get tip => throw _privateConstructorUsedError;

  /// Serializes this ActionStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActionStepCopyWith<ActionStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionStepCopyWith<$Res> {
  factory $ActionStepCopyWith(
    ActionStep value,
    $Res Function(ActionStep) then,
  ) = _$ActionStepCopyWithImpl<$Res, ActionStep>;
  @useResult
  $Res call({int stepNumber, String instruction, String? tip});
}

/// @nodoc
class _$ActionStepCopyWithImpl<$Res, $Val extends ActionStep>
    implements $ActionStepCopyWith<$Res> {
  _$ActionStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? instruction = null,
    Object? tip = freezed,
  }) {
    return _then(
      _value.copyWith(
            stepNumber: null == stepNumber
                ? _value.stepNumber
                : stepNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            instruction: null == instruction
                ? _value.instruction
                : instruction // ignore: cast_nullable_to_non_nullable
                      as String,
            tip: freezed == tip
                ? _value.tip
                : tip // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActionStepImplCopyWith<$Res>
    implements $ActionStepCopyWith<$Res> {
  factory _$$ActionStepImplCopyWith(
    _$ActionStepImpl value,
    $Res Function(_$ActionStepImpl) then,
  ) = __$$ActionStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int stepNumber, String instruction, String? tip});
}

/// @nodoc
class __$$ActionStepImplCopyWithImpl<$Res>
    extends _$ActionStepCopyWithImpl<$Res, _$ActionStepImpl>
    implements _$$ActionStepImplCopyWith<$Res> {
  __$$ActionStepImplCopyWithImpl(
    _$ActionStepImpl _value,
    $Res Function(_$ActionStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepNumber = null,
    Object? instruction = null,
    Object? tip = freezed,
  }) {
    return _then(
      _$ActionStepImpl(
        stepNumber: null == stepNumber
            ? _value.stepNumber
            : stepNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        instruction: null == instruction
            ? _value.instruction
            : instruction // ignore: cast_nullable_to_non_nullable
                  as String,
        tip: freezed == tip
            ? _value.tip
            : tip // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActionStepImpl implements _ActionStep {
  const _$ActionStepImpl({
    required this.stepNumber,
    required this.instruction,
    this.tip,
  });

  factory _$ActionStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActionStepImplFromJson(json);

  @override
  final int stepNumber;
  @override
  final String instruction;
  @override
  final String? tip;

  @override
  String toString() {
    return 'ActionStep(stepNumber: $stepNumber, instruction: $instruction, tip: $tip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActionStepImpl &&
            (identical(other.stepNumber, stepNumber) ||
                other.stepNumber == stepNumber) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.tip, tip) || other.tip == tip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stepNumber, instruction, tip);

  /// Create a copy of ActionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActionStepImplCopyWith<_$ActionStepImpl> get copyWith =>
      __$$ActionStepImplCopyWithImpl<_$ActionStepImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActionStepImplToJson(this);
  }
}

abstract class _ActionStep implements ActionStep {
  const factory _ActionStep({
    required final int stepNumber,
    required final String instruction,
    final String? tip,
  }) = _$ActionStepImpl;

  factory _ActionStep.fromJson(Map<String, dynamic> json) =
      _$ActionStepImpl.fromJson;

  @override
  int get stepNumber;
  @override
  String get instruction;
  @override
  String? get tip;

  /// Create a copy of ActionStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActionStepImplCopyWith<_$ActionStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DailyActionItem _$DailyActionItemFromJson(Map<String, dynamic> json) {
  return _DailyActionItem.fromJson(json);
}

/// @nodoc
mixin _$DailyActionItem {
  String get id => throw _privateConstructorUsedError;
  @ActionItemTypeConverter()
  ActionItemType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get goal => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;
  String? get targetRefId => throw _privateConstructorUsedError;
  List<String> get specificItemIds => throw _privateConstructorUsedError;
  List<ActionStep> get steps => throw _privateConstructorUsedError;
  String? get externalLink => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this DailyActionItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyActionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyActionItemCopyWith<DailyActionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyActionItemCopyWith<$Res> {
  factory $DailyActionItemCopyWith(
    DailyActionItem value,
    $Res Function(DailyActionItem) then,
  ) = _$DailyActionItemCopyWithImpl<$Res, DailyActionItem>;
  @useResult
  $Res call({
    String id,
    @ActionItemTypeConverter() ActionItemType type,
    String title,
    String goal,
    int estimatedMinutes,
    String? targetRefId,
    List<String> specificItemIds,
    List<ActionStep> steps,
    String? externalLink,
    String? notes,
  });
}

/// @nodoc
class _$DailyActionItemCopyWithImpl<$Res, $Val extends DailyActionItem>
    implements $DailyActionItemCopyWith<$Res> {
  _$DailyActionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyActionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? goal = null,
    Object? estimatedMinutes = null,
    Object? targetRefId = freezed,
    Object? specificItemIds = null,
    Object? steps = null,
    Object? externalLink = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ActionItemType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            goal: null == goal
                ? _value.goal
                : goal // ignore: cast_nullable_to_non_nullable
                      as String,
            estimatedMinutes: null == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            targetRefId: freezed == targetRefId
                ? _value.targetRefId
                : targetRefId // ignore: cast_nullable_to_non_nullable
                      as String?,
            specificItemIds: null == specificItemIds
                ? _value.specificItemIds
                : specificItemIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<ActionStep>,
            externalLink: freezed == externalLink
                ? _value.externalLink
                : externalLink // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyActionItemImplCopyWith<$Res>
    implements $DailyActionItemCopyWith<$Res> {
  factory _$$DailyActionItemImplCopyWith(
    _$DailyActionItemImpl value,
    $Res Function(_$DailyActionItemImpl) then,
  ) = __$$DailyActionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @ActionItemTypeConverter() ActionItemType type,
    String title,
    String goal,
    int estimatedMinutes,
    String? targetRefId,
    List<String> specificItemIds,
    List<ActionStep> steps,
    String? externalLink,
    String? notes,
  });
}

/// @nodoc
class __$$DailyActionItemImplCopyWithImpl<$Res>
    extends _$DailyActionItemCopyWithImpl<$Res, _$DailyActionItemImpl>
    implements _$$DailyActionItemImplCopyWith<$Res> {
  __$$DailyActionItemImplCopyWithImpl(
    _$DailyActionItemImpl _value,
    $Res Function(_$DailyActionItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyActionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? goal = null,
    Object? estimatedMinutes = null,
    Object? targetRefId = freezed,
    Object? specificItemIds = null,
    Object? steps = null,
    Object? externalLink = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$DailyActionItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ActionItemType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        goal: null == goal
            ? _value.goal
            : goal // ignore: cast_nullable_to_non_nullable
                  as String,
        estimatedMinutes: null == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        targetRefId: freezed == targetRefId
            ? _value.targetRefId
            : targetRefId // ignore: cast_nullable_to_non_nullable
                  as String?,
        specificItemIds: null == specificItemIds
            ? _value._specificItemIds
            : specificItemIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<ActionStep>,
        externalLink: freezed == externalLink
            ? _value.externalLink
            : externalLink // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyActionItemImpl implements _DailyActionItem {
  const _$DailyActionItemImpl({
    required this.id,
    @ActionItemTypeConverter() required this.type,
    required this.title,
    this.goal = '',
    this.estimatedMinutes = 15,
    this.targetRefId,
    final List<String> specificItemIds = const [],
    final List<ActionStep> steps = const [],
    this.externalLink,
    this.notes,
  }) : _specificItemIds = specificItemIds,
       _steps = steps;

  factory _$DailyActionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyActionItemImplFromJson(json);

  @override
  final String id;
  @override
  @ActionItemTypeConverter()
  final ActionItemType type;
  @override
  final String title;
  @override
  @JsonKey()
  final String goal;
  @override
  @JsonKey()
  final int estimatedMinutes;
  @override
  final String? targetRefId;
  final List<String> _specificItemIds;
  @override
  @JsonKey()
  List<String> get specificItemIds {
    if (_specificItemIds is EqualUnmodifiableListView) return _specificItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specificItemIds);
  }

  final List<ActionStep> _steps;
  @override
  @JsonKey()
  List<ActionStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final String? externalLink;
  @override
  final String? notes;

  @override
  String toString() {
    return 'DailyActionItem(id: $id, type: $type, title: $title, goal: $goal, estimatedMinutes: $estimatedMinutes, targetRefId: $targetRefId, specificItemIds: $specificItemIds, steps: $steps, externalLink: $externalLink, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyActionItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.targetRefId, targetRefId) ||
                other.targetRefId == targetRefId) &&
            const DeepCollectionEquality().equals(
              other._specificItemIds,
              _specificItemIds,
            ) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.externalLink, externalLink) ||
                other.externalLink == externalLink) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    title,
    goal,
    estimatedMinutes,
    targetRefId,
    const DeepCollectionEquality().hash(_specificItemIds),
    const DeepCollectionEquality().hash(_steps),
    externalLink,
    notes,
  );

  /// Create a copy of DailyActionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyActionItemImplCopyWith<_$DailyActionItemImpl> get copyWith =>
      __$$DailyActionItemImplCopyWithImpl<_$DailyActionItemImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyActionItemImplToJson(this);
  }
}

abstract class _DailyActionItem implements DailyActionItem {
  const factory _DailyActionItem({
    required final String id,
    @ActionItemTypeConverter() required final ActionItemType type,
    required final String title,
    final String goal,
    final int estimatedMinutes,
    final String? targetRefId,
    final List<String> specificItemIds,
    final List<ActionStep> steps,
    final String? externalLink,
    final String? notes,
  }) = _$DailyActionItemImpl;

  factory _DailyActionItem.fromJson(Map<String, dynamic> json) =
      _$DailyActionItemImpl.fromJson;

  @override
  String get id;
  @override
  @ActionItemTypeConverter()
  ActionItemType get type;
  @override
  String get title;
  @override
  String get goal;
  @override
  int get estimatedMinutes;
  @override
  String? get targetRefId;
  @override
  List<String> get specificItemIds;
  @override
  List<ActionStep> get steps;
  @override
  String? get externalLink;
  @override
  String? get notes;

  /// Create a copy of DailyActionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyActionItemImplCopyWith<_$DailyActionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudyPlan _$StudyPlanFromJson(Map<String, dynamic> json) {
  return _StudyPlan.fromJson(json);
}

/// @nodoc
mixin _$StudyPlan {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get durationWeeks => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

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
  $Res call({
    String id,
    String title,
    String description,
    int durationWeeks,
    bool isDefault,
    DateTime? createdAt,
  });
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
    Object? title = null,
    Object? description = null,
    Object? durationWeeks = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            durationWeeks: null == durationWeeks
                ? _value.durationWeeks
                : durationWeeks // ignore: cast_nullable_to_non_nullable
                      as int,
            isDefault: null == isDefault
                ? _value.isDefault
                : isDefault // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
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
  $Res call({
    String id,
    String title,
    String description,
    int durationWeeks,
    bool isDefault,
    DateTime? createdAt,
  });
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
    Object? title = null,
    Object? description = null,
    Object? durationWeeks = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$StudyPlanImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        durationWeeks: null == durationWeeks
            ? _value.durationWeeks
            : durationWeeks // ignore: cast_nullable_to_non_nullable
                  as int,
        isDefault: null == isDefault
            ? _value.isDefault
            : isDefault // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyPlanImpl implements _StudyPlan {
  const _$StudyPlanImpl({
    required this.id,
    required this.title,
    this.description = '',
    this.durationWeeks = 26,
    this.isDefault = true,
    this.createdAt,
  });

  factory _$StudyPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int durationWeeks;
  @override
  @JsonKey()
  final bool isDefault;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'StudyPlan(id: $id, title: $title, description: $description, durationWeeks: $durationWeeks, isDefault: $isDefault, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationWeeks, durationWeeks) ||
                other.durationWeeks == durationWeeks) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    durationWeeks,
    isDefault,
    createdAt,
  );

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
    required final String title,
    final String description,
    final int durationWeeks,
    final bool isDefault,
    final DateTime? createdAt,
  }) = _$StudyPlanImpl;

  factory _StudyPlan.fromJson(Map<String, dynamic> json) =
      _$StudyPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get durationWeeks;
  @override
  bool get isDefault;
  @override
  DateTime? get createdAt;

  /// Create a copy of StudyPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyPlanImplCopyWith<_$StudyPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudyPlanWeek _$StudyPlanWeekFromJson(Map<String, dynamic> json) {
  return _StudyPlanWeek.fromJson(json);
}

/// @nodoc
mixin _$StudyPlanWeek {
  String get id => throw _privateConstructorUsedError;
  String get planId => throw _privateConstructorUsedError;
  int get weekNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<StudyDay> get days => throw _privateConstructorUsedError;

  /// Serializes this StudyPlanWeek to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyPlanWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyPlanWeekCopyWith<StudyPlanWeek> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyPlanWeekCopyWith<$Res> {
  factory $StudyPlanWeekCopyWith(
    StudyPlanWeek value,
    $Res Function(StudyPlanWeek) then,
  ) = _$StudyPlanWeekCopyWithImpl<$Res, StudyPlanWeek>;
  @useResult
  $Res call({
    String id,
    String planId,
    int weekNumber,
    String title,
    List<StudyDay> days,
  });
}

/// @nodoc
class _$StudyPlanWeekCopyWithImpl<$Res, $Val extends StudyPlanWeek>
    implements $StudyPlanWeekCopyWith<$Res> {
  _$StudyPlanWeekCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyPlanWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planId = null,
    Object? weekNumber = null,
    Object? title = null,
    Object? days = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            planId: null == planId
                ? _value.planId
                : planId // ignore: cast_nullable_to_non_nullable
                      as String,
            weekNumber: null == weekNumber
                ? _value.weekNumber
                : weekNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            days: null == days
                ? _value.days
                : days // ignore: cast_nullable_to_non_nullable
                      as List<StudyDay>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudyPlanWeekImplCopyWith<$Res>
    implements $StudyPlanWeekCopyWith<$Res> {
  factory _$$StudyPlanWeekImplCopyWith(
    _$StudyPlanWeekImpl value,
    $Res Function(_$StudyPlanWeekImpl) then,
  ) = __$$StudyPlanWeekImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String planId,
    int weekNumber,
    String title,
    List<StudyDay> days,
  });
}

/// @nodoc
class __$$StudyPlanWeekImplCopyWithImpl<$Res>
    extends _$StudyPlanWeekCopyWithImpl<$Res, _$StudyPlanWeekImpl>
    implements _$$StudyPlanWeekImplCopyWith<$Res> {
  __$$StudyPlanWeekImplCopyWithImpl(
    _$StudyPlanWeekImpl _value,
    $Res Function(_$StudyPlanWeekImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyPlanWeek
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? planId = null,
    Object? weekNumber = null,
    Object? title = null,
    Object? days = null,
  }) {
    return _then(
      _$StudyPlanWeekImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        planId: null == planId
            ? _value.planId
            : planId // ignore: cast_nullable_to_non_nullable
                  as String,
        weekNumber: null == weekNumber
            ? _value.weekNumber
            : weekNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        days: null == days
            ? _value._days
            : days // ignore: cast_nullable_to_non_nullable
                  as List<StudyDay>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyPlanWeekImpl implements _StudyPlanWeek {
  const _$StudyPlanWeekImpl({
    required this.id,
    required this.planId,
    required this.weekNumber,
    required this.title,
    final List<StudyDay> days = const [],
  }) : _days = days;

  factory _$StudyPlanWeekImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyPlanWeekImplFromJson(json);

  @override
  final String id;
  @override
  final String planId;
  @override
  final int weekNumber;
  @override
  final String title;
  final List<StudyDay> _days;
  @override
  @JsonKey()
  List<StudyDay> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  String toString() {
    return 'StudyPlanWeek(id: $id, planId: $planId, weekNumber: $weekNumber, title: $title, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyPlanWeekImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.weekNumber, weekNumber) ||
                other.weekNumber == weekNumber) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._days, _days));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    planId,
    weekNumber,
    title,
    const DeepCollectionEquality().hash(_days),
  );

  /// Create a copy of StudyPlanWeek
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyPlanWeekImplCopyWith<_$StudyPlanWeekImpl> get copyWith =>
      __$$StudyPlanWeekImplCopyWithImpl<_$StudyPlanWeekImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyPlanWeekImplToJson(this);
  }
}

abstract class _StudyPlanWeek implements StudyPlanWeek {
  const factory _StudyPlanWeek({
    required final String id,
    required final String planId,
    required final int weekNumber,
    required final String title,
    final List<StudyDay> days,
  }) = _$StudyPlanWeekImpl;

  factory _StudyPlanWeek.fromJson(Map<String, dynamic> json) =
      _$StudyPlanWeekImpl.fromJson;

  @override
  String get id;
  @override
  String get planId;
  @override
  int get weekNumber;
  @override
  String get title;
  @override
  List<StudyDay> get days;

  /// Create a copy of StudyPlanWeek
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyPlanWeekImplCopyWith<_$StudyPlanWeekImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudyDay _$StudyDayFromJson(Map<String, dynamic> json) {
  return _StudyDay.fromJson(json);
}

/// @nodoc
mixin _$StudyDay {
  int get dayIndex => throw _privateConstructorUsedError;
  String get dayName =>
      throw _privateConstructorUsedError; // e.g., "Monday", "Tiistai"
  List<String> get activityIds =>
      throw _privateConstructorUsedError; // Deprecated fallback
  List<DailyActionItem> get actions => throw _privateConstructorUsedError;

  /// Serializes this StudyDay to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudyDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudyDayCopyWith<StudyDay> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyDayCopyWith<$Res> {
  factory $StudyDayCopyWith(StudyDay value, $Res Function(StudyDay) then) =
      _$StudyDayCopyWithImpl<$Res, StudyDay>;
  @useResult
  $Res call({
    int dayIndex,
    String dayName,
    List<String> activityIds,
    List<DailyActionItem> actions,
  });
}

/// @nodoc
class _$StudyDayCopyWithImpl<$Res, $Val extends StudyDay>
    implements $StudyDayCopyWith<$Res> {
  _$StudyDayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudyDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayIndex = null,
    Object? dayName = null,
    Object? activityIds = null,
    Object? actions = null,
  }) {
    return _then(
      _value.copyWith(
            dayIndex: null == dayIndex
                ? _value.dayIndex
                : dayIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            dayName: null == dayName
                ? _value.dayName
                : dayName // ignore: cast_nullable_to_non_nullable
                      as String,
            activityIds: null == activityIds
                ? _value.activityIds
                : activityIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            actions: null == actions
                ? _value.actions
                : actions // ignore: cast_nullable_to_non_nullable
                      as List<DailyActionItem>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StudyDayImplCopyWith<$Res>
    implements $StudyDayCopyWith<$Res> {
  factory _$$StudyDayImplCopyWith(
    _$StudyDayImpl value,
    $Res Function(_$StudyDayImpl) then,
  ) = __$$StudyDayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int dayIndex,
    String dayName,
    List<String> activityIds,
    List<DailyActionItem> actions,
  });
}

/// @nodoc
class __$$StudyDayImplCopyWithImpl<$Res>
    extends _$StudyDayCopyWithImpl<$Res, _$StudyDayImpl>
    implements _$$StudyDayImplCopyWith<$Res> {
  __$$StudyDayImplCopyWithImpl(
    _$StudyDayImpl _value,
    $Res Function(_$StudyDayImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StudyDay
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayIndex = null,
    Object? dayName = null,
    Object? activityIds = null,
    Object? actions = null,
  }) {
    return _then(
      _$StudyDayImpl(
        dayIndex: null == dayIndex
            ? _value.dayIndex
            : dayIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        dayName: null == dayName
            ? _value.dayName
            : dayName // ignore: cast_nullable_to_non_nullable
                  as String,
        activityIds: null == activityIds
            ? _value._activityIds
            : activityIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        actions: null == actions
            ? _value._actions
            : actions // ignore: cast_nullable_to_non_nullable
                  as List<DailyActionItem>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyDayImpl implements _StudyDay {
  const _$StudyDayImpl({
    this.dayIndex = 1,
    required this.dayName,
    final List<String> activityIds = const [],
    final List<DailyActionItem> actions = const [],
  }) : _activityIds = activityIds,
       _actions = actions;

  factory _$StudyDayImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyDayImplFromJson(json);

  @override
  @JsonKey()
  final int dayIndex;
  @override
  final String dayName;
  // e.g., "Monday", "Tiistai"
  final List<String> _activityIds;
  // e.g., "Monday", "Tiistai"
  @override
  @JsonKey()
  List<String> get activityIds {
    if (_activityIds is EqualUnmodifiableListView) return _activityIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityIds);
  }

  // Deprecated fallback
  final List<DailyActionItem> _actions;
  // Deprecated fallback
  @override
  @JsonKey()
  List<DailyActionItem> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  @override
  String toString() {
    return 'StudyDay(dayIndex: $dayIndex, dayName: $dayName, activityIds: $activityIds, actions: $actions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyDayImpl &&
            (identical(other.dayIndex, dayIndex) ||
                other.dayIndex == dayIndex) &&
            (identical(other.dayName, dayName) || other.dayName == dayName) &&
            const DeepCollectionEquality().equals(
              other._activityIds,
              _activityIds,
            ) &&
            const DeepCollectionEquality().equals(other._actions, _actions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dayIndex,
    dayName,
    const DeepCollectionEquality().hash(_activityIds),
    const DeepCollectionEquality().hash(_actions),
  );

  /// Create a copy of StudyDay
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyDayImplCopyWith<_$StudyDayImpl> get copyWith =>
      __$$StudyDayImplCopyWithImpl<_$StudyDayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyDayImplToJson(this);
  }
}

abstract class _StudyDay implements StudyDay {
  const factory _StudyDay({
    final int dayIndex,
    required final String dayName,
    final List<String> activityIds,
    final List<DailyActionItem> actions,
  }) = _$StudyDayImpl;

  factory _StudyDay.fromJson(Map<String, dynamic> json) =
      _$StudyDayImpl.fromJson;

  @override
  int get dayIndex;
  @override
  String get dayName; // e.g., "Monday", "Tiistai"
  @override
  List<String> get activityIds; // Deprecated fallback
  @override
  List<DailyActionItem> get actions;

  /// Create a copy of StudyDay
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudyDayImplCopyWith<_$StudyDayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
