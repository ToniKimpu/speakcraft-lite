// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_step_progress_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VideoStepProgressEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAll,
    required TResult Function(String youtubeId) loadVideo,
    required TResult Function(String youtubeId, VideoLessonStep step)
        markInProgress,
    required TResult Function(String youtubeId, VideoLessonStep step) markDone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAll,
    TResult? Function(String youtubeId)? loadVideo,
    TResult? Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult? Function(String youtubeId, VideoLessonStep step)? markDone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAll,
    TResult Function(String youtubeId)? loadVideo,
    TResult Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult Function(String youtubeId, VideoLessonStep step)? markDone,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadAll value) loadAll,
    required TResult Function(_LoadVideo value) loadVideo,
    required TResult Function(_MarkInProgress value) markInProgress,
    required TResult Function(_MarkDone value) markDone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadAll value)? loadAll,
    TResult? Function(_LoadVideo value)? loadVideo,
    TResult? Function(_MarkInProgress value)? markInProgress,
    TResult? Function(_MarkDone value)? markDone,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadAll value)? loadAll,
    TResult Function(_LoadVideo value)? loadVideo,
    TResult Function(_MarkInProgress value)? markInProgress,
    TResult Function(_MarkDone value)? markDone,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStepProgressEventCopyWith<$Res> {
  factory $VideoStepProgressEventCopyWith(VideoStepProgressEvent value,
          $Res Function(VideoStepProgressEvent) then) =
      _$VideoStepProgressEventCopyWithImpl<$Res, VideoStepProgressEvent>;
}

/// @nodoc
class _$VideoStepProgressEventCopyWithImpl<$Res,
        $Val extends VideoStepProgressEvent>
    implements $VideoStepProgressEventCopyWith<$Res> {
  _$VideoStepProgressEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadAllImplCopyWith<$Res> {
  factory _$$LoadAllImplCopyWith(
          _$LoadAllImpl value, $Res Function(_$LoadAllImpl) then) =
      __$$LoadAllImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadAllImplCopyWithImpl<$Res>
    extends _$VideoStepProgressEventCopyWithImpl<$Res, _$LoadAllImpl>
    implements _$$LoadAllImplCopyWith<$Res> {
  __$$LoadAllImplCopyWithImpl(
      _$LoadAllImpl _value, $Res Function(_$LoadAllImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadAllImpl implements _LoadAll {
  const _$LoadAllImpl();

  @override
  String toString() {
    return 'VideoStepProgressEvent.loadAll()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadAllImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAll,
    required TResult Function(String youtubeId) loadVideo,
    required TResult Function(String youtubeId, VideoLessonStep step)
        markInProgress,
    required TResult Function(String youtubeId, VideoLessonStep step) markDone,
  }) {
    return loadAll();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAll,
    TResult? Function(String youtubeId)? loadVideo,
    TResult? Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult? Function(String youtubeId, VideoLessonStep step)? markDone,
  }) {
    return loadAll?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAll,
    TResult Function(String youtubeId)? loadVideo,
    TResult Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult Function(String youtubeId, VideoLessonStep step)? markDone,
    required TResult orElse(),
  }) {
    if (loadAll != null) {
      return loadAll();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadAll value) loadAll,
    required TResult Function(_LoadVideo value) loadVideo,
    required TResult Function(_MarkInProgress value) markInProgress,
    required TResult Function(_MarkDone value) markDone,
  }) {
    return loadAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadAll value)? loadAll,
    TResult? Function(_LoadVideo value)? loadVideo,
    TResult? Function(_MarkInProgress value)? markInProgress,
    TResult? Function(_MarkDone value)? markDone,
  }) {
    return loadAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadAll value)? loadAll,
    TResult Function(_LoadVideo value)? loadVideo,
    TResult Function(_MarkInProgress value)? markInProgress,
    TResult Function(_MarkDone value)? markDone,
    required TResult orElse(),
  }) {
    if (loadAll != null) {
      return loadAll(this);
    }
    return orElse();
  }
}

abstract class _LoadAll implements VideoStepProgressEvent {
  const factory _LoadAll() = _$LoadAllImpl;
}

/// @nodoc
abstract class _$$LoadVideoImplCopyWith<$Res> {
  factory _$$LoadVideoImplCopyWith(
          _$LoadVideoImpl value, $Res Function(_$LoadVideoImpl) then) =
      __$$LoadVideoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String youtubeId});
}

/// @nodoc
class __$$LoadVideoImplCopyWithImpl<$Res>
    extends _$VideoStepProgressEventCopyWithImpl<$Res, _$LoadVideoImpl>
    implements _$$LoadVideoImplCopyWith<$Res> {
  __$$LoadVideoImplCopyWithImpl(
      _$LoadVideoImpl _value, $Res Function(_$LoadVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
  }) {
    return _then(_$LoadVideoImpl(
      null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadVideoImpl implements _LoadVideo {
  const _$LoadVideoImpl(this.youtubeId);

  @override
  final String youtubeId;

  @override
  String toString() {
    return 'VideoStepProgressEvent.loadVideo(youtubeId: $youtubeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadVideoImpl &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, youtubeId);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadVideoImplCopyWith<_$LoadVideoImpl> get copyWith =>
      __$$LoadVideoImplCopyWithImpl<_$LoadVideoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAll,
    required TResult Function(String youtubeId) loadVideo,
    required TResult Function(String youtubeId, VideoLessonStep step)
        markInProgress,
    required TResult Function(String youtubeId, VideoLessonStep step) markDone,
  }) {
    return loadVideo(youtubeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAll,
    TResult? Function(String youtubeId)? loadVideo,
    TResult? Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult? Function(String youtubeId, VideoLessonStep step)? markDone,
  }) {
    return loadVideo?.call(youtubeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAll,
    TResult Function(String youtubeId)? loadVideo,
    TResult Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult Function(String youtubeId, VideoLessonStep step)? markDone,
    required TResult orElse(),
  }) {
    if (loadVideo != null) {
      return loadVideo(youtubeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadAll value) loadAll,
    required TResult Function(_LoadVideo value) loadVideo,
    required TResult Function(_MarkInProgress value) markInProgress,
    required TResult Function(_MarkDone value) markDone,
  }) {
    return loadVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadAll value)? loadAll,
    TResult? Function(_LoadVideo value)? loadVideo,
    TResult? Function(_MarkInProgress value)? markInProgress,
    TResult? Function(_MarkDone value)? markDone,
  }) {
    return loadVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadAll value)? loadAll,
    TResult Function(_LoadVideo value)? loadVideo,
    TResult Function(_MarkInProgress value)? markInProgress,
    TResult Function(_MarkDone value)? markDone,
    required TResult orElse(),
  }) {
    if (loadVideo != null) {
      return loadVideo(this);
    }
    return orElse();
  }
}

abstract class _LoadVideo implements VideoStepProgressEvent {
  const factory _LoadVideo(final String youtubeId) = _$LoadVideoImpl;

  String get youtubeId;

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadVideoImplCopyWith<_$LoadVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkInProgressImplCopyWith<$Res> {
  factory _$$MarkInProgressImplCopyWith(_$MarkInProgressImpl value,
          $Res Function(_$MarkInProgressImpl) then) =
      __$$MarkInProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String youtubeId, VideoLessonStep step});
}

/// @nodoc
class __$$MarkInProgressImplCopyWithImpl<$Res>
    extends _$VideoStepProgressEventCopyWithImpl<$Res, _$MarkInProgressImpl>
    implements _$$MarkInProgressImplCopyWith<$Res> {
  __$$MarkInProgressImplCopyWithImpl(
      _$MarkInProgressImpl _value, $Res Function(_$MarkInProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
    Object? step = null,
  }) {
    return _then(_$MarkInProgressImpl(
      null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as VideoLessonStep,
    ));
  }
}

/// @nodoc

class _$MarkInProgressImpl implements _MarkInProgress {
  const _$MarkInProgressImpl(this.youtubeId, this.step);

  @override
  final String youtubeId;
  @override
  final VideoLessonStep step;

  @override
  String toString() {
    return 'VideoStepProgressEvent.markInProgress(youtubeId: $youtubeId, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkInProgressImpl &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, youtubeId, step);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkInProgressImplCopyWith<_$MarkInProgressImpl> get copyWith =>
      __$$MarkInProgressImplCopyWithImpl<_$MarkInProgressImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAll,
    required TResult Function(String youtubeId) loadVideo,
    required TResult Function(String youtubeId, VideoLessonStep step)
        markInProgress,
    required TResult Function(String youtubeId, VideoLessonStep step) markDone,
  }) {
    return markInProgress(youtubeId, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAll,
    TResult? Function(String youtubeId)? loadVideo,
    TResult? Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult? Function(String youtubeId, VideoLessonStep step)? markDone,
  }) {
    return markInProgress?.call(youtubeId, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAll,
    TResult Function(String youtubeId)? loadVideo,
    TResult Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult Function(String youtubeId, VideoLessonStep step)? markDone,
    required TResult orElse(),
  }) {
    if (markInProgress != null) {
      return markInProgress(youtubeId, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadAll value) loadAll,
    required TResult Function(_LoadVideo value) loadVideo,
    required TResult Function(_MarkInProgress value) markInProgress,
    required TResult Function(_MarkDone value) markDone,
  }) {
    return markInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadAll value)? loadAll,
    TResult? Function(_LoadVideo value)? loadVideo,
    TResult? Function(_MarkInProgress value)? markInProgress,
    TResult? Function(_MarkDone value)? markDone,
  }) {
    return markInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadAll value)? loadAll,
    TResult Function(_LoadVideo value)? loadVideo,
    TResult Function(_MarkInProgress value)? markInProgress,
    TResult Function(_MarkDone value)? markDone,
    required TResult orElse(),
  }) {
    if (markInProgress != null) {
      return markInProgress(this);
    }
    return orElse();
  }
}

abstract class _MarkInProgress implements VideoStepProgressEvent {
  const factory _MarkInProgress(
          final String youtubeId, final VideoLessonStep step) =
      _$MarkInProgressImpl;

  String get youtubeId;
  VideoLessonStep get step;

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkInProgressImplCopyWith<_$MarkInProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MarkDoneImplCopyWith<$Res> {
  factory _$$MarkDoneImplCopyWith(
          _$MarkDoneImpl value, $Res Function(_$MarkDoneImpl) then) =
      __$$MarkDoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String youtubeId, VideoLessonStep step});
}

/// @nodoc
class __$$MarkDoneImplCopyWithImpl<$Res>
    extends _$VideoStepProgressEventCopyWithImpl<$Res, _$MarkDoneImpl>
    implements _$$MarkDoneImplCopyWith<$Res> {
  __$$MarkDoneImplCopyWithImpl(
      _$MarkDoneImpl _value, $Res Function(_$MarkDoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeId = null,
    Object? step = null,
  }) {
    return _then(_$MarkDoneImpl(
      null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as VideoLessonStep,
    ));
  }
}

/// @nodoc

class _$MarkDoneImpl implements _MarkDone {
  const _$MarkDoneImpl(this.youtubeId, this.step);

  @override
  final String youtubeId;
  @override
  final VideoLessonStep step;

  @override
  String toString() {
    return 'VideoStepProgressEvent.markDone(youtubeId: $youtubeId, step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkDoneImpl &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, youtubeId, step);

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkDoneImplCopyWith<_$MarkDoneImpl> get copyWith =>
      __$$MarkDoneImplCopyWithImpl<_$MarkDoneImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadAll,
    required TResult Function(String youtubeId) loadVideo,
    required TResult Function(String youtubeId, VideoLessonStep step)
        markInProgress,
    required TResult Function(String youtubeId, VideoLessonStep step) markDone,
  }) {
    return markDone(youtubeId, step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadAll,
    TResult? Function(String youtubeId)? loadVideo,
    TResult? Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult? Function(String youtubeId, VideoLessonStep step)? markDone,
  }) {
    return markDone?.call(youtubeId, step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadAll,
    TResult Function(String youtubeId)? loadVideo,
    TResult Function(String youtubeId, VideoLessonStep step)? markInProgress,
    TResult Function(String youtubeId, VideoLessonStep step)? markDone,
    required TResult orElse(),
  }) {
    if (markDone != null) {
      return markDone(youtubeId, step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadAll value) loadAll,
    required TResult Function(_LoadVideo value) loadVideo,
    required TResult Function(_MarkInProgress value) markInProgress,
    required TResult Function(_MarkDone value) markDone,
  }) {
    return markDone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadAll value)? loadAll,
    TResult? Function(_LoadVideo value)? loadVideo,
    TResult? Function(_MarkInProgress value)? markInProgress,
    TResult? Function(_MarkDone value)? markDone,
  }) {
    return markDone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadAll value)? loadAll,
    TResult Function(_LoadVideo value)? loadVideo,
    TResult Function(_MarkInProgress value)? markInProgress,
    TResult Function(_MarkDone value)? markDone,
    required TResult orElse(),
  }) {
    if (markDone != null) {
      return markDone(this);
    }
    return orElse();
  }
}

abstract class _MarkDone implements VideoStepProgressEvent {
  const factory _MarkDone(final String youtubeId, final VideoLessonStep step) =
      _$MarkDoneImpl;

  String get youtubeId;
  VideoLessonStep get step;

  /// Create a copy of VideoStepProgressEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkDoneImplCopyWith<_$MarkDoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VideoStepProgressState {
  Map<String, Map<String, VideoStepProgress>> get byVideo =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of VideoStepProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoStepProgressStateCopyWith<VideoStepProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoStepProgressStateCopyWith<$Res> {
  factory $VideoStepProgressStateCopyWith(VideoStepProgressState value,
          $Res Function(VideoStepProgressState) then) =
      _$VideoStepProgressStateCopyWithImpl<$Res, VideoStepProgressState>;
  @useResult
  $Res call(
      {Map<String, Map<String, VideoStepProgress>> byVideo,
      bool isLoading,
      String? error});
}

/// @nodoc
class _$VideoStepProgressStateCopyWithImpl<$Res,
        $Val extends VideoStepProgressState>
    implements $VideoStepProgressStateCopyWith<$Res> {
  _$VideoStepProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoStepProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byVideo = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      byVideo: null == byVideo
          ? _value.byVideo
          : byVideo // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, VideoStepProgress>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoStepProgressStateImplCopyWith<$Res>
    implements $VideoStepProgressStateCopyWith<$Res> {
  factory _$$VideoStepProgressStateImplCopyWith(
          _$VideoStepProgressStateImpl value,
          $Res Function(_$VideoStepProgressStateImpl) then) =
      __$$VideoStepProgressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, Map<String, VideoStepProgress>> byVideo,
      bool isLoading,
      String? error});
}

/// @nodoc
class __$$VideoStepProgressStateImplCopyWithImpl<$Res>
    extends _$VideoStepProgressStateCopyWithImpl<$Res,
        _$VideoStepProgressStateImpl>
    implements _$$VideoStepProgressStateImplCopyWith<$Res> {
  __$$VideoStepProgressStateImplCopyWithImpl(
      _$VideoStepProgressStateImpl _value,
      $Res Function(_$VideoStepProgressStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoStepProgressState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? byVideo = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$VideoStepProgressStateImpl(
      byVideo: null == byVideo
          ? _value._byVideo
          : byVideo // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, VideoStepProgress>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VideoStepProgressStateImpl extends _VideoStepProgressState {
  const _$VideoStepProgressStateImpl(
      {final Map<String, Map<String, VideoStepProgress>> byVideo =
          const <String, Map<String, VideoStepProgress>>{},
      this.isLoading = false,
      this.error})
      : _byVideo = byVideo,
        super._();

  final Map<String, Map<String, VideoStepProgress>> _byVideo;
  @override
  @JsonKey()
  Map<String, Map<String, VideoStepProgress>> get byVideo {
    if (_byVideo is EqualUnmodifiableMapView) return _byVideo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byVideo);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'VideoStepProgressState(byVideo: $byVideo, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoStepProgressStateImpl &&
            const DeepCollectionEquality().equals(other._byVideo, _byVideo) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_byVideo), isLoading, error);

  /// Create a copy of VideoStepProgressState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoStepProgressStateImplCopyWith<_$VideoStepProgressStateImpl>
      get copyWith => __$$VideoStepProgressStateImplCopyWithImpl<
          _$VideoStepProgressStateImpl>(this, _$identity);
}

abstract class _VideoStepProgressState extends VideoStepProgressState {
  const factory _VideoStepProgressState(
      {final Map<String, Map<String, VideoStepProgress>> byVideo,
      final bool isLoading,
      final String? error}) = _$VideoStepProgressStateImpl;
  const _VideoStepProgressState._() : super._();

  @override
  Map<String, Map<String, VideoStepProgress>> get byVideo;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of VideoStepProgressState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoStepProgressStateImplCopyWith<_$VideoStepProgressStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
