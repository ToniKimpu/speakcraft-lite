// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_speaking_feedback.freezed.dart';
part 'daily_speaking_feedback.g.dart';

enum CefrLevel {
  @JsonValue('beginner')
  beginner,
  @JsonValue('elementary')
  elementary,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('upper_intermediate')
  upperIntermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('fluent')
  fluent,
}

/// What kind of issue a flagged [FeedbackSegment] marks. Plain runs of text
/// carry no type. Drives the highlight colour and which Feedback-tab list the
/// segment is derived into.
enum SegmentType {
  @JsonValue('grammar')
  grammar,
  @JsonValue('vocab')
  vocab,
  @JsonValue('interference')
  interference,
  @JsonValue('filler')
  filler,
}

@freezed
class DailySpeakingFeedback with _$DailySpeakingFeedback {
  const DailySpeakingFeedback._();

  const factory DailySpeakingFeedback({
    required int score,
    @Default(CefrLevel.beginner) CefrLevel level,
    @JsonKey(name: 'inferred_topic') String? inferredTopic,
    /// The learner's words as the AI heard them. Always returned for voice
    /// sessions (Gemini already reads the audio, so the marginal token cost is
    /// small) and persisted into the session's `inputText` so the result page
    /// and history can show what was actually said. Empty on the text path,
    /// where `inputText` already holds the typed words.
    @JsonKey(name: 'transcript') @Default('') String transcript,
    @JsonKey(name: 'duration_seconds') @Default(0) int durationSeconds,
    @JsonKey(name: 'word_count') @Default(0) int wordCount,
    @JsonKey(name: 'speaking_pace_wpm') @Default(0) int speakingPaceWpm,
    @Default(<String>[]) List<String> strengths,
    @Default(<FeedbackFix>[]) List<FeedbackFix> fixes,
    @JsonKey(name: 'native_rewrite') @Default('') String nativeRewrite,
    @JsonKey(name: 'pronunciation_notes') @Default(<String>[])
    List<String> pronunciationNotes,
    @JsonKey(name: 'explanation_mm') @Default('') String explanationMm,
    @JsonKey(name: 'target_phrase_results') @Default(<TargetPhraseResult>[])
    List<TargetPhraseResult> targetPhraseResults,
    // --- Optional sections, returned only when requested via
    // `requested_sections`. All default-empty so the result page can keep
    // rendering each section iff non-empty.
    @JsonKey(name: 'grammar_patterns') @Default(<String>[])
    List<String> grammarPatterns,
    @JsonKey(name: 'interference_notes') @Default(<FeedbackFix>[])
    List<FeedbackFix> interferenceNotes,
    @JsonKey(name: 'vocab_upgrades') @Default(<VocabUpgrade>[])
    List<VocabUpgrade> vocabUpgrades,
    /// Natural phrases (collocations + idioms) the learner could pick up —
    /// suggestions seeded by the topic, NOT pulled from what they said. Each
    /// carries a Burmese (and optional English) meaning plus example sentences,
    /// so a learner who doesn't know the phrase can tap to learn how to use it.
    /// The `kind` discriminator lets the choose-feedback `collocations` /
    /// `idioms` toggles filter independently.
    @Default(<PhraseSuggestion>[]) List<PhraseSuggestion> phrases,
    @JsonKey(name: 'sentence_rewrites') @Default(<SentenceRewrite>[])
    List<SentenceRewrite> sentenceRewrites,
    @JsonKey(name: 'filler_words') @Default(<FillerWord>[])
    List<FillerWord> fillerWords,
    @JsonKey(name: 'sub_scores') SubScores? subScores,
    @JsonKey(name: 'total_tokens') @Default(0) int totalTokens,
    // --- v2: the annotated transcript. When present, this is the single source
    // of truth for the transcript, the inline highlights, the sentence-aligned
    // split, and the derived `effective*` lists below. Older payloads (and the
    // legacy stub responses) leave it empty and fall back to the flat lists.
    @Default(<FeedbackSentence>[]) List<FeedbackSentence> sentences,
  }) = _DailySpeakingFeedback;

  factory DailySpeakingFeedback.fromJson(Map<String, dynamic> json) =>
      _$DailySpeakingFeedbackFromJson(json);

  /// Whether the annotated transcript is available (v2 payloads). The Review &
  /// highlights screen is only offered when this is true.
  bool get hasSentences => sentences.isNotEmpty;

  /// Sentences whose native form differs from the original — the ones worth
  /// showing emphasised in the split-compare view. Uses [FeedbackSentence.isRewrite]
  /// (text-derived) rather than the model's unreliable `changed` flag.
  List<FeedbackSentence> get changedSentences =>
      sentences.where((s) => s.isRewrite).toList(growable: false);

  Iterable<FeedbackSegment> get _flaggedSegments =>
      sentences.expand((s) => s.segments).where((seg) => seg.isActionable);

  /// Grammar fixes. Preferred source is the flat, model-filled [fixes] list
  /// (each carries a `type`); untyped entries are treated as grammar. Falls back
  /// to the legacy annotated `segments` for older payloads.
  List<FeedbackFix> get effectiveFixes {
    if (fixes.isNotEmpty) {
      return fixes
          .where((f) => (f.type ?? SegmentType.grammar) == SegmentType.grammar)
          .where((f) => f.corrected.trim().isNotEmpty)
          .toList(growable: false);
    }
    return _flaggedSegments
        .where((seg) => seg.type == SegmentType.grammar)
        .map((seg) => FeedbackFix(
              original: seg.text.trim(),
              corrected: seg.correction,
              reasonMm: seg.bestReason,
            ))
        .toList(growable: false);
  }

  /// Burmese-interference notes — `interference`-typed [fixes], else legacy
  /// `interference` segments, else the flat `interferenceNotes` list.
  List<FeedbackFix> get effectiveInterference {
    if (fixes.isNotEmpty) {
      return fixes
          .where((f) => f.type == SegmentType.interference)
          .where((f) => f.corrected.trim().isNotEmpty)
          .toList(growable: false);
    }
    if (sentences.isEmpty) return interferenceNotes;
    return _flaggedSegments
        .where((seg) => seg.type == SegmentType.interference)
        .map((seg) => FeedbackFix(
              original: seg.text.trim(),
              corrected: seg.correction,
              reasonMm: seg.bestReason,
            ))
        .toList(growable: false);
  }

  /// Vocabulary upgrades — `vocab`-typed [fixes], else legacy `vocab` segments,
  /// else `vocabUpgrades`.
  List<VocabUpgrade> get effectiveVocabUpgrades {
    if (fixes.isNotEmpty) {
      return fixes
          .where((f) => f.type == SegmentType.vocab && f.corrected.trim().isNotEmpty)
          .map((f) => VocabUpgrade(
                original: f.original.trim(),
                suggestion: f.corrected,
                reasonMm: f.reasonMm,
              ))
          .toList(growable: false);
    }
    if (sentences.isEmpty) return vocabUpgrades;
    return _flaggedSegments
        .where((seg) => seg.type == SegmentType.vocab)
        .map((seg) => VocabUpgrade(
              original: seg.text.trim(),
              suggestion: seg.correction,
              reasonMm: seg.bestReason,
            ))
        .toList(growable: false);
  }

  /// Filler words with counts — tallied from `filler`-typed [fixes], else legacy
  /// `filler` segments, else the flat `fillerWords` list.
  List<FillerWord> get effectiveFillerWords {
    if (fixes.isNotEmpty) {
      return _tallyFillers(fixes.where((f) => f.type == SegmentType.filler)
          .map((f) => f.original));
    }
    if (sentences.isEmpty) return fillerWords;
    return _tallyFillers(_flaggedSegments
        .where((seg) => seg.type == SegmentType.filler)
        .map((seg) => seg.text));
  }

  List<FillerWord> _tallyFillers(Iterable<String> words) {
    final counts = <String, int>{};
    for (final raw in words) {
      final word = raw.trim().replaceAll(RegExp(r'[,.]'), '').toLowerCase();
      if (word.isEmpty) continue;
      counts[word] = (counts[word] ?? 0) + 1;
    }
    return counts.entries
        .map((e) => FillerWord(word: e.key, count: e.value))
        .toList(growable: false);
  }

  /// Sentence rewrites — derived from changed sentences (original → native),
  /// else the flat `sentenceRewrites` list.
  List<SentenceRewrite> get effectiveSentenceRewrites {
    if (sentences.isEmpty) return sentenceRewrites;
    return changedSentences
        .map((s) => SentenceRewrite(original: s.original, rewrite: s.native))
        .toList(growable: false);
  }

  /// The whole native rewrite — joined from sentences when present, else the
  /// flat `nativeRewrite` field.
  String get effectiveNativeRewrite {
    if (sentences.isEmpty) return nativeRewrite;
    return sentences.map((s) => s.native).join(' ');
  }

  /// The transcript — joined from sentences when present, else `transcript`.
  String get effectiveTranscript {
    if (sentences.isEmpty) return transcript;
    return sentences.map((s) => s.original).join(' ');
  }
}

/// One sentence of the learner's transcript, pre-annotated by the model. The
/// join of [segments] text reproduces [original] exactly (validated on the
/// client); the join of every sentence's [native] reproduces the whole rewrite.
@freezed
class FeedbackSentence with _$FeedbackSentence {
  const FeedbackSentence._();

  const factory FeedbackSentence({
    required String original,
    @Default('') String native,
    @Default(false) bool changed,
    @Default(<FeedbackSegment>[]) List<FeedbackSegment> segments,
  }) = _FeedbackSentence;

  factory FeedbackSentence.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSentenceFromJson(json);

  /// True when [native] is a genuine rewrite worth comparing — derived from the
  /// text rather than the model's `changed` flag, which some models (notably
  /// flash-lite) fill inconsistently or leave false even when native differs.
  bool get isRewrite =>
      native.trim().isNotEmpty && native.trim() != original.trim();
}

/// A run of text inside a [FeedbackSentence]. Plain runs carry only [text];
/// flagged runs also carry a [type], the [correction], and a short reason in
/// Burmese ([reasonMm]) and/or English ([reasonEn]) — whichever the learner's
/// `reason_lang` preference asked for.
@freezed
class FeedbackSegment with _$FeedbackSegment {
  const FeedbackSegment._();

  const factory FeedbackSegment({
    required String text,
    // Tolerate retired enum values in OLD saved sessions (e.g. "word_choice"
    // from a reverted experiment) instead of crashing history deserialization —
    // map any unknown value to grammar (where those errors belong now).
    @JsonKey(unknownEnumValue: SegmentType.grammar) SegmentType? type,
    @Default('') String correction,
    @JsonKey(name: 'reason_mm') @Default('') String reasonMm,
    @JsonKey(name: 'reason_en') @Default('') String reasonEn,
  }) = _FeedbackSegment;

  factory FeedbackSegment.fromJson(Map<String, dynamic> json) =>
      _$FeedbackSegmentFromJson(json);

  /// True for plain (unflagged) runs of text.
  bool get isPlain => type == null;

  /// A flagged run worth surfacing. Filler is a "drop this word" flag that needs
  /// no correction; every other type must carry a non-empty correction to be
  /// useful — otherwise tapping the highlight shows nothing and the derived card
  /// has an empty arrow. Guards against sloppy model output that flags a span
  /// but leaves the fix blank.
  bool get isActionable =>
      type == SegmentType.filler ||
      (type != null && correction.trim().isNotEmpty);

  /// A single reason string for places that show only one — prefers Burmese,
  /// falls back to English. May be empty (reasons are optional).
  String get bestReason => reasonMm.isNotEmpty ? reasonMm : reasonEn;
}

/// One correction the learner needs: the exact wrong words ([original]) → the
/// fixed English ([corrected]), with a Burmese reason. [type] categorises it
/// (grammar / vocab / interference / filler) so the result page can split the
/// flat `fixes` list into its sections; it's null on legacy segment-derived
/// fixes (which are already filtered by category at the call site). The model
/// emits the fixed English under the JSON key `correction`.
@freezed
class FeedbackFix with _$FeedbackFix {
  const factory FeedbackFix({
    required String original,
    @JsonKey(name: 'correction') @Default('') String corrected,
    // Tolerate retired enum values in OLD saved sessions (e.g. "word_choice"
    // from a reverted experiment) instead of crashing history deserialization —
    // map any unknown value to grammar (where those errors belong now).
    @JsonKey(unknownEnumValue: SegmentType.grammar) SegmentType? type,
    @JsonKey(name: 'reason_mm') @Default('') String reasonMm,
    @JsonKey(name: 'reason_en') @Default('') String reasonEn,
  }) = _FeedbackFix;

  factory FeedbackFix.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFixFromJson(json);
}

/// A basic word the learner used → a more precise/advanced alternative, with a
/// Burmese reason. Used by the `better_vocab` section.
@freezed
class VocabUpgrade with _$VocabUpgrade {
  const factory VocabUpgrade({
    required String original,
    required String suggestion,
    @JsonKey(name: 'reason_mm') @Default('') String reasonMm,
  }) = _VocabUpgrade;

  factory VocabUpgrade.fromJson(Map<String, dynamic> json) =>
      _$VocabUpgradeFromJson(json);
}

/// Whether a [PhraseSuggestion] is a collocation (natural word pairing) or an
/// idiom / fixed expression. Drives the chip icon and the `collocations` /
/// `idioms` request-section filtering.
enum PhraseKind {
  @JsonValue('collocation')
  collocation,
  @JsonValue('idiom')
  idiom,
  @JsonValue('phrasal_verb')
  phrasalVerb,
}

/// One example sentence for a [PhraseSuggestion], English with an optional
/// Burmese translation so the learner sees the phrase used in context.
@freezed
class PhraseExample with _$PhraseExample {
  const factory PhraseExample({
    required String en,
    @JsonKey(name: 'mm') @Default('') String mm,
  }) = _PhraseExample;

  factory PhraseExample.fromJson(Map<String, dynamic> json) =>
      _$PhraseExampleFromJson(json);
}

/// A natural phrase (collocation or idiom) the learner could pick up, with a
/// Burmese (and optional English) meaning and example sentences. Replaces the
/// old bare-string `collocations` + meaning-only `IdiomSuggestion` so each chip
/// can be tapped to reveal what it means and how to use it. Used by the
/// `collocations` / `idioms` sections (filtered by [kind]).
@freezed
class PhraseSuggestion with _$PhraseSuggestion {
  const factory PhraseSuggestion({
    required String phrase,
    @Default(PhraseKind.collocation) PhraseKind kind,
    @JsonKey(name: 'meaning_mm') @Default('') String meaningMm,
    @JsonKey(name: 'meaning_en') @Default('') String meaningEn,
    @Default(<PhraseExample>[]) List<PhraseExample> examples,
  }) = _PhraseSuggestion;

  factory PhraseSuggestion.fromJson(Map<String, dynamic> json) =>
      _$PhraseSuggestionFromJson(json);
}

/// One of the learner's sentences rewritten to sound native. Used by the
/// `sentence_rewrite` section.
@freezed
class SentenceRewrite with _$SentenceRewrite {
  const factory SentenceRewrite({
    required String original,
    required String rewrite,
  }) = _SentenceRewrite;

  factory SentenceRewrite.fromJson(Map<String, dynamic> json) =>
      _$SentenceRewriteFromJson(json);
}

/// A filler word and how many times it occurred. Voice only — `filler_words`.
@freezed
class FillerWord with _$FillerWord {
  const factory FillerWord({
    required String word,
    @Default(0) int count,
  }) = _FillerWord;

  factory FillerWord.fromJson(Map<String, dynamic> json) =>
      _$FillerWordFromJson(json);
}

/// Per-skill breakdown of the overall score (0–100 each). Used by `sub_scores`.
@freezed
class SubScores with _$SubScores {
  const factory SubScores({
    @Default(0) int grammar,
    @Default(0) int vocabulary,
    @Default(0) int fluency,
    @Default(0) int pronunciation,
  }) = _SubScores;

  factory SubScores.fromJson(Map<String, dynamic> json) =>
      _$SubScoresFromJson(json);
}

@freezed
class TargetPhraseResult with _$TargetPhraseResult {
  const factory TargetPhraseResult({
    @JsonKey(name: 'phrase_en') required String phraseEn,
    required bool used,
    @JsonKey(name: 'used_correctly') @Default(false) bool usedCorrectly,
  }) = _TargetPhraseResult;

  factory TargetPhraseResult.fromJson(Map<String, dynamic> json) =>
      _$TargetPhraseResultFromJson(json);
}
