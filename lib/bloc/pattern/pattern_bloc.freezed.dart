// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatternEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lessonId) loadPatternsByLesson,
    required TResult Function(String? keyword, bool? examples,
            bool? vocabularies, bool? userComments)
        loadPatterns,
    required TResult Function(int patternId) loadVocabulariesByPattern,
    required TResult Function(int patternId) loadExamplesByPattern,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int lessonId)? loadPatternsByLesson,
    TResult? Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult? Function(int patternId)? loadVocabulariesByPattern,
    TResult? Function(int patternId)? loadExamplesByPattern,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lessonId)? loadPatternsByLesson,
    TResult Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult Function(int patternId)? loadVocabulariesByPattern,
    TResult Function(int patternId)? loadExamplesByPattern,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLessonPatterns value) loadPatternsByLesson,
    required TResult Function(_Loadpatterns value) loadPatterns,
    required TResult Function(_LoadVocabulariesByPattern value)
        loadVocabulariesByPattern,
    required TResult Function(_LoadExamplesByPattern value)
        loadExamplesByPattern,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult? Function(_Loadpatterns value)? loadPatterns,
    TResult? Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult? Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult Function(_Loadpatterns value)? loadPatterns,
    TResult Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternEventCopyWith<$Res> {
  factory $PatternEventCopyWith(
          PatternEvent value, $Res Function(PatternEvent) then) =
      _$PatternEventCopyWithImpl<$Res, PatternEvent>;
}

/// @nodoc
class _$PatternEventCopyWithImpl<$Res, $Val extends PatternEvent>
    implements $PatternEventCopyWith<$Res> {
  _$PatternEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadLessonPatternsImplCopyWith<$Res> {
  factory _$$LoadLessonPatternsImplCopyWith(_$LoadLessonPatternsImpl value,
          $Res Function(_$LoadLessonPatternsImpl) then) =
      __$$LoadLessonPatternsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int lessonId});
}

/// @nodoc
class __$$LoadLessonPatternsImplCopyWithImpl<$Res>
    extends _$PatternEventCopyWithImpl<$Res, _$LoadLessonPatternsImpl>
    implements _$$LoadLessonPatternsImplCopyWith<$Res> {
  __$$LoadLessonPatternsImplCopyWithImpl(_$LoadLessonPatternsImpl _value,
      $Res Function(_$LoadLessonPatternsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
  }) {
    return _then(_$LoadLessonPatternsImpl(
      null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadLessonPatternsImpl implements _LoadLessonPatterns {
  const _$LoadLessonPatternsImpl(this.lessonId);

  @override
  final int lessonId;

  @override
  String toString() {
    return 'PatternEvent.loadPatternsByLesson(lessonId: $lessonId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadLessonPatternsImpl &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lessonId);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadLessonPatternsImplCopyWith<_$LoadLessonPatternsImpl> get copyWith =>
      __$$LoadLessonPatternsImplCopyWithImpl<_$LoadLessonPatternsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lessonId) loadPatternsByLesson,
    required TResult Function(String? keyword, bool? examples,
            bool? vocabularies, bool? userComments)
        loadPatterns,
    required TResult Function(int patternId) loadVocabulariesByPattern,
    required TResult Function(int patternId) loadExamplesByPattern,
  }) {
    return loadPatternsByLesson(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int lessonId)? loadPatternsByLesson,
    TResult? Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult? Function(int patternId)? loadVocabulariesByPattern,
    TResult? Function(int patternId)? loadExamplesByPattern,
  }) {
    return loadPatternsByLesson?.call(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lessonId)? loadPatternsByLesson,
    TResult Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult Function(int patternId)? loadVocabulariesByPattern,
    TResult Function(int patternId)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadPatternsByLesson != null) {
      return loadPatternsByLesson(lessonId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLessonPatterns value) loadPatternsByLesson,
    required TResult Function(_Loadpatterns value) loadPatterns,
    required TResult Function(_LoadVocabulariesByPattern value)
        loadVocabulariesByPattern,
    required TResult Function(_LoadExamplesByPattern value)
        loadExamplesByPattern,
  }) {
    return loadPatternsByLesson(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult? Function(_Loadpatterns value)? loadPatterns,
    TResult? Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult? Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
  }) {
    return loadPatternsByLesson?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult Function(_Loadpatterns value)? loadPatterns,
    TResult Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadPatternsByLesson != null) {
      return loadPatternsByLesson(this);
    }
    return orElse();
  }
}

abstract class _LoadLessonPatterns implements PatternEvent {
  const factory _LoadLessonPatterns(final int lessonId) =
      _$LoadLessonPatternsImpl;

  int get lessonId;

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadLessonPatternsImplCopyWith<_$LoadLessonPatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadpatternsImplCopyWith<$Res> {
  factory _$$LoadpatternsImplCopyWith(
          _$LoadpatternsImpl value, $Res Function(_$LoadpatternsImpl) then) =
      __$$LoadpatternsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? keyword,
      bool? examples,
      bool? vocabularies,
      bool? userComments});
}

/// @nodoc
class __$$LoadpatternsImplCopyWithImpl<$Res>
    extends _$PatternEventCopyWithImpl<$Res, _$LoadpatternsImpl>
    implements _$$LoadpatternsImplCopyWith<$Res> {
  __$$LoadpatternsImplCopyWithImpl(
      _$LoadpatternsImpl _value, $Res Function(_$LoadpatternsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyword = freezed,
    Object? examples = freezed,
    Object? vocabularies = freezed,
    Object? userComments = freezed,
  }) {
    return _then(_$LoadpatternsImpl(
      keyword: freezed == keyword
          ? _value.keyword
          : keyword // ignore: cast_nullable_to_non_nullable
              as String?,
      examples: freezed == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as bool?,
      vocabularies: freezed == vocabularies
          ? _value.vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as bool?,
      userComments: freezed == userComments
          ? _value.userComments
          : userComments // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$LoadpatternsImpl implements _Loadpatterns {
  const _$LoadpatternsImpl(
      {this.keyword, this.examples, this.vocabularies, this.userComments});

  @override
  final String? keyword;
  @override
  final bool? examples;
  @override
  final bool? vocabularies;
  @override
  final bool? userComments;

  @override
  String toString() {
    return 'PatternEvent.loadPatterns(keyword: $keyword, examples: $examples, vocabularies: $vocabularies, userComments: $userComments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadpatternsImpl &&
            (identical(other.keyword, keyword) || other.keyword == keyword) &&
            (identical(other.examples, examples) ||
                other.examples == examples) &&
            (identical(other.vocabularies, vocabularies) ||
                other.vocabularies == vocabularies) &&
            (identical(other.userComments, userComments) ||
                other.userComments == userComments));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, keyword, examples, vocabularies, userComments);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadpatternsImplCopyWith<_$LoadpatternsImpl> get copyWith =>
      __$$LoadpatternsImplCopyWithImpl<_$LoadpatternsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lessonId) loadPatternsByLesson,
    required TResult Function(String? keyword, bool? examples,
            bool? vocabularies, bool? userComments)
        loadPatterns,
    required TResult Function(int patternId) loadVocabulariesByPattern,
    required TResult Function(int patternId) loadExamplesByPattern,
  }) {
    return loadPatterns(keyword, examples, vocabularies, userComments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int lessonId)? loadPatternsByLesson,
    TResult? Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult? Function(int patternId)? loadVocabulariesByPattern,
    TResult? Function(int patternId)? loadExamplesByPattern,
  }) {
    return loadPatterns?.call(keyword, examples, vocabularies, userComments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lessonId)? loadPatternsByLesson,
    TResult Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult Function(int patternId)? loadVocabulariesByPattern,
    TResult Function(int patternId)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadPatterns != null) {
      return loadPatterns(keyword, examples, vocabularies, userComments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLessonPatterns value) loadPatternsByLesson,
    required TResult Function(_Loadpatterns value) loadPatterns,
    required TResult Function(_LoadVocabulariesByPattern value)
        loadVocabulariesByPattern,
    required TResult Function(_LoadExamplesByPattern value)
        loadExamplesByPattern,
  }) {
    return loadPatterns(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult? Function(_Loadpatterns value)? loadPatterns,
    TResult? Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult? Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
  }) {
    return loadPatterns?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult Function(_Loadpatterns value)? loadPatterns,
    TResult Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadPatterns != null) {
      return loadPatterns(this);
    }
    return orElse();
  }
}

abstract class _Loadpatterns implements PatternEvent {
  const factory _Loadpatterns(
      {final String? keyword,
      final bool? examples,
      final bool? vocabularies,
      final bool? userComments}) = _$LoadpatternsImpl;

  String? get keyword;
  bool? get examples;
  bool? get vocabularies;
  bool? get userComments;

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadpatternsImplCopyWith<_$LoadpatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadVocabulariesByPatternImplCopyWith<$Res> {
  factory _$$LoadVocabulariesByPatternImplCopyWith(
          _$LoadVocabulariesByPatternImpl value,
          $Res Function(_$LoadVocabulariesByPatternImpl) then) =
      __$$LoadVocabulariesByPatternImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int patternId});
}

/// @nodoc
class __$$LoadVocabulariesByPatternImplCopyWithImpl<$Res>
    extends _$PatternEventCopyWithImpl<$Res, _$LoadVocabulariesByPatternImpl>
    implements _$$LoadVocabulariesByPatternImplCopyWith<$Res> {
  __$$LoadVocabulariesByPatternImplCopyWithImpl(
      _$LoadVocabulariesByPatternImpl _value,
      $Res Function(_$LoadVocabulariesByPatternImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patternId = null,
  }) {
    return _then(_$LoadVocabulariesByPatternImpl(
      null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadVocabulariesByPatternImpl implements _LoadVocabulariesByPattern {
  const _$LoadVocabulariesByPatternImpl(this.patternId);

  @override
  final int patternId;

  @override
  String toString() {
    return 'PatternEvent.loadVocabulariesByPattern(patternId: $patternId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadVocabulariesByPatternImpl &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patternId);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadVocabulariesByPatternImplCopyWith<_$LoadVocabulariesByPatternImpl>
      get copyWith => __$$LoadVocabulariesByPatternImplCopyWithImpl<
          _$LoadVocabulariesByPatternImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lessonId) loadPatternsByLesson,
    required TResult Function(String? keyword, bool? examples,
            bool? vocabularies, bool? userComments)
        loadPatterns,
    required TResult Function(int patternId) loadVocabulariesByPattern,
    required TResult Function(int patternId) loadExamplesByPattern,
  }) {
    return loadVocabulariesByPattern(patternId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int lessonId)? loadPatternsByLesson,
    TResult? Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult? Function(int patternId)? loadVocabulariesByPattern,
    TResult? Function(int patternId)? loadExamplesByPattern,
  }) {
    return loadVocabulariesByPattern?.call(patternId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lessonId)? loadPatternsByLesson,
    TResult Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult Function(int patternId)? loadVocabulariesByPattern,
    TResult Function(int patternId)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadVocabulariesByPattern != null) {
      return loadVocabulariesByPattern(patternId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLessonPatterns value) loadPatternsByLesson,
    required TResult Function(_Loadpatterns value) loadPatterns,
    required TResult Function(_LoadVocabulariesByPattern value)
        loadVocabulariesByPattern,
    required TResult Function(_LoadExamplesByPattern value)
        loadExamplesByPattern,
  }) {
    return loadVocabulariesByPattern(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult? Function(_Loadpatterns value)? loadPatterns,
    TResult? Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult? Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
  }) {
    return loadVocabulariesByPattern?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult Function(_Loadpatterns value)? loadPatterns,
    TResult Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadVocabulariesByPattern != null) {
      return loadVocabulariesByPattern(this);
    }
    return orElse();
  }
}

abstract class _LoadVocabulariesByPattern implements PatternEvent {
  const factory _LoadVocabulariesByPattern(final int patternId) =
      _$LoadVocabulariesByPatternImpl;

  int get patternId;

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadVocabulariesByPatternImplCopyWith<_$LoadVocabulariesByPatternImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadExamplesByPatternImplCopyWith<$Res> {
  factory _$$LoadExamplesByPatternImplCopyWith(
          _$LoadExamplesByPatternImpl value,
          $Res Function(_$LoadExamplesByPatternImpl) then) =
      __$$LoadExamplesByPatternImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int patternId});
}

/// @nodoc
class __$$LoadExamplesByPatternImplCopyWithImpl<$Res>
    extends _$PatternEventCopyWithImpl<$Res, _$LoadExamplesByPatternImpl>
    implements _$$LoadExamplesByPatternImplCopyWith<$Res> {
  __$$LoadExamplesByPatternImplCopyWithImpl(_$LoadExamplesByPatternImpl _value,
      $Res Function(_$LoadExamplesByPatternImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patternId = null,
  }) {
    return _then(_$LoadExamplesByPatternImpl(
      null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadExamplesByPatternImpl implements _LoadExamplesByPattern {
  const _$LoadExamplesByPatternImpl(this.patternId);

  @override
  final int patternId;

  @override
  String toString() {
    return 'PatternEvent.loadExamplesByPattern(patternId: $patternId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadExamplesByPatternImpl &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patternId);

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadExamplesByPatternImplCopyWith<_$LoadExamplesByPatternImpl>
      get copyWith => __$$LoadExamplesByPatternImplCopyWithImpl<
          _$LoadExamplesByPatternImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int lessonId) loadPatternsByLesson,
    required TResult Function(String? keyword, bool? examples,
            bool? vocabularies, bool? userComments)
        loadPatterns,
    required TResult Function(int patternId) loadVocabulariesByPattern,
    required TResult Function(int patternId) loadExamplesByPattern,
  }) {
    return loadExamplesByPattern(patternId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int lessonId)? loadPatternsByLesson,
    TResult? Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult? Function(int patternId)? loadVocabulariesByPattern,
    TResult? Function(int patternId)? loadExamplesByPattern,
  }) {
    return loadExamplesByPattern?.call(patternId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int lessonId)? loadPatternsByLesson,
    TResult Function(String? keyword, bool? examples, bool? vocabularies,
            bool? userComments)?
        loadPatterns,
    TResult Function(int patternId)? loadVocabulariesByPattern,
    TResult Function(int patternId)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadExamplesByPattern != null) {
      return loadExamplesByPattern(patternId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLessonPatterns value) loadPatternsByLesson,
    required TResult Function(_Loadpatterns value) loadPatterns,
    required TResult Function(_LoadVocabulariesByPattern value)
        loadVocabulariesByPattern,
    required TResult Function(_LoadExamplesByPattern value)
        loadExamplesByPattern,
  }) {
    return loadExamplesByPattern(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult? Function(_Loadpatterns value)? loadPatterns,
    TResult? Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult? Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
  }) {
    return loadExamplesByPattern?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLessonPatterns value)? loadPatternsByLesson,
    TResult Function(_Loadpatterns value)? loadPatterns,
    TResult Function(_LoadVocabulariesByPattern value)?
        loadVocabulariesByPattern,
    TResult Function(_LoadExamplesByPattern value)? loadExamplesByPattern,
    required TResult orElse(),
  }) {
    if (loadExamplesByPattern != null) {
      return loadExamplesByPattern(this);
    }
    return orElse();
  }
}

abstract class _LoadExamplesByPattern implements PatternEvent {
  const factory _LoadExamplesByPattern(final int patternId) =
      _$LoadExamplesByPatternImpl;

  int get patternId;

  /// Create a copy of PatternEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadExamplesByPatternImplCopyWith<_$LoadExamplesByPatternImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PatternState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternStateCopyWith<$Res> {
  factory $PatternStateCopyWith(
          PatternState value, $Res Function(PatternState) then) =
      _$PatternStateCopyWithImpl<$Res, PatternState>;
}

/// @nodoc
class _$PatternStateCopyWithImpl<$Res, $Val extends PatternState>
    implements $PatternStateCopyWith<$Res> {
  _$PatternStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternState
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
    extends _$PatternStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'PatternState.initial()';
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
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
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
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
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
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
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
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PatternState {
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
    extends _$PatternStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'PatternState.loading()';
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
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
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
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
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
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
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
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PatternState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Pattern> patterns});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$PatternStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patterns = null,
  }) {
    return _then(_$LoadedImpl(
      null == patterns
          ? _value._patterns
          : patterns // ignore: cast_nullable_to_non_nullable
              as List<Pattern>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(final List<Pattern> patterns) : _patterns = patterns;

  final List<Pattern> _patterns;
  @override
  List<Pattern> get patterns {
    if (_patterns is EqualUnmodifiableListView) return _patterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_patterns);
  }

  @override
  String toString() {
    return 'PatternState.loaded(patterns: $patterns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._patterns, _patterns));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_patterns));

  /// Create a copy of PatternState
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
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) {
    return loaded(patterns);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(patterns);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(patterns);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
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
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
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
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements PatternState {
  const factory _Loaded(final List<Pattern> patterns) = _$LoadedImpl;

  List<Pattern> get patterns;

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VocabularyLoadedImplCopyWith<$Res> {
  factory _$$VocabularyLoadedImplCopyWith(_$VocabularyLoadedImpl value,
          $Res Function(_$VocabularyLoadedImpl) then) =
      __$$VocabularyLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PatternVocabulary> vocabularies});
}

/// @nodoc
class __$$VocabularyLoadedImplCopyWithImpl<$Res>
    extends _$PatternStateCopyWithImpl<$Res, _$VocabularyLoadedImpl>
    implements _$$VocabularyLoadedImplCopyWith<$Res> {
  __$$VocabularyLoadedImplCopyWithImpl(_$VocabularyLoadedImpl _value,
      $Res Function(_$VocabularyLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vocabularies = null,
  }) {
    return _then(_$VocabularyLoadedImpl(
      null == vocabularies
          ? _value._vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<PatternVocabulary>,
    ));
  }
}

/// @nodoc

class _$VocabularyLoadedImpl implements _VocabularyLoaded {
  const _$VocabularyLoadedImpl(final List<PatternVocabulary> vocabularies)
      : _vocabularies = vocabularies;

  final List<PatternVocabulary> _vocabularies;
  @override
  List<PatternVocabulary> get vocabularies {
    if (_vocabularies is EqualUnmodifiableListView) return _vocabularies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vocabularies);
  }

  @override
  String toString() {
    return 'PatternState.vocabularyLoaded(vocabularies: $vocabularies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._vocabularies, _vocabularies));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_vocabularies));

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyLoadedImplCopyWith<_$VocabularyLoadedImpl> get copyWith =>
      __$$VocabularyLoadedImplCopyWithImpl<_$VocabularyLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) {
    return vocabularyLoaded(vocabularies);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) {
    return vocabularyLoaded?.call(vocabularies);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (vocabularyLoaded != null) {
      return vocabularyLoaded(vocabularies);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
    required TResult Function(_Error value) error,
  }) {
    return vocabularyLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return vocabularyLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (vocabularyLoaded != null) {
      return vocabularyLoaded(this);
    }
    return orElse();
  }
}

abstract class _VocabularyLoaded implements PatternState {
  const factory _VocabularyLoaded(final List<PatternVocabulary> vocabularies) =
      _$VocabularyLoadedImpl;

  List<PatternVocabulary> get vocabularies;

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyLoadedImplCopyWith<_$VocabularyLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExampleLoadedImplCopyWith<$Res> {
  factory _$$ExampleLoadedImplCopyWith(
          _$ExampleLoadedImpl value, $Res Function(_$ExampleLoadedImpl) then) =
      __$$ExampleLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PatternExample> examples});
}

/// @nodoc
class __$$ExampleLoadedImplCopyWithImpl<$Res>
    extends _$PatternStateCopyWithImpl<$Res, _$ExampleLoadedImpl>
    implements _$$ExampleLoadedImplCopyWith<$Res> {
  __$$ExampleLoadedImplCopyWithImpl(
      _$ExampleLoadedImpl _value, $Res Function(_$ExampleLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? examples = null,
  }) {
    return _then(_$ExampleLoadedImpl(
      null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<PatternExample>,
    ));
  }
}

/// @nodoc

class _$ExampleLoadedImpl implements _ExampleLoaded {
  const _$ExampleLoadedImpl(final List<PatternExample> examples)
      : _examples = examples;

  final List<PatternExample> _examples;
  @override
  List<PatternExample> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  String toString() {
    return 'PatternState.examplesLoaded(examples: $examples)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExampleLoadedImpl &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_examples));

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExampleLoadedImplCopyWith<_$ExampleLoadedImpl> get copyWith =>
      __$$ExampleLoadedImplCopyWithImpl<_$ExampleLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) {
    return examplesLoaded(examples);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) {
    return examplesLoaded?.call(examples);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (examplesLoaded != null) {
      return examplesLoaded(examples);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
    required TResult Function(_Error value) error,
  }) {
    return examplesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
    TResult? Function(_Error value)? error,
  }) {
    return examplesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (examplesLoaded != null) {
      return examplesLoaded(this);
    }
    return orElse();
  }
}

abstract class _ExampleLoaded implements PatternState {
  const factory _ExampleLoaded(final List<PatternExample> examples) =
      _$ExampleLoadedImpl;

  List<PatternExample> get examples;

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExampleLoadedImplCopyWith<_$ExampleLoadedImpl> get copyWith =>
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
    extends _$PatternStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternState
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
    return 'PatternState.error(message: $message)';
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

  /// Create a copy of PatternState
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
    required TResult Function(List<Pattern> patterns) loaded,
    required TResult Function(List<PatternVocabulary> vocabularies)
        vocabularyLoaded,
    required TResult Function(List<PatternExample> examples) examplesLoaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Pattern> patterns)? loaded,
    TResult? Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult? Function(List<PatternExample> examples)? examplesLoaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Pattern> patterns)? loaded,
    TResult Function(List<PatternVocabulary> vocabularies)? vocabularyLoaded,
    TResult Function(List<PatternExample> examples)? examplesLoaded,
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
    required TResult Function(_VocabularyLoaded value) vocabularyLoaded,
    required TResult Function(_ExampleLoaded value) examplesLoaded,
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
    TResult? Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult? Function(_ExampleLoaded value)? examplesLoaded,
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
    TResult Function(_VocabularyLoaded value)? vocabularyLoaded,
    TResult Function(_ExampleLoaded value)? examplesLoaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PatternState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of PatternState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
