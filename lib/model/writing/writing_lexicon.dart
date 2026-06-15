/// Writing module — the **shared lexicon** (master vocabulary).
///
/// Words live here once and are referenced by id from many units (a `Toolkit`
/// holds id lists, not embedded words). A verb stores *every* form, so each
/// tense-unit pulls the form it needs — Present simple uses `third`, Past simple
/// will reuse the same entry's `past`, etc. Authored once, reused forever.
///
/// Phase-0: loaded from bundled JSON (`assets/writing/lexicon/`). The JSON keys
/// mirror the future Supabase `writing_lexicon` table (`mm`, `forms` jsonb,
/// `examples` jsonb, `tags` text[]) so productionizing is a copy.
library;

import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;

import 'writing_unit.dart' show ExamplePair;

const _kVerbsAsset = 'assets/writing/lexicon/verbs.json';
const _kTimeWordsAsset = 'assets/writing/lexicon/time_words.json';

/// Loads and indexes the bundled lexicon files.
Future<WritingLexicon> loadWritingLexicon() async {
  final verbsRaw = await rootBundle.loadString(_kVerbsAsset);
  final timeRaw = await rootBundle.loadString(_kTimeWordsAsset);
  return WritingLexicon.fromJson(
    verbsJson: jsonDecode(verbsRaw) as List,
    timeWordsJson: jsonDecode(timeRaw) as List,
  );
}

/// One verb entry — all forms in one place.
class LexiconVerb {
  const LexiconVerb({
    required this.id,
    required this.mm,
    required this.forms,
    required this.examples,
    required this.tags,
  });

  final String id;

  /// Burmese gloss (founder-reviewed).
  final String mm;

  /// base / third / past / past_participle / ing.
  final Map<String, String> forms;
  final List<ExamplePair> examples;
  final List<String> tags;

  String get base => forms['base'] ?? id;
  String get third => forms['third'] ?? base;
  String get ing => forms['ing'] ?? '${base}ing';

  /// The "second form" a unit's verb bank shows next to the base — `third` for
  /// present simple, `ing` for present continuous, `past` for past simple, etc.
  /// Falls back to the base form when the key is missing.
  String secondForm(String key) {
    final v = forms[key];
    return (v != null && v.isNotEmpty) ? v : base;
  }

  factory LexiconVerb.fromJson(Map<String, dynamic> json) => LexiconVerb(
        id: json['id'] as String,
        mm: json['mm'] as String? ?? '',
        forms: ((json['forms'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k.toString(), v.toString())),
        examples: ((json['examples'] as List?) ?? const [])
            .map((e) => ExamplePair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        tags: ((json['tags'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
      );
}

/// One frequency adverb or time expression. [position] drives the "where it
/// goes" hint and the reorder exercises.
class LexiconTimeWord {
  const LexiconTimeWord({
    required this.id,
    required this.en,
    required this.mm,
    required this.position,
    required this.frequency,
    required this.examples,
  });

  final String id;
  final String en;
  final String mm;

  /// `before_main_verb` | `end_of_sentence` (extend as needed).
  final String position;

  /// 0–100 "how often" rank, set only for **frequency adverbs**
  /// (always = 100 … never = 0). Drives the frequency-scale block; null for
  /// plain time phrases (every day, on Mondays …).
  final int? frequency;

  final List<ExamplePair> examples;

  /// True for adverbs of frequency (placed before the main verb), as opposed to
  /// time phrases (placed at the end of the sentence).
  bool get isFrequencyAdverb => position == 'before_main_verb';

  /// Short English label for the position rule.
  String get positionLabel => switch (position) {
        'before_main_verb' => 'before the verb',
        'end_of_sentence' => 'end of sentence',
        _ => '',
      };

  factory LexiconTimeWord.fromJson(Map<String, dynamic> json) =>
      LexiconTimeWord(
        id: json['id'] as String,
        en: json['en'] as String? ?? '',
        mm: json['mm'] as String? ?? '',
        position: json['position'] as String? ?? '',
        frequency: (json['frequency'] as num?)?.toInt(),
        examples: ((json['examples'] as List?) ?? const [])
            .map((e) => ExamplePair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
      );
}

/// The indexed lexicon. Resolve a unit's [Toolkit] id lists into full objects.
class WritingLexicon {
  const WritingLexicon({required this.verbs, required this.timeWords});

  final Map<String, LexiconVerb> verbs;
  final Map<String, LexiconTimeWord> timeWords;

  factory WritingLexicon.fromJson({
    required List<dynamic> verbsJson,
    required List<dynamic> timeWordsJson,
  }) {
    final verbs = <String, LexiconVerb>{};
    for (final v in verbsJson) {
      final verb = LexiconVerb.fromJson((v as Map).cast<String, dynamic>());
      verbs[verb.id] = verb;
    }
    final timeWords = <String, LexiconTimeWord>{};
    for (final t in timeWordsJson) {
      final tw = LexiconTimeWord.fromJson((t as Map).cast<String, dynamic>());
      timeWords[tw.id] = tw;
    }
    return WritingLexicon(verbs: verbs, timeWords: timeWords);
  }

  List<LexiconVerb> resolveVerbs(List<String> ids) {
    assert(() {
      final missing = ids.where((id) => !verbs.containsKey(id)).toList();
      if (missing.isNotEmpty) {
        debugPrint('[WritingLexicon] unknown verb ids (check the unit): $missing');
      }
      return true;
    }());
    return ids.map((id) => verbs[id]).whereType<LexiconVerb>().toList(growable: false);
  }

  List<LexiconTimeWord> resolveTimeWords(List<String> ids) {
    assert(() {
      final missing = ids.where((id) => !timeWords.containsKey(id)).toList();
      if (missing.isNotEmpty) {
        debugPrint('[WritingLexicon] unknown time-word ids (check the unit): $missing');
      }
      return true;
    }());
    return ids
        .map((id) => timeWords[id])
        .whereType<LexiconTimeWord>()
        .toList(growable: false);
  }
}

/// A unit's toolkit after its id lists have been resolved against the lexicon.
class ResolvedToolkit {
  const ResolvedToolkit({required this.verbs, required this.timeWords});
  final List<LexiconVerb> verbs;
  final List<LexiconTimeWord> timeWords;

  bool get isEmpty => verbs.isEmpty && timeWords.isEmpty;
}
