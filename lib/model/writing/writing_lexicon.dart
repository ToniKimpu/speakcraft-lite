/// Writing module — the **shared lexicon** (master vocabulary).
///
/// Words live here once and are referenced by id from many units (a `Toolkit`
/// holds id lists, not embedded words). A verb stores *every* form, so each
/// tense-unit pulls the form it needs — Present simple uses `third`, Past simple
/// will reuse the same entry's `past`, etc. Authored once, reused forever.
///
/// **Online-only**: loaded from the Supabase `writing_lexicon` table (rows split
/// by `kind`). No bundled fallback.
library;

import 'package:flutter/foundation.dart' show debugPrint;

import '../../services/supabase_service.dart';
import 'writing_unit.dart' show ExamplePair;

// Cached for the session — the lexicon is shared by every unit, so resolve once.
WritingLexicon? _lexiconCache;

/// Loads and indexes the shared lexicon.
/// Online-only: queries Supabase `writing_lexicon`, splitting rows by `kind`.
Future<WritingLexicon> loadWritingLexicon() async {
  if (_lexiconCache != null) return _lexiconCache!;
  final rows = await supabase.from('writing_lexicon').select('id,kind,data');
  final byKind = <String, List>{
    'verb': [],
    'time_word': [],
    'adjective': [],
    'noun': [],
  };
  for (final r in (rows as List)) {
    final m = (r as Map).cast<String, dynamic>();
    final kind = m['kind'] as String?;
    final data = m['data'];
    if (kind != null && data != null && byKind.containsKey(kind)) {
      byKind[kind]!.add(data);
    }
  }
  return _lexiconCache = WritingLexicon.fromJson(
    verbsJson: byKind['verb']!,
    timeWordsJson: byKind['time_word']!,
    adjectivesJson: byKind['adjective']!,
    nounsJson: byKind['noun']!,
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

/// One adjective — a describing word that follows `be` (She is **happy**) or a
/// noun (a **tall** man). Adjectives don't inflect, so there are no `forms`.
class LexiconAdjective {
  const LexiconAdjective({
    required this.id,
    required this.en,
    required this.mm,
    required this.examples,
    required this.tags,
  });

  final String id;
  final String en;
  final String mm;
  final List<ExamplePair> examples;
  final List<String> tags;

  factory LexiconAdjective.fromJson(Map<String, dynamic> json) =>
      LexiconAdjective(
        id: json['id'] as String,
        en: json['en'] as String? ?? '',
        mm: json['mm'] as String? ?? '',
        examples: ((json['examples'] as List?) ?? const [])
            .map((e) => ExamplePair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        tags: ((json['tags'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
      );
}

/// One noun — a thing / job / role (I am **a student**). Stores its [article]
/// (a / an) and [plural] so the later a/an and plurals units reuse the entry.
class LexiconNoun {
  const LexiconNoun({
    required this.id,
    required this.en,
    required this.mm,
    required this.article,
    required this.plural,
    required this.examples,
    required this.tags,
  });

  final String id;
  final String en;
  final String mm;

  /// `a` or `an` — the indefinite article this noun takes in the singular.
  final String article;

  /// Plural form (students, businessmen). Falls back to `en + s`.
  final String plural;
  final List<ExamplePair> examples;
  final List<String> tags;

  /// The noun with its article, e.g. `a student`, `an engineer`. Empty article
  /// (e.g. uncountable / proper nouns) → just the noun.
  String get withArticle => article.isEmpty ? en : '$article $en';

  factory LexiconNoun.fromJson(Map<String, dynamic> json) => LexiconNoun(
        id: json['id'] as String,
        en: json['en'] as String? ?? '',
        mm: json['mm'] as String? ?? '',
        article: json['article'] as String? ?? 'a',
        plural: json['plural'] as String? ?? '${json['en'] ?? ''}s',
        examples: ((json['examples'] as List?) ?? const [])
            .map((e) => ExamplePair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        tags: ((json['tags'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
      );
}

/// The indexed lexicon. Resolve a unit's [Toolkit] id lists into full objects.
class WritingLexicon {
  const WritingLexicon({
    required this.verbs,
    required this.timeWords,
    required this.adjectives,
    required this.nouns,
  });

  final Map<String, LexiconVerb> verbs;
  final Map<String, LexiconTimeWord> timeWords;
  final Map<String, LexiconAdjective> adjectives;
  final Map<String, LexiconNoun> nouns;

  factory WritingLexicon.fromJson({
    required List<dynamic> verbsJson,
    required List<dynamic> timeWordsJson,
    List<dynamic> adjectivesJson = const [],
    List<dynamic> nounsJson = const [],
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
    final adjectives = <String, LexiconAdjective>{};
    for (final a in adjectivesJson) {
      final adj = LexiconAdjective.fromJson((a as Map).cast<String, dynamic>());
      adjectives[adj.id] = adj;
    }
    final nouns = <String, LexiconNoun>{};
    for (final n in nounsJson) {
      final noun = LexiconNoun.fromJson((n as Map).cast<String, dynamic>());
      nouns[noun.id] = noun;
    }
    return WritingLexicon(
      verbs: verbs,
      timeWords: timeWords,
      adjectives: adjectives,
      nouns: nouns,
    );
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

  List<LexiconAdjective> resolveAdjectives(List<String> ids) {
    assert(() {
      final missing = ids.where((id) => !adjectives.containsKey(id)).toList();
      if (missing.isNotEmpty) {
        debugPrint('[WritingLexicon] unknown adjective ids (check the unit): $missing');
      }
      return true;
    }());
    return ids
        .map((id) => adjectives[id])
        .whereType<LexiconAdjective>()
        .toList(growable: false);
  }

  List<LexiconNoun> resolveNouns(List<String> ids) {
    assert(() {
      final missing = ids.where((id) => !nouns.containsKey(id)).toList();
      if (missing.isNotEmpty) {
        debugPrint('[WritingLexicon] unknown noun ids (check the unit): $missing');
      }
      return true;
    }());
    return ids
        .map((id) => nouns[id])
        .whereType<LexiconNoun>()
        .toList(growable: false);
  }
}

/// A unit's toolkit after its id lists have been resolved against the lexicon.
class ResolvedToolkit {
  const ResolvedToolkit({
    required this.verbs,
    required this.timeWords,
    this.adjectives = const [],
    this.nouns = const [],
  });
  final List<LexiconVerb> verbs;
  final List<LexiconTimeWord> timeWords;
  final List<LexiconAdjective> adjectives;
  final List<LexiconNoun> nouns;

  bool get isEmpty =>
      verbs.isEmpty &&
      timeWords.isEmpty &&
      adjectives.isEmpty &&
      nouns.isEmpty;
}
