/// The catalog of feedback sections a learner can request before the AI call.
///
/// Plain Dart (no codegen) on purpose — this is request-side configuration, not
/// a serialized payload. The keys are the wire contract: they go out as
/// `requested_sections: [...]` and the edge function builds its prompt from
/// them so only requested sections cost tokens. They must match the field
/// filtering in `DailySpeakingService` and the section gating in
/// `feedback_result_page.dart`.
///
/// Core sections (score, CEFR level, strengths, Burmese summary) are always
/// returned and never appear here.
library;

/// Stable string keys for each optional feedback section. Snake_case because
/// they travel to the edge function verbatim.
class FeedbackSectionKey {
  static const String sentenceFixes = 'sentence_fixes';
  static const String grammarPatterns = 'grammar_patterns';
  static const String burmeseInterference = 'burmese_interference';
  static const String betterVocab = 'better_vocab';
  static const String collocations = 'collocations';
  static const String idioms = 'idioms';
  static const String phrasalVerbs = 'phrasal_verbs';
  static const String wholeRewrite = 'whole_rewrite';
  static const String sentenceRewrite = 'sentence_rewrite';
  static const String pronunciation = 'pronunciation';
  static const String fillerWords = 'filler_words';
  static const String subScores = 'sub_scores';
}

/// Visual grouping on the Choose-feedback screen.
enum FeedbackSectionGroup {
  accuracy,
  vocabulary,
  style,
  delivery,
  scoring,
}

/// A relative token-cost hint shown next to each option (⚡ low / med / high).
enum FeedbackSectionCost { low, medium, high }

/// One selectable option in the menu. UI-facing labels/descriptions/icons are
/// resolved by key in the screen so this stays free of Flutter + l10n imports.
class FeedbackSection {
  const FeedbackSection({
    required this.key,
    required this.group,
    required this.cost,
    this.voiceOnly = false,
    this.defaultOn = false,
  });

  final String key;
  final FeedbackSectionGroup group;
  final FeedbackSectionCost cost;

  /// Hidden on the write path (text has no delivery to assess).
  final bool voiceOnly;

  /// Pre-ticked when the learner opens the screen for the first time
  /// (the "Recommended" set).
  final bool defaultOn;
}

/// The full menu, in display order.
const List<FeedbackSection> kFeedbackSections = [
  // Accuracy
  FeedbackSection(
    key: FeedbackSectionKey.sentenceFixes,
    group: FeedbackSectionGroup.accuracy,
    cost: FeedbackSectionCost.low,
    defaultOn: true,
  ),
  FeedbackSection(
    key: FeedbackSectionKey.burmeseInterference,
    group: FeedbackSectionGroup.accuracy,
    cost: FeedbackSectionCost.medium,
  ),
  // Vocabulary
  FeedbackSection(
    key: FeedbackSectionKey.betterVocab,
    group: FeedbackSectionGroup.vocabulary,
    cost: FeedbackSectionCost.medium,
    defaultOn: true,
  ),
  FeedbackSection(
    key: FeedbackSectionKey.collocations,
    group: FeedbackSectionGroup.vocabulary,
    cost: FeedbackSectionCost.medium,
    defaultOn: true,
  ),
  FeedbackSection(
    key: FeedbackSectionKey.idioms,
    group: FeedbackSectionGroup.vocabulary,
    cost: FeedbackSectionCost.medium,
    defaultOn: true,
  ),
  FeedbackSection(
    key: FeedbackSectionKey.phrasalVerbs,
    group: FeedbackSectionGroup.vocabulary,
    cost: FeedbackSectionCost.medium,
    defaultOn: true,
  ),
  // Delivery (voice only)
  FeedbackSection(
    key: FeedbackSectionKey.pronunciation,
    group: FeedbackSectionGroup.delivery,
    cost: FeedbackSectionCost.low,
    voiceOnly: true,
    defaultOn: true,
  ),
  // Scoring
  FeedbackSection(
    key: FeedbackSectionKey.subScores,
    group: FeedbackSectionGroup.scoring,
    cost: FeedbackSectionCost.medium,
  ),
];

/// The default ("Recommended") selection — derived from [FeedbackSection.defaultOn]
/// so the catalog stays the single source of truth.
Set<String> defaultSelectedSections() => kFeedbackSections
    .where((s) => s.defaultOn)
    .map((s) => s.key)
    .toSet();

/// One-tap bundles. The learner can still open Customize and tweak afterwards.
/// `everything` is computed from the catalog at use-site (respecting voiceOnly),
/// so it isn't listed here.
enum FeedbackPreset { recommended, soundNatural, grammarFocus, everything }

const Map<FeedbackPreset, Set<String>> kPresetSections = {
  FeedbackPreset.recommended: {
    FeedbackSectionKey.sentenceFixes,
    FeedbackSectionKey.betterVocab,
    FeedbackSectionKey.collocations,
    FeedbackSectionKey.idioms,
    FeedbackSectionKey.phrasalVerbs,
    FeedbackSectionKey.pronunciation,
  },
  FeedbackPreset.soundNatural: {
    FeedbackSectionKey.betterVocab,
    FeedbackSectionKey.collocations,
    FeedbackSectionKey.idioms,
    FeedbackSectionKey.phrasalVerbs,
    FeedbackSectionKey.pronunciation,
  },
  FeedbackPreset.grammarFocus: {
    FeedbackSectionKey.burmeseInterference,
    FeedbackSectionKey.sentenceFixes,
    FeedbackSectionKey.subScores,
  },
};

/// Sections held back until the **terminal reveal** at the end of the version
/// loop. During iterations (v1…vN of a suggested / own-topic attempt) these are
/// hidden from the menu — handing over a full rewrite mid-loop turns the next
/// version into copying, not practice. The learner gets them once, when they
/// tap "I'm done with this topic". Just-talk has no loop, so it keeps them.
/// See `daily_speaking_feature.md` ("The version loop").
const Set<String> kTerminalRevealSections = <String>{};

/// Keys applicable to the given input mode (drops voice-only on the text path).
///
/// When [includeTerminalReveal] is false (a loop-capable on-ramp), the
/// terminal-reveal sections are also dropped — they're deferred to the end of
/// the loop rather than offered per attempt.
Set<String> sectionsForMode({
  required bool isVoice,
  bool includeTerminalReveal = true,
}) =>
    kFeedbackSections
        .where((s) => isVoice || !s.voiceOnly)
        .where((s) => includeTerminalReveal || !kTerminalRevealSections.contains(s.key))
        .map((s) => s.key)
        .toSet();
