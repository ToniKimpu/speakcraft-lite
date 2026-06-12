// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'daily_speaking_topic.dart';

part 'guided_lesson.freezed.dart';
part 'guided_lesson.g.dart';

/// A beginner "Start here" lesson for the guided on-ramp. Walks a learner from
/// a worked model paragraph to their own spoken version (I do → We do → You do),
/// then converges into the same recording + feedback flow as the other on-ramps.
///
/// Content lives in the bundled `assets/daily_speaking/guided/guided.json`
/// (offline-fallback pattern, mirroring the suggested-topic bank). When the
/// Supabase swap lands, the loader flips to network-first and this asset stays
/// as the fallback — the JSON shape maps 1:1 to [GuidedLesson.fromJson].
///
/// Reuses [TopicVocabItem] / [TopicTargetPhrase] from `daily_speaking_topic.dart`
/// so the prep visuals and the synthetic topic handed to the recorder share one
/// shape.
@freezed
class GuidedLesson with _$GuidedLesson {
  const factory GuidedLesson({
    required String id,
    required String title,

    /// 1, 2, or 3. Drives both the list grouping and how much of the learner's
    /// own paragraph stays visible while recording (L1 full / L2 keywords /
    /// L3 hidden — the scaffold fades as they grow).
    @Default(1) int level,

    /// The payoff shown up front: "By the end you'll be able to …".
    @JsonKey(name: 'objective_en') required String objectiveEn,
    @JsonKey(name: 'objective_mm') @Default('') String objectiveMm,

    /// The worked example shown in the "I do" step (e.g. "I'm James. I come
    /// from the USA…"). Hidden once the learner moves on to record.
    @JsonKey(name: 'model_paragraph_en') required String modelParagraphEn,

    /// Same paragraph as a fill-in template using `{slotId}` tokens. The "We do"
    /// step replaces each token with the learner's own answer to assemble their
    /// paragraph. See [GuidedSlot].
    @Default('') String template,

    /// Per-sentence breakdown for the "I do" step (English sentence + Burmese
    /// explanation of what it's doing / why this wording).
    @Default(<GuidedSentence>[]) List<GuidedSentence> sentences,

    /// The slots the learner fills in the "We do" step.
    @Default(<GuidedSlot>[]) List<GuidedSlot> slots,

    @Default(<TopicVocabItem>[]) List<TopicVocabItem> vocabulary,
    @JsonKey(name: 'target_phrases') @Default(<TopicTargetPhrase>[])
    List<TopicTargetPhrase> targetPhrases,
    @JsonKey(name: 'warmup_questions') @Default(<String>[])
    List<String> warmupQuestions,
    @JsonKey(name: 'duration_target_seconds') @Default(60)
    int durationTargetSeconds,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _GuidedLesson;

  factory GuidedLesson.fromJson(Map<String, dynamic> json) =>
      _$GuidedLessonFromJson(json);
}

/// One sentence of the model paragraph plus its breakdown, shown in the "I do"
/// step so the learner understands *why* the sentence is built the way it is —
/// not just what to copy.
@freezed
class GuidedSentence with _$GuidedSentence {
  const factory GuidedSentence({
    @JsonKey(name: 'text_en') required String textEn,
    @JsonKey(name: 'explanation_mm') @Default('') String explanationMm,
  }) = _GuidedSentence;

  factory GuidedSentence.fromJson(Map<String, dynamic> json) =>
      _$GuidedSentenceFromJson(json);
}

/// One fill-in slot in the "We do" step. [options] non-empty ⇒ tap-to-pick
/// chips (keeps it light — it's a speaking app, not a writing form); empty ⇒ a
/// short free-text field. [hint] seeds the field / chip group.
@freezed
class GuidedSlot with _$GuidedSlot {
  const factory GuidedSlot({
    required String id,
    @JsonKey(name: 'label_en') required String labelEn,
    @JsonKey(name: 'label_mm') @Default('') String labelMm,
    @Default('') String hint,
    @Default(<String>[]) List<String> options,
  }) = _GuidedSlot;

  factory GuidedSlot.fromJson(Map<String, dynamic> json) =>
      _$GuidedSlotFromJson(json);
}
