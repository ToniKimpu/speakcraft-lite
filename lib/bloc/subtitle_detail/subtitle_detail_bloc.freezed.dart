// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubtitleEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitleEventCopyWith<$Res> {
  factory $SubtitleEventCopyWith(
          SubtitleEvent value, $Res Function(SubtitleEvent) then) =
      _$SubtitleEventCopyWithImpl<$Res, SubtitleEvent>;
}

/// @nodoc
class _$SubtitleEventCopyWithImpl<$Res, $Val extends SubtitleEvent>
    implements $SubtitleEventCopyWith<$Res> {
  _$SubtitleEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ParseSubtitleLineImplCopyWith<$Res> {
  factory _$$ParseSubtitleLineImplCopyWith(_$ParseSubtitleLineImpl value,
          $Res Function(_$ParseSubtitleLineImpl) then) =
      __$$ParseSubtitleLineImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$ParseSubtitleLineImplCopyWithImpl<$Res>
    extends _$SubtitleEventCopyWithImpl<$Res, _$ParseSubtitleLineImpl>
    implements _$$ParseSubtitleLineImplCopyWith<$Res> {
  __$$ParseSubtitleLineImplCopyWithImpl(_$ParseSubtitleLineImpl _value,
      $Res Function(_$ParseSubtitleLineImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$ParseSubtitleLineImpl(
      null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ParseSubtitleLineImpl
    with DiagnosticableTreeMixin
    implements _ParseSubtitleLine {
  const _$ParseSubtitleLineImpl(this.url);

  @override
  final String url;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.parseSubtitleLine(url: $url)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.parseSubtitleLine'))
      ..add(DiagnosticsProperty('url', url));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseSubtitleLineImpl &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ParseSubtitleLineImplCopyWith<_$ParseSubtitleLineImpl> get copyWith =>
      __$$ParseSubtitleLineImplCopyWithImpl<_$ParseSubtitleLineImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseSubtitleLine(url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseSubtitleLine?.call(url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseSubtitleLine != null) {
      return parseSubtitleLine(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseSubtitleLine(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseSubtitleLine?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseSubtitleLine != null) {
      return parseSubtitleLine(this);
    }
    return orElse();
  }
}

abstract class _ParseSubtitleLine implements SubtitleEvent {
  const factory _ParseSubtitleLine(final String url) = _$ParseSubtitleLineImpl;

  String get url;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  _$$ParseSubtitleLineImplCopyWith<_$ParseSubtitleLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParseSubtitleImplCopyWith<$Res> {
  factory _$$ParseSubtitleImplCopyWith(
          _$ParseSubtitleImpl value, $Res Function(_$ParseSubtitleImpl) then) =
      __$$ParseSubtitleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Listening listening});

  $ListeningCopyWith<$Res> get listening;
}

/// @nodoc
class __$$ParseSubtitleImplCopyWithImpl<$Res>
    extends _$SubtitleEventCopyWithImpl<$Res, _$ParseSubtitleImpl>
    implements _$$ParseSubtitleImplCopyWith<$Res> {
  __$$ParseSubtitleImplCopyWithImpl(
      _$ParseSubtitleImpl _value, $Res Function(_$ParseSubtitleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listening = null,
  }) {
    return _then(_$ParseSubtitleImpl(
      null == listening
          ? _value.listening
          : listening // ignore: cast_nullable_to_non_nullable
              as Listening,
    ));
  }

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ListeningCopyWith<$Res> get listening {
    return $ListeningCopyWith<$Res>(_value.listening, (value) {
      return _then(_value.copyWith(listening: value));
    });
  }
}

/// @nodoc

class _$ParseSubtitleImpl
    with DiagnosticableTreeMixin
    implements _ParseSubtitle {
  const _$ParseSubtitleImpl(this.listening);

  @override
  final Listening listening;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.parseSubtitle(listening: $listening)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.parseSubtitle'))
      ..add(DiagnosticsProperty('listening', listening));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseSubtitleImpl &&
            (identical(other.listening, listening) ||
                other.listening == listening));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listening);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ParseSubtitleImplCopyWith<_$ParseSubtitleImpl> get copyWith =>
      __$$ParseSubtitleImplCopyWithImpl<_$ParseSubtitleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseSubtitle(listening);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseSubtitle?.call(listening);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseSubtitle != null) {
      return parseSubtitle(listening);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseSubtitle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseSubtitle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseSubtitle != null) {
      return parseSubtitle(this);
    }
    return orElse();
  }
}

abstract class _ParseSubtitle implements SubtitleEvent {
  const factory _ParseSubtitle(final Listening listening) = _$ParseSubtitleImpl;

  Listening get listening;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  _$$ParseSubtitleImplCopyWith<_$ParseSubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParseRecordSubtitleImplCopyWith<$Res> {
  factory _$$ParseRecordSubtitleImplCopyWith(_$ParseRecordSubtitleImpl value,
          $Res Function(_$ParseRecordSubtitleImpl) then) =
      __$$ParseRecordSubtitleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Listening listening});

  $ListeningCopyWith<$Res> get listening;
}

/// @nodoc
class __$$ParseRecordSubtitleImplCopyWithImpl<$Res>
    extends _$SubtitleEventCopyWithImpl<$Res, _$ParseRecordSubtitleImpl>
    implements _$$ParseRecordSubtitleImplCopyWith<$Res> {
  __$$ParseRecordSubtitleImplCopyWithImpl(_$ParseRecordSubtitleImpl _value,
      $Res Function(_$ParseRecordSubtitleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listening = null,
  }) {
    return _then(_$ParseRecordSubtitleImpl(
      null == listening
          ? _value.listening
          : listening // ignore: cast_nullable_to_non_nullable
              as Listening,
    ));
  }

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ListeningCopyWith<$Res> get listening {
    return $ListeningCopyWith<$Res>(_value.listening, (value) {
      return _then(_value.copyWith(listening: value));
    });
  }
}

/// @nodoc

class _$ParseRecordSubtitleImpl
    with DiagnosticableTreeMixin
    implements _ParseRecordSubtitle {
  const _$ParseRecordSubtitleImpl(this.listening);

  @override
  final Listening listening;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.parseRecordSubtitle(listening: $listening)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.parseRecordSubtitle'))
      ..add(DiagnosticsProperty('listening', listening));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseRecordSubtitleImpl &&
            (identical(other.listening, listening) ||
                other.listening == listening));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listening);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ParseRecordSubtitleImplCopyWith<_$ParseRecordSubtitleImpl> get copyWith =>
      __$$ParseRecordSubtitleImplCopyWithImpl<_$ParseRecordSubtitleImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseRecordSubtitle(listening);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseRecordSubtitle?.call(listening);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseRecordSubtitle != null) {
      return parseRecordSubtitle(listening);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseRecordSubtitle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseRecordSubtitle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseRecordSubtitle != null) {
      return parseRecordSubtitle(this);
    }
    return orElse();
  }
}

abstract class _ParseRecordSubtitle implements SubtitleEvent {
  const factory _ParseRecordSubtitle(final Listening listening) =
      _$ParseRecordSubtitleImpl;

  Listening get listening;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  _$$ParseRecordSubtitleImplCopyWith<_$ParseRecordSubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParseListeningQuestionImplCopyWith<$Res> {
  factory _$$ParseListeningQuestionImplCopyWith(
          _$ParseListeningQuestionImpl value,
          $Res Function(_$ParseListeningQuestionImpl) then) =
      __$$ParseListeningQuestionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Listening listening});

  $ListeningCopyWith<$Res> get listening;
}

/// @nodoc
class __$$ParseListeningQuestionImplCopyWithImpl<$Res>
    extends _$SubtitleEventCopyWithImpl<$Res, _$ParseListeningQuestionImpl>
    implements _$$ParseListeningQuestionImplCopyWith<$Res> {
  __$$ParseListeningQuestionImplCopyWithImpl(
      _$ParseListeningQuestionImpl _value,
      $Res Function(_$ParseListeningQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listening = null,
  }) {
    return _then(_$ParseListeningQuestionImpl(
      null == listening
          ? _value.listening
          : listening // ignore: cast_nullable_to_non_nullable
              as Listening,
    ));
  }

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ListeningCopyWith<$Res> get listening {
    return $ListeningCopyWith<$Res>(_value.listening, (value) {
      return _then(_value.copyWith(listening: value));
    });
  }
}

/// @nodoc

class _$ParseListeningQuestionImpl
    with DiagnosticableTreeMixin
    implements _ParseListeningQuestion {
  const _$ParseListeningQuestionImpl(this.listening);

  @override
  final Listening listening;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.parseListeningQuestion(listening: $listening)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.parseListeningQuestion'))
      ..add(DiagnosticsProperty('listening', listening));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseListeningQuestionImpl &&
            (identical(other.listening, listening) ||
                other.listening == listening));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listening);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ParseListeningQuestionImplCopyWith<_$ParseListeningQuestionImpl>
      get copyWith => __$$ParseListeningQuestionImplCopyWithImpl<
          _$ParseListeningQuestionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseListeningQuestion(listening);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseListeningQuestion?.call(listening);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseListeningQuestion != null) {
      return parseListeningQuestion(listening);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseListeningQuestion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseListeningQuestion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseListeningQuestion != null) {
      return parseListeningQuestion(this);
    }
    return orElse();
  }
}

abstract class _ParseListeningQuestion implements SubtitleEvent {
  const factory _ParseListeningQuestion(final Listening listening) =
      _$ParseListeningQuestionImpl;

  Listening get listening;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  _$$ParseListeningQuestionImplCopyWith<_$ParseListeningQuestionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ParseCompleteImplCopyWith<$Res> {
  factory _$$ParseCompleteImplCopyWith(
          _$ParseCompleteImpl value, $Res Function(_$ParseCompleteImpl) then) =
      __$$ParseCompleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Subtitle> subtitles});
}

/// @nodoc
class __$$ParseCompleteImplCopyWithImpl<$Res>
    extends _$SubtitleEventCopyWithImpl<$Res, _$ParseCompleteImpl>
    implements _$$ParseCompleteImplCopyWith<$Res> {
  __$$ParseCompleteImplCopyWithImpl(
      _$ParseCompleteImpl _value, $Res Function(_$ParseCompleteImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitles = null,
  }) {
    return _then(_$ParseCompleteImpl(
      null == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<Subtitle>,
    ));
  }
}

/// @nodoc

class _$ParseCompleteImpl
    with DiagnosticableTreeMixin
    implements _ParseComplete {
  const _$ParseCompleteImpl(final List<Subtitle> subtitles)
      : _subtitles = subtitles;

  final List<Subtitle> _subtitles;
  @override
  List<Subtitle> get subtitles {
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitles);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.parseComplete(subtitles: $subtitles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.parseComplete'))
      ..add(DiagnosticsProperty('subtitles', subtitles));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseCompleteImpl &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_subtitles));

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ParseCompleteImplCopyWith<_$ParseCompleteImpl> get copyWith =>
      __$$ParseCompleteImplCopyWithImpl<_$ParseCompleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseComplete(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseComplete?.call(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseComplete != null) {
      return parseComplete(subtitles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseComplete != null) {
      return parseComplete(this);
    }
    return orElse();
  }
}

abstract class _ParseComplete implements SubtitleEvent {
  const factory _ParseComplete(final List<Subtitle> subtitles) =
      _$ParseCompleteImpl;

  List<Subtitle> get subtitles;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  _$$ParseCompleteImplCopyWith<_$ParseCompleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCurrentPageIndexImplCopyWith<$Res> {
  factory _$$SetCurrentPageIndexImplCopyWith(_$SetCurrentPageIndexImpl value,
          $Res Function(_$SetCurrentPageIndexImpl) then) =
      __$$SetCurrentPageIndexImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$SetCurrentPageIndexImplCopyWithImpl<$Res>
    extends _$SubtitleEventCopyWithImpl<$Res, _$SetCurrentPageIndexImpl>
    implements _$$SetCurrentPageIndexImplCopyWith<$Res> {
  __$$SetCurrentPageIndexImplCopyWithImpl(_$SetCurrentPageIndexImpl _value,
      $Res Function(_$SetCurrentPageIndexImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$SetCurrentPageIndexImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SetCurrentPageIndexImpl
    with DiagnosticableTreeMixin
    implements _SetCurrentPageIndex {
  const _$SetCurrentPageIndexImpl(this.index);

  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.setCurrentPageIndex(index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.setCurrentPageIndex'))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCurrentPageIndexImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentPageIndexImplCopyWith<_$SetCurrentPageIndexImpl> get copyWith =>
      __$$SetCurrentPageIndexImplCopyWithImpl<_$SetCurrentPageIndexImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String url) parseSubtitleLine,
    required TResult Function(Listening listening) parseSubtitle,
    required TResult Function(Listening listening) parseRecordSubtitle,
    required TResult Function(Listening listening) parseListeningQuestion,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return setCurrentPageIndex(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String url)? parseSubtitleLine,
    TResult? Function(Listening listening)? parseSubtitle,
    TResult? Function(Listening listening)? parseRecordSubtitle,
    TResult? Function(Listening listening)? parseListeningQuestion,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return setCurrentPageIndex?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String url)? parseSubtitleLine,
    TResult Function(Listening listening)? parseSubtitle,
    TResult Function(Listening listening)? parseRecordSubtitle,
    TResult Function(Listening listening)? parseListeningQuestion,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (setCurrentPageIndex != null) {
      return setCurrentPageIndex(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitleLine value) parseSubtitleLine,
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseRecordSubtitle value) parseRecordSubtitle,
    required TResult Function(_ParseListeningQuestion value)
        parseListeningQuestion,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return setCurrentPageIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult? Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return setCurrentPageIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitleLine value)? parseSubtitleLine,
    TResult Function(_ParseSubtitle value)? parseSubtitle,
    TResult Function(_ParseRecordSubtitle value)? parseRecordSubtitle,
    TResult Function(_ParseListeningQuestion value)? parseListeningQuestion,
    TResult Function(_ParseComplete value)? parseComplete,
    TResult Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (setCurrentPageIndex != null) {
      return setCurrentPageIndex(this);
    }
    return orElse();
  }
}

abstract class _SetCurrentPageIndex implements SubtitleEvent {
  const factory _SetCurrentPageIndex(final int index) =
      _$SetCurrentPageIndexImpl;

  int get index;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  _$$SetCurrentPageIndexImplCopyWith<_$SetCurrentPageIndexImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SubtitleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitleStateCopyWith<$Res> {
  factory $SubtitleStateCopyWith(
          SubtitleState value, $Res Function(SubtitleState) then) =
      _$SubtitleStateCopyWithImpl<$Res, SubtitleState>;
}

/// @nodoc
class _$SubtitleStateCopyWithImpl<$Res, $Val extends SubtitleState>
    implements $SubtitleStateCopyWith<$Res> {
  _$SubtitleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtitleState
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
    extends _$SubtitleStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'SubtitleState.initial'));
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
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SubtitleState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LoadingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl({this.message});

  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.loading(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleState.loading'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SubtitleState {
  const factory _Loading({final String? message}) = _$LoadingImpl;

  String? get message;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnParsingSubtitleImplCopyWith<$Res> {
  factory _$$OnParsingSubtitleImplCopyWith(_$OnParsingSubtitleImpl value,
          $Res Function(_$OnParsingSubtitleImpl) then) =
      __$$OnParsingSubtitleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Subtitle> subtitles});
}

/// @nodoc
class __$$OnParsingSubtitleImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res, _$OnParsingSubtitleImpl>
    implements _$$OnParsingSubtitleImplCopyWith<$Res> {
  __$$OnParsingSubtitleImplCopyWithImpl(_$OnParsingSubtitleImpl _value,
      $Res Function(_$OnParsingSubtitleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitles = null,
  }) {
    return _then(_$OnParsingSubtitleImpl(
      null == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<Subtitle>,
    ));
  }
}

/// @nodoc

class _$OnParsingSubtitleImpl
    with DiagnosticableTreeMixin
    implements _OnParsingSubtitle {
  const _$OnParsingSubtitleImpl(final List<Subtitle> subtitles)
      : _subtitles = subtitles;

  final List<Subtitle> _subtitles;
  @override
  List<Subtitle> get subtitles {
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitles);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.onParsingSubtitle(subtitles: $subtitles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleState.onParsingSubtitle'))
      ..add(DiagnosticsProperty('subtitles', subtitles));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnParsingSubtitleImpl &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_subtitles));

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$OnParsingSubtitleImplCopyWith<_$OnParsingSubtitleImpl> get copyWith =>
      __$$OnParsingSubtitleImplCopyWithImpl<_$OnParsingSubtitleImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return onParsingSubtitle(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return onParsingSubtitle?.call(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onParsingSubtitle != null) {
      return onParsingSubtitle(subtitles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return onParsingSubtitle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return onParsingSubtitle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onParsingSubtitle != null) {
      return onParsingSubtitle(this);
    }
    return orElse();
  }
}

abstract class _OnParsingSubtitle implements SubtitleState {
  const factory _OnParsingSubtitle(final List<Subtitle> subtitles) =
      _$OnParsingSubtitleImpl;

  List<Subtitle> get subtitles;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$OnParsingSubtitleImplCopyWith<_$OnParsingSubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnParseListeningQuestionCompletedImplCopyWith<$Res> {
  factory _$$OnParseListeningQuestionCompletedImplCopyWith(
          _$OnParseListeningQuestionCompletedImpl value,
          $Res Function(_$OnParseListeningQuestionCompletedImpl) then) =
      __$$OnParseListeningQuestionCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ListeningQuestion> listeningQuestions,
      List<ListeningPracticeAnswer> userAnswers});
}

/// @nodoc
class __$$OnParseListeningQuestionCompletedImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res,
        _$OnParseListeningQuestionCompletedImpl>
    implements _$$OnParseListeningQuestionCompletedImplCopyWith<$Res> {
  __$$OnParseListeningQuestionCompletedImplCopyWithImpl(
      _$OnParseListeningQuestionCompletedImpl _value,
      $Res Function(_$OnParseListeningQuestionCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listeningQuestions = null,
    Object? userAnswers = null,
  }) {
    return _then(_$OnParseListeningQuestionCompletedImpl(
      null == listeningQuestions
          ? _value._listeningQuestions
          : listeningQuestions // ignore: cast_nullable_to_non_nullable
              as List<ListeningQuestion>,
      null == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<ListeningPracticeAnswer>,
    ));
  }
}

/// @nodoc

class _$OnParseListeningQuestionCompletedImpl
    with DiagnosticableTreeMixin
    implements _OnParseListeningQuestionCompleted {
  const _$OnParseListeningQuestionCompletedImpl(
      final List<ListeningQuestion> listeningQuestions,
      final List<ListeningPracticeAnswer> userAnswers)
      : _listeningQuestions = listeningQuestions,
        _userAnswers = userAnswers;

  final List<ListeningQuestion> _listeningQuestions;
  @override
  List<ListeningQuestion> get listeningQuestions {
    if (_listeningQuestions is EqualUnmodifiableListView)
      return _listeningQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listeningQuestions);
  }

  final List<ListeningPracticeAnswer> _userAnswers;
  @override
  List<ListeningPracticeAnswer> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.onParseListeningQuestionCompleted(listeningQuestions: $listeningQuestions, userAnswers: $userAnswers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'SubtitleState.onParseListeningQuestionCompleted'))
      ..add(DiagnosticsProperty('listeningQuestions', listeningQuestions))
      ..add(DiagnosticsProperty('userAnswers', userAnswers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnParseListeningQuestionCompletedImpl &&
            const DeepCollectionEquality()
                .equals(other._listeningQuestions, _listeningQuestions) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_listeningQuestions),
      const DeepCollectionEquality().hash(_userAnswers));

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$OnParseListeningQuestionCompletedImplCopyWith<
          _$OnParseListeningQuestionCompletedImpl>
      get copyWith => __$$OnParseListeningQuestionCompletedImplCopyWithImpl<
          _$OnParseListeningQuestionCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return onParseListeningQuestionCompleted(listeningQuestions, userAnswers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return onParseListeningQuestionCompleted?.call(
        listeningQuestions, userAnswers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onParseListeningQuestionCompleted != null) {
      return onParseListeningQuestionCompleted(listeningQuestions, userAnswers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return onParseListeningQuestionCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return onParseListeningQuestionCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onParseListeningQuestionCompleted != null) {
      return onParseListeningQuestionCompleted(this);
    }
    return orElse();
  }
}

abstract class _OnParseListeningQuestionCompleted implements SubtitleState {
  const factory _OnParseListeningQuestionCompleted(
          final List<ListeningQuestion> listeningQuestions,
          final List<ListeningPracticeAnswer> userAnswers) =
      _$OnParseListeningQuestionCompletedImpl;

  List<ListeningQuestion> get listeningQuestions;
  List<ListeningPracticeAnswer> get userAnswers;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$OnParseListeningQuestionCompletedImplCopyWith<
          _$OnParseListeningQuestionCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnParseCompletedImplCopyWith<$Res> {
  factory _$$OnParseCompletedImplCopyWith(_$OnParseCompletedImpl value,
          $Res Function(_$OnParseCompletedImpl) then) =
      __$$OnParseCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Subtitle> subtitles});
}

/// @nodoc
class __$$OnParseCompletedImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res, _$OnParseCompletedImpl>
    implements _$$OnParseCompletedImplCopyWith<$Res> {
  __$$OnParseCompletedImplCopyWithImpl(_$OnParseCompletedImpl _value,
      $Res Function(_$OnParseCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitles = null,
  }) {
    return _then(_$OnParseCompletedImpl(
      null == subtitles
          ? _value._subtitles
          : subtitles // ignore: cast_nullable_to_non_nullable
              as List<Subtitle>,
    ));
  }
}

/// @nodoc

class _$OnParseCompletedImpl
    with DiagnosticableTreeMixin
    implements _OnParseCompleted {
  const _$OnParseCompletedImpl(final List<Subtitle> subtitles)
      : _subtitles = subtitles;

  final List<Subtitle> _subtitles;
  @override
  List<Subtitle> get subtitles {
    if (_subtitles is EqualUnmodifiableListView) return _subtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitles);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.onParseCompleted(subtitles: $subtitles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleState.onParseCompleted'))
      ..add(DiagnosticsProperty('subtitles', subtitles));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnParseCompletedImpl &&
            const DeepCollectionEquality()
                .equals(other._subtitles, _subtitles));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_subtitles));

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$OnParseCompletedImplCopyWith<_$OnParseCompletedImpl> get copyWith =>
      __$$OnParseCompletedImplCopyWithImpl<_$OnParseCompletedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return onParseCompleted(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return onParseCompleted?.call(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onParseCompleted != null) {
      return onParseCompleted(subtitles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return onParseCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return onParseCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onParseCompleted != null) {
      return onParseCompleted(this);
    }
    return orElse();
  }
}

abstract class _OnParseCompleted implements SubtitleState {
  const factory _OnParseCompleted(final List<Subtitle> subtitles) =
      _$OnParseCompletedImpl;

  List<Subtitle> get subtitles;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$OnParseCompletedImplCopyWith<_$OnParseCompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnRecordSubtitleCompletedImplCopyWith<$Res> {
  factory _$$OnRecordSubtitleCompletedImplCopyWith(
          _$OnRecordSubtitleCompletedImpl value,
          $Res Function(_$OnRecordSubtitleCompletedImpl) then) =
      __$$OnRecordSubtitleCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RecordSubtitle> recordSubtitles});
}

/// @nodoc
class __$$OnRecordSubtitleCompletedImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res, _$OnRecordSubtitleCompletedImpl>
    implements _$$OnRecordSubtitleCompletedImplCopyWith<$Res> {
  __$$OnRecordSubtitleCompletedImplCopyWithImpl(
      _$OnRecordSubtitleCompletedImpl _value,
      $Res Function(_$OnRecordSubtitleCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordSubtitles = null,
  }) {
    return _then(_$OnRecordSubtitleCompletedImpl(
      null == recordSubtitles
          ? _value._recordSubtitles
          : recordSubtitles // ignore: cast_nullable_to_non_nullable
              as List<RecordSubtitle>,
    ));
  }
}

/// @nodoc

class _$OnRecordSubtitleCompletedImpl
    with DiagnosticableTreeMixin
    implements _OnRecordSubtitleCompleted {
  const _$OnRecordSubtitleCompletedImpl(
      final List<RecordSubtitle> recordSubtitles)
      : _recordSubtitles = recordSubtitles;

  final List<RecordSubtitle> _recordSubtitles;
  @override
  List<RecordSubtitle> get recordSubtitles {
    if (_recordSubtitles is EqualUnmodifiableListView) return _recordSubtitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recordSubtitles);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.onRecordSubtitleCompleted(recordSubtitles: $recordSubtitles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'SubtitleState.onRecordSubtitleCompleted'))
      ..add(DiagnosticsProperty('recordSubtitles', recordSubtitles));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnRecordSubtitleCompletedImpl &&
            const DeepCollectionEquality()
                .equals(other._recordSubtitles, _recordSubtitles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_recordSubtitles));

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$OnRecordSubtitleCompletedImplCopyWith<_$OnRecordSubtitleCompletedImpl>
      get copyWith => __$$OnRecordSubtitleCompletedImplCopyWithImpl<
          _$OnRecordSubtitleCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return onRecordSubtitleCompleted(recordSubtitles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return onRecordSubtitleCompleted?.call(recordSubtitles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onRecordSubtitleCompleted != null) {
      return onRecordSubtitleCompleted(recordSubtitles);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return onRecordSubtitleCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return onRecordSubtitleCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onRecordSubtitleCompleted != null) {
      return onRecordSubtitleCompleted(this);
    }
    return orElse();
  }
}

abstract class _OnRecordSubtitleCompleted implements SubtitleState {
  const factory _OnRecordSubtitleCompleted(
          final List<RecordSubtitle> recordSubtitles) =
      _$OnRecordSubtitleCompletedImpl;

  List<RecordSubtitle> get recordSubtitles;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$OnRecordSubtitleCompletedImplCopyWith<_$OnRecordSubtitleCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnParseSubtitleLineCompletedImplCopyWith<$Res> {
  factory _$$OnParseSubtitleLineCompletedImplCopyWith(
          _$OnParseSubtitleLineCompletedImpl value,
          $Res Function(_$OnParseSubtitleLineCompletedImpl) then) =
      __$$OnParseSubtitleLineCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<SubtitleLine> subtitleLines});
}

/// @nodoc
class __$$OnParseSubtitleLineCompletedImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res,
        _$OnParseSubtitleLineCompletedImpl>
    implements _$$OnParseSubtitleLineCompletedImplCopyWith<$Res> {
  __$$OnParseSubtitleLineCompletedImplCopyWithImpl(
      _$OnParseSubtitleLineCompletedImpl _value,
      $Res Function(_$OnParseSubtitleLineCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitleLines = null,
  }) {
    return _then(_$OnParseSubtitleLineCompletedImpl(
      null == subtitleLines
          ? _value._subtitleLines
          : subtitleLines // ignore: cast_nullable_to_non_nullable
              as List<SubtitleLine>,
    ));
  }
}

/// @nodoc

class _$OnParseSubtitleLineCompletedImpl
    with DiagnosticableTreeMixin
    implements _OnParseSubtitleLineCompleted {
  const _$OnParseSubtitleLineCompletedImpl(
      final List<SubtitleLine> subtitleLines)
      : _subtitleLines = subtitleLines;

  final List<SubtitleLine> _subtitleLines;
  @override
  List<SubtitleLine> get subtitleLines {
    if (_subtitleLines is EqualUnmodifiableListView) return _subtitleLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subtitleLines);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.onParseSubtitleLineCompleted(subtitleLines: $subtitleLines)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'SubtitleState.onParseSubtitleLineCompleted'))
      ..add(DiagnosticsProperty('subtitleLines', subtitleLines));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnParseSubtitleLineCompletedImpl &&
            const DeepCollectionEquality()
                .equals(other._subtitleLines, _subtitleLines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_subtitleLines));

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$OnParseSubtitleLineCompletedImplCopyWith<
          _$OnParseSubtitleLineCompletedImpl>
      get copyWith => __$$OnParseSubtitleLineCompletedImplCopyWithImpl<
          _$OnParseSubtitleLineCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return onParseSubtitleLineCompleted(subtitleLines);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return onParseSubtitleLineCompleted?.call(subtitleLines);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onParseSubtitleLineCompleted != null) {
      return onParseSubtitleLineCompleted(subtitleLines);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return onParseSubtitleLineCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return onParseSubtitleLineCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onParseSubtitleLineCompleted != null) {
      return onParseSubtitleLineCompleted(this);
    }
    return orElse();
  }
}

abstract class _OnParseSubtitleLineCompleted implements SubtitleState {
  const factory _OnParseSubtitleLineCompleted(
          final List<SubtitleLine> subtitleLines) =
      _$OnParseSubtitleLineCompletedImpl;

  List<SubtitleLine> get subtitleLines;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$OnParseSubtitleLineCompletedImplCopyWith<
          _$OnParseSubtitleLineCompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnPageChangedImplCopyWith<$Res> {
  factory _$$OnPageChangedImplCopyWith(
          _$OnPageChangedImpl value, $Res Function(_$OnPageChangedImpl) then) =
      __$$OnPageChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$OnPageChangedImplCopyWithImpl<$Res>
    extends _$SubtitleStateCopyWithImpl<$Res, _$OnPageChangedImpl>
    implements _$$OnPageChangedImplCopyWith<$Res> {
  __$$OnPageChangedImplCopyWithImpl(
      _$OnPageChangedImpl _value, $Res Function(_$OnPageChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$OnPageChangedImpl(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OnPageChangedImpl
    with DiagnosticableTreeMixin
    implements OnPageChanged {
  const _$OnPageChangedImpl(this.index);

  @override
  final int index;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.onPageChanged(index: $index)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleState.onPageChanged'))
      ..add(DiagnosticsProperty('index', index));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnPageChangedImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$OnPageChangedImplCopyWith<_$OnPageChangedImpl> get copyWith =>
      __$$OnPageChangedImplCopyWithImpl<_$OnPageChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return onPageChanged(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return onPageChanged?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onPageChanged != null) {
      return onPageChanged(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return onPageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return onPageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onPageChanged != null) {
      return onPageChanged(this);
    }
    return orElse();
  }
}

abstract class OnPageChanged implements SubtitleState {
  const factory OnPageChanged(final int index) = _$OnPageChangedImpl;

  int get index;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$OnPageChangedImplCopyWith<_$OnPageChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$SubtitleStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleState
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

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleState.error'))
      ..add(DiagnosticsProperty('message', message));
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

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(List<Subtitle> subtitles) onParsingSubtitle,
    required TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)
        onParseListeningQuestionCompleted,
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(List<RecordSubtitle> recordSubtitles)
        onRecordSubtitleCompleted,
    required TResult Function(List<SubtitleLine> subtitleLines)
        onParseSubtitleLineCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult? Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<ListeningQuestion> listeningQuestions,
            List<ListeningPracticeAnswer> userAnswers)?
        onParseListeningQuestionCompleted,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult Function(List<RecordSubtitle> recordSubtitles)?
        onRecordSubtitleCompleted,
    TResult Function(List<SubtitleLine> subtitleLines)?
        onParseSubtitleLineCompleted,
    TResult Function(int index)? onPageChanged,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnParsingSubtitle value) onParsingSubtitle,
    required TResult Function(_OnParseListeningQuestionCompleted value)
        onParseListeningQuestionCompleted,
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(_OnRecordSubtitleCompleted value)
        onRecordSubtitleCompleted,
    required TResult Function(_OnParseSubtitleLineCompleted value)
        onParseSubtitleLineCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult? Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseListeningQuestionCompleted value)?
        onParseListeningQuestionCompleted,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
    TResult Function(_OnRecordSubtitleCompleted value)?
        onRecordSubtitleCompleted,
    TResult Function(_OnParseSubtitleLineCompleted value)?
        onParseSubtitleLineCompleted,
    TResult Function(OnPageChanged value)? onPageChanged,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SubtitleState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of SubtitleState
  /// with the given fields replaced by the non-null parameter values.
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
