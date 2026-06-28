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
    this.unit = 'word',
    this.section = '',
  });

  final String id;
  final String title;

  /// 1 = beginner, 2 = intermediate, 3 = upper (mirrors the Grammar levels).
  final int level;
  final int order;
  final String theme;
  final int wordCount;

  /// 'word' or 'expression' — for the count label on the list card.
  final String unit;

  /// Optional grouping within a level (e.g. "Daily life") so a large level
  /// can show section tabs instead of one long scroll. Empty = no section.
  final String section;

  factory VocabIndexEntry.fromJson(Map<String, dynamic> j) => VocabIndexEntry(
        id: j['id'] as String,
        title: j['title'] as String? ?? '',
        level: (j['level'] as num?)?.toInt() ?? 1,
        order: (j['order'] as num?)?.toInt() ?? 0,
        theme: j['theme'] as String? ?? '',
        wordCount: (j['word_count'] as num?)?.toInt() ?? 0,
        unit: j['unit'] as String? ?? 'word',
        section: j['section'] as String? ?? '',
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
    this.style = 'contrast',
    this.unit = 'word',
    this.hasAudio = false,
  });

  final String id;
  final String title;
  final int level;
  final int order;
  final String theme;

  /// True once pre-generated Bunny audio has been uploaded for this group.
  /// Audio URLs are *computed* (see [vocab_audio.dart]), never stored — so
  /// turning audio on is a one-column flip, not a content rewrite. Off → the
  /// UI falls back to on-device TTS.
  final bool hasAudio;

  /// 'contrast' (which-word-when, the Intermediate style) or 'theme' (topical
  /// Beginner style — lighter, no "Which one, when?" synthesis).
  final String style;

  /// What the entries are: 'word' (single words) or 'expression' (useful
  /// phrases/chunks — for themes where the words are already known but the
  /// *saying* isn't, e.g. Family). Drives labels (word vs expression).
  final String unit;
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
        style: j['style'] as String? ?? 'contrast',
        unit: j['unit'] as String? ?? 'word',
        hasAudio: j['has_audio'] as bool? ?? false,
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
    required this.whyMm,
  });

  final String prompt;
  final String right;
  final String wrong;
  final String why;
  final String whyMm;

  factory VocabMinimalPair.fromJson(Map<String, dynamic> j) => VocabMinimalPair(
        prompt: j['prompt'] as String? ?? '',
        right: j['right'] as String? ?? '',
        wrong: j['wrong'] as String? ?? '',
        why: j['why'] as String? ?? '',
        whyMm: j['why_mm'] as String? ?? '',
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
    required this.useWhenMm,
    required this.explanationEn,
    required this.explanationMm,
    required this.nuanceEn,
    required this.nuanceMm,
    required this.goesWithEn,
    required this.goesWithNoteEn,
    required this.goesWithNoteMm,
    required this.examples,
    required this.collocations,
    required this.confuseWith,
  });

  final String word;

  /// Part of speech, e.g. "adjective", "adverb", "phrase".
  final String pos;
  final String ipa;
  final String shortEn;
  final String shortMm;

  /// The decision rule — "Use it when …". Drives the comparison table.
  final String useWhenEn;
  final String useWhenMm;
  final String explanationEn;
  final String explanationMm;
  final String nuanceEn;
  final String nuanceMm;

  /// Typical partners / frame, e.g. "a great + idea / time / news".
  final String goesWithEn;

  /// One-line note on how the word collocates (e.g. "Pairs with positive
  /// nouns and with sounds/looks").
  final String goesWithNoteEn;
  final String goesWithNoteMm;
  final List<VocabExample> examples;
  final List<String> collocations;
  final List<String> confuseWith;

  factory VocabWord.fromJson(Map<String, dynamic> j) => VocabWord(
        word: j['word'] as String? ?? '',
        pos: j['pos'] as String? ?? '',
        ipa: j['ipa'] as String? ?? '',
        shortEn: j['short_en'] as String? ?? '',
        shortMm: j['short_mm'] as String? ?? '',
        useWhenEn: j['use_when_en'] as String? ?? '',
        useWhenMm: j['use_when_mm'] as String? ?? '',
        explanationEn: j['explanation_en'] as String? ?? '',
        explanationMm: j['explanation_mm'] as String? ?? '',
        nuanceEn: j['nuance_en'] as String? ?? '',
        nuanceMm: j['nuance_mm'] as String? ?? '',
        goesWithEn: j['goes_with_en'] as String? ?? '',
        goesWithNoteEn: j['goes_with_note_en'] as String? ?? '',
        goesWithNoteMm: j['goes_with_note_mm'] as String? ?? '',
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
      );
}

class VocabExample {
  const VocabExample({required this.en, required this.mm});

  final String en;
  final String mm;

  factory VocabExample.fromJson(Map<String, dynamic> j) => VocabExample(
        en: j['en'] as String? ?? '',
        mm: j['mm'] as String? ?? '',
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
    required this.explainEn,
    required this.explainMm,
    required this.accept,
  });

  /// `which_word` (multiple choice) or `gap_fill` (type the word).
  final String type;
  final String prompt;
  final String answer;

  /// Choices for `which_word` (empty for `gap_fill`).
  final List<String> options;

  /// The "why" shown after answering — reinforces on correct, corrects the
  /// misconception on wrong.
  final String explainEn;
  final String explainMm;

  /// Extra accepted answers for `gap_fill` (beyond [answer]); matching is
  /// case-insensitive so capitalisation isn't listed here.
  final List<String> accept;

  /// All acceptable answers, normalised for comparison.
  List<String> get acceptedAnswers =>
      [answer, ...accept].map((s) => s.trim().toLowerCase()).toList();

  bool isCorrect(String input) =>
      acceptedAnswers.contains(input.trim().toLowerCase());

  factory VocabExercise.fromJson(Map<String, dynamic> j) => VocabExercise(
        type: j['type'] as String? ?? 'which_word',
        prompt: j['prompt'] as String? ?? '',
        answer: j['answer'] as String? ?? '',
        options: ((j['options'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        explainEn: j['explain_en'] as String? ?? '',
        explainMm: j['explain_mm'] as String? ?? '',
        accept: ((j['accept'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
      );
}
