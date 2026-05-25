import 'package:flutter/foundation.dart';

/// Feature flag for the runtime-generated cloze (fill-in-the-blank) exercises
/// shown under each sentence explanation. Flip to `false` to hide them
/// everywhere without touching the render code or the data.
const bool kEnableClozeExercises = true;

/// Placeholder token a cloze prompt uses where the answer was removed.
const String clozeBlank = '_____';

/// A single fill-in-the-blank item, generated at runtime from one explained
/// term plus one of its own example sentences. No extra authoring and no
/// change to the `__template.json` schema — everything here is derived from
/// fields the term already carries.
@immutable
class ClozeItem {
  const ClozeItem({
    required this.promptEn,
    required this.answer,
    required this.hintMy,
    required this.kind,
    required this.number,
  });

  /// Example sentence with the term replaced by [clozeBlank].
  final String promptEn;

  /// The term the learner must recall (the correct answer).
  final String answer;

  /// Burmese translation of the term, revealed on demand as a hint.
  final String hintMy;

  /// Grammatical kind (Noun, Phrase, …), for a small label.
  final String kind;

  /// Source term number, kept for stable display order.
  final int number;
}

/// Builds one cloze item per term that appears verbatim in one of its own
/// example sentences. Terms whose example never contains the term are skipped,
/// so the result can be empty — callers should render nothing in that case.
List<ClozeItem> buildClozeItems(List<dynamic> terms) {
  final items = <ClozeItem>[];
  for (final raw in terms) {
    if (raw is! Map<String, dynamic>) continue;
    final answer = (raw['term'] as String? ?? '').trim();
    if (answer.isEmpty) continue;

    final examples = (raw['examples'] as List<dynamic>?) ?? const [];
    final prompt = _firstBlankedExample(examples, answer);
    if (prompt == null) continue; // term never appears in its examples

    items.add(ClozeItem(
      promptEn: prompt,
      answer: answer,
      hintMy: (raw['translation_my'] as String? ?? '').trim(),
      kind: (raw['kind'] as String? ?? '').trim(),
      number: raw['number'] as int? ?? items.length + 1,
    ));
  }
  return items;
}

/// Returns the first example sentence (in order) that contains [answer], with
/// the first occurrence replaced by [clozeBlank]; null when none match.
String? _firstBlankedExample(List<dynamic> examples, String answer) {
  final needle = RegExp(RegExp.escape(answer), caseSensitive: false);
  for (final ex in examples) {
    if (ex is! Map<String, dynamic>) continue;
    final english = ex['english'] as String? ?? '';
    final match = needle.firstMatch(english);
    if (match == null) continue;
    return english.replaceRange(match.start, match.end, clozeBlank);
  }
  return null;
}

/// Normalizes an answer for lenient comparison: lower-cased, trimmed, inner
/// whitespace collapsed, and surrounding punctuation removed. Applied to both
/// the typed input and the expected answer so e.g. "Don't" matches "dont".
String normalizeClozeAnswer(String input) {
  final lowered = input.toLowerCase();
  final noPunct = lowered.replaceAll(RegExp(r'''[.,!?;:"'()]'''), '');
  return noPunct.replaceAll(RegExp(r'\s+'), ' ').trim();
}
