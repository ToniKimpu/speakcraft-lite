/// Speak Your Mind — **prototype** content models.
///
/// The "produce" bridge between knowing English and using it. A *topic*
/// (e.g. "My Family") gives the learner a **toolbox** of communicative *moves*
/// — each a function ("Saying your family size") with a few reusable example
/// chunks — then asks them to **produce** their own short piece about their real
/// life. Plain immutable Dart mirroring the Vocabulary phase-0 pattern; keys map
/// 1:1 to the bundled JSON under `assets/speak_your_mind/`, so productionizing to
/// Supabase later is a loader swap.
library;

import 'sym_guide.dart';

/// One reusable example sentence inside a move. [highlight] is the substring of
/// [textEn] worth emphasizing (the pattern to reuse); [swapEn] lists alternative
/// fillers for that slot — the invitation to make it the learner's own.
class SymChunk {
  const SymChunk({
    required this.textEn,
    required this.highlight,
    required this.swapEn,
    required this.glossMm,
    required this.audio,
    required this.tag,
  });

  final String textEn;
  final String highlight;
  final String swapEn;
  final String glossMm;

  /// Bunny path/URL for the pre-generated clip; empty ⇒ fall back to device TTS.
  final String audio;

  /// Register/difficulty so different learners self-select: simple | natural |
  /// advanced (empty ⇒ untagged). Chunks are authored simple→advanced in order.
  final String tag;

  factory SymChunk.fromJson(Map<String, dynamic> j) => SymChunk(
        textEn: j['text_en'] as String? ?? '',
        highlight: j['highlight'] as String? ?? '',
        swapEn: j['swap_en'] as String? ?? '',
        glossMm: j['gloss_mm'] as String? ?? '',
        audio: j['audio'] as String? ?? '',
        tag: j['tag'] as String? ?? '',
      );
}

/// A communicative "move" — one thing you can *do* when talking about the topic
/// (e.g. "Describing someone's age"), with a handful of example chunks.
class SymMove {
  const SymMove({
    required this.moveEn,
    required this.moveMm,
    required this.items,
  });

  final String moveEn;
  final String moveMm;
  final List<SymChunk> items;

  factory SymMove.fromJson(Map<String, dynamic> j) => SymMove(
        moveEn: j['move_en'] as String? ?? '',
        moveMm: j['move_mm'] as String? ?? '',
        items: ((j['items'] as List?) ?? const [])
            .map((e) => SymChunk.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
      );
}

/// The production task: a prompt to write about the learner's real life, a word
/// target, the moves we hope they touch (feeds the AI "coverage" nudge later),
/// and the speak-aloud rehearsal that closes the loop.
class SymProduce {
  const SymProduce({
    required this.promptEn,
    required this.promptMm,
    required this.minWords,
    required this.maxWords,
    required this.coverageHints,
    required this.speakAloudEn,
    required this.speakAloudMm,
  });

  final String promptEn;
  final String promptMm;

  /// Soft floor — below this, "Get feedback" stays disabled (don't waste a call
  /// on too little to produce). 0 ⇒ no minimum.
  final int minWords;

  /// Hard ceiling — above this, submit is disabled (cost + focus + feedback
  /// quality guard). 0 ⇒ no maximum.
  final int maxWords;

  final List<String> coverageHints;
  final String speakAloudEn;
  final String speakAloudMm;

  factory SymProduce.fromJson(Map<String, dynamic> j) => SymProduce(
        promptEn: j['prompt_en'] as String? ?? '',
        promptMm: j['prompt_mm'] as String? ?? '',
        minWords: (j['min_words'] as num?)?.toInt() ?? 0,
        maxWords: (j['max_words'] as num?)?.toInt() ?? 0,
        coverageHints: ((j['coverage_hints'] as List?) ?? const [])
            .map((e) => e as String)
            .toList(growable: false),
        speakAloudEn: j['speak_aloud_en'] as String? ?? '',
        speakAloudMm: j['speak_aloud_mm'] as String? ?? '',
      );
}

/// A full topic: meta + the toolbox of moves + the produce task.
class SymTopic {
  const SymTopic({
    required this.id,
    required this.level,
    required this.domainEn,
    required this.domainMm,
    required this.titleEn,
    required this.titleMm,
    required this.promiseEn,
    required this.promiseMm,
    required this.introEn,
    required this.introMm,
    required this.toolbox,
    required this.produce,
    this.guide,
  });

  final String id;
  final int level;
  final String domainEn;
  final String domainMm;
  final String titleEn;
  final String titleMm;
  final String promiseEn;
  final String promiseMm;
  final String introEn;
  final String introMm;
  final List<SymMove> toolbox;
  final SymProduce produce;

  /// Optional step-by-step on-ramp for learners who freeze at a blank page.
  final SymGuide? guide;

  bool get hasGuide => guide != null && guide!.slots.isNotEmpty;

  /// Total example chunks across all moves — a quick "size" for the list card.
  int get chunkCount =>
      toolbox.fold(0, (sum, m) => sum + m.items.length);

  factory SymTopic.fromJson(Map<String, dynamic> j) => SymTopic(
        id: j['id'] as String? ?? '',
        level: (j['level'] as num?)?.toInt() ?? 1,
        domainEn: j['domain_en'] as String? ?? '',
        domainMm: j['domain_mm'] as String? ?? '',
        titleEn: j['title_en'] as String? ?? '',
        titleMm: j['title_mm'] as String? ?? '',
        promiseEn: j['promise_en'] as String? ?? '',
        promiseMm: j['promise_mm'] as String? ?? '',
        introEn: j['intro_en'] as String? ?? '',
        introMm: j['intro_mm'] as String? ?? '',
        toolbox: ((j['toolbox'] as List?) ?? const [])
            .map((e) => SymMove.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        produce: SymProduce.fromJson(
            ((j['produce'] as Map?) ?? const {}).cast<String, dynamic>()),
        guide: SymGuide.maybe(j['guide']),
      );
}
