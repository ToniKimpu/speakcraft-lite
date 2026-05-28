// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_speaking_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailySpeakingFeedback _$DailySpeakingFeedbackFromJson(
    Map<String, dynamic> json) {
  return _DailySpeakingFeedback.fromJson(json);
}

/// @nodoc
mixin _$DailySpeakingFeedback {
  int get score => throw _privateConstructorUsedError;
  CefrLevel get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'inferred_topic')
  String? get inferredTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_seconds')
  int get durationSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_count')
  int get wordCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'speaking_pace_wpm')
  int get speakingPaceWpm => throw _privateConstructorUsedError;
  List<String> get strengths => throw _privateConstructorUsedError;
  List<FeedbackFix> get fixes => throw _privateConstructorUsedError;
  @JsonKey(name: 'native_rewrite')
  String get nativeRewrite => throw _privateConstructorUsedError;
  @JsonKey(name: 'pronunciation_notes')
  List<String> get pronunciationNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'explanation_mm')
  String get explanationMm => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_phrase_results')
  List<TargetPhraseResult> get targetPhraseResults =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'total_tokens')
  int get totalTokens => throw _privateConstructorUsedError;

  /// Serializes this DailySpeakingFeedback to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailySpeakingFeedbackCopyWith<DailySpeakingFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingFeedbackCopyWith<$Res> {
  factory $DailySpeakingFeedbackCopyWith(DailySpeakingFeedback value,
          $Res Function(DailySpeakingFeedback) then) =
      _$DailySpeakingFeedbackCopyWithImpl<$Res, DailySpeakingFeedback>;
  @useResult
  $Res call(
      {int score,
      CefrLevel level,
      @JsonKey(name: 'inferred_topic') String? inferredTopic,
      @JsonKey(name: 'duration_seconds') int durationSeconds,
      @JsonKey(name: 'word_count') int wordCount,
      @JsonKey(name: 'speaking_pace_wpm') int speakingPaceWpm,
      List<String> strengths,
      List<FeedbackFix> fixes,
      @JsonKey(name: 'native_rewrite') String nativeRewrite,
      @JsonKey(name: 'pronunciation_notes') List<String> pronunciationNotes,
      @JsonKey(name: 'explanation_mm') String explanationMm,
      @JsonKey(name: 'target_phrase_results')
      List<TargetPhraseResult> targetPhraseResults,
      @JsonKey(name: 'total_tokens') int totalTokens});
}

/// @nodoc
class _$DailySpeakingFeedbackCopyWithImpl<$Res,
        $Val extends DailySpeakingFeedback>
    implements $DailySpeakingFeedbackCopyWith<$Res> {
  _$DailySpeakingFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? level = null,
    Object? inferredTopic = freezed,
    Object? durationSeconds = null,
    Object? wordCount = null,
    Object? speakingPaceWpm = null,
    Object? strengths = null,
    Object? fixes = null,
    Object? nativeRewrite = null,
    Object? pronunciationNotes = null,
    Object? explanationMm = null,
    Object? targetPhraseResults = null,
    Object? totalTokens = null,
  }) {
    return _then(_value.copyWith(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as CefrLevel,
      inferredTopic: freezed == inferredTopic
          ? _value.inferredTopic
          : inferredTopic // ignore: cast_nullable_to_non_nullable
              as String?,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      wordCount: null == wordCount
          ? _value.wordCount
          : wordCount // ignore: cast_nullable_to_non_nullable
              as int,
      speakingPaceWpm: null == speakingPaceWpm
          ? _value.speakingPaceWpm
          : speakingPaceWpm // ignore: cast_nullable_to_non_nullable
              as int,
      strengths: null == strengths
          ? _value.strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fixes: null == fixes
          ? _value.fixes
          : fixes // ignore: cast_nullable_to_non_nullable
              as List<FeedbackFix>,
      nativeRewrite: null == nativeRewrite
          ? _value.nativeRewrite
          : nativeRewrite // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciationNotes: null == pronunciationNotes
          ? _value.pronunciationNotes
          : pronunciationNotes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanationMm: null == explanationMm
          ? _value.explanationMm
          : explanationMm // ignore: cast_nullable_to_non_nullable
              as String,
      targetPhraseResults: null == targetPhraseResults
          ? _value.targetPhraseResults
          : targetPhraseResults // ignore: cast_nullable_to_non_nullable
              as List<TargetPhraseResult>,
      totalTokens: null == totalTokens
          ? _value.totalTokens
          : totalTokens // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailySpeakingFeedbackImplCopyWith<$Res>
    implements $DailySpeakingFeedbackCopyWith<$Res> {
  factory _$$DailySpeakingFeedbackImplCopyWith(
          _$DailySpeakingFeedbackImpl value,
          $Res Function(_$DailySpeakingFeedbackImpl) then) =
      __$$DailySpeakingFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int score,
      CefrLevel level,
      @JsonKey(name: 'inferred_topic') String? inferredTopic,
      @JsonKey(name: 'duration_seconds') int durationSeconds,
      @JsonKey(name: 'word_count') int wordCount,
      @JsonKey(name: 'speaking_pace_wpm') int speakingPaceWpm,
      List<String> strengths,
      List<FeedbackFix> fixes,
      @JsonKey(name: 'native_rewrite') String nativeRewrite,
      @JsonKey(name: 'pronunciation_notes') List<String> pronunciationNotes,
      @JsonKey(name: 'explanation_mm') String explanationMm,
      @JsonKey(name: 'target_phrase_results')
      List<TargetPhraseResult> targetPhraseResults,
      @JsonKey(name: 'total_tokens') int totalTokens});
}

/// @nodoc
class __$$DailySpeakingFeedbackImplCopyWithImpl<$Res>
    extends _$DailySpeakingFeedbackCopyWithImpl<$Res,
        _$DailySpeakingFeedbackImpl>
    implements _$$DailySpeakingFeedbackImplCopyWith<$Res> {
  __$$DailySpeakingFeedbackImplCopyWithImpl(_$DailySpeakingFeedbackImpl _value,
      $Res Function(_$DailySpeakingFeedbackImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? level = null,
    Object? inferredTopic = freezed,
    Object? durationSeconds = null,
    Object? wordCount = null,
    Object? speakingPaceWpm = null,
    Object? strengths = null,
    Object? fixes = null,
    Object? nativeRewrite = null,
    Object? pronunciationNotes = null,
    Object? explanationMm = null,
    Object? targetPhraseResults = null,
    Object? totalTokens = null,
  }) {
    return _then(_$DailySpeakingFeedbackImpl(
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as CefrLevel,
      inferredTopic: freezed == inferredTopic
          ? _value.inferredTopic
          : inferredTopic // ignore: cast_nullable_to_non_nullable
              as String?,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      wordCount: null == wordCount
          ? _value.wordCount
          : wordCount // ignore: cast_nullable_to_non_nullable
              as int,
      speakingPaceWpm: null == speakingPaceWpm
          ? _value.speakingPaceWpm
          : speakingPaceWpm // ignore: cast_nullable_to_non_nullable
              as int,
      strengths: null == strengths
          ? _value._strengths
          : strengths // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fixes: null == fixes
          ? _value._fixes
          : fixes // ignore: cast_nullable_to_non_nullable
              as List<FeedbackFix>,
      nativeRewrite: null == nativeRewrite
          ? _value.nativeRewrite
          : nativeRewrite // ignore: cast_nullable_to_non_nullable
              as String,
      pronunciationNotes: null == pronunciationNotes
          ? _value._pronunciationNotes
          : pronunciationNotes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      explanationMm: null == explanationMm
          ? _value.explanationMm
          : explanationMm // ignore: cast_nullable_to_non_nullable
              as String,
      targetPhraseResults: null == targetPhraseResults
          ? _value._targetPhraseResults
          : targetPhraseResults // ignore: cast_nullable_to_non_nullable
              as List<TargetPhraseResult>,
      totalTokens: null == totalTokens
          ? _value.totalTokens
          : totalTokens // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySpeakingFeedbackImpl implements _DailySpeakingFeedback {
  const _$DailySpeakingFeedbackImpl(
      {required this.score,
      this.level = CefrLevel.beginner,
      @JsonKey(name: 'inferred_topic') this.inferredTopic,
      @JsonKey(name: 'duration_seconds') this.durationSeconds = 0,
      @JsonKey(name: 'word_count') this.wordCount = 0,
      @JsonKey(name: 'speaking_pace_wpm') this.speakingPaceWpm = 0,
      final List<String> strengths = const <String>[],
      final List<FeedbackFix> fixes = const <FeedbackFix>[],
      @JsonKey(name: 'native_rewrite') this.nativeRewrite = '',
      @JsonKey(name: 'pronunciation_notes')
      final List<String> pronunciationNotes = const <String>[],
      @JsonKey(name: 'explanation_mm') this.explanationMm = '',
      @JsonKey(name: 'target_phrase_results')
      final List<TargetPhraseResult> targetPhraseResults =
          const <TargetPhraseResult>[],
      @JsonKey(name: 'total_tokens') this.totalTokens = 0})
      : _strengths = strengths,
        _fixes = fixes,
        _pronunciationNotes = pronunciationNotes,
        _targetPhraseResults = targetPhraseResults;

  factory _$DailySpeakingFeedbackImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySpeakingFeedbackImplFromJson(json);

  @override
  final int score;
  @override
  @JsonKey()
  final CefrLevel level;
  @override
  @JsonKey(name: 'inferred_topic')
  final String? inferredTopic;
  @override
  @JsonKey(name: 'duration_seconds')
  final int durationSeconds;
  @override
  @JsonKey(name: 'word_count')
  final int wordCount;
  @override
  @JsonKey(name: 'speaking_pace_wpm')
  final int speakingPaceWpm;
  final List<String> _strengths;
  @override
  @JsonKey()
  List<String> get strengths {
    if (_strengths is EqualUnmodifiableListView) return _strengths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strengths);
  }

  final List<FeedbackFix> _fixes;
  @override
  @JsonKey()
  List<FeedbackFix> get fixes {
    if (_fixes is EqualUnmodifiableListView) return _fixes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fixes);
  }

  @override
  @JsonKey(name: 'native_rewrite')
  final String nativeRewrite;
  final List<String> _pronunciationNotes;
  @override
  @JsonKey(name: 'pronunciation_notes')
  List<String> get pronunciationNotes {
    if (_pronunciationNotes is EqualUnmodifiableListView)
      return _pronunciationNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pronunciationNotes);
  }

  @override
  @JsonKey(name: 'explanation_mm')
  final String explanationMm;
  final List<TargetPhraseResult> _targetPhraseResults;
  @override
  @JsonKey(name: 'target_phrase_results')
  List<TargetPhraseResult> get targetPhraseResults {
    if (_targetPhraseResults is EqualUnmodifiableListView)
      return _targetPhraseResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetPhraseResults);
  }

  @override
  @JsonKey(name: 'total_tokens')
  final int totalTokens;

  @override
  String toString() {
    return 'DailySpeakingFeedback(score: $score, level: $level, inferredTopic: $inferredTopic, durationSeconds: $durationSeconds, wordCount: $wordCount, speakingPaceWpm: $speakingPaceWpm, strengths: $strengths, fixes: $fixes, nativeRewrite: $nativeRewrite, pronunciationNotes: $pronunciationNotes, explanationMm: $explanationMm, targetPhraseResults: $targetPhraseResults, totalTokens: $totalTokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySpeakingFeedbackImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.inferredTopic, inferredTopic) ||
                other.inferredTopic == inferredTopic) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.wordCount, wordCount) ||
                other.wordCount == wordCount) &&
            (identical(other.speakingPaceWpm, speakingPaceWpm) ||
                other.speakingPaceWpm == speakingPaceWpm) &&
            const DeepCollectionEquality()
                .equals(other._strengths, _strengths) &&
            const DeepCollectionEquality().equals(other._fixes, _fixes) &&
            (identical(other.nativeRewrite, nativeRewrite) ||
                other.nativeRewrite == nativeRewrite) &&
            const DeepCollectionEquality()
                .equals(other._pronunciationNotes, _pronunciationNotes) &&
            (identical(other.explanationMm, explanationMm) ||
                other.explanationMm == explanationMm) &&
            const DeepCollectionEquality()
                .equals(other._targetPhraseResults, _targetPhraseResults) &&
            (identical(other.totalTokens, totalTokens) ||
                other.totalTokens == totalTokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      score,
      level,
      inferredTopic,
      durationSeconds,
      wordCount,
      speakingPaceWpm,
      const DeepCollectionEquality().hash(_strengths),
      const DeepCollectionEquality().hash(_fixes),
      nativeRewrite,
      const DeepCollectionEquality().hash(_pronunciationNotes),
      explanationMm,
      const DeepCollectionEquality().hash(_targetPhraseResults),
      totalTokens);

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySpeakingFeedbackImplCopyWith<_$DailySpeakingFeedbackImpl>
      get copyWith => __$$DailySpeakingFeedbackImplCopyWithImpl<
          _$DailySpeakingFeedbackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailySpeakingFeedbackImplToJson(
      this,
    );
  }
}

abstract class _DailySpeakingFeedback implements DailySpeakingFeedback {
  const factory _DailySpeakingFeedback(
          {required final int score,
          final CefrLevel level,
          @JsonKey(name: 'inferred_topic') final String? inferredTopic,
          @JsonKey(name: 'duration_seconds') final int durationSeconds,
          @JsonKey(name: 'word_count') final int wordCount,
          @JsonKey(name: 'speaking_pace_wpm') final int speakingPaceWpm,
          final List<String> strengths,
          final List<FeedbackFix> fixes,
          @JsonKey(name: 'native_rewrite') final String nativeRewrite,
          @JsonKey(name: 'pronunciation_notes')
          final List<String> pronunciationNotes,
          @JsonKey(name: 'explanation_mm') final String explanationMm,
          @JsonKey(name: 'target_phrase_results')
          final List<TargetPhraseResult> targetPhraseResults,
          @JsonKey(name: 'total_tokens') final int totalTokens}) =
      _$DailySpeakingFeedbackImpl;

  factory _DailySpeakingFeedback.fromJson(Map<String, dynamic> json) =
      _$DailySpeakingFeedbackImpl.fromJson;

  @override
  int get score;
  @override
  CefrLevel get level;
  @override
  @JsonKey(name: 'inferred_topic')
  String? get inferredTopic;
  @override
  @JsonKey(name: 'duration_seconds')
  int get durationSeconds;
  @override
  @JsonKey(name: 'word_count')
  int get wordCount;
  @override
  @JsonKey(name: 'speaking_pace_wpm')
  int get speakingPaceWpm;
  @override
  List<String> get strengths;
  @override
  List<FeedbackFix> get fixes;
  @override
  @JsonKey(name: 'native_rewrite')
  String get nativeRewrite;
  @override
  @JsonKey(name: 'pronunciation_notes')
  List<String> get pronunciationNotes;
  @override
  @JsonKey(name: 'explanation_mm')
  String get explanationMm;
  @override
  @JsonKey(name: 'target_phrase_results')
  List<TargetPhraseResult> get targetPhraseResults;
  @override
  @JsonKey(name: 'total_tokens')
  int get totalTokens;

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySpeakingFeedbackImplCopyWith<_$DailySpeakingFeedbackImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeedbackFix _$FeedbackFixFromJson(Map<String, dynamic> json) {
  return _FeedbackFix.fromJson(json);
}

/// @nodoc
mixin _$FeedbackFix {
  String get original => throw _privateConstructorUsedError;
  String get corrected => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason_mm')
  String get reasonMm => throw _privateConstructorUsedError;

  /// Serializes this FeedbackFix to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedbackFix
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedbackFixCopyWith<FeedbackFix> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackFixCopyWith<$Res> {
  factory $FeedbackFixCopyWith(
          FeedbackFix value, $Res Function(FeedbackFix) then) =
      _$FeedbackFixCopyWithImpl<$Res, FeedbackFix>;
  @useResult
  $Res call(
      {String original,
      String corrected,
      @JsonKey(name: 'reason_mm') String reasonMm});
}

/// @nodoc
class _$FeedbackFixCopyWithImpl<$Res, $Val extends FeedbackFix>
    implements $FeedbackFixCopyWith<$Res> {
  _$FeedbackFixCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedbackFix
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? corrected = null,
    Object? reasonMm = null,
  }) {
    return _then(_value.copyWith(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      corrected: null == corrected
          ? _value.corrected
          : corrected // ignore: cast_nullable_to_non_nullable
              as String,
      reasonMm: null == reasonMm
          ? _value.reasonMm
          : reasonMm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackFixImplCopyWith<$Res>
    implements $FeedbackFixCopyWith<$Res> {
  factory _$$FeedbackFixImplCopyWith(
          _$FeedbackFixImpl value, $Res Function(_$FeedbackFixImpl) then) =
      __$$FeedbackFixImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String original,
      String corrected,
      @JsonKey(name: 'reason_mm') String reasonMm});
}

/// @nodoc
class __$$FeedbackFixImplCopyWithImpl<$Res>
    extends _$FeedbackFixCopyWithImpl<$Res, _$FeedbackFixImpl>
    implements _$$FeedbackFixImplCopyWith<$Res> {
  __$$FeedbackFixImplCopyWithImpl(
      _$FeedbackFixImpl _value, $Res Function(_$FeedbackFixImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedbackFix
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? corrected = null,
    Object? reasonMm = null,
  }) {
    return _then(_$FeedbackFixImpl(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      corrected: null == corrected
          ? _value.corrected
          : corrected // ignore: cast_nullable_to_non_nullable
              as String,
      reasonMm: null == reasonMm
          ? _value.reasonMm
          : reasonMm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackFixImpl implements _FeedbackFix {
  const _$FeedbackFixImpl(
      {required this.original,
      required this.corrected,
      @JsonKey(name: 'reason_mm') required this.reasonMm});

  factory _$FeedbackFixImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackFixImplFromJson(json);

  @override
  final String original;
  @override
  final String corrected;
  @override
  @JsonKey(name: 'reason_mm')
  final String reasonMm;

  @override
  String toString() {
    return 'FeedbackFix(original: $original, corrected: $corrected, reasonMm: $reasonMm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackFixImpl &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.corrected, corrected) ||
                other.corrected == corrected) &&
            (identical(other.reasonMm, reasonMm) ||
                other.reasonMm == reasonMm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, original, corrected, reasonMm);

  /// Create a copy of FeedbackFix
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackFixImplCopyWith<_$FeedbackFixImpl> get copyWith =>
      __$$FeedbackFixImplCopyWithImpl<_$FeedbackFixImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackFixImplToJson(
      this,
    );
  }
}

abstract class _FeedbackFix implements FeedbackFix {
  const factory _FeedbackFix(
          {required final String original,
          required final String corrected,
          @JsonKey(name: 'reason_mm') required final String reasonMm}) =
      _$FeedbackFixImpl;

  factory _FeedbackFix.fromJson(Map<String, dynamic> json) =
      _$FeedbackFixImpl.fromJson;

  @override
  String get original;
  @override
  String get corrected;
  @override
  @JsonKey(name: 'reason_mm')
  String get reasonMm;

  /// Create a copy of FeedbackFix
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedbackFixImplCopyWith<_$FeedbackFixImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TargetPhraseResult _$TargetPhraseResultFromJson(Map<String, dynamic> json) {
  return _TargetPhraseResult.fromJson(json);
}

/// @nodoc
mixin _$TargetPhraseResult {
  @JsonKey(name: 'phrase_en')
  String get phraseEn => throw _privateConstructorUsedError;
  bool get used => throw _privateConstructorUsedError;
  @JsonKey(name: 'used_correctly')
  bool get usedCorrectly => throw _privateConstructorUsedError;

  /// Serializes this TargetPhraseResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TargetPhraseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TargetPhraseResultCopyWith<TargetPhraseResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TargetPhraseResultCopyWith<$Res> {
  factory $TargetPhraseResultCopyWith(
          TargetPhraseResult value, $Res Function(TargetPhraseResult) then) =
      _$TargetPhraseResultCopyWithImpl<$Res, TargetPhraseResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'phrase_en') String phraseEn,
      bool used,
      @JsonKey(name: 'used_correctly') bool usedCorrectly});
}

/// @nodoc
class _$TargetPhraseResultCopyWithImpl<$Res, $Val extends TargetPhraseResult>
    implements $TargetPhraseResultCopyWith<$Res> {
  _$TargetPhraseResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TargetPhraseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phraseEn = null,
    Object? used = null,
    Object? usedCorrectly = null,
  }) {
    return _then(_value.copyWith(
      phraseEn: null == phraseEn
          ? _value.phraseEn
          : phraseEn // ignore: cast_nullable_to_non_nullable
              as String,
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as bool,
      usedCorrectly: null == usedCorrectly
          ? _value.usedCorrectly
          : usedCorrectly // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TargetPhraseResultImplCopyWith<$Res>
    implements $TargetPhraseResultCopyWith<$Res> {
  factory _$$TargetPhraseResultImplCopyWith(_$TargetPhraseResultImpl value,
          $Res Function(_$TargetPhraseResultImpl) then) =
      __$$TargetPhraseResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'phrase_en') String phraseEn,
      bool used,
      @JsonKey(name: 'used_correctly') bool usedCorrectly});
}

/// @nodoc
class __$$TargetPhraseResultImplCopyWithImpl<$Res>
    extends _$TargetPhraseResultCopyWithImpl<$Res, _$TargetPhraseResultImpl>
    implements _$$TargetPhraseResultImplCopyWith<$Res> {
  __$$TargetPhraseResultImplCopyWithImpl(_$TargetPhraseResultImpl _value,
      $Res Function(_$TargetPhraseResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of TargetPhraseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phraseEn = null,
    Object? used = null,
    Object? usedCorrectly = null,
  }) {
    return _then(_$TargetPhraseResultImpl(
      phraseEn: null == phraseEn
          ? _value.phraseEn
          : phraseEn // ignore: cast_nullable_to_non_nullable
              as String,
      used: null == used
          ? _value.used
          : used // ignore: cast_nullable_to_non_nullable
              as bool,
      usedCorrectly: null == usedCorrectly
          ? _value.usedCorrectly
          : usedCorrectly // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TargetPhraseResultImpl implements _TargetPhraseResult {
  const _$TargetPhraseResultImpl(
      {@JsonKey(name: 'phrase_en') required this.phraseEn,
      required this.used,
      @JsonKey(name: 'used_correctly') this.usedCorrectly = false});

  factory _$TargetPhraseResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$TargetPhraseResultImplFromJson(json);

  @override
  @JsonKey(name: 'phrase_en')
  final String phraseEn;
  @override
  final bool used;
  @override
  @JsonKey(name: 'used_correctly')
  final bool usedCorrectly;

  @override
  String toString() {
    return 'TargetPhraseResult(phraseEn: $phraseEn, used: $used, usedCorrectly: $usedCorrectly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TargetPhraseResultImpl &&
            (identical(other.phraseEn, phraseEn) ||
                other.phraseEn == phraseEn) &&
            (identical(other.used, used) || other.used == used) &&
            (identical(other.usedCorrectly, usedCorrectly) ||
                other.usedCorrectly == usedCorrectly));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phraseEn, used, usedCorrectly);

  /// Create a copy of TargetPhraseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TargetPhraseResultImplCopyWith<_$TargetPhraseResultImpl> get copyWith =>
      __$$TargetPhraseResultImplCopyWithImpl<_$TargetPhraseResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TargetPhraseResultImplToJson(
      this,
    );
  }
}

abstract class _TargetPhraseResult implements TargetPhraseResult {
  const factory _TargetPhraseResult(
          {@JsonKey(name: 'phrase_en') required final String phraseEn,
          required final bool used,
          @JsonKey(name: 'used_correctly') final bool usedCorrectly}) =
      _$TargetPhraseResultImpl;

  factory _TargetPhraseResult.fromJson(Map<String, dynamic> json) =
      _$TargetPhraseResultImpl.fromJson;

  @override
  @JsonKey(name: 'phrase_en')
  String get phraseEn;
  @override
  bool get used;
  @override
  @JsonKey(name: 'used_correctly')
  bool get usedCorrectly;

  /// Create a copy of TargetPhraseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TargetPhraseResultImplCopyWith<_$TargetPhraseResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
