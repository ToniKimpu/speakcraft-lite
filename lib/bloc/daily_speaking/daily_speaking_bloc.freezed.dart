// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_speaking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailySpeakingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitVoice,
    required TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitText,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult? Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmitVoice value) submitVoice,
    required TResult Function(_SubmitText value) submitText,
    required TResult Function(_Reset value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmitVoice value)? submitVoice,
    TResult? Function(_SubmitText value)? submitText,
    TResult? Function(_Reset value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmitVoice value)? submitVoice,
    TResult Function(_SubmitText value)? submitText,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingEventCopyWith<$Res> {
  factory $DailySpeakingEventCopyWith(
          DailySpeakingEvent value, $Res Function(DailySpeakingEvent) then) =
      _$DailySpeakingEventCopyWithImpl<$Res, DailySpeakingEvent>;
}

/// @nodoc
class _$DailySpeakingEventCopyWithImpl<$Res, $Val extends DailySpeakingEvent>
    implements $DailySpeakingEventCopyWith<$Res> {
  _$DailySpeakingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SubmitVoiceImplCopyWith<$Res> {
  factory _$$SubmitVoiceImplCopyWith(
          _$SubmitVoiceImpl value, $Res Function(_$SubmitVoiceImpl) then) =
      __$$SubmitVoiceImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String audioPath,
      String onRamp,
      List<String> requestedSections,
      DailySpeakingTopic? topic,
      String? topicAttemptId,
      int revisionNumber});

  $DailySpeakingTopicCopyWith<$Res>? get topic;
}

/// @nodoc
class __$$SubmitVoiceImplCopyWithImpl<$Res>
    extends _$DailySpeakingEventCopyWithImpl<$Res, _$SubmitVoiceImpl>
    implements _$$SubmitVoiceImplCopyWith<$Res> {
  __$$SubmitVoiceImplCopyWithImpl(
      _$SubmitVoiceImpl _value, $Res Function(_$SubmitVoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioPath = null,
    Object? onRamp = null,
    Object? requestedSections = null,
    Object? topic = freezed,
    Object? topicAttemptId = freezed,
    Object? revisionNumber = null,
  }) {
    return _then(_$SubmitVoiceImpl(
      audioPath: null == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
      onRamp: null == onRamp
          ? _value.onRamp
          : onRamp // ignore: cast_nullable_to_non_nullable
              as String,
      requestedSections: null == requestedSections
          ? _value._requestedSections
          : requestedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as DailySpeakingTopic?,
      topicAttemptId: freezed == topicAttemptId
          ? _value.topicAttemptId
          : topicAttemptId // ignore: cast_nullable_to_non_nullable
              as String?,
      revisionNumber: null == revisionNumber
          ? _value.revisionNumber
          : revisionNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailySpeakingTopicCopyWith<$Res>? get topic {
    if (_value.topic == null) {
      return null;
    }

    return $DailySpeakingTopicCopyWith<$Res>(_value.topic!, (value) {
      return _then(_value.copyWith(topic: value));
    });
  }
}

/// @nodoc

class _$SubmitVoiceImpl implements _SubmitVoice {
  const _$SubmitVoiceImpl(
      {required this.audioPath,
      required this.onRamp,
      required final List<String> requestedSections,
      this.topic,
      this.topicAttemptId,
      this.revisionNumber = 1})
      : _requestedSections = requestedSections;

  @override
  final String audioPath;
  @override
  final String onRamp;
  final List<String> _requestedSections;
  @override
  List<String> get requestedSections {
    if (_requestedSections is EqualUnmodifiableListView)
      return _requestedSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requestedSections);
  }

  @override
  final DailySpeakingTopic? topic;
  @override
  final String? topicAttemptId;
  @override
  @JsonKey()
  final int revisionNumber;

  @override
  String toString() {
    return 'DailySpeakingEvent.submitVoice(audioPath: $audioPath, onRamp: $onRamp, requestedSections: $requestedSections, topic: $topic, topicAttemptId: $topicAttemptId, revisionNumber: $revisionNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitVoiceImpl &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.onRamp, onRamp) || other.onRamp == onRamp) &&
            const DeepCollectionEquality()
                .equals(other._requestedSections, _requestedSections) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.topicAttemptId, topicAttemptId) ||
                other.topicAttemptId == topicAttemptId) &&
            (identical(other.revisionNumber, revisionNumber) ||
                other.revisionNumber == revisionNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      audioPath,
      onRamp,
      const DeepCollectionEquality().hash(_requestedSections),
      topic,
      topicAttemptId,
      revisionNumber);

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitVoiceImplCopyWith<_$SubmitVoiceImpl> get copyWith =>
      __$$SubmitVoiceImplCopyWithImpl<_$SubmitVoiceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitVoice,
    required TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitText,
    required TResult Function() reset,
  }) {
    return submitVoice(audioPath, onRamp, requestedSections, topic,
        topicAttemptId, revisionNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult? Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult? Function()? reset,
  }) {
    return submitVoice?.call(audioPath, onRamp, requestedSections, topic,
        topicAttemptId, revisionNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (submitVoice != null) {
      return submitVoice(audioPath, onRamp, requestedSections, topic,
          topicAttemptId, revisionNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmitVoice value) submitVoice,
    required TResult Function(_SubmitText value) submitText,
    required TResult Function(_Reset value) reset,
  }) {
    return submitVoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmitVoice value)? submitVoice,
    TResult? Function(_SubmitText value)? submitText,
    TResult? Function(_Reset value)? reset,
  }) {
    return submitVoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmitVoice value)? submitVoice,
    TResult Function(_SubmitText value)? submitText,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (submitVoice != null) {
      return submitVoice(this);
    }
    return orElse();
  }
}

abstract class _SubmitVoice implements DailySpeakingEvent {
  const factory _SubmitVoice(
      {required final String audioPath,
      required final String onRamp,
      required final List<String> requestedSections,
      final DailySpeakingTopic? topic,
      final String? topicAttemptId,
      final int revisionNumber}) = _$SubmitVoiceImpl;

  String get audioPath;
  String get onRamp;
  List<String> get requestedSections;
  DailySpeakingTopic? get topic;
  String? get topicAttemptId;
  int get revisionNumber;

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitVoiceImplCopyWith<_$SubmitVoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitTextImplCopyWith<$Res> {
  factory _$$SubmitTextImplCopyWith(
          _$SubmitTextImpl value, $Res Function(_$SubmitTextImpl) then) =
      __$$SubmitTextImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String text,
      String onRamp,
      List<String> requestedSections,
      DailySpeakingTopic? topic,
      String? topicAttemptId,
      int revisionNumber});

  $DailySpeakingTopicCopyWith<$Res>? get topic;
}

/// @nodoc
class __$$SubmitTextImplCopyWithImpl<$Res>
    extends _$DailySpeakingEventCopyWithImpl<$Res, _$SubmitTextImpl>
    implements _$$SubmitTextImplCopyWith<$Res> {
  __$$SubmitTextImplCopyWithImpl(
      _$SubmitTextImpl _value, $Res Function(_$SubmitTextImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? onRamp = null,
    Object? requestedSections = null,
    Object? topic = freezed,
    Object? topicAttemptId = freezed,
    Object? revisionNumber = null,
  }) {
    return _then(_$SubmitTextImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      onRamp: null == onRamp
          ? _value.onRamp
          : onRamp // ignore: cast_nullable_to_non_nullable
              as String,
      requestedSections: null == requestedSections
          ? _value._requestedSections
          : requestedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as DailySpeakingTopic?,
      topicAttemptId: freezed == topicAttemptId
          ? _value.topicAttemptId
          : topicAttemptId // ignore: cast_nullable_to_non_nullable
              as String?,
      revisionNumber: null == revisionNumber
          ? _value.revisionNumber
          : revisionNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailySpeakingTopicCopyWith<$Res>? get topic {
    if (_value.topic == null) {
      return null;
    }

    return $DailySpeakingTopicCopyWith<$Res>(_value.topic!, (value) {
      return _then(_value.copyWith(topic: value));
    });
  }
}

/// @nodoc

class _$SubmitTextImpl implements _SubmitText {
  const _$SubmitTextImpl(
      {required this.text,
      required this.onRamp,
      required final List<String> requestedSections,
      this.topic,
      this.topicAttemptId,
      this.revisionNumber = 1})
      : _requestedSections = requestedSections;

  @override
  final String text;
  @override
  final String onRamp;
  final List<String> _requestedSections;
  @override
  List<String> get requestedSections {
    if (_requestedSections is EqualUnmodifiableListView)
      return _requestedSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requestedSections);
  }

  @override
  final DailySpeakingTopic? topic;
  @override
  final String? topicAttemptId;
  @override
  @JsonKey()
  final int revisionNumber;

  @override
  String toString() {
    return 'DailySpeakingEvent.submitText(text: $text, onRamp: $onRamp, requestedSections: $requestedSections, topic: $topic, topicAttemptId: $topicAttemptId, revisionNumber: $revisionNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitTextImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.onRamp, onRamp) || other.onRamp == onRamp) &&
            const DeepCollectionEquality()
                .equals(other._requestedSections, _requestedSections) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.topicAttemptId, topicAttemptId) ||
                other.topicAttemptId == topicAttemptId) &&
            (identical(other.revisionNumber, revisionNumber) ||
                other.revisionNumber == revisionNumber));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      text,
      onRamp,
      const DeepCollectionEquality().hash(_requestedSections),
      topic,
      topicAttemptId,
      revisionNumber);

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitTextImplCopyWith<_$SubmitTextImpl> get copyWith =>
      __$$SubmitTextImplCopyWithImpl<_$SubmitTextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitVoice,
    required TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitText,
    required TResult Function() reset,
  }) {
    return submitText(
        text, onRamp, requestedSections, topic, topicAttemptId, revisionNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult? Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult? Function()? reset,
  }) {
    return submitText?.call(
        text, onRamp, requestedSections, topic, topicAttemptId, revisionNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (submitText != null) {
      return submitText(text, onRamp, requestedSections, topic, topicAttemptId,
          revisionNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmitVoice value) submitVoice,
    required TResult Function(_SubmitText value) submitText,
    required TResult Function(_Reset value) reset,
  }) {
    return submitText(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmitVoice value)? submitVoice,
    TResult? Function(_SubmitText value)? submitText,
    TResult? Function(_Reset value)? reset,
  }) {
    return submitText?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmitVoice value)? submitVoice,
    TResult Function(_SubmitText value)? submitText,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (submitText != null) {
      return submitText(this);
    }
    return orElse();
  }
}

abstract class _SubmitText implements DailySpeakingEvent {
  const factory _SubmitText(
      {required final String text,
      required final String onRamp,
      required final List<String> requestedSections,
      final DailySpeakingTopic? topic,
      final String? topicAttemptId,
      final int revisionNumber}) = _$SubmitTextImpl;

  String get text;
  String get onRamp;
  List<String> get requestedSections;
  DailySpeakingTopic? get topic;
  String? get topicAttemptId;
  int get revisionNumber;

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitTextImplCopyWith<_$SubmitTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
          _$ResetImpl value, $Res Function(_$ResetImpl) then) =
      __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$DailySpeakingEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
      _$ResetImpl _value, $Res Function(_$ResetImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'DailySpeakingEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitVoice,
    required TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)
        submitText,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult? Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String audioPath,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitVoice,
    TResult Function(
            String text,
            String onRamp,
            List<String> requestedSections,
            DailySpeakingTopic? topic,
            String? topicAttemptId,
            int revisionNumber)?
        submitText,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SubmitVoice value) submitVoice,
    required TResult Function(_SubmitText value) submitText,
    required TResult Function(_Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SubmitVoice value)? submitVoice,
    TResult? Function(_SubmitText value)? submitText,
    TResult? Function(_Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SubmitVoice value)? submitVoice,
    TResult Function(_SubmitText value)? submitText,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements DailySpeakingEvent {
  const factory _Reset() = _$ResetImpl;
}

/// @nodoc
mixin _$DailySpeakingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) submitting,
    required TResult Function(DailySpeakingSession session) success,
    required TResult Function() socketError,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? submitting,
    TResult? Function(DailySpeakingSession session)? success,
    TResult? Function()? socketError,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? submitting,
    TResult Function(DailySpeakingSession session)? success,
    TResult Function()? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingStateCopyWith<$Res> {
  factory $DailySpeakingStateCopyWith(
          DailySpeakingState value, $Res Function(DailySpeakingState) then) =
      _$DailySpeakingStateCopyWithImpl<$Res, DailySpeakingState>;
}

/// @nodoc
class _$DailySpeakingStateCopyWithImpl<$Res, $Val extends DailySpeakingState>
    implements $DailySpeakingStateCopyWith<$Res> {
  _$DailySpeakingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$DailySpeakingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'DailySpeakingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) submitting,
    required TResult Function(DailySpeakingSession session) success,
    required TResult Function() socketError,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? submitting,
    TResult? Function(DailySpeakingSession session)? success,
    TResult? Function()? socketError,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? submitting,
    TResult Function(DailySpeakingSession session)? success,
    TResult Function()? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements DailySpeakingState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SubmittingImplCopyWith<$Res> {
  factory _$$SubmittingImplCopyWith(
          _$SubmittingImpl value, $Res Function(_$SubmittingImpl) then) =
      __$$SubmittingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SubmittingImplCopyWithImpl<$Res>
    extends _$DailySpeakingStateCopyWithImpl<$Res, _$SubmittingImpl>
    implements _$$SubmittingImplCopyWith<$Res> {
  __$$SubmittingImplCopyWithImpl(
      _$SubmittingImpl _value, $Res Function(_$SubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SubmittingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SubmittingImpl implements _Submitting {
  const _$SubmittingImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'DailySpeakingState.submitting(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmittingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmittingImplCopyWith<_$SubmittingImpl> get copyWith =>
      __$$SubmittingImplCopyWithImpl<_$SubmittingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) submitting,
    required TResult Function(DailySpeakingSession session) success,
    required TResult Function() socketError,
    required TResult Function(String message) error,
  }) {
    return submitting(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? submitting,
    TResult? Function(DailySpeakingSession session)? success,
    TResult? Function()? socketError,
    TResult? Function(String message)? error,
  }) {
    return submitting?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? submitting,
    TResult Function(DailySpeakingSession session)? success,
    TResult Function()? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class _Submitting implements DailySpeakingState {
  const factory _Submitting({final String? message}) = _$SubmittingImpl;

  String? get message;

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmittingImplCopyWith<_$SubmittingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DailySpeakingSession session});

  $DailySpeakingSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$DailySpeakingStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$SuccessImpl(
      null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as DailySpeakingSession,
    ));
  }

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailySpeakingSessionCopyWith<$Res> get session {
    return $DailySpeakingSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.session);

  @override
  final DailySpeakingSession session;

  @override
  String toString() {
    return 'DailySpeakingState.success(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) submitting,
    required TResult Function(DailySpeakingSession session) success,
    required TResult Function() socketError,
    required TResult Function(String message) error,
  }) {
    return success(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? submitting,
    TResult? Function(DailySpeakingSession session)? success,
    TResult? Function()? socketError,
    TResult? Function(String message)? error,
  }) {
    return success?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? submitting,
    TResult Function(DailySpeakingSession session)? success,
    TResult Function()? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements DailySpeakingState {
  const factory _Success(final DailySpeakingSession session) = _$SuccessImpl;

  DailySpeakingSession get session;

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SocketErrorImplCopyWith<$Res> {
  factory _$$SocketErrorImplCopyWith(
          _$SocketErrorImpl value, $Res Function(_$SocketErrorImpl) then) =
      __$$SocketErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SocketErrorImplCopyWithImpl<$Res>
    extends _$DailySpeakingStateCopyWithImpl<$Res, _$SocketErrorImpl>
    implements _$$SocketErrorImplCopyWith<$Res> {
  __$$SocketErrorImplCopyWithImpl(
      _$SocketErrorImpl _value, $Res Function(_$SocketErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SocketErrorImpl implements _SocketError {
  const _$SocketErrorImpl();

  @override
  String toString() {
    return 'DailySpeakingState.socketError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SocketErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) submitting,
    required TResult Function(DailySpeakingSession session) success,
    required TResult Function() socketError,
    required TResult Function(String message) error,
  }) {
    return socketError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? submitting,
    TResult? Function(DailySpeakingSession session)? success,
    TResult? Function()? socketError,
    TResult? Function(String message)? error,
  }) {
    return socketError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? submitting,
    TResult Function(DailySpeakingSession session)? success,
    TResult Function()? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (socketError != null) {
      return socketError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return socketError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return socketError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (socketError != null) {
      return socketError(this);
    }
    return orElse();
  }
}

abstract class _SocketError implements DailySpeakingState {
  const factory _SocketError() = _$SocketErrorImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$DailySpeakingStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'DailySpeakingState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) submitting,
    required TResult Function(DailySpeakingSession session) success,
    required TResult Function() socketError,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? submitting,
    TResult? Function(DailySpeakingSession session)? success,
    TResult? Function()? socketError,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? submitting,
    TResult Function(DailySpeakingSession session)? success,
    TResult Function()? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Success value) success,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Success value)? success,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Success value)? success,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DailySpeakingState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of DailySpeakingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
