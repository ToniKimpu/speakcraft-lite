/// Vocabulary module — **prototype** content models.
///
/// Plain immutable Dart (no `@freezed`, no build_runner) mirroring the Grammar
/// phase-0 pattern. Keys map 1:1 to the bundled sample JSON under
/// `assets/vocabulary/` AND to the future Supabase `vocab_groups` JSONB, so
/// productionizing is a copy + a loader swap (see [vocab_loader.dart]).
library;

/// One row in the manifest — enough to draw a group card on the list screen.
class VocabIndexEntry {
  const VocabIndexEntry({
    required this.id,
    required this.title,
    required this.level,
    required this.order,
    required this.theme,
    required this.wordCount,
  });

  final String id;
  final String title;

  /// 1 = beginner, 2 = intermediate, 3 = upper (mirrors the Grammar levels).
  final int level;
  final int order;
  final String theme;
  final int wordCount;

  factory VocabIndexEntry.fromJson(Map<String, dynamic> j) => VocabIndexEntry(
        id: j['id'] as String,
        title: j['title'] as String? ?? '',
        level: (j['level'] as num?)?.toInt() ?? 1,
        order: (j['order'] as num?)?.toInt() ?? 0,
        theme: j['theme'] as String? ?? '',
        wordCount: (j['word_count'] as num?)?.toInt() ?? 0,
      );
}

/// A full taught set: a "why these belong together" framing + its words +
/// contrast exercises.
class VocabGroup {
  const VocabGroup({
    required this.id,
    required this.title,
    required this.level,
    required this.order,
    required this.theme,
    required this.whyGroupedEn,
    required this.whyGroupedMm,
    required this.words,
    required this.minimalPairs,
    required this.exercises,
  });

  final String id;
  final String title;
  final int level;
  final int order;
  final String theme;
  final String whyGroupedEn;
  final String whyGroupedMm;
  final List<VocabWord> words;

  /// Right-vs-wrong contrasts shown on the comparison page.
  final List<VocabMinimalPair> minimalPairs;
  final List<VocabExercise> exercises;

  factory VocabGroup.fromJson(Map<String, dynamic> j) => VocabGroup(
        id: j['id'] as String,
        title: j['title'] as String? ?? '',
        level: (j['level'] as num?)?.toInt() ?? 1,
        order: (j['order'] as num?)?.toInt() ?? 0,
        theme: j['theme'] as String? ?? '',
        whyGroupedEn: j['why_grouped_en'] as String? ?? '',
        whyGroupedMm: j['why_grouped_mm'] as String? ?? '',
        words: ((j['words'] as List?) ?? const [])
            .map((e) => VocabWord.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        minimalPairs: ((j['minimal_pairs'] as List?) ?? const [])
            .map((e) =>
                VocabMinimalPair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        exercises: ((j['exercises'] as List?) ?? const [])
            .map((e) =>
                VocabExercise.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
      );
}

/// One "right word vs wrong word in the same slot" contrast, with the reason.
class VocabMinimalPair {
  const VocabMinimalPair({
    required this.prompt,
    required this.right,
    required this.wrong,
    required this.why,
  });

  final String prompt;
  final String right;
  final String wrong;
  final String why;

  factory VocabMinimalPair.fromJson(Map<String, dynamic> j) => VocabMinimalPair(
        prompt: j['prompt'] as String? ?? '',
        right: j['right'] as String? ?? '',
        wrong: j['wrong'] as String? ?? '',
        why: j['why'] as String? ?? '',
      );
}

class VocabWord {
  const VocabWord({
    required this.word,
    required this.pos,
    required this.ipa,
    required this.shortEn,
    required this.shortMm,
    required this.useWhenEn,
    required this.explanationEn,
    required this.nuanceEn,
    required this.goesWithEn,
    required this.examples,
    required this.collocations,
    required this.confuseWith,
    this.audioPath,
  });

  final String word;

  /// Part of speech, e.g. "adjective", "adverb", "phrase".
  final String pos;
  final String ipa;
  final String shortEn;
  final String shortMm;

  /// The decision rule — "Use it when …". Drives the comparison table.
  final String useWhenEn;
  final String explanationEn;
  final String nuanceEn;

  /// Typical partners / frame, e.g. "a great + idea / time / news".
  final String goesWithEn;
  final List<VocabExample> examples;
  final List<String> collocations;
  final List<String> confuseWith;

  /// Pre-generated clip path (Bunny) — null in the prototype, which falls back
  /// to on-device TTS.
  final String? audioPath;

  factory VocabWord.fromJson(Map<String, dynamic> j) => VocabWord(
        word: j['word'] as String? ?? '',
        pos: j['pos'] as String? ?? '',
        ipa: j['ipa'] as String? ?? '',
        shortEn: j['short_en'] as String? ?? '',
        shortMm: j['short_mm'] as String? ?? '',
        useWhenEn: j['use_when_en'] as String? ?? '',
        explanationEn: j['explanation_en'] as String? ?? '',
        nuanceEn: j['nuance_en'] as String? ?? '',
        goesWithEn: j['goes_with_en'] as String? ?? '',
        examples: ((j['examples'] as List?) ?? const [])
            .map(
                (e) => VocabExample.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        collocations: ((j['collocations'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        confuseWith: ((j['confuse_with'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        audioPath: j['audio_path'] as String?,
      );
}

class VocabExample {
  const VocabExample({required this.en, required this.mm, this.audioPath});

  final String en;
  final String mm;
  final String? audioPath;

  factory VocabExample.fromJson(Map<String, dynamic> j) => VocabExample(
        en: j['en'] as String? ?? '',
        mm: j['mm'] as String? ?? '',
        audioPath: j['audio_path'] as String?,
      );
}

/// Prototype supports `which_word` (multiple choice). Unknown types are kept
/// but the practice screen skips what it can't render.
class VocabExercise {
  const VocabExercise({
    required this.type,
    required this.prompt,
    required this.answer,
    required this.options,
  });

  final String type;
  final String prompt;
  final String answer;
  final List<String> options;

  factory VocabExercise.fromJson(Map<String, dynamic> j) => VocabExercise(
        type: j['type'] as String? ?? 'which_word',
        prompt: j['prompt'] as String? ?? '',
        answer: j['answer'] as String? ?? '',
        options: ((j['options'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
      );
}
