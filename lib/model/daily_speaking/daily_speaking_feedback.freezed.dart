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

  /// The learner's words as the AI heard them. Always returned for voice
  /// sessions (Gemini already reads the audio, so the marginal token cost is
  /// small) and persisted into the session's `inputText` so the result page
  /// and history can show what was actually said. Empty on the text path,
  /// where `inputText` already holds the typed words.
  @JsonKey(name: 'transcript')
  String get transcript => throw _privateConstructorUsedError;
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
      throw _privateConstructorUsedError; // --- Optional sections, returned only when requested via
// `requested_sections`. All default-empty so the result page can keep
// rendering each section iff non-empty.
  @JsonKey(name: 'grammar_patterns')
  List<String> get grammarPatterns => throw _privateConstructorUsedError;
  @JsonKey(name: 'interference_notes')
  List<FeedbackFix> get interferenceNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'vocab_upgrades')
  List<VocabUpgrade> get vocabUpgrades => throw _privateConstructorUsedError;

  /// Natural phrases (collocations + idioms) the learner could pick up —
  /// suggestions seeded by the topic, NOT pulled from what they said. Each
  /// carries a Burmese (and optional English) meaning plus example sentences,
  /// so a learner who doesn't know the phrase can tap to learn how to use it.
  /// The `kind` discriminator lets the choose-feedback `collocations` /
  /// `idioms` toggles filter independently.
  List<PhraseSuggestion> get phrases => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentence_rewrites')
  List<SentenceRewrite> get sentenceRewrites =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'filler_words')
  List<FillerWord> get fillerWords => throw _privateConstructorUsedError;
  @JsonKey(name: 'sub_scores')
  SubScores? get subScores => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_tokens')
  int get totalTokens =>
      throw _privateConstructorUsedError; // --- v2: the annotated transcript. When present, this is the single source
// of truth for the transcript, the inline highlights, the sentence-aligned
// split, and the derived `effective*` lists below. Older payloads (and the
// legacy stub responses) leave it empty and fall back to the flat lists.
  List<FeedbackSentence> get sentences => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'transcript') String transcript,
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
      @JsonKey(name: 'grammar_patterns') List<String> grammarPatterns,
      @JsonKey(name: 'interference_notes') List<FeedbackFix> interferenceNotes,
      @JsonKey(name: 'vocab_upgrades') List<VocabUpgrade> vocabUpgrades,
      List<PhraseSuggestion> phrases,
      @JsonKey(name: 'sentence_rewrites')
      List<SentenceRewrite> sentenceRewrites,
      @JsonKey(name: 'filler_words') List<FillerWord> fillerWords,
      @JsonKey(name: 'sub_scores') SubScores? subScores,
      @JsonKey(name: 'total_tokens') int totalTokens,
      List<FeedbackSentence> sentences});

  $SubScoresCopyWith<$Res>? get subScores;
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
    Object? transcript = null,
    Object? durationSeconds = null,
    Object? wordCount = null,
    Object? speakingPaceWpm = null,
    Object? strengths = null,
    Object? fixes = null,
    Object? nativeRewrite = null,
    Object? pronunciationNotes = null,
    Object? explanationMm = null,
    Object? targetPhraseResults = null,
    Object? grammarPatterns = null,
    Object? interferenceNotes = null,
    Object? vocabUpgrades = null,
    Object? phrases = null,
    Object? sentenceRewrites = null,
    Object? fillerWords = null,
    Object? subScores = freezed,
    Object? totalTokens = null,
    Object? sentences = null,
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
      transcript: null == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String,
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
      grammarPatterns: null == grammarPatterns
          ? _value.grammarPatterns
          : grammarPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interferenceNotes: null == interferenceNotes
          ? _value.interferenceNotes
          : interferenceNotes // ignore: cast_nullable_to_non_nullable
              as List<FeedbackFix>,
      vocabUpgrades: null == vocabUpgrades
          ? _value.vocabUpgrades
          : vocabUpgrades // ignore: cast_nullable_to_non_nullable
              as List<VocabUpgrade>,
      phrases: null == phrases
          ? _value.phrases
          : phrases // ignore: cast_nullable_to_non_nullable
              as List<PhraseSuggestion>,
      sentenceRewrites: null == sentenceRewrites
          ? _value.sentenceRewrites
          : sentenceRewrites // ignore: cast_nullable_to_non_nullable
              as List<SentenceRewrite>,
      fillerWords: null == fillerWords
          ? _value.fillerWords
          : fillerWords // ignore: cast_nullable_to_non_nullable
              as List<FillerWord>,
      subScores: freezed == subScores
          ? _value.subScores
          : subScores // ignore: cast_nullable_to_non_nullable
              as SubScores?,
      totalTokens: null == totalTokens
          ? _value.totalTokens
          : totalTokens // ignore: cast_nullable_to_non_nullable
              as int,
      sentences: null == sentences
          ? _value.sentences
          : sentences // ignore: cast_nullable_to_non_nullable
              as List<FeedbackSentence>,
    ) as $Val);
  }

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubScoresCopyWith<$Res>? get subScores {
    if (_value.subScores == null) {
      return null;
    }

    return $SubScoresCopyWith<$Res>(_value.subScores!, (value) {
      return _then(_value.copyWith(subScores: value) as $Val);
    });
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
      @JsonKey(name: 'transcript') String transcript,
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
      @JsonKey(name: 'grammar_patterns') List<String> grammarPatterns,
      @JsonKey(name: 'interference_notes') List<FeedbackFix> interferenceNotes,
      @JsonKey(name: 'vocab_upgrades') List<VocabUpgrade> vocabUpgrades,
      List<PhraseSuggestion> phrases,
      @JsonKey(name: 'sentence_rewrites')
      List<SentenceRewrite> sentenceRewrites,
      @JsonKey(name: 'filler_words') List<FillerWord> fillerWords,
      @JsonKey(name: 'sub_scores') SubScores? subScores,
      @JsonKey(name: 'total_tokens') int totalTokens,
      List<FeedbackSentence> sentences});

  @override
  $SubScoresCopyWith<$Res>? get subScores;
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
    Object? transcript = null,
    Object? durationSeconds = null,
    Object? wordCount = null,
    Object? speakingPaceWpm = null,
    Object? strengths = null,
    Object? fixes = null,
    Object? nativeRewrite = null,
    Object? pronunciationNotes = null,
    Object? explanationMm = null,
    Object? targetPhraseResults = null,
    Object? grammarPatterns = null,
    Object? interferenceNotes = null,
    Object? vocabUpgrades = null,
    Object? phrases = null,
    Object? sentenceRewrites = null,
    Object? fillerWords = null,
    Object? subScores = freezed,
    Object? totalTokens = null,
    Object? sentences = null,
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
      transcript: null == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String,
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
      grammarPatterns: null == grammarPatterns
          ? _value._grammarPatterns
          : grammarPatterns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      interferenceNotes: null == interferenceNotes
          ? _value._interferenceNotes
          : interferenceNotes // ignore: cast_nullable_to_non_nullable
              as List<FeedbackFix>,
      vocabUpgrades: null == vocabUpgrades
          ? _value._vocabUpgrades
          : vocabUpgrades // ignore: cast_nullable_to_non_nullable
              as List<VocabUpgrade>,
      phrases: null == phrases
          ? _value._phrases
          : phrases // ignore: cast_nullable_to_non_nullable
              as List<PhraseSuggestion>,
      sentenceRewrites: null == sentenceRewrites
          ? _value._sentenceRewrites
          : sentenceRewrites // ignore: cast_nullable_to_non_nullable
              as List<SentenceRewrite>,
      fillerWords: null == fillerWords
          ? _value._fillerWords
          : fillerWords // ignore: cast_nullable_to_non_nullable
              as List<FillerWord>,
      subScores: freezed == subScores
          ? _value.subScores
          : subScores // ignore: cast_nullable_to_non_nullable
              as SubScores?,
      totalTokens: null == totalTokens
          ? _value.totalTokens
          : totalTokens // ignore: cast_nullable_to_non_nullable
              as int,
      sentences: null == sentences
          ? _value._sentences
          : sentences // ignore: cast_nullable_to_non_nullable
              as List<FeedbackSentence>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySpeakingFeedbackImpl extends _DailySpeakingFeedback {
  const _$DailySpeakingFeedbackImpl(
      {required this.score,
      this.level = CefrLevel.beginner,
      @JsonKey(name: 'inferred_topic') this.inferredTopic,
      @JsonKey(name: 'transcript') this.transcript = '',
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
      @JsonKey(name: 'grammar_patterns')
      final List<String> grammarPatterns = const <String>[],
      @JsonKey(name: 'interference_notes')
      final List<FeedbackFix> interferenceNotes = const <FeedbackFix>[],
      @JsonKey(name: 'vocab_upgrades')
      final List<VocabUpgrade> vocabUpgrades = const <VocabUpgrade>[],
      final List<PhraseSuggestion> phrases = const <PhraseSuggestion>[],
      @JsonKey(name: 'sentence_rewrites')
      final List<SentenceRewrite> sentenceRewrites = const <SentenceRewrite>[],
      @JsonKey(name: 'filler_words')
      final List<FillerWord> fillerWords = const <FillerWord>[],
      @JsonKey(name: 'sub_scores') this.subScores,
      @JsonKey(name: 'total_tokens') this.totalTokens = 0,
      final List<FeedbackSentence> sentences = const <FeedbackSentence>[]})
      : _strengths = strengths,
        _fixes = fixes,
        _pronunciationNotes = pronunciationNotes,
        _targetPhraseResults = targetPhraseResults,
        _grammarPatterns = grammarPatterns,
        _interferenceNotes = interferenceNotes,
        _vocabUpgrades = vocabUpgrades,
        _phrases = phrases,
        _sentenceRewrites = sentenceRewrites,
        _fillerWords = fillerWords,
        _sentences = sentences,
        super._();

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

  /// The learner's words as the AI heard them. Always returned for voice
  /// sessions (Gemini already reads the audio, so the marginal token cost is
  /// small) and persisted into the session's `inputText` so the result page
  /// and history can show what was actually said. Empty on the text path,
  /// where `inputText` already holds the typed words.
  @override
  @JsonKey(name: 'transcript')
  final String transcript;
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

// --- Optional sections, returned only when requested via
// `requested_sections`. All default-empty so the result page can keep
// rendering each section iff non-empty.
  final List<String> _grammarPatterns;
// --- Optional sections, returned only when requested via
// `requested_sections`. All default-empty so the result page can keep
// rendering each section iff non-empty.
  @override
  @JsonKey(name: 'grammar_patterns')
  List<String> get grammarPatterns {
    if (_grammarPatterns is EqualUnmodifiableListView) return _grammarPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grammarPatterns);
  }

  final List<FeedbackFix> _interferenceNotes;
  @override
  @JsonKey(name: 'interference_notes')
  List<FeedbackFix> get interferenceNotes {
    if (_interferenceNotes is EqualUnmodifiableListView)
      return _interferenceNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interferenceNotes);
  }

  final List<VocabUpgrade> _vocabUpgrades;
  @override
  @JsonKey(name: 'vocab_upgrades')
  List<VocabUpgrade> get vocabUpgrades {
    if (_vocabUpgrades is EqualUnmodifiableListView) return _vocabUpgrades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vocabUpgrades);
  }

  /// Natural phrases (collocations + idioms) the learner could pick up —
  /// suggestions seeded by the topic, NOT pulled from what they said. Each
  /// carries a Burmese (and optional English) meaning plus example sentences,
  /// so a learner who doesn't know the phrase can tap to learn how to use it.
  /// The `kind` discriminator lets the choose-feedback `collocations` /
  /// `idioms` toggles filter independently.
  final List<PhraseSuggestion> _phrases;

  /// Natural phrases (collocations + idioms) the learner could pick up —
  /// suggestions seeded by the topic, NOT pulled from what they said. Each
  /// carries a Burmese (and optional English) meaning plus example sentences,
  /// so a learner who doesn't know the phrase can tap to learn how to use it.
  /// The `kind` discriminator lets the choose-feedback `collocations` /
  /// `idioms` toggles filter independently.
  @override
  @JsonKey()
  List<PhraseSuggestion> get phrases {
    if (_phrases is EqualUnmodifiableListView) return _phrases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phrases);
  }

  final List<SentenceRewrite> _sentenceRewrites;
  @override
  @JsonKey(name: 'sentence_rewrites')
  List<SentenceRewrite> get sentenceRewrites {
    if (_sentenceRewrites is EqualUnmodifiableListView)
      return _sentenceRewrites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentenceRewrites);
  }

  final List<FillerWord> _fillerWords;
  @override
  @JsonKey(name: 'filler_words')
  List<FillerWord> get fillerWords {
    if (_fillerWords is EqualUnmodifiableListView) return _fillerWords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fillerWords);
  }

  @override
  @JsonKey(name: 'sub_scores')
  final SubScores? subScores;
  @override
  @JsonKey(name: 'total_tokens')
  final int totalTokens;
// --- v2: the annotated transcript. When present, this is the single source
// of truth for the transcript, the inline highlights, the sentence-aligned
// split, and the derived `effective*` lists below. Older payloads (and the
// legacy stub responses) leave it empty and fall back to the flat lists.
  final List<FeedbackSentence> _sentences;
// --- v2: the annotated transcript. When present, this is the single source
// of truth for the transcript, the inline highlights, the sentence-aligned
// split, and the derived `effective*` lists below. Older payloads (and the
// legacy stub responses) leave it empty and fall back to the flat lists.
  @override
  @JsonKey()
  List<FeedbackSentence> get sentences {
    if (_sentences is EqualUnmodifiableListView) return _sentences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentences);
  }

  @override
  String toString() {
    return 'DailySpeakingFeedback(score: $score, level: $level, inferredTopic: $inferredTopic, transcript: $transcript, durationSeconds: $durationSeconds, wordCount: $wordCount, speakingPaceWpm: $speakingPaceWpm, strengths: $strengths, fixes: $fixes, nativeRewrite: $nativeRewrite, pronunciationNotes: $pronunciationNotes, explanationMm: $explanationMm, targetPhraseResults: $targetPhraseResults, grammarPatterns: $grammarPatterns, interferenceNotes: $interferenceNotes, vocabUpgrades: $vocabUpgrades, phrases: $phrases, sentenceRewrites: $sentenceRewrites, fillerWords: $fillerWords, subScores: $subScores, totalTokens: $totalTokens, sentences: $sentences)';
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
            (identical(other.transcript, transcript) ||
                other.transcript == transcript) &&
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
            const DeepCollectionEquality()
                .equals(other._grammarPatterns, _grammarPatterns) &&
            const DeepCollectionEquality()
                .equals(other._interferenceNotes, _interferenceNotes) &&
            const DeepCollectionEquality()
                .equals(other._vocabUpgrades, _vocabUpgrades) &&
            const DeepCollectionEquality().equals(other._phrases, _phrases) &&
            const DeepCollectionEquality()
                .equals(other._sentenceRewrites, _sentenceRewrites) &&
            const DeepCollectionEquality()
                .equals(other._fillerWords, _fillerWords) &&
            (identical(other.subScores, subScores) ||
                other.subScores == subScores) &&
            (identical(other.totalTokens, totalTokens) ||
                other.totalTokens == totalTokens) &&
            const DeepCollectionEquality()
                .equals(other._sentences, _sentences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        score,
        level,
        inferredTopic,
        transcript,
        durationSeconds,
        wordCount,
        speakingPaceWpm,
        const DeepCollectionEquality().hash(_strengths),
        const DeepCollectionEquality().hash(_fixes),
        nativeRewrite,
        const DeepCollectionEquality().hash(_pronunciationNotes),
        explanationMm,
        const DeepCollectionEquality().hash(_targetPhraseResults),
        const DeepCollectionEquality().hash(_grammarPatterns),
        const DeepCollectionEquality().hash(_interferenceNotes),
        const DeepCollectionEquality().hash(_vocabUpgrades),
        const DeepCollectionEquality().hash(_phrases),
        const DeepCollectionEquality().hash(_sentenceRewrites),
        const DeepCollectionEquality().hash(_fillerWords),
        subScores,
        totalTokens,
        const DeepCollectionEquality().hash(_sentences)
      ]);

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

abstract class _DailySpeakingFeedback extends DailySpeakingFeedback {
  const factory _DailySpeakingFeedback(
      {required final int score,
      final CefrLevel level,
      @JsonKey(name: 'inferred_topic') final String? inferredTopic,
      @JsonKey(name: 'transcript') final String transcript,
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
      @JsonKey(name: 'grammar_patterns') final List<String> grammarPatterns,
      @JsonKey(name: 'interference_notes')
      final List<FeedbackFix> interferenceNotes,
      @JsonKey(name: 'vocab_upgrades') final List<VocabUpgrade> vocabUpgrades,
      final List<PhraseSuggestion> phrases,
      @JsonKey(name: 'sentence_rewrites')
      final List<SentenceRewrite> sentenceRewrites,
      @JsonKey(name: 'filler_words') final List<FillerWord> fillerWords,
      @JsonKey(name: 'sub_scores') final SubScores? subScores,
      @JsonKey(name: 'total_tokens') final int totalTokens,
      final List<FeedbackSentence> sentences}) = _$DailySpeakingFeedbackImpl;
  const _DailySpeakingFeedback._() : super._();

  factory _DailySpeakingFeedback.fromJson(Map<String, dynamic> json) =
      _$DailySpeakingFeedbackImpl.fromJson;

  @override
  int get score;
  @override
  CefrLevel get level;
  @override
  @JsonKey(name: 'inferred_topic')
  String? get inferredTopic;

  /// The learner's words as the AI heard them. Always returned for voice
  /// sessions (Gemini already reads the audio, so the marginal token cost is
  /// small) and persisted into the session's `inputText` so the result page
  /// and history can show what was actually said. Empty on the text path,
  /// where `inputText` already holds the typed words.
  @override
  @JsonKey(name: 'transcript')
  String get transcript;
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
  List<TargetPhraseResult>
      get targetPhraseResults; // --- Optional sections, returned only when requested via
// `requested_sections`. All default-empty so the result page can keep
// rendering each section iff non-empty.
  @override
  @JsonKey(name: 'grammar_patterns')
  List<String> get grammarPatterns;
  @override
  @JsonKey(name: 'interference_notes')
  List<FeedbackFix> get interferenceNotes;
  @override
  @JsonKey(name: 'vocab_upgrades')
  List<VocabUpgrade> get vocabUpgrades;

  /// Natural phrases (collocations + idioms) the learner could pick up —
  /// suggestions seeded by the topic, NOT pulled from what they said. Each
  /// carries a Burmese (and optional English) meaning plus example sentences,
  /// so a learner who doesn't know the phrase can tap to learn how to use it.
  /// The `kind` discriminator lets the choose-feedback `collocations` /
  /// `idioms` toggles filter independently.
  @override
  List<PhraseSuggestion> get phrases;
  @override
  @JsonKey(name: 'sentence_rewrites')
  List<SentenceRewrite> get sentenceRewrites;
  @override
  @JsonKey(name: 'filler_words')
  List<FillerWord> get fillerWords;
  @override
  @JsonKey(name: 'sub_scores')
  SubScores? get subScores;
  @override
  @JsonKey(name: 'total_tokens')
  int get totalTokens; // --- v2: the annotated transcript. When present, this is the single source
// of truth for the transcript, the inline highlights, the sentence-aligned
// split, and the derived `effective*` lists below. Older payloads (and the
// legacy stub responses) leave it empty and fall back to the flat lists.
  @override
  List<FeedbackSentence> get sentences;

  /// Create a copy of DailySpeakingFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySpeakingFeedbackImplCopyWith<_$DailySpeakingFeedbackImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeedbackSentence _$FeedbackSentenceFromJson(Map<String, dynamic> json) {
  return _FeedbackSentence.fromJson(json);
}

/// @nodoc
mixin _$FeedbackSentence {
  String get original => throw _privateConstructorUsedError;
  String get native => throw _privateConstructorUsedError;
  bool get changed => throw _privateConstructorUsedError;
  List<FeedbackSegment> get segments => throw _privateConstructorUsedError;

  /// Serializes this FeedbackSentence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedbackSentence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedbackSentenceCopyWith<FeedbackSentence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackSentenceCopyWith<$Res> {
  factory $FeedbackSentenceCopyWith(
          FeedbackSentence value, $Res Function(FeedbackSentence) then) =
      _$FeedbackSentenceCopyWithImpl<$Res, FeedbackSentence>;
  @useResult
  $Res call(
      {String original,
      String native,
      bool changed,
      List<FeedbackSegment> segments});
}

/// @nodoc
class _$FeedbackSentenceCopyWithImpl<$Res, $Val extends FeedbackSentence>
    implements $FeedbackSentenceCopyWith<$Res> {
  _$FeedbackSentenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedbackSentence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? native = null,
    Object? changed = null,
    Object? segments = null,
  }) {
    return _then(_value.copyWith(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      native: null == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String,
      changed: null == changed
          ? _value.changed
          : changed // ignore: cast_nullable_to_non_nullable
              as bool,
      segments: null == segments
          ? _value.segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<FeedbackSegment>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackSentenceImplCopyWith<$Res>
    implements $FeedbackSentenceCopyWith<$Res> {
  factory _$$FeedbackSentenceImplCopyWith(_$FeedbackSentenceImpl value,
          $Res Function(_$FeedbackSentenceImpl) then) =
      __$$FeedbackSentenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String original,
      String native,
      bool changed,
      List<FeedbackSegment> segments});
}

/// @nodoc
class __$$FeedbackSentenceImplCopyWithImpl<$Res>
    extends _$FeedbackSentenceCopyWithImpl<$Res, _$FeedbackSentenceImpl>
    implements _$$FeedbackSentenceImplCopyWith<$Res> {
  __$$FeedbackSentenceImplCopyWithImpl(_$FeedbackSentenceImpl _value,
      $Res Function(_$FeedbackSentenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedbackSentence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? native = null,
    Object? changed = null,
    Object? segments = null,
  }) {
    return _then(_$FeedbackSentenceImpl(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      native: null == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String,
      changed: null == changed
          ? _value.changed
          : changed // ignore: cast_nullable_to_non_nullable
              as bool,
      segments: null == segments
          ? _value._segments
          : segments // ignore: cast_nullable_to_non_nullable
              as List<FeedbackSegment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackSentenceImpl implements _FeedbackSentence {
  const _$FeedbackSentenceImpl(
      {required this.original,
      this.native = '',
      this.changed = false,
      final List<FeedbackSegment> segments = const <FeedbackSegment>[]})
      : _segments = segments;

  factory _$FeedbackSentenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackSentenceImplFromJson(json);

  @override
  final String original;
  @override
  @JsonKey()
  final String native;
  @override
  @JsonKey()
  final bool changed;
  final List<FeedbackSegment> _segments;
  @override
  @JsonKey()
  List<FeedbackSegment> get segments {
    if (_segments is EqualUnmodifiableListView) return _segments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_segments);
  }

  @override
  String toString() {
    return 'FeedbackSentence(original: $original, native: $native, changed: $changed, segments: $segments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackSentenceImpl &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.native, native) || other.native == native) &&
            (identical(other.changed, changed) || other.changed == changed) &&
            const DeepCollectionEquality().equals(other._segments, _segments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, original, native, changed,
      const DeepCollectionEquality().hash(_segments));

  /// Create a copy of FeedbackSentence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackSentenceImplCopyWith<_$FeedbackSentenceImpl> get copyWith =>
      __$$FeedbackSentenceImplCopyWithImpl<_$FeedbackSentenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackSentenceImplToJson(
      this,
    );
  }
}

abstract class _FeedbackSentence implements FeedbackSentence {
  const factory _FeedbackSentence(
      {required final String original,
      final String native,
      final bool changed,
      final List<FeedbackSegment> segments}) = _$FeedbackSentenceImpl;

  factory _FeedbackSentence.fromJson(Map<String, dynamic> json) =
      _$FeedbackSentenceImpl.fromJson;

  @override
  String get original;
  @override
  String get native;
  @override
  bool get changed;
  @override
  List<FeedbackSegment> get segments;

  /// Create a copy of FeedbackSentence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedbackSentenceImplCopyWith<_$FeedbackSentenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedbackSegment _$FeedbackSegmentFromJson(Map<String, dynamic> json) {
  return _FeedbackSegment.fromJson(json);
}

/// @nodoc
mixin _$FeedbackSegment {
  String get text => throw _privateConstructorUsedError;
  SegmentType? get type => throw _privateConstructorUsedError;
  String get correction => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason_mm')
  String get reasonMm => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason_en')
  String get reasonEn => throw _privateConstructorUsedError;

  /// Serializes this FeedbackSegment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedbackSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedbackSegmentCopyWith<FeedbackSegment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedbackSegmentCopyWith<$Res> {
  factory $FeedbackSegmentCopyWith(
          FeedbackSegment value, $Res Function(FeedbackSegment) then) =
      _$FeedbackSegmentCopyWithImpl<$Res, FeedbackSegment>;
  @useResult
  $Res call(
      {String text,
      SegmentType? type,
      String correction,
      @JsonKey(name: 'reason_mm') String reasonMm,
      @JsonKey(name: 'reason_en') String reasonEn});
}

/// @nodoc
class _$FeedbackSegmentCopyWithImpl<$Res, $Val extends FeedbackSegment>
    implements $FeedbackSegmentCopyWith<$Res> {
  _$FeedbackSegmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedbackSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = freezed,
    Object? correction = null,
    Object? reasonMm = null,
    Object? reasonEn = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SegmentType?,
      correction: null == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String,
      reasonMm: null == reasonMm
          ? _value.reasonMm
          : reasonMm // ignore: cast_nullable_to_non_nullable
              as String,
      reasonEn: null == reasonEn
          ? _value.reasonEn
          : reasonEn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedbackSegmentImplCopyWith<$Res>
    implements $FeedbackSegmentCopyWith<$Res> {
  factory _$$FeedbackSegmentImplCopyWith(_$FeedbackSegmentImpl value,
          $Res Function(_$FeedbackSegmentImpl) then) =
      __$$FeedbackSegmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String text,
      SegmentType? type,
      String correction,
      @JsonKey(name: 'reason_mm') String reasonMm,
      @JsonKey(name: 'reason_en') String reasonEn});
}

/// @nodoc
class __$$FeedbackSegmentImplCopyWithImpl<$Res>
    extends _$FeedbackSegmentCopyWithImpl<$Res, _$FeedbackSegmentImpl>
    implements _$$FeedbackSegmentImplCopyWith<$Res> {
  __$$FeedbackSegmentImplCopyWithImpl(
      _$FeedbackSegmentImpl _value, $Res Function(_$FeedbackSegmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedbackSegment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? type = freezed,
    Object? correction = null,
    Object? reasonMm = null,
    Object? reasonEn = null,
  }) {
    return _then(_$FeedbackSegmentImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SegmentType?,
      correction: null == correction
          ? _value.correction
          : correction // ignore: cast_nullable_to_non_nullable
              as String,
      reasonMm: null == reasonMm
          ? _value.reasonMm
          : reasonMm // ignore: cast_nullable_to_non_nullable
              as String,
      reasonEn: null == reasonEn
          ? _value.reasonEn
          : reasonEn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedbackSegmentImpl extends _FeedbackSegment {
  const _$FeedbackSegmentImpl(
      {required this.text,
      this.type,
      this.correction = '',
      @JsonKey(name: 'reason_mm') this.reasonMm = '',
      @JsonKey(name: 'reason_en') this.reasonEn = ''})
      : super._();

  factory _$FeedbackSegmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedbackSegmentImplFromJson(json);

  @override
  final String text;
  @override
  final SegmentType? type;
  @override
  @JsonKey()
  final String correction;
  @override
  @JsonKey(name: 'reason_mm')
  final String reasonMm;
  @override
  @JsonKey(name: 'reason_en')
  final String reasonEn;

  @override
  String toString() {
    return 'FeedbackSegment(text: $text, type: $type, correction: $correction, reasonMm: $reasonMm, reasonEn: $reasonEn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedbackSegmentImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.correction, correction) ||
                other.correction == correction) &&
            (identical(other.reasonMm, reasonMm) ||
                other.reasonMm == reasonMm) &&
            (identical(other.reasonEn, reasonEn) ||
                other.reasonEn == reasonEn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, text, type, correction, reasonMm, reasonEn);

  /// Create a copy of FeedbackSegment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedbackSegmentImplCopyWith<_$FeedbackSegmentImpl> get copyWith =>
      __$$FeedbackSegmentImplCopyWithImpl<_$FeedbackSegmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedbackSegmentImplToJson(
      this,
    );
  }
}

abstract class _FeedbackSegment extends FeedbackSegment {
  const factory _FeedbackSegment(
          {required final String text,
          final SegmentType? type,
          final String correction,
          @JsonKey(name: 'reason_mm') final String reasonMm,
          @JsonKey(name: 'reason_en') final String reasonEn}) =
      _$FeedbackSegmentImpl;
  const _FeedbackSegment._() : super._();

  factory _FeedbackSegment.fromJson(Map<String, dynamic> json) =
      _$FeedbackSegmentImpl.fromJson;

  @override
  String get text;
  @override
  SegmentType? get type;
  @override
  String get correction;
  @override
  @JsonKey(name: 'reason_mm')
  String get reasonMm;
  @override
  @JsonKey(name: 'reason_en')
  String get reasonEn;

  /// Create a copy of FeedbackSegment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedbackSegmentImplCopyWith<_$FeedbackSegmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
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

VocabUpgrade _$VocabUpgradeFromJson(Map<String, dynamic> json) {
  return _VocabUpgrade.fromJson(json);
}

/// @nodoc
mixin _$VocabUpgrade {
  String get original => throw _privateConstructorUsedError;
  String get suggestion => throw _privateConstructorUsedError;
  @JsonKey(name: 'reason_mm')
  String get reasonMm => throw _privateConstructorUsedError;

  /// Serializes this VocabUpgrade to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabUpgradeCopyWith<VocabUpgrade> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabUpgradeCopyWith<$Res> {
  factory $VocabUpgradeCopyWith(
          VocabUpgrade value, $Res Function(VocabUpgrade) then) =
      _$VocabUpgradeCopyWithImpl<$Res, VocabUpgrade>;
  @useResult
  $Res call(
      {String original,
      String suggestion,
      @JsonKey(name: 'reason_mm') String reasonMm});
}

/// @nodoc
class _$VocabUpgradeCopyWithImpl<$Res, $Val extends VocabUpgrade>
    implements $VocabUpgradeCopyWith<$Res> {
  _$VocabUpgradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? suggestion = null,
    Object? reasonMm = null,
  }) {
    return _then(_value.copyWith(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      suggestion: null == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String,
      reasonMm: null == reasonMm
          ? _value.reasonMm
          : reasonMm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VocabUpgradeImplCopyWith<$Res>
    implements $VocabUpgradeCopyWith<$Res> {
  factory _$$VocabUpgradeImplCopyWith(
          _$VocabUpgradeImpl value, $Res Function(_$VocabUpgradeImpl) then) =
      __$$VocabUpgradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String original,
      String suggestion,
      @JsonKey(name: 'reason_mm') String reasonMm});
}

/// @nodoc
class __$$VocabUpgradeImplCopyWithImpl<$Res>
    extends _$VocabUpgradeCopyWithImpl<$Res, _$VocabUpgradeImpl>
    implements _$$VocabUpgradeImplCopyWith<$Res> {
  __$$VocabUpgradeImplCopyWithImpl(
      _$VocabUpgradeImpl _value, $Res Function(_$VocabUpgradeImpl) _then)
      : super(_value, _then);

  /// Create a copy of VocabUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? suggestion = null,
    Object? reasonMm = null,
  }) {
    return _then(_$VocabUpgradeImpl(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      suggestion: null == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
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
class _$VocabUpgradeImpl implements _VocabUpgrade {
  const _$VocabUpgradeImpl(
      {required this.original,
      required this.suggestion,
      @JsonKey(name: 'reason_mm') this.reasonMm = ''});

  factory _$VocabUpgradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabUpgradeImplFromJson(json);

  @override
  final String original;
  @override
  final String suggestion;
  @override
  @JsonKey(name: 'reason_mm')
  final String reasonMm;

  @override
  String toString() {
    return 'VocabUpgrade(original: $original, suggestion: $suggestion, reasonMm: $reasonMm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabUpgradeImpl &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion) &&
            (identical(other.reasonMm, reasonMm) ||
                other.reasonMm == reasonMm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, original, suggestion, reasonMm);

  /// Create a copy of VocabUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabUpgradeImplCopyWith<_$VocabUpgradeImpl> get copyWith =>
      __$$VocabUpgradeImplCopyWithImpl<_$VocabUpgradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabUpgradeImplToJson(
      this,
    );
  }
}

abstract class _VocabUpgrade implements VocabUpgrade {
  const factory _VocabUpgrade(
      {required final String original,
      required final String suggestion,
      @JsonKey(name: 'reason_mm') final String reasonMm}) = _$VocabUpgradeImpl;

  factory _VocabUpgrade.fromJson(Map<String, dynamic> json) =
      _$VocabUpgradeImpl.fromJson;

  @override
  String get original;
  @override
  String get suggestion;
  @override
  @JsonKey(name: 'reason_mm')
  String get reasonMm;

  /// Create a copy of VocabUpgrade
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabUpgradeImplCopyWith<_$VocabUpgradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhraseExample _$PhraseExampleFromJson(Map<String, dynamic> json) {
  return _PhraseExample.fromJson(json);
}

/// @nodoc
mixin _$PhraseExample {
  String get en => throw _privateConstructorUsedError;
  @JsonKey(name: 'mm')
  String get mm => throw _privateConstructorUsedError;

  /// Serializes this PhraseExample to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhraseExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhraseExampleCopyWith<PhraseExample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhraseExampleCopyWith<$Res> {
  factory $PhraseExampleCopyWith(
          PhraseExample value, $Res Function(PhraseExample) then) =
      _$PhraseExampleCopyWithImpl<$Res, PhraseExample>;
  @useResult
  $Res call({String en, @JsonKey(name: 'mm') String mm});
}

/// @nodoc
class _$PhraseExampleCopyWithImpl<$Res, $Val extends PhraseExample>
    implements $PhraseExampleCopyWith<$Res> {
  _$PhraseExampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhraseExample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? en = null,
    Object? mm = null,
  }) {
    return _then(_value.copyWith(
      en: null == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      mm: null == mm
          ? _value.mm
          : mm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhraseExampleImplCopyWith<$Res>
    implements $PhraseExampleCopyWith<$Res> {
  factory _$$PhraseExampleImplCopyWith(
          _$PhraseExampleImpl value, $Res Function(_$PhraseExampleImpl) then) =
      __$$PhraseExampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String en, @JsonKey(name: 'mm') String mm});
}

/// @nodoc
class __$$PhraseExampleImplCopyWithImpl<$Res>
    extends _$PhraseExampleCopyWithImpl<$Res, _$PhraseExampleImpl>
    implements _$$PhraseExampleImplCopyWith<$Res> {
  __$$PhraseExampleImplCopyWithImpl(
      _$PhraseExampleImpl _value, $Res Function(_$PhraseExampleImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhraseExample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? en = null,
    Object? mm = null,
  }) {
    return _then(_$PhraseExampleImpl(
      en: null == en
          ? _value.en
          : en // ignore: cast_nullable_to_non_nullable
              as String,
      mm: null == mm
          ? _value.mm
          : mm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhraseExampleImpl implements _PhraseExample {
  const _$PhraseExampleImpl(
      {required this.en, @JsonKey(name: 'mm') this.mm = ''});

  factory _$PhraseExampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhraseExampleImplFromJson(json);

  @override
  final String en;
  @override
  @JsonKey(name: 'mm')
  final String mm;

  @override
  String toString() {
    return 'PhraseExample(en: $en, mm: $mm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhraseExampleImpl &&
            (identical(other.en, en) || other.en == en) &&
            (identical(other.mm, mm) || other.mm == mm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, en, mm);

  /// Create a copy of PhraseExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhraseExampleImplCopyWith<_$PhraseExampleImpl> get copyWith =>
      __$$PhraseExampleImplCopyWithImpl<_$PhraseExampleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhraseExampleImplToJson(
      this,
    );
  }
}

abstract class _PhraseExample implements PhraseExample {
  const factory _PhraseExample(
      {required final String en,
      @JsonKey(name: 'mm') final String mm}) = _$PhraseExampleImpl;

  factory _PhraseExample.fromJson(Map<String, dynamic> json) =
      _$PhraseExampleImpl.fromJson;

  @override
  String get en;
  @override
  @JsonKey(name: 'mm')
  String get mm;

  /// Create a copy of PhraseExample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhraseExampleImplCopyWith<_$PhraseExampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhraseSuggestion _$PhraseSuggestionFromJson(Map<String, dynamic> json) {
  return _PhraseSuggestion.fromJson(json);
}

/// @nodoc
mixin _$PhraseSuggestion {
  String get phrase => throw _privateConstructorUsedError;
  PhraseKind get kind => throw _privateConstructorUsedError;
  @JsonKey(name: 'meaning_mm')
  String get meaningMm => throw _privateConstructorUsedError;
  @JsonKey(name: 'meaning_en')
  String get meaningEn => throw _privateConstructorUsedError;
  List<PhraseExample> get examples => throw _privateConstructorUsedError;

  /// Serializes this PhraseSuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhraseSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhraseSuggestionCopyWith<PhraseSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhraseSuggestionCopyWith<$Res> {
  factory $PhraseSuggestionCopyWith(
          PhraseSuggestion value, $Res Function(PhraseSuggestion) then) =
      _$PhraseSuggestionCopyWithImpl<$Res, PhraseSuggestion>;
  @useResult
  $Res call(
      {String phrase,
      PhraseKind kind,
      @JsonKey(name: 'meaning_mm') String meaningMm,
      @JsonKey(name: 'meaning_en') String meaningEn,
      List<PhraseExample> examples});
}

/// @nodoc
class _$PhraseSuggestionCopyWithImpl<$Res, $Val extends PhraseSuggestion>
    implements $PhraseSuggestionCopyWith<$Res> {
  _$PhraseSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhraseSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phrase = null,
    Object? kind = null,
    Object? meaningMm = null,
    Object? meaningEn = null,
    Object? examples = null,
  }) {
    return _then(_value.copyWith(
      phrase: null == phrase
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as PhraseKind,
      meaningMm: null == meaningMm
          ? _value.meaningMm
          : meaningMm // ignore: cast_nullable_to_non_nullable
              as String,
      meaningEn: null == meaningEn
          ? _value.meaningEn
          : meaningEn // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<PhraseExample>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhraseSuggestionImplCopyWith<$Res>
    implements $PhraseSuggestionCopyWith<$Res> {
  factory _$$PhraseSuggestionImplCopyWith(_$PhraseSuggestionImpl value,
          $Res Function(_$PhraseSuggestionImpl) then) =
      __$$PhraseSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phrase,
      PhraseKind kind,
      @JsonKey(name: 'meaning_mm') String meaningMm,
      @JsonKey(name: 'meaning_en') String meaningEn,
      List<PhraseExample> examples});
}

/// @nodoc
class __$$PhraseSuggestionImplCopyWithImpl<$Res>
    extends _$PhraseSuggestionCopyWithImpl<$Res, _$PhraseSuggestionImpl>
    implements _$$PhraseSuggestionImplCopyWith<$Res> {
  __$$PhraseSuggestionImplCopyWithImpl(_$PhraseSuggestionImpl _value,
      $Res Function(_$PhraseSuggestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhraseSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phrase = null,
    Object? kind = null,
    Object? meaningMm = null,
    Object? meaningEn = null,
    Object? examples = null,
  }) {
    return _then(_$PhraseSuggestionImpl(
      phrase: null == phrase
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as PhraseKind,
      meaningMm: null == meaningMm
          ? _value.meaningMm
          : meaningMm // ignore: cast_nullable_to_non_nullable
              as String,
      meaningEn: null == meaningEn
          ? _value.meaningEn
          : meaningEn // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<PhraseExample>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhraseSuggestionImpl implements _PhraseSuggestion {
  const _$PhraseSuggestionImpl(
      {required this.phrase,
      this.kind = PhraseKind.collocation,
      @JsonKey(name: 'meaning_mm') this.meaningMm = '',
      @JsonKey(name: 'meaning_en') this.meaningEn = '',
      final List<PhraseExample> examples = const <PhraseExample>[]})
      : _examples = examples;

  factory _$PhraseSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhraseSuggestionImplFromJson(json);

  @override
  final String phrase;
  @override
  @JsonKey()
  final PhraseKind kind;
  @override
  @JsonKey(name: 'meaning_mm')
  final String meaningMm;
  @override
  @JsonKey(name: 'meaning_en')
  final String meaningEn;
  final List<PhraseExample> _examples;
  @override
  @JsonKey()
  List<PhraseExample> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  String toString() {
    return 'PhraseSuggestion(phrase: $phrase, kind: $kind, meaningMm: $meaningMm, meaningEn: $meaningEn, examples: $examples)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhraseSuggestionImpl &&
            (identical(other.phrase, phrase) || other.phrase == phrase) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.meaningMm, meaningMm) ||
                other.meaningMm == meaningMm) &&
            (identical(other.meaningEn, meaningEn) ||
                other.meaningEn == meaningEn) &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phrase, kind, meaningMm,
      meaningEn, const DeepCollectionEquality().hash(_examples));

  /// Create a copy of PhraseSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhraseSuggestionImplCopyWith<_$PhraseSuggestionImpl> get copyWith =>
      __$$PhraseSuggestionImplCopyWithImpl<_$PhraseSuggestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhraseSuggestionImplToJson(
      this,
    );
  }
}

abstract class _PhraseSuggestion implements PhraseSuggestion {
  const factory _PhraseSuggestion(
      {required final String phrase,
      final PhraseKind kind,
      @JsonKey(name: 'meaning_mm') final String meaningMm,
      @JsonKey(name: 'meaning_en') final String meaningEn,
      final List<PhraseExample> examples}) = _$PhraseSuggestionImpl;

  factory _PhraseSuggestion.fromJson(Map<String, dynamic> json) =
      _$PhraseSuggestionImpl.fromJson;

  @override
  String get phrase;
  @override
  PhraseKind get kind;
  @override
  @JsonKey(name: 'meaning_mm')
  String get meaningMm;
  @override
  @JsonKey(name: 'meaning_en')
  String get meaningEn;
  @override
  List<PhraseExample> get examples;

  /// Create a copy of PhraseSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhraseSuggestionImplCopyWith<_$PhraseSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SentenceRewrite _$SentenceRewriteFromJson(Map<String, dynamic> json) {
  return _SentenceRewrite.fromJson(json);
}

/// @nodoc
mixin _$SentenceRewrite {
  String get original => throw _privateConstructorUsedError;
  String get rewrite => throw _privateConstructorUsedError;

  /// Serializes this SentenceRewrite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SentenceRewrite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SentenceRewriteCopyWith<SentenceRewrite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceRewriteCopyWith<$Res> {
  factory $SentenceRewriteCopyWith(
          SentenceRewrite value, $Res Function(SentenceRewrite) then) =
      _$SentenceRewriteCopyWithImpl<$Res, SentenceRewrite>;
  @useResult
  $Res call({String original, String rewrite});
}

/// @nodoc
class _$SentenceRewriteCopyWithImpl<$Res, $Val extends SentenceRewrite>
    implements $SentenceRewriteCopyWith<$Res> {
  _$SentenceRewriteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SentenceRewrite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? rewrite = null,
  }) {
    return _then(_value.copyWith(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      rewrite: null == rewrite
          ? _value.rewrite
          : rewrite // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentenceRewriteImplCopyWith<$Res>
    implements $SentenceRewriteCopyWith<$Res> {
  factory _$$SentenceRewriteImplCopyWith(_$SentenceRewriteImpl value,
          $Res Function(_$SentenceRewriteImpl) then) =
      __$$SentenceRewriteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String original, String rewrite});
}

/// @nodoc
class __$$SentenceRewriteImplCopyWithImpl<$Res>
    extends _$SentenceRewriteCopyWithImpl<$Res, _$SentenceRewriteImpl>
    implements _$$SentenceRewriteImplCopyWith<$Res> {
  __$$SentenceRewriteImplCopyWithImpl(
      _$SentenceRewriteImpl _value, $Res Function(_$SentenceRewriteImpl) _then)
      : super(_value, _then);

  /// Create a copy of SentenceRewrite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? rewrite = null,
  }) {
    return _then(_$SentenceRewriteImpl(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      rewrite: null == rewrite
          ? _value.rewrite
          : rewrite // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentenceRewriteImpl implements _SentenceRewrite {
  const _$SentenceRewriteImpl({required this.original, required this.rewrite});

  factory _$SentenceRewriteImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentenceRewriteImplFromJson(json);

  @override
  final String original;
  @override
  final String rewrite;

  @override
  String toString() {
    return 'SentenceRewrite(original: $original, rewrite: $rewrite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceRewriteImpl &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.rewrite, rewrite) || other.rewrite == rewrite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, original, rewrite);

  /// Create a copy of SentenceRewrite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceRewriteImplCopyWith<_$SentenceRewriteImpl> get copyWith =>
      __$$SentenceRewriteImplCopyWithImpl<_$SentenceRewriteImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentenceRewriteImplToJson(
      this,
    );
  }
}

abstract class _SentenceRewrite implements SentenceRewrite {
  const factory _SentenceRewrite(
      {required final String original,
      required final String rewrite}) = _$SentenceRewriteImpl;

  factory _SentenceRewrite.fromJson(Map<String, dynamic> json) =
      _$SentenceRewriteImpl.fromJson;

  @override
  String get original;
  @override
  String get rewrite;

  /// Create a copy of SentenceRewrite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentenceRewriteImplCopyWith<_$SentenceRewriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FillerWord _$FillerWordFromJson(Map<String, dynamic> json) {
  return _FillerWord.fromJson(json);
}

/// @nodoc
mixin _$FillerWord {
  String get word => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this FillerWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FillerWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FillerWordCopyWith<FillerWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FillerWordCopyWith<$Res> {
  factory $FillerWordCopyWith(
          FillerWord value, $Res Function(FillerWord) then) =
      _$FillerWordCopyWithImpl<$Res, FillerWord>;
  @useResult
  $Res call({String word, int count});
}

/// @nodoc
class _$FillerWordCopyWithImpl<$Res, $Val extends FillerWord>
    implements $FillerWordCopyWith<$Res> {
  _$FillerWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FillerWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FillerWordImplCopyWith<$Res>
    implements $FillerWordCopyWith<$Res> {
  factory _$$FillerWordImplCopyWith(
          _$FillerWordImpl value, $Res Function(_$FillerWordImpl) then) =
      __$$FillerWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String word, int count});
}

/// @nodoc
class __$$FillerWordImplCopyWithImpl<$Res>
    extends _$FillerWordCopyWithImpl<$Res, _$FillerWordImpl>
    implements _$$FillerWordImplCopyWith<$Res> {
  __$$FillerWordImplCopyWithImpl(
      _$FillerWordImpl _value, $Res Function(_$FillerWordImpl) _then)
      : super(_value, _then);

  /// Create a copy of FillerWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? count = null,
  }) {
    return _then(_$FillerWordImpl(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FillerWordImpl implements _FillerWord {
  const _$FillerWordImpl({required this.word, this.count = 0});

  factory _$FillerWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$FillerWordImplFromJson(json);

  @override
  final String word;
  @override
  @JsonKey()
  final int count;

  @override
  String toString() {
    return 'FillerWord(word: $word, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FillerWordImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, word, count);

  /// Create a copy of FillerWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FillerWordImplCopyWith<_$FillerWordImpl> get copyWith =>
      __$$FillerWordImplCopyWithImpl<_$FillerWordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FillerWordImplToJson(
      this,
    );
  }
}

abstract class _FillerWord implements FillerWord {
  const factory _FillerWord({required final String word, final int count}) =
      _$FillerWordImpl;

  factory _FillerWord.fromJson(Map<String, dynamic> json) =
      _$FillerWordImpl.fromJson;

  @override
  String get word;
  @override
  int get count;

  /// Create a copy of FillerWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FillerWordImplCopyWith<_$FillerWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubScores _$SubScoresFromJson(Map<String, dynamic> json) {
  return _SubScores.fromJson(json);
}

/// @nodoc
mixin _$SubScores {
  int get grammar => throw _privateConstructorUsedError;
  int get vocabulary => throw _privateConstructorUsedError;
  int get fluency => throw _privateConstructorUsedError;
  int get pronunciation => throw _privateConstructorUsedError;

  /// Serializes this SubScores to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubScores
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubScoresCopyWith<SubScores> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubScoresCopyWith<$Res> {
  factory $SubScoresCopyWith(SubScores value, $Res Function(SubScores) then) =
      _$SubScoresCopyWithImpl<$Res, SubScores>;
  @useResult
  $Res call({int grammar, int vocabulary, int fluency, int pronunciation});
}

/// @nodoc
class _$SubScoresCopyWithImpl<$Res, $Val extends SubScores>
    implements $SubScoresCopyWith<$Res> {
  _$SubScoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubScores
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grammar = null,
    Object? vocabulary = null,
    Object? fluency = null,
    Object? pronunciation = null,
  }) {
    return _then(_value.copyWith(
      grammar: null == grammar
          ? _value.grammar
          : grammar // ignore: cast_nullable_to_non_nullable
              as int,
      vocabulary: null == vocabulary
          ? _value.vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as int,
      fluency: null == fluency
          ? _value.fluency
          : fluency // ignore: cast_nullable_to_non_nullable
              as int,
      pronunciation: null == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubScoresImplCopyWith<$Res>
    implements $SubScoresCopyWith<$Res> {
  factory _$$SubScoresImplCopyWith(
          _$SubScoresImpl value, $Res Function(_$SubScoresImpl) then) =
      __$$SubScoresImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int grammar, int vocabulary, int fluency, int pronunciation});
}

/// @nodoc
class __$$SubScoresImplCopyWithImpl<$Res>
    extends _$SubScoresCopyWithImpl<$Res, _$SubScoresImpl>
    implements _$$SubScoresImplCopyWith<$Res> {
  __$$SubScoresImplCopyWithImpl(
      _$SubScoresImpl _value, $Res Function(_$SubScoresImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubScores
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grammar = null,
    Object? vocabulary = null,
    Object? fluency = null,
    Object? pronunciation = null,
  }) {
    return _then(_$SubScoresImpl(
      grammar: null == grammar
          ? _value.grammar
          : grammar // ignore: cast_nullable_to_non_nullable
              as int,
      vocabulary: null == vocabulary
          ? _value.vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as int,
      fluency: null == fluency
          ? _value.fluency
          : fluency // ignore: cast_nullable_to_non_nullable
              as int,
      pronunciation: null == pronunciation
          ? _value.pronunciation
          : pronunciation // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubScoresImpl implements _SubScores {
  const _$SubScoresImpl(
      {this.grammar = 0,
      this.vocabulary = 0,
      this.fluency = 0,
      this.pronunciation = 0});

  factory _$SubScoresImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubScoresImplFromJson(json);

  @override
  @JsonKey()
  final int grammar;
  @override
  @JsonKey()
  final int vocabulary;
  @override
  @JsonKey()
  final int fluency;
  @override
  @JsonKey()
  final int pronunciation;

  @override
  String toString() {
    return 'SubScores(grammar: $grammar, vocabulary: $vocabulary, fluency: $fluency, pronunciation: $pronunciation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubScoresImpl &&
            (identical(other.grammar, grammar) || other.grammar == grammar) &&
            (identical(other.vocabulary, vocabulary) ||
                other.vocabulary == vocabulary) &&
            (identical(other.fluency, fluency) || other.fluency == fluency) &&
            (identical(other.pronunciation, pronunciation) ||
                other.pronunciation == pronunciation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, grammar, vocabulary, fluency, pronunciation);

  /// Create a copy of SubScores
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubScoresImplCopyWith<_$SubScoresImpl> get copyWith =>
      __$$SubScoresImplCopyWithImpl<_$SubScoresImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubScoresImplToJson(
      this,
    );
  }
}

abstract class _SubScores implements SubScores {
  const factory _SubScores(
      {final int grammar,
      final int vocabulary,
      final int fluency,
      final int pronunciation}) = _$SubScoresImpl;

  factory _SubScores.fromJson(Map<String, dynamic> json) =
      _$SubScoresImpl.fromJson;

  @override
  int get grammar;
  @override
  int get vocabulary;
  @override
  int get fluency;
  @override
  int get pronunciation;

  /// Create a copy of SubScores
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubScoresImplCopyWith<_$SubScoresImpl> get copyWith =>
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
