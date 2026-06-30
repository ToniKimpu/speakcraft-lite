/// Speak Your Mind — the optional **guided** on-ramp for a topic.
///
/// For learners who freeze at a blank page, gradual release (I do → We do →
/// You do): a worked model paragraph + line-by-line breakdown, then a
/// fill-the-blanks template where they supply only the personal bits and watch
/// their own paragraph assemble — which then seeds the normal produce flow.
/// Optional per topic (null ⇒ that topic only offers the direct write path).
library;

/// One fill-in slot in the Build step. [options] non-empty ⇒ tap-to-pick chips
/// (lowest friction); empty ⇒ a short free-text field. [hint] seeds the field.
class SymSlot {
  const SymSlot({
    required this.id,
    required this.labelEn,
    required this.labelMm,
    required this.hint,
    required this.options,
  });

  final String id;
  final String labelEn;
  final String labelMm;
  final String hint;
  final List<String> options;

  factory SymSlot.fromJson(Map<String, dynamic> j) => SymSlot(
        id: j['id'] as String? ?? '',
        labelEn: j['label_en'] as String? ?? '',
        labelMm: j['label_mm'] as String? ?? '',
        hint: j['hint'] as String? ?? '',
        options: ((j['options'] as List?) ?? const [])
            .map((e) => e as String)
            .toList(growable: false),
      );
}

/// One sentence of the model paragraph + why it's built that way — the "I do"
/// breakdown, so the learner understands the shape, not just copies it.
class SymGuideLine {
  const SymGuideLine({
    required this.textEn,
    required this.glossMm,
    required this.whyMm,
  });

  final String textEn;
  final String glossMm;
  final String whyMm;

  factory SymGuideLine.fromJson(Map<String, dynamic> j) => SymGuideLine(
        textEn: j['text_en'] as String? ?? '',
        glossMm: j['gloss_mm'] as String? ?? '',
        whyMm: j['why_mm'] as String? ?? '',
      );
}

/// The guided scaffold: a worked example, its breakdown, and a `{slot}` template
/// the learner fills to build their own first draft.
class SymGuide {
  const SymGuide({
    required this.modelEn,
    required this.modelMm,
    required this.breakdown,
    required this.template,
    required this.slots,
    this.modelAudio = '',
  });

  /// The worked example paragraph — the "I do".
  final String modelEn;

  /// Its natural Burmese meaning.
  final String modelMm;

  /// Stored Bunny path for the model paragraph's pre-generated clip
  /// (`bunny/speak_your_mind/…/guide-model.mp3`); empty ⇒ on-device TTS.
  final String modelAudio;

  /// Per-sentence breakdown of [modelEn].
  final List<SymGuideLine> breakdown;

  /// The same shape as a fill-in template using `{slotId}` tokens.
  final String template;

  /// The slots the learner fills to assemble their draft.
  final List<SymSlot> slots;

  factory SymGuide.fromJson(Map<String, dynamic> j) => SymGuide(
        modelEn: j['model_en'] as String? ?? '',
        modelMm: j['model_mm'] as String? ?? '',
        breakdown: ((j['breakdown'] as List?) ?? const [])
            .map((e) =>
                SymGuideLine.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        template: j['template'] as String? ?? '',
        slots: ((j['slots'] as List?) ?? const [])
            .map((e) => SymSlot.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        modelAudio: j['model_audio'] as String? ?? '',
      );

  /// Null-safe parse — a topic without a `guide` block returns null.
  static SymGuide? maybe(Object? j) => j is Map
      ? SymGuide.fromJson(j.cast<String, dynamic>())
      : null;
}
