// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_speaking_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailySpeakingSession _$DailySpeakingSessionFromJson(Map<String, dynamic> json) {
  return _DailySpeakingSession.fromJson(json);
}

/// @nodoc
mixin _$DailySpeakingSession {
  int get id => throw _privateConstructorUsedError;
  String? get topicId => throw _privateConstructorUsedError;
  String get onRamp => throw _privateConstructorUsedError;
  String get inputMode => throw _privateConstructorUsedError;
  String? get inputText => throw _privateConstructorUsedError;
  DailySpeakingFeedback get feedback => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Local path to the saved recording (voice sessions only). Audio is kept
  /// only for the active attempt chain and pruned when a new chain starts, so
  /// this is null for older / pruned sessions and for the text path. Powers
  /// the result-page player and the A/B "hear your progress" comparison across
  /// the version loop. See `daily_speaking_feature.md`.
  String? get audioPath => throw _privateConstructorUsedError;

  /// Groups every version (v1, v2, …) of one topic attempt together. Minted
  /// on the first attempt; carried forward by "Polish & retry". Null for
  /// legacy rows and one-off (just-talk) sessions. See the version loop in
  /// `daily_speaking_feature.md`.
  String? get topicAttemptId => throw _privateConstructorUsedError;

  /// 1 for the first attempt, 2 for the first retry, etc. Rendered as "v{n}".
  int get revisionNumber => throw _privateConstructorUsedError;

  /// Serialized [DailySpeakingTopic] for loop-capable on-ramps, so the topic
  /// can be resumed from history. Null for just-talk and legacy rows. See
  /// [decodedTopic].
  String? get topicJson => throw _privateConstructorUsedError;

  /// Serializes this DailySpeakingSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailySpeakingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailySpeakingSessionCopyWith<DailySpeakingSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingSessionCopyWith<$Res> {
  factory $DailySpeakingSessionCopyWith(DailySpeakingSession value,
          $Res Function(DailySpeakingSession) then) =
      _$DailySpeakingSessionCopyWithImpl<$Res, DailySpeakingSession>;
  @useResult
  $Res call(
      {int id,
      String? topicId,
      String onRamp,
      String inputMode,
      String? inputText,
      DailySpeakingFeedback feedback,
      DateTime? createdAt,
      String? audioPath,
      String? topicAttemptId,
      int revisionNumber,
      String? topicJson});

  $DailySpeakingFeedbackCopyWith<$Res> get feedback;
}

/// @nodoc
class _$DailySpeakingSessionCopyWithImpl<$Res,
        $Val extends DailySpeakingSession>
    implements $DailySpeakingSessionCopyWith<$Res> {
  _$DailySpeakingSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = freezed,
    Object? onRamp = null,
    Object? inputMode = null,
    Object? inputText = freezed,
    Object? feedback = null,
    Object? createdAt = freezed,
    Object? audioPath = freezed,
    Object? topicAttemptId = freezed,
    Object? revisionNumber = null,
    Object? topicJson = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      topicId: freezed == topicId
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as String?,
      onRamp: null == onRamp
          ? _value.onRamp
          : onRamp // ignore: cast_nullable_to_non_nullable
              as String,
      inputMode: null == inputMode
          ? _value.inputMode
          : inputMode // ignore: cast_nullable_to_non_nullable
              as String,
      inputText: freezed == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String?,
      feedback: null == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as DailySpeakingFeedback,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      topicAttemptId: freezed == topicAttemptId
          ? _value.topicAttemptId
          : topicAttemptId // ignore: cast_nullable_to_non_nullable
              as String?,
      revisionNumber: null == revisionNumber
          ? _value.revisionNumber
          : revisionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      topicJson: freezed == topicJson
          ? _value.topicJson
          : topicJson // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of DailySpeakingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailySpeakingFeedbackCopyWith<$Res> get feedback {
    return $DailySpeakingFeedbackCopyWith<$Res>(_value.feedback, (value) {
      return _then(_value.copyWith(feedback: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailySpeakingSessionImplCopyWith<$Res>
    implements $DailySpeakingSessionCopyWith<$Res> {
  factory _$$DailySpeakingSessionImplCopyWith(_$DailySpeakingSessionImpl value,
          $Res Function(_$DailySpeakingSessionImpl) then) =
      __$$DailySpeakingSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? topicId,
      String onRamp,
      String inputMode,
      String? inputText,
      DailySpeakingFeedback feedback,
      DateTime? createdAt,
      String? audioPath,
      String? topicAttemptId,
      int revisionNumber,
      String? topicJson});

  @override
  $DailySpeakingFeedbackCopyWith<$Res> get feedback;
}

/// @nodoc
class __$$DailySpeakingSessionImplCopyWithImpl<$Res>
    extends _$DailySpeakingSessionCopyWithImpl<$Res, _$DailySpeakingSessionImpl>
    implements _$$DailySpeakingSessionImplCopyWith<$Res> {
  __$$DailySpeakingSessionImplCopyWithImpl(_$DailySpeakingSessionImpl _value,
      $Res Function(_$DailySpeakingSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = freezed,
    Object? onRamp = null,
    Object? inputMode = null,
    Object? inputText = freezed,
    Object? feedback = null,
    Object? createdAt = freezed,
    Object? audioPath = freezed,
    Object? topicAttemptId = freezed,
    Object? revisionNumber = null,
    Object? topicJson = freezed,
  }) {
    return _then(_$DailySpeakingSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      topicId: freezed == topicId
          ? _value.topicId
          : topicId // ignore: cast_nullable_to_non_nullable
              as String?,
      onRamp: null == onRamp
          ? _value.onRamp
          : onRamp // ignore: cast_nullable_to_non_nullable
              as String,
      inputMode: null == inputMode
          ? _value.inputMode
          : inputMode // ignore: cast_nullable_to_non_nullable
              as String,
      inputText: freezed == inputText
          ? _value.inputText
          : inputText // ignore: cast_nullable_to_non_nullable
              as String?,
      feedback: null == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as DailySpeakingFeedback,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      topicAttemptId: freezed == topicAttemptId
          ? _value.topicAttemptId
          : topicAttemptId // ignore: cast_nullable_to_non_nullable
              as String?,
      revisionNumber: null == revisionNumber
          ? _value.revisionNumber
          : revisionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      topicJson: freezed == topicJson
          ? _value.topicJson
          : topicJson // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySpeakingSessionImpl implements _DailySpeakingSession {
  const _$DailySpeakingSessionImpl(
      {required this.id,
      this.topicId,
      required this.onRamp,
      required this.inputMode,
      this.inputText,
      required this.feedback,
      this.createdAt,
      this.audioPath,
      this.topicAttemptId,
      this.revisionNumber = 1,
      this.topicJson});

  factory _$DailySpeakingSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySpeakingSessionImplFromJson(json);

  @override
  final int id;
  @override
  final String? topicId;
  @override
  final String onRamp;
  @override
  final String inputMode;
  @override
  final String? inputText;
  @override
  final DailySpeakingFeedback feedback;
  @override
  final DateTime? createdAt;

  /// Local path to the saved recording (voice sessions only). Audio is kept
  /// only for the active attempt chain and pruned when a new chain starts, so
  /// this is null for older / pruned sessions and for the text path. Powers
  /// the result-page player and the A/B "hear your progress" comparison across
  /// the version loop. See `daily_speaking_feature.md`.
  @override
  final String? audioPath;

  /// Groups every version (v1, v2, …) of one topic attempt together. Minted
  /// on the first attempt; carried forward by "Polish & retry". Null for
  /// legacy rows and one-off (just-talk) sessions. See the version loop in
  /// `daily_speaking_feature.md`.
  @override
  final String? topicAttemptId;

  /// 1 for the first attempt, 2 for the first retry, etc. Rendered as "v{n}".
  @override
  @JsonKey()
  final int revisionNumber;

  /// Serialized [DailySpeakingTopic] for loop-capable on-ramps, so the topic
  /// can be resumed from history. Null for just-talk and legacy rows. See
  /// [decodedTopic].
  @override
  final String? topicJson;

  @override
  String toString() {
    return 'DailySpeakingSession(id: $id, topicId: $topicId, onRamp: $onRamp, inputMode: $inputMode, inputText: $inputText, feedback: $feedback, createdAt: $createdAt, audioPath: $audioPath, topicAttemptId: $topicAttemptId, revisionNumber: $revisionNumber, topicJson: $topicJson)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySpeakingSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.onRamp, onRamp) || other.onRamp == onRamp) &&
            (identical(other.inputMode, inputMode) ||
                other.inputMode == inputMode) &&
            (identical(other.inputText, inputText) ||
                other.inputText == inputText) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.topicAttemptId, topicAttemptId) ||
                other.topicAttemptId == topicAttemptId) &&
            (identical(other.revisionNumber, revisionNumber) ||
                other.revisionNumber == revisionNumber) &&
            (identical(other.topicJson, topicJson) ||
                other.topicJson == topicJson));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      topicId,
      onRamp,
      inputMode,
      inputText,
      feedback,
      createdAt,
      audioPath,
      topicAttemptId,
      revisionNumber,
      topicJson);

  /// Create a copy of DailySpeakingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySpeakingSessionImplCopyWith<_$DailySpeakingSessionImpl>
      get copyWith =>
          __$$DailySpeakingSessionImplCopyWithImpl<_$DailySpeakingSessionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailySpeakingSessionImplToJson(
      this,
    );
  }
}

abstract class _DailySpeakingSession implements DailySpeakingSession {
  const factory _DailySpeakingSession(
      {required final int id,
      final String? topicId,
      required final String onRamp,
      required final String inputMode,
      final String? inputText,
      required final DailySpeakingFeedback feedback,
      final DateTime? createdAt,
      final String? audioPath,
      final String? topicAttemptId,
      final int revisionNumber,
      final String? topicJson}) = _$DailySpeakingSessionImpl;

  factory _DailySpeakingSession.fromJson(Map<String, dynamic> json) =
      _$DailySpeakingSessionImpl.fromJson;

  @override
  int get id;
  @override
  String? get topicId;
  @override
  String get onRamp;
  @override
  String get inputMode;
  @override
  String? get inputText;
  @override
  DailySpeakingFeedback get feedback;
  @override
  DateTime? get createdAt;

  /// Local path to the saved recording (voice sessions only). Audio is kept
  /// only for the active attempt chain and pruned when a new chain starts, so
  /// this is null for older / pruned sessions and for the text path. Powers
  /// the result-page player and the A/B "hear your progress" comparison across
  /// the version loop. See `daily_speaking_feature.md`.
  @override
  String? get audioPath;

  /// Groups every version (v1, v2, …) of one topic attempt together. Minted
  /// on the first attempt; carried forward by "Polish & retry". Null for
  /// legacy rows and one-off (just-talk) sessions. See the version loop in
  /// `daily_speaking_feature.md`.
  @override
  String? get topicAttemptId;

  /// 1 for the first attempt, 2 for the first retry, etc. Rendered as "v{n}".
  @override
  int get revisionNumber;

  /// Serialized [DailySpeakingTopic] for loop-capable on-ramps, so the topic
  /// can be resumed from history. Null for just-talk and legacy rows. See
  /// [decodedTopic].
  @override
  String? get topicJson;

  /// Create a copy of DailySpeakingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySpeakingSessionImplCopyWith<_$DailySpeakingSessionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
