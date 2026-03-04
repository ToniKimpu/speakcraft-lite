// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TranslationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int translationDayId) loadTranslations,
    required TResult Function() loadTranslationLevels,
    required TResult Function(int translationDayId) loadUserTranslations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int translationDayId)? loadTranslations,
    TResult? Function()? loadTranslationLevels,
    TResult? Function(int translationDayId)? loadUserTranslations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int translationDayId)? loadTranslations,
    TResult Function()? loadTranslationLevels,
    TResult Function(int translationDayId)? loadUserTranslations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTranslations value) loadTranslations,
    required TResult Function(_LoadTranslationLevels value)
        loadTranslationLevels,
    required TResult Function(_LoadUserTranslations value) loadUserTranslations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTranslations value)? loadTranslations,
    TResult? Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult? Function(_LoadUserTranslations value)? loadUserTranslations,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTranslations value)? loadTranslations,
    TResult Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult Function(_LoadUserTranslations value)? loadUserTranslations,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationEventCopyWith<$Res> {
  factory $TranslationEventCopyWith(
          TranslationEvent value, $Res Function(TranslationEvent) then) =
      _$TranslationEventCopyWithImpl<$Res, TranslationEvent>;
}

/// @nodoc
class _$TranslationEventCopyWithImpl<$Res, $Val extends TranslationEvent>
    implements $TranslationEventCopyWith<$Res> {
  _$TranslationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadTranslationsImplCopyWith<$Res> {
  factory _$$LoadTranslationsImplCopyWith(_$LoadTranslationsImpl value,
          $Res Function(_$LoadTranslationsImpl) then) =
      __$$LoadTranslationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int translationDayId});
}

/// @nodoc
class __$$LoadTranslationsImplCopyWithImpl<$Res>
    extends _$TranslationEventCopyWithImpl<$Res, _$LoadTranslationsImpl>
    implements _$$LoadTranslationsImplCopyWith<$Res> {
  __$$LoadTranslationsImplCopyWithImpl(_$LoadTranslationsImpl _value,
      $Res Function(_$LoadTranslationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translationDayId = null,
  }) {
    return _then(_$LoadTranslationsImpl(
      null == translationDayId
          ? _value.translationDayId
          : translationDayId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadTranslationsImpl
    with DiagnosticableTreeMixin
    implements _LoadTranslations {
  const _$LoadTranslationsImpl(this.translationDayId);

  @override
  final int translationDayId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationEvent.loadTranslations(translationDayId: $translationDayId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TranslationEvent.loadTranslations'))
      ..add(DiagnosticsProperty('translationDayId', translationDayId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTranslationsImpl &&
            (identical(other.translationDayId, translationDayId) ||
                other.translationDayId == translationDayId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, translationDayId);

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadTranslationsImplCopyWith<_$LoadTranslationsImpl> get copyWith =>
      __$$LoadTranslationsImplCopyWithImpl<_$LoadTranslationsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int translationDayId) loadTranslations,
    required TResult Function() loadTranslationLevels,
    required TResult Function(int translationDayId) loadUserTranslations,
  }) {
    return loadTranslations(translationDayId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int translationDayId)? loadTranslations,
    TResult? Function()? loadTranslationLevels,
    TResult? Function(int translationDayId)? loadUserTranslations,
  }) {
    return loadTranslations?.call(translationDayId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int translationDayId)? loadTranslations,
    TResult Function()? loadTranslationLevels,
    TResult Function(int translationDayId)? loadUserTranslations,
    required TResult orElse(),
  }) {
    if (loadTranslations != null) {
      return loadTranslations(translationDayId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTranslations value) loadTranslations,
    required TResult Function(_LoadTranslationLevels value)
        loadTranslationLevels,
    required TResult Function(_LoadUserTranslations value) loadUserTranslations,
  }) {
    return loadTranslations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTranslations value)? loadTranslations,
    TResult? Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult? Function(_LoadUserTranslations value)? loadUserTranslations,
  }) {
    return loadTranslations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTranslations value)? loadTranslations,
    TResult Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult Function(_LoadUserTranslations value)? loadUserTranslations,
    required TResult orElse(),
  }) {
    if (loadTranslations != null) {
      return loadTranslations(this);
    }
    return orElse();
  }
}

abstract class _LoadTranslations implements TranslationEvent {
  const factory _LoadTranslations(final int translationDayId) =
      _$LoadTranslationsImpl;

  int get translationDayId;

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadTranslationsImplCopyWith<_$LoadTranslationsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadTranslationLevelsImplCopyWith<$Res> {
  factory _$$LoadTranslationLevelsImplCopyWith(
          _$LoadTranslationLevelsImpl value,
          $Res Function(_$LoadTranslationLevelsImpl) then) =
      __$$LoadTranslationLevelsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadTranslationLevelsImplCopyWithImpl<$Res>
    extends _$TranslationEventCopyWithImpl<$Res, _$LoadTranslationLevelsImpl>
    implements _$$LoadTranslationLevelsImplCopyWith<$Res> {
  __$$LoadTranslationLevelsImplCopyWithImpl(_$LoadTranslationLevelsImpl _value,
      $Res Function(_$LoadTranslationLevelsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadTranslationLevelsImpl
    with DiagnosticableTreeMixin
    implements _LoadTranslationLevels {
  const _$LoadTranslationLevelsImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationEvent.loadTranslationLevels()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'TranslationEvent.loadTranslationLevels'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadTranslationLevelsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int translationDayId) loadTranslations,
    required TResult Function() loadTranslationLevels,
    required TResult Function(int translationDayId) loadUserTranslations,
  }) {
    return loadTranslationLevels();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int translationDayId)? loadTranslations,
    TResult? Function()? loadTranslationLevels,
    TResult? Function(int translationDayId)? loadUserTranslations,
  }) {
    return loadTranslationLevels?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int translationDayId)? loadTranslations,
    TResult Function()? loadTranslationLevels,
    TResult Function(int translationDayId)? loadUserTranslations,
    required TResult orElse(),
  }) {
    if (loadTranslationLevels != null) {
      return loadTranslationLevels();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTranslations value) loadTranslations,
    required TResult Function(_LoadTranslationLevels value)
        loadTranslationLevels,
    required TResult Function(_LoadUserTranslations value) loadUserTranslations,
  }) {
    return loadTranslationLevels(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTranslations value)? loadTranslations,
    TResult? Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult? Function(_LoadUserTranslations value)? loadUserTranslations,
  }) {
    return loadTranslationLevels?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTranslations value)? loadTranslations,
    TResult Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult Function(_LoadUserTranslations value)? loadUserTranslations,
    required TResult orElse(),
  }) {
    if (loadTranslationLevels != null) {
      return loadTranslationLevels(this);
    }
    return orElse();
  }
}

abstract class _LoadTranslationLevels implements TranslationEvent {
  const factory _LoadTranslationLevels() = _$LoadTranslationLevelsImpl;
}

/// @nodoc
abstract class _$$LoadUserTranslationsImplCopyWith<$Res> {
  factory _$$LoadUserTranslationsImplCopyWith(_$LoadUserTranslationsImpl value,
          $Res Function(_$LoadUserTranslationsImpl) then) =
      __$$LoadUserTranslationsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int translationDayId});
}

/// @nodoc
class __$$LoadUserTranslationsImplCopyWithImpl<$Res>
    extends _$TranslationEventCopyWithImpl<$Res, _$LoadUserTranslationsImpl>
    implements _$$LoadUserTranslationsImplCopyWith<$Res> {
  __$$LoadUserTranslationsImplCopyWithImpl(_$LoadUserTranslationsImpl _value,
      $Res Function(_$LoadUserTranslationsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translationDayId = null,
  }) {
    return _then(_$LoadUserTranslationsImpl(
      null == translationDayId
          ? _value.translationDayId
          : translationDayId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadUserTranslationsImpl
    with DiagnosticableTreeMixin
    implements _LoadUserTranslations {
  const _$LoadUserTranslationsImpl(this.translationDayId);

  @override
  final int translationDayId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationEvent.loadUserTranslations(translationDayId: $translationDayId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'TranslationEvent.loadUserTranslations'))
      ..add(DiagnosticsProperty('translationDayId', translationDayId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadUserTranslationsImpl &&
            (identical(other.translationDayId, translationDayId) ||
                other.translationDayId == translationDayId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, translationDayId);

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadUserTranslationsImplCopyWith<_$LoadUserTranslationsImpl>
      get copyWith =>
          __$$LoadUserTranslationsImplCopyWithImpl<_$LoadUserTranslationsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int translationDayId) loadTranslations,
    required TResult Function() loadTranslationLevels,
    required TResult Function(int translationDayId) loadUserTranslations,
  }) {
    return loadUserTranslations(translationDayId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int translationDayId)? loadTranslations,
    TResult? Function()? loadTranslationLevels,
    TResult? Function(int translationDayId)? loadUserTranslations,
  }) {
    return loadUserTranslations?.call(translationDayId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int translationDayId)? loadTranslations,
    TResult Function()? loadTranslationLevels,
    TResult Function(int translationDayId)? loadUserTranslations,
    required TResult orElse(),
  }) {
    if (loadUserTranslations != null) {
      return loadUserTranslations(translationDayId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadTranslations value) loadTranslations,
    required TResult Function(_LoadTranslationLevels value)
        loadTranslationLevels,
    required TResult Function(_LoadUserTranslations value) loadUserTranslations,
  }) {
    return loadUserTranslations(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadTranslations value)? loadTranslations,
    TResult? Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult? Function(_LoadUserTranslations value)? loadUserTranslations,
  }) {
    return loadUserTranslations?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadTranslations value)? loadTranslations,
    TResult Function(_LoadTranslationLevels value)? loadTranslationLevels,
    TResult Function(_LoadUserTranslations value)? loadUserTranslations,
    required TResult orElse(),
  }) {
    if (loadUserTranslations != null) {
      return loadUserTranslations(this);
    }
    return orElse();
  }
}

abstract class _LoadUserTranslations implements TranslationEvent {
  const factory _LoadUserTranslations(final int translationDayId) =
      _$LoadUserTranslationsImpl;

  int get translationDayId;

  /// Create a copy of TranslationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadUserTranslationsImplCopyWith<_$LoadUserTranslationsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TranslationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Translation> translations) loaded,
    required TResult Function(List<TranslationLevel> translationLevels)
        translationLevelsLoaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Translation> translations)? loaded,
    TResult? Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Translation> translations)? loaded,
    TResult Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_TranslationLevelsLoaded value)
        translationLevelsLoaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationStateCopyWith<$Res> {
  factory $TranslationStateCopyWith(
          TranslationState value, $Res Function(TranslationState) then) =
      _$TranslationStateCopyWithImpl<$Res, TranslationState>;
}

/// @nodoc
class _$TranslationStateCopyWithImpl<$Res, $Val extends TranslationState>
    implements $TranslationStateCopyWith<$Res> {
  _$TranslationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationState
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
    extends _$TranslationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'TranslationState.initial'));
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
    required TResult Function() loading,
    required TResult Function(List<Translation> translations) loaded,
    required TResult Function(List<TranslationLevel> translationLevels)
        translationLevelsLoaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Translation> translations)? loaded,
    TResult? Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Translation> translations)? loaded,
    TResult Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_TranslationLevelsLoaded value)
        translationLevelsLoaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TranslationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$TranslationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'TranslationState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Translation> translations) loaded,
    required TResult Function(List<TranslationLevel> translationLevels)
        translationLevelsLoaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Translation> translations)? loaded,
    TResult? Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Translation> translations)? loaded,
    TResult Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_TranslationLevelsLoaded value)
        translationLevelsLoaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements TranslationState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Translation> translations});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$TranslationStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translations = null,
  }) {
    return _then(_$LoadedImpl(
      null == translations
          ? _value._translations
          : translations // ignore: cast_nullable_to_non_nullable
              as List<Translation>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl(final List<Translation> translations)
      : _translations = translations;

  final List<Translation> _translations;
  @override
  List<Translation> get translations {
    if (_translations is EqualUnmodifiableListView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_translations);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationState.loaded(translations: $translations)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TranslationState.loaded'))
      ..add(DiagnosticsProperty('translations', translations));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._translations, _translations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_translations));

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Translation> translations) loaded,
    required TResult Function(List<TranslationLevel> translationLevels)
        translationLevelsLoaded,
    required TResult Function(String message) error,
  }) {
    return loaded(translations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Translation> translations)? loaded,
    TResult? Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(translations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Translation> translations)? loaded,
    TResult Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(translations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_TranslationLevelsLoaded value)
        translationLevelsLoaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements TranslationState {
  const factory _Loaded(final List<Translation> translations) = _$LoadedImpl;

  List<Translation> get translations;

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TranslationLevelsLoadedImplCopyWith<$Res> {
  factory _$$TranslationLevelsLoadedImplCopyWith(
          _$TranslationLevelsLoadedImpl value,
          $Res Function(_$TranslationLevelsLoadedImpl) then) =
      __$$TranslationLevelsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TranslationLevel> translationLevels});
}

/// @nodoc
class __$$TranslationLevelsLoadedImplCopyWithImpl<$Res>
    extends _$TranslationStateCopyWithImpl<$Res, _$TranslationLevelsLoadedImpl>
    implements _$$TranslationLevelsLoadedImplCopyWith<$Res> {
  __$$TranslationLevelsLoadedImplCopyWithImpl(
      _$TranslationLevelsLoadedImpl _value,
      $Res Function(_$TranslationLevelsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? translationLevels = null,
  }) {
    return _then(_$TranslationLevelsLoadedImpl(
      null == translationLevels
          ? _value._translationLevels
          : translationLevels // ignore: cast_nullable_to_non_nullable
              as List<TranslationLevel>,
    ));
  }
}

/// @nodoc

class _$TranslationLevelsLoadedImpl
    with DiagnosticableTreeMixin
    implements _TranslationLevelsLoaded {
  const _$TranslationLevelsLoadedImpl(
      final List<TranslationLevel> translationLevels)
      : _translationLevels = translationLevels;

  final List<TranslationLevel> _translationLevels;
  @override
  List<TranslationLevel> get translationLevels {
    if (_translationLevels is EqualUnmodifiableListView)
      return _translationLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_translationLevels);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TranslationState.translationLevelsLoaded(translationLevels: $translationLevels)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'TranslationState.translationLevelsLoaded'))
      ..add(DiagnosticsProperty('translationLevels', translationLevels));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationLevelsLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._translationLevels, _translationLevels));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_translationLevels));

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationLevelsLoadedImplCopyWith<_$TranslationLevelsLoadedImpl>
      get copyWith => __$$TranslationLevelsLoadedImplCopyWithImpl<
          _$TranslationLevelsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Translation> translations) loaded,
    required TResult Function(List<TranslationLevel> translationLevels)
        translationLevelsLoaded,
    required TResult Function(String message) error,
  }) {
    return translationLevelsLoaded(translationLevels);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Translation> translations)? loaded,
    TResult? Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult? Function(String message)? error,
  }) {
    return translationLevelsLoaded?.call(translationLevels);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Translation> translations)? loaded,
    TResult Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (translationLevelsLoaded != null) {
      return translationLevelsLoaded(translationLevels);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_TranslationLevelsLoaded value)
        translationLevelsLoaded,
    required TResult Function(_Error value) error,
  }) {
    return translationLevelsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return translationLevelsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (translationLevelsLoaded != null) {
      return translationLevelsLoaded(this);
    }
    return orElse();
  }
}

abstract class _TranslationLevelsLoaded implements TranslationState {
  const factory _TranslationLevelsLoaded(
          final List<TranslationLevel> translationLevels) =
      _$TranslationLevelsLoadedImpl;

  List<TranslationLevel> get translationLevels;

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationLevelsLoadedImplCopyWith<_$TranslationLevelsLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    extends _$TranslationStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationState
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
    return 'TranslationState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TranslationState.error'))
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

  /// Create a copy of TranslationState
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
    required TResult Function() loading,
    required TResult Function(List<Translation> translations) loaded,
    required TResult Function(List<TranslationLevel> translationLevels)
        translationLevelsLoaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Translation> translations)? loaded,
    TResult? Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Translation> translations)? loaded,
    TResult Function(List<TranslationLevel> translationLevels)?
        translationLevelsLoaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_TranslationLevelsLoaded value)
        translationLevelsLoaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_TranslationLevelsLoaded value)? translationLevelsLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements TranslationState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of TranslationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
