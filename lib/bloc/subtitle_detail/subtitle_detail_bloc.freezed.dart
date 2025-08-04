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
    required TResult Function(String subtitlePath) parseSubtitle,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String subtitlePath)? parseSubtitle,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String subtitlePath)? parseSubtitle,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitle value)? parseSubtitle,
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
abstract class _$$ParseSubtitleImplCopyWith<$Res> {
  factory _$$ParseSubtitleImplCopyWith(
          _$ParseSubtitleImpl value, $Res Function(_$ParseSubtitleImpl) then) =
      __$$ParseSubtitleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String subtitlePath});
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
    Object? subtitlePath = null,
  }) {
    return _then(_$ParseSubtitleImpl(
      null == subtitlePath
          ? _value.subtitlePath
          : subtitlePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ParseSubtitleImpl
    with DiagnosticableTreeMixin
    implements _ParseSubtitle {
  const _$ParseSubtitleImpl(this.subtitlePath);

  @override
  final String subtitlePath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SubtitleEvent.parseSubtitle(subtitlePath: $subtitlePath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SubtitleEvent.parseSubtitle'))
      ..add(DiagnosticsProperty('subtitlePath', subtitlePath));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParseSubtitleImpl &&
            (identical(other.subtitlePath, subtitlePath) ||
                other.subtitlePath == subtitlePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, subtitlePath);

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParseSubtitleImplCopyWith<_$ParseSubtitleImpl> get copyWith =>
      __$$ParseSubtitleImplCopyWithImpl<_$ParseSubtitleImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String subtitlePath) parseSubtitle,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseSubtitle(subtitlePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String subtitlePath)? parseSubtitle,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseSubtitle?.call(subtitlePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String subtitlePath)? parseSubtitle,
    TResult Function(List<Subtitle> subtitles)? parseComplete,
    TResult Function(int index)? setCurrentPageIndex,
    required TResult orElse(),
  }) {
    if (parseSubtitle != null) {
      return parseSubtitle(subtitlePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseSubtitle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseSubtitle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitle value)? parseSubtitle,
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
  const factory _ParseSubtitle(final String subtitlePath) = _$ParseSubtitleImpl;

  String get subtitlePath;

  /// Create a copy of SubtitleEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParseSubtitleImplCopyWith<_$ParseSubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParseCompleteImplCopyWith<_$ParseCompleteImpl> get copyWith =>
      __$$ParseCompleteImplCopyWithImpl<_$ParseCompleteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String subtitlePath) parseSubtitle,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return parseComplete(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String subtitlePath)? parseSubtitle,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return parseComplete?.call(subtitles);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String subtitlePath)? parseSubtitle,
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
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return parseComplete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return parseComplete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitle value)? parseSubtitle,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentPageIndexImplCopyWith<_$SetCurrentPageIndexImpl> get copyWith =>
      __$$SetCurrentPageIndexImplCopyWithImpl<_$SetCurrentPageIndexImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String subtitlePath) parseSubtitle,
    required TResult Function(List<Subtitle> subtitles) parseComplete,
    required TResult Function(int index) setCurrentPageIndex,
  }) {
    return setCurrentPageIndex(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String subtitlePath)? parseSubtitle,
    TResult? Function(List<Subtitle> subtitles)? parseComplete,
    TResult? Function(int index)? setCurrentPageIndex,
  }) {
    return setCurrentPageIndex?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String subtitlePath)? parseSubtitle,
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
    required TResult Function(_ParseSubtitle value) parseSubtitle,
    required TResult Function(_ParseComplete value) parseComplete,
    required TResult Function(_SetCurrentPageIndex value) setCurrentPageIndex,
  }) {
    return setCurrentPageIndex(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParseSubtitle value)? parseSubtitle,
    TResult? Function(_ParseComplete value)? parseComplete,
    TResult? Function(_SetCurrentPageIndex value)? setCurrentPageIndex,
  }) {
    return setCurrentPageIndex?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParseSubtitle value)? parseSubtitle,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
    required TResult Function(int index) onPageChanged,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
    TResult? Function(int index)? onPageChanged,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(List<Subtitle> subtitles)? onParsingSubtitle,
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
    required TResult Function(OnPageChanged value) onPageChanged,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
    TResult? Function(OnPageChanged value)? onPageChanged,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnParsingSubtitle value)? onParsingSubtitle,
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
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
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
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
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
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
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
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
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
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
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
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
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
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
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
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
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
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
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
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
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
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
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
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
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnParsingSubtitleImplCopyWith<_$OnParsingSubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
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
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
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
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
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
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
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
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnParseCompletedImplCopyWith<_$OnParseCompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
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
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
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
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
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
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
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
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  @JsonKey(includeFromJson: false, includeToJson: false)
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
    required TResult Function(List<Subtitle> subtitles) onParseCompleted,
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
    TResult? Function(List<Subtitle> subtitles)? onParseCompleted,
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
    TResult Function(List<Subtitle> subtitles)? onParseCompleted,
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
    required TResult Function(_OnParseCompleted value) onParseCompleted,
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
    TResult? Function(_OnParseCompleted value)? onParseCompleted,
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
    TResult Function(_OnParseCompleted value)? onParseCompleted,
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
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
