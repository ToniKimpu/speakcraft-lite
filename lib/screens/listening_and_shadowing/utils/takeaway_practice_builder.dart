import '../../../model/writing/writing_unit.dart';

/// Turns a fetched **key_takeaways** deck (the JSON `KeyTakeawaysPage` already
/// downloads from Bunny) into a practice ladder shaped as a [WritingUnit], so it
/// renders through the existing `WritingPracticePage` with no new UI.
///
/// This mirrors the offline prototype generator (tooling) but runs client-side:
/// any deck whose takeaways JSON is live on Bunny gets a practice ladder for
/// free — no per-deck asset to author or upload.
///
/// The ladder runs easy → hard, grouped by kind:
///   - `mcq`        — headword → correct Burmese gloss (distractors are other
///                    glosses from the same deck)
///   - `gap_fill`   — a real example with the target phrase blanked to `_____`,
///                    the Burmese translation shown as a hint
///   - `word_order` — rebuild a short, comma-free example from word chips
///
/// `pronunciation` takeaways are skipped (they don't gap-fill / arrange cleanly).
class TakeawayPracticeBuilder {
  static const _skipCategories = {'pronunciation'};
  static const _maxWordOrderWords = 9;
  static const _maxWordOrder = 6;

  /// Longest answer (in words) we'll turn into a free-type `gap_fill`. A phrase
  /// longer than this is hard to type exactly and typo-prone, so it falls
  /// through to the meaning-match `mcq` instead (recognition suits long phrases).
  static const _maxGapFillWords = 4;

  /// Build the unit. Returns a unit with an empty `exercises` list if the deck
  /// has nothing usable — callers should check `exercises.isNotEmpty` first.
  static WritingUnit build(Map<String, dynamic> deck) {
    final takeaways = (deck['takeaways'] as List? ?? const [])
        .cast<Map<String, dynamic>>()
        .where((t) => !_skipCategories.contains(t['category'] as String? ?? ''))
        .toList();

    final glossPool = [
      for (final t in takeaways) (t['gloss_my'] as String? ?? '')
    ].where((g) => g.isNotEmpty).toList();

    final mcq = <Map<String, dynamic>>[];
    final gap = <Map<String, dynamic>>[];
    final word = <Map<String, dynamic>>[];

    for (var i = 0; i < takeaways.length; i++) {
      final t = takeaways[i];
      final cat = t['category'] as String? ?? '';
      final head = t['headword'] as String? ?? '';
      final gloss = t['gloss_my'] as String? ?? '';
      final rawExpl = t['explanation_my'] as String? ?? '';
      final expl = rawExpl.isNotEmpty ? rawExpl : gloss;
      final examples =
          (t['examples'] as List? ?? const []).cast<Map<String, dynamic>>();

      // Primary kind by category: phrases / patterns gap-fill in context;
      // everything else matches meaning.
      var gapMade = false;
      if (cat == 'phrase' || cat == 'grammar_pattern') {
        for (final ex in examples) {
          final blanked = _blank(ex);
          if (blanked != null &&
              blanked.$2.split(RegExp(r'\s+')).length <= _maxGapFillWords) {
            gap.add({
              'kind': 'gap_fill',
              'grade': 'auto',
              'prompt_en': blanked.$1,
              'prompt_mm': ex['burmese'] as String? ?? '',
              'answers': [blanked.$2],
              'explain_mm': '$head — $expl',
            });
            gapMade = true;
            break;
          }
        }
      }

      if (!gapMade && gloss.isNotEmpty) {
        mcq.add({
          'kind': 'mcq',
          'grade': 'auto',
          // {v}…{/v} renders the headword in the teal "focus" highlight so the
          // term under test stands out from the question frame.
          'prompt_en': 'What does {v}“$head”{/v} mean?',
          'prompt_mm': 'မှန်ကန်တဲ့ အဓိပ္ပါယ်ကို ရွေးပါ။',
          'options': _options(gloss, glossPool, i),
          'answers': [gloss],
          'explain_mm': expl,
        });
      }

      // A production step where a short, clean example exists (capped overall).
      if (word.length < _maxWordOrder) {
        final clean = _shortClean(examples);
        if (clean != null) {
          word.add({
            'kind': 'word_order',
            'grade': 'auto',
            'prompt_en': '',
            'prompt_mm': clean.$2,
            'options': clean.$1.split(' '),
            'answers': [clean.$1],
            'explain_mm': '$head — $gloss',
          });
        }
      }
    }

    final exercises = [...mcq, ...gap, ...word];
    return WritingUnit.fromJson({
      'id': '${deck['video_id'] ?? 'deck'}_takeaways',
      'type': 'takeaways_practice',
      'title': '${deck['title'] ?? ''} — Key takeaways',
      'subtitle_mm': 'ဗီဒီယိုမှ သင်ယူထားတဲ့ စကားလုံးတွေကို လေ့ကျင့်ပါ',
      'exercises': exercises,
      'practice_recap_en':
          'Practice the words, phrases and patterns from the talk.',
      'practice_recap_mm':
          'ဟောပြောပွဲထဲက စကားလုံးနဲ့ ပုံစံတွေကို လေ့ကျင့်ကြည့်ပါ။',
    });
  }

  /// Coerce a `highlight` value to a string list. Gemini sometimes returns a
  /// single string instead of the requested `[string]`, so accept both.
  static List<String> _asStringList(dynamic v) {
    if (v is List) {
      return v.map((e) => e.toString()).where((s) => s.isNotEmpty).toList();
    }
    if (v is String && v.isNotEmpty) return [v];
    return const [];
  }

  /// `(promptWithBlank, answer)` for the first highlight literally present in
  /// the example's english, else null. Case-insensitive match; the answer keeps
  /// the original casing as authored.
  static (String, String)? _blank(Map<String, dynamic> ex) {
    final english = ex['english'] as String? ?? '';
    final low = english.toLowerCase();
    for (final h in _asStringList(ex['highlight'])) {
      if (h.isEmpty) continue;
      final i = low.indexOf(h.toLowerCase());
      if (i < 0) continue;
      final j = i + h.length;
      final blanked =
          '${english.substring(0, i)}_____${english.substring(j)}'
              .replaceAll(RegExp(r'\s+'), ' ')
              .trim();
      return (blanked, english.substring(i, j));
    }
    return null;
  }

  /// A short, comma/dash/quote-free example good for `word_order` (4–9 words),
  /// returned as `(sentenceWithoutTrailingPunct, burmese)`.
  static (String, String)? _shortClean(List<Map<String, dynamic>> examples) {
    for (final ex in examples) {
      final en = ex['english'] as String? ?? '';
      if (en.contains(',') ||
          en.contains('—') || // em dash
          en.contains('→') || // arrow
          en.contains('"')) {
        continue;
      }
      final core = en.replaceAll(RegExp(r'[.!?]+$'), '').trim();
      final words = core.split(RegExp(r'\s+'));
      if (words.length >= 4 && words.length <= _maxWordOrderWords) {
        return (core, ex['burmese'] as String? ?? '');
      }
    }
    return null;
  }

  /// Four options — the correct gloss plus three distinct distractors pulled
  /// from other glosses in the deck. Deterministic (no RNG) so the same deck
  /// always yields the same quiz; [seed] (the takeaway index) varies the pick
  /// and rotates the answer's position so it isn't always first.
  static List<String> _options(String correct, List<String> pool, int seed) {
    final distractors = <String>[];
    for (var k = 1; k < pool.length && distractors.length < 3; k++) {
      final g = pool[(seed + k) % pool.length];
      if (g != correct && !distractors.contains(g)) distractors.add(g);
    }
    final opts = [correct, ...distractors];
    if (opts.length < 2) return opts;
    final rot = seed % opts.length;
    return [...opts.sublist(rot), ...opts.sublist(0, rot)];
  }
}
