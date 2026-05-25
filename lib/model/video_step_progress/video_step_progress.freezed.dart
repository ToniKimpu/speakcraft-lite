// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_step_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoStepProgress _$VideoStepProgressFromJson(Map<String, dynamic> json) {
  return _VideoStepProgress.fromJson(json);
}

/// @nodoc
mixin _$VideoStepProgress {
  String get youtubeId => throw _privateConstructorUsedError;
  String get stepKey => throw _privateConstructorUsedError;
  int get state => throw _privateConstructorUsedError;
  DateTime? get lastOpenedAt => throw _privateConstructorUsedError;
  int get openCount => throw _privateConstructorUsedError;

  /// Serializes this VideoStepProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoStepProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoStepProgressCopyWith<VideoStepProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStepProgressCopyWith<$Res> {
  factory $VideoStepProgressCopyWith(
          VideoStepProgress value, $Res Function(VideoStepProgress) then) =
      _$VideoStepProgressCopyWithImpl<$Res, VideoStepProgress>;
  @useResult
  $Res call(
      {String youtubeId,
      String stepKey,
      int state,
      DateTime? lastOpenedAt,
      int openCount});
}

/// @nodoc
class _$VideoStepProgressCopyWithImpl<$Res, $Val extends VideoStepProgress>
    implements $VideoStepProgressCopyWith<$Res> {
  _$VideoStepProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoStepProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
    Object? stepKey = null,
    Object? state = null,
    Object? lastOpenedAt = freezed,
    Object? openCount = null,
  }) {
    return _then(_value.copyWith(
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      stepKey: null == stepKey
          ? _value.stepKey
          : stepKey // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int,
      lastOpenedAt: freezed == lastOpenedAt
          ? _value.lastOpenedAt
          : lastOpenedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      openCount: null == openCount
          ? _value.openCount
          : openCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoStepProgressImplCopyWith<$Res>
    implements $VideoStepProgressCopyWith<$Res> {
  factory _$$VideoStepProgressImplCopyWith(_$VideoStepProgressImpl value,
          $Res Function(_$VideoStepProgressImpl) then) =
      __$$VideoStepProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String youtubeId,
      String stepKey,
      int state,
      DateTime? lastOpenedAt,
      int openCount});
}

/// @nodoc
class __$$VideoStepProgressImplCopyWithImpl<$Res>
    extends _$VideoStepProgressCopyWithImpl<$Res, _$VideoStepProgressImpl>
    implements _$$VideoStepProgressImplCopyWith<$Res> {
  __$$VideoStepProgressImplCopyWithImpl(_$VideoStepProgressImpl _value,
      $Res Function(_$VideoStepProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStepProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
    Object? stepKey = null,
    Object? state = null,
    Object? lastOpenedAt = freezed,
    Object? openCount = null,
  }) {
    return _then(_$VideoStepProgressImpl(
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      stepKey: null == stepKey
          ? _value.stepKey
          : stepKey // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as int,
      lastOpenedAt: freezed == lastOpenedAt
          ? _value.lastOpenedAt
          : lastOpenedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      openCount: null == openCount
          ? _value.openCount
          : openCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoStepProgressImpl implements _VideoStepProgress {
  const _$VideoStepProgressImpl(
      {required this.youtubeId,
      required this.stepKey,
      this.state = 0,
      this.lastOpenedAt,
      this.openCount = 0});

  factory _$VideoStepProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoStepProgressImplFromJson(json);

  @override
  final String youtubeId;
  @override
  final String stepKey;
  @override
  @JsonKey()
  final int state;
  @override
  final DateTime? lastOpenedAt;
  @override
  @JsonKey()
  final int openCount;

  @override
  String toString() {
    return 'VideoStepProgress(youtubeId: $youtubeId, stepKey: $stepKey, state: $state, lastOpenedAt: $lastOpenedAt, openCount: $openCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStepProgressImpl &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.stepKey, stepKey) || other.stepKey == stepKey) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.lastOpenedAt, lastOpenedAt) ||
                other.lastOpenedAt == lastOpenedAt) &&
            (identical(other.openCount, openCount) ||
                other.openCount == openCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, youtubeId, stepKey, state, lastOpenedAt, openCount);

  /// Create a copy of VideoStepProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStepProgressImplCopyWith<_$VideoStepProgressImpl> get copyWith =>
      __$$VideoStepProgressImplCopyWithImpl<_$VideoStepProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoStepProgressImplToJson(
      this,
    );
  }
}

abstract class _VideoStepProgress implements VideoStepProgress {
  const factory _VideoStepProgress(
      {required final String youtubeId,
      required final String stepKey,
      final int state,
      final DateTime? lastOpenedAt,
      final int openCount}) = _$VideoStepProgressImpl;

  factory _VideoStepProgress.fromJson(Map<String, dynamic> json) =
      _$VideoStepProgressImpl.fromJson;

  @override
  String get youtubeId;
  @override
  String get stepKey;
  @override
  int get state;
  @override
  DateTime? get lastOpenedAt;
  @override
  int get openCount;

  /// Create a copy of VideoStepProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStepProgressImplCopyWith<_$VideoStepProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
