import '../../../model/writing/writing_lexicon.dart';
import '../../../model/writing/writing_unit.dart';

/// Lexicon helpers for the writing teach screen ([WritingTeachStepsPage]) —
/// shared between the toolkit step and the word banks so the toolkit is read
/// identically everywhere.

/// Frequency adverbs (how often → before the verb), highest frequency first.
List<LexiconTimeWord> frequencyAdverbs(ResolvedToolkit t) {
  final list =
      t.timeWords.where((w) => w.isFrequencyAdverb).toList(growable: false);
  list.sort((a, b) => (b.frequency ?? 0).compareTo(a.frequency ?? 0));
  return list;
}

/// Time phrases (when → end of sentence), in authored order.
List<LexiconTimeWord> timePhrases(ResolvedToolkit t) =>
    t.timeWords.where((w) => !w.isFrequencyAdverb).toList(growable: false);

/// The shared lexicon stores **positive present-simple** examples, so they only
/// fit an affirmative present-simple unit (`verb_form: third`). For negatives /
/// questions (`base`) or continuous (`ing`) those examples are off-message, so
/// the banks show form-only (the unit's own Examples section carries the
/// tense-correct sentences).
bool showBankExamples(WritingUnit unit) => unit.toolkit.verbForm == 'third';
