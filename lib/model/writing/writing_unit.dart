/// Writing module — content models for the **Phase-0 prototype slice**.
///
/// These are deliberately plain immutable Dart classes (NOT `@freezed`) so the
/// one-unit device-review prototype needs no `build_runner` step. They map 1:1
/// to the local JSON under `assets/writing/units/` — and the JSON keys mirror
/// the future Supabase `writing_lessons` JSONB, so productionizing is a copy.
/// When the module moves past Phase 0, convert these to `@freezed`.
///
/// See repo root `WRITING_FEATURE_PLAN.md` (v2) for the full design.
library;

/// One grammar unit = a self-contained lesson: a [WritingTeach] page + an
/// ordered ladder of [WritingExercise]s.
class WritingUnit {
  const WritingUnit({
    required this.id,
    required this.level,
    required this.section,
    required this.order,
    required this.type,
    required this.title,
    required this.subtitleMm,
    required this.teach,
    required this.toolkit,
    required this.exercises,
  });

  final String id;
  final int level;
  final String section;
  final int order;

  /// e.g. `grammar_unit`. Reserved for the later task types
  /// (sentence/paragraph/picture/chart).
  final String type;
  final String title;
  final String subtitleMm;
  final WritingTeach teach;

  /// The verbs + time words this unit builds with — id lists into the shared
  /// lexicon (see [Toolkit]). Resolve via `WritingLexicon`.
  final Toolkit toolkit;
  final List<WritingExercise> exercises;

  factory WritingUnit.fromJson(Map<String, dynamic> json) => WritingUnit(
        id: json['id'] as String,
        level: (json['level'] as num?)?.toInt() ?? 1,
        section: json['section'] as String? ?? '',
        order: (json['order'] as num?)?.toInt() ?? 0,
        type: json['type'] as String? ?? 'grammar_unit',
        title: json['title'] as String? ?? '',
        subtitleMm: json['subtitle_mm'] as String? ?? '',
        teach: WritingTeach.fromJson(
            (json['teach'] as Map?)?.cast<String, dynamic>() ?? const {}),
        toolkit: Toolkit.fromJson(
            (json['toolkit'] as Map?)?.cast<String, dynamic>() ?? const {}),
        exercises: ((json['exercises'] as List?) ?? const [])
            .map((e) =>
                WritingExercise.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
      );
}

/// A unit's word banks, stored as id lists into the shared lexicon. Kept as ids
/// (not embedded words) so one word is authored once and reused across units.
class Toolkit {
  const Toolkit({
    required this.verbIds,
    required this.timeWordIds,
    required this.adjectiveIds,
    required this.nounIds,
    required this.timeWordsNoteMm,
    required this.noteMm,
    required this.verbForm,
    required this.verbExamples,
    required this.timeWordExamples,
  });

  final List<String> verbIds;
  final List<String> timeWordIds;

  /// Adjective / noun word-bank ids (into the shared lexicon). Used by units
  /// built around `be` and descriptions, where the useful vocabulary is what
  /// follows the verb (She is **happy** · I am **a student**) rather than action
  /// verbs. Empty for action-verb units.
  final List<String> adjectiveIds;
  final List<String> nounIds;

  /// Optional Burmese "how to use" note rendered under the frequency / time
  /// words (e.g. the adverb-position rule). Empty when a unit needs none.
  final String timeWordsNoteMm;

  /// Optional Burmese note rendered under the adjective / noun banks — e.g. the
  /// `be` unit folds the "places after be" hint (I am **at home** · She is
  /// **from Mandalay**) in here rather than carrying a separate place table.
  final String noteMm;

  /// Which verb form the bank shows next to the base — `third` (default, present
  /// simple), `ing` (present continuous), `past` (past simple)… Lets each
  /// tense-unit reuse the same lexicon entry and pull the form it needs.
  final String verbForm;

  /// Optional per-unit example overrides, keyed by lexicon id. The shared
  /// lexicon only stores positive present-simple examples, so a unit whose
  /// grammar differs (negatives, questions, continuous) provides bank examples
  /// that match (e.g. `v_like` → "She doesn't like coffee."). When absent, the
  /// bank falls back to the lexicon example for affirmative units.
  final Map<String, ExamplePair> verbExamples;
  final Map<String, ExamplePair> timeWordExamples;

  bool get isEmpty =>
      verbIds.isEmpty &&
      timeWordIds.isEmpty &&
      adjectiveIds.isEmpty &&
      nounIds.isEmpty;

  static Map<String, ExamplePair> _examplesFromJson(Object? raw) {
    final map = (raw as Map?)?.cast<String, dynamic>() ?? const {};
    return map.map((k, v) =>
        MapEntry(k, ExamplePair.fromJson((v as Map).cast<String, dynamic>())));
  }

  factory Toolkit.fromJson(Map<String, dynamic> json) => Toolkit(
        verbIds: ((json['verbs'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        timeWordIds: ((json['time_words'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        adjectiveIds: ((json['adjectives'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        nounIds: ((json['nouns'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        timeWordsNoteMm: json['time_words_note_mm'] as String? ?? '',
        noteMm: json['note_mm'] as String? ?? '',
        verbForm: json['verb_form'] as String? ?? 'third',
        verbExamples: _examplesFromJson(json['verb_examples']),
        timeWordExamples: _examplesFromJson(json['time_word_examples']),
      );
}

/// An optional, typed teach block that a unit can slot in **on top of the fixed
/// spine** (situation → use → form → trap → examples → toolkit → model).
///
/// The spine gives every lesson the same predictable rhythm; blocks add the
/// bespoke-per-unit pieces without forking the screen. Present simple ships a
/// `frequency_scale`; most units ship none. New block types are added to the
/// renderer registry once and reused; unknown types render nothing
/// (forward-compatible with content authored ahead of the app).
class TeachBlock {
  const TeachBlock({required this.type, required this.data});

  /// e.g. `frequency_scale` (later: `image`, `decision_tree`, `mnemonic` …).
  final String type;

  /// Block-specific payload. `frequency_scale` reads from the resolved toolkit,
  /// so its data is currently empty — kept for future per-block config.
  final Map<String, dynamic> data;

  factory TeachBlock.fromJson(Map<String, dynamic> json) => TeachBlock(
        type: json['type'] as String? ?? '',
        data: Map<String, dynamic>.from(json)..remove('type'),
      );
}

/// Normalizes a note field that may be authored either as a single string or as
/// a JSON array of lines (the preferred, cleaner form) into newline-separated
/// text. The teach page splits it back into a bullet list per line.
String _linesToText(Object? raw) {
  if (raw is List) {
    return raw
        .map((e) => e.toString().trim())
        .where((s) => s.isNotEmpty)
        .join('\n');
  }
  return raw as String? ?? '';
}

/// The fixed teach spine: situation → use (+timeline) → form → Burmese trap →
/// examples → toolkit → model paragraph. Authored English fields may carry
/// `{v}…{/v}` / `{t}…{/t}` highlight markup (see `writing_highlight.dart`).
/// Optional [blocks] slot in bespoke-per-unit pieces on top of the spine.
class WritingTeach {
  const WritingTeach({
    required this.situationEn,
    required this.situationMm,
    required this.useEn,
    required this.useMm,
    required this.timeline,
    required this.form,
    required this.trapEn,
    required this.trapMm,
    required this.examples,
    required this.formNoteMm,
    required this.modelParagraphEn,
    required this.modelParagraphMm,
    required this.blocks,
  });

  final String situationEn;
  final String situationMm;
  final String useEn;
  final String useMm;

  /// A short ASCII timeline string for tenses (may be empty for non-tense units).
  final String timeline;
  final List<FormRow> form;
  final String trapEn;
  final String trapMm;
  final List<ExamplePair> examples;

  /// Optional Burmese note shown under the form table (e.g. how subject and verb
  /// agree), authored one rule per line. May be a single string or a JSON array
  /// of lines in the source; both are normalized to newline-separated text and
  /// rendered as a bullet list. Empty when a unit needs none.
  final String formNoteMm;

  /// A short worked example that uses the toolkit in real prose — shown right
  /// before the learner writes, so they see the target output first.
  final String modelParagraphEn;
  final String modelParagraphMm;

  /// Optional bespoke-per-unit teach blocks (e.g. `frequency_scale`), rendered
  /// in the toolkit region. Empty for units that need none.
  final List<TeachBlock> blocks;

  bool get hasModelParagraph => modelParagraphEn.isNotEmpty;

  factory WritingTeach.fromJson(Map<String, dynamic> json) => WritingTeach(
        situationEn: json['situation_en'] as String? ?? '',
        situationMm: json['situation_mm'] as String? ?? '',
        useEn: json['use_en'] as String? ?? '',
        useMm: json['use_mm'] as String? ?? '',
        timeline: json['timeline'] as String? ?? '',
        form: ((json['form'] as List?) ?? const [])
            .map((e) => FormRow.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        trapEn: json['trap_en'] as String? ?? '',
        trapMm: json['trap_mm'] as String? ?? '',
        examples: ((json['examples'] as List?) ?? const [])
            .map(
                (e) => ExamplePair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        formNoteMm: _linesToText(json['form_note_mm']),
        modelParagraphEn: json['model_paragraph_en'] as String? ?? '',
        modelParagraphMm: json['model_paragraph_mm'] as String? ?? '',
        blocks: ((json['blocks'] as List?) ?? const [])
            .map((e) => TeachBlock.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
      );
}

/// One row of the "form" table — a subject group and how the verb looks for it.
class FormRow {
  const FormRow({required this.subject, required this.form});
  final String subject;
  final String form;

  factory FormRow.fromJson(Map<String, dynamic> json) => FormRow(
        subject: json['subject'] as String? ?? '',
        form: json['form'] as String? ?? '',
      );
}

/// A bilingual example sentence (English + Burmese gloss).
class ExamplePair {
  const ExamplePair({required this.en, required this.mm});
  final String en;
  final String mm;

  factory ExamplePair.fromJson(Map<String, dynamic> json) => ExamplePair(
        en: json['en'] as String? ?? '',
        mm: json['mm'] as String? ?? '',
      );
}

/// How an exercise is graded.
/// - [auto]: objective, checked on-device against [WritingExercise.answers]
///   (free, instant — mcq / gap_fill / reorder / correct_error).
/// - [ai]: open / multi-answer — checked by Gemini (type or handwrite-and-scan).
///   In the Phase-0 stub there is no key, so we type-and-reveal the model answer.
enum WritingGrade { auto, ai }

/// The per-exercise AI grading rubric. Carried in the unit JSON and injected
/// into the single `writing-review` Gemini prompt at Phase 3, so feedback is
/// "highly customized per unit" through **data, not a bespoke function** — the
/// model is told exactly which grammar point, rule, and Burmese-learner traps
/// to check. Null for auto-graded items (graded on-device against [answers]).
class Grading {
  const Grading({
    required this.grammarPoint,
    required this.rule,
    required this.mustCheck,
    required this.commonMmErrors,
    required this.ignore,
  });

  final String grammarPoint;
  final String rule;
  final List<String> mustCheck;
  final List<String> commonMmErrors;

  /// Surface issues the AI must **not** mark wrong (e.g. `punctuation`,
  /// `capitalization`, `spelling`) — at most a one-line friendly tip. Keeps
  /// feedback focused on the grammar point and avoids penalising beginners /
  /// transcription artifacts. Defaults to punctuation + capitalization.
  final List<String> ignore;

  factory Grading.fromJson(Map<String, dynamic> json) => Grading(
        grammarPoint: json['grammar_point'] as String? ?? '',
        rule: json['rule'] as String? ?? '',
        mustCheck: ((json['must_check'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        commonMmErrors: ((json['common_mm_errors'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        ignore: ((json['ignore'] as List?) ??
                const ['punctuation', 'capitalization'])
            .map((e) => e.toString())
            .toList(growable: false),
      );
}

/// One exercise on the practice ladder.
class WritingExercise {
  const WritingExercise({
    required this.kind,
    required this.grade,
    required this.promptEn,
    required this.promptMm,
    required this.options,
    required this.answers,
    required this.stimulus,
    required this.model,
    required this.explainMm,
    required this.grading,
    required this.minLines,
    required this.maxLines,
  });

  /// mcq | gap_fill | correct_error | reorder | join | transform | free_write …
  final String kind;
  final WritingGrade grade;
  final String promptEn;
  final String promptMm;

  /// For `scan_sentences`: the min / max number of sentence rows the typed
  /// fallback shows (line-by-line input). Defaults 5 / 10. Ignored by other
  /// kinds (`scan_paragraph` is one continuous box).
  final int minLines;
  final int maxLines;

  /// Choices for `mcq` (empty otherwise).
  final List<String> options;

  /// Accepted answers for [WritingGrade.auto] grading.
  final List<String> answers;

  /// The two source sentences for `join` (empty otherwise).
  final List<String> stimulus;

  /// A model answer for [WritingGrade.ai] items — revealed in the Phase-0 stub.
  /// May carry `{v}`/`{t}` highlight markup.
  final String model;
  final String explainMm;

  /// The AI grading rubric for [WritingGrade.ai] items (null otherwise).
  final Grading? grading;

  factory WritingExercise.fromJson(Map<String, dynamic> json) =>
      WritingExercise(
        kind: json['kind'] as String? ?? 'mcq',
        grade: (json['grade'] as String?) == 'ai'
            ? WritingGrade.ai
            : WritingGrade.auto,
        promptEn: json['prompt_en'] as String? ?? '',
        promptMm: json['prompt_mm'] as String? ?? '',
        options: ((json['options'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        answers: ((json['answers'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        stimulus: ((json['stimulus'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        model: json['model'] as String? ?? '',
        explainMm: json['explain_mm'] as String? ?? '',
        grading: json['grading'] == null
            ? null
            : Grading.fromJson(
                (json['grading'] as Map).cast<String, dynamic>()),
        minLines: (json['min_lines'] as num?)?.toInt() ?? 5,
        maxLines: (json['max_lines'] as num?)?.toInt() ?? 10,
      );

  /// On-device auto-grader. Normalizes case, surrounding/duplicate whitespace,
  /// and a trailing period, then checks membership in [answers]. Used only for
  /// [WritingGrade.auto] items.
  bool isCorrect(String input) {
    final got = normalize(input);
    if (got.isEmpty) return false;
    return answers.any((a) => normalize(a) == got);
  }

  /// The single answer normalizer (trim, lowercase, collapse inner whitespace,
  /// drop trailing `.!?`). Shared by auto-grading and MCQ checking so there is
  /// one source of truth.
  static String normalize(String s) {
    var t = s.trim().toLowerCase();
    t = t.replaceAll(RegExp(r'\s+'), ' ');
    t = t.replaceAll(RegExp(r'[.!?]+$'), '');
    return t.trim();
  }
}
