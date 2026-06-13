import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// The kinds of prep help a learner can request before recording an own-topic
/// monologue. Mirrors the "choose your feedback" pattern (`feedback_section.dart`):
/// the learner picks which sections they want so the AI prep call only generates
/// those (own-topic prep is a paid generation, unlike the pre-authored suggested
/// topics). Each maps 1:1 to a field on [DailySpeakingTopic].
///
/// Plain Dart (no codegen) — request-side configuration, not a serialized
/// payload. UI labels/descriptions/icons are resolved by [PrepSection] in the
/// screens so this stays free of Flutter + l10n imports.
enum PrepSection {
  /// Talk structure / outline → [DailySpeakingTopic.outline].
  structure,

  /// Words you might use → [DailySpeakingTopic.vocabulary].
  vocab,

  /// Useful phrases → [DailySpeakingTopic.targetPhrases].
  phrases,

  /// Grammar patterns → [DailySpeakingTopic.grammarPatterns].
  grammar,

  /// Common mistakes → [DailySpeakingTopic.commonMistakes].
  mistakes,

  /// A gated example answer → [DailySpeakingTopic.exampleAnswerEn].
  example,
}

/// Menu display order.
const List<PrepSection> kPrepSections = [
  PrepSection.structure,
  PrepSection.vocab,
  PrepSection.phrases,
  PrepSection.grammar,
  PrepSection.mistakes,
  PrepSection.example,
];

/// The default ("Recommended") selection shown pre-ticked on the choose screen —
/// the core a learner needs to get talking, without overwhelming a beginner.
const Set<PrepSection> kRecommendedPrep = {
  PrepSection.structure,
  PrepSection.vocab,
  PrepSection.phrases,
};

/// Whether [section]'s content is already present on [topic] — used both to
/// render the scaffold (show a section iff filled) and to derive which sections
/// are still available to pull via "Add more help".
bool prepSectionPresent(PrepSection section, DailySpeakingTopic topic) {
  switch (section) {
    case PrepSection.structure:
      return topic.outline.isNotEmpty;
    case PrepSection.vocab:
      return topic.vocabulary.isNotEmpty;
    case PrepSection.phrases:
      return topic.targetPhrases.isNotEmpty;
    case PrepSection.grammar:
      return topic.grammarPatterns.isNotEmpty;
    case PrepSection.mistakes:
      return topic.commonMistakes.isNotEmpty;
    case PrepSection.example:
      return topic.exampleAnswerEn.isNotEmpty;
  }
}
