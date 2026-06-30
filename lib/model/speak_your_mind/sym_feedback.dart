/// Speak Your Mind — the structured AI feedback returned for one produced piece.
///
/// Shape mirrors the JSON `gemini-2.5-flash-lite` returns (via the response
/// schema in `sym_reviewer.dart`). Tuned for *production* practice: encourage
/// first, correct gently, then push the learner to say more (`useMore`). Plain
/// hand-written class, consistent with the other Speak Your Mind models.
library;

/// One gentle correction: what they wrote, the fix, a Burmese why, and a kind.
class SymCorrection {
  const SymCorrection({
    required this.original,
    required this.fixed,
    required this.whyMm,
    required this.type,
  });

  final String original;
  final String fixed;
  final String whyMm;

  /// grammar | word_choice | spelling | naturalness
  final String type;

  factory SymCorrection.fromJson(Map<String, dynamic> j) => SymCorrection(
        original: j['original'] as String? ?? '',
        fixed: j['fixed'] as String? ?? '',
        whyMm: j['why_mm'] as String? ?? '',
        type: j['type'] as String? ?? 'grammar',
      );

  Map<String, dynamic> toJson() => {
        'original': original,
        'fixed': fixed,
        'why_mm': whyMm,
        'type': type,
      };
}

/// A toolbox move the learner did NOT use but could — the "produce more" nudge.
class SymUseMore {
  const SymUseMore({
    required this.moveEn,
    required this.exampleEn,
    required this.whyMm,
  });

  final String moveEn;
  final String exampleEn;
  final String whyMm;

  factory SymUseMore.fromJson(Map<String, dynamic> j) => SymUseMore(
        moveEn: j['move_en'] as String? ?? '',
        exampleEn: j['example_en'] as String? ?? '',
        whyMm: j['why_mm'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'move_en': moveEn,
        'example_en': exampleEn,
        'why_mm': whyMm,
      };
}

/// The daily budget state returned alongside feedback (server-authoritative).
class SymBudget {
  const SymBudget({
    required this.used,
    required this.limit,
    required this.remaining,
    required this.checksLeft,
    required this.isPremium,
    required this.resetAt,
  });

  final int used;
  final int limit;
  final int remaining;

  /// Estimated feedback checks still available today (remaining ÷ avg call).
  final int checksLeft;
  final bool isPremium;
  final DateTime? resetAt;

  factory SymBudget.fromJson(Map<String, dynamic> j) => SymBudget(
        used: (j['used'] as num?)?.toInt() ?? 0,
        limit: (j['limit'] as num?)?.toInt() ?? 0,
        remaining: (j['remaining'] as num?)?.toInt() ?? 0,
        checksLeft: (j['checks_left'] as num?)?.toInt() ?? 0,
        isPremium: j['is_premium'] as bool? ?? false,
        resetAt: DateTime.tryParse(j['reset_at'] as String? ?? ''),
      );
}

/// The full feedback for one version of a produced piece.
class SymFeedback {
  const SymFeedback({
    required this.overallMm,
    required this.band,
    required this.score,
    required this.strengths,
    required this.corrections,
    required this.naturalVersionEn,
    required this.useMore,
    required this.nextStepMm,
    this.totalTokens = 0,
    this.budget,
  });

  /// Warm 1–2 sentence Burmese coach summary.
  final String overallMm;

  /// great | good | keep_going — drives the colour/title.
  final String band;

  /// 0–100 clarity score; powers the v1 → v2 delta.
  final int score;

  /// Specific things they did well (English, short).
  final List<String> strengths;

  /// The gentle corrections (empty when clean).
  final List<SymCorrection> corrections;

  /// Their whole piece rewritten naturally — same meaning, better English. This
  /// is also what they read aloud in the speak-aloud step.
  final String naturalVersionEn;

  /// Toolbox moves to add next time.
  final List<SymUseMore> useMore;

  /// One concrete Burmese next-step for their next version.
  final String nextStepMm;

  /// Tokens the call billed (0 for the on-device mock) — a cost meter.
  final int totalTokens;

  /// Daily budget state from the server (null for the mock).
  final SymBudget? budget;

  bool get isClean => corrections.isEmpty;

  factory SymFeedback.fromJson(Map<String, dynamic> j, {int? totalTokens}) =>
      SymFeedback(
        overallMm: j['overall_mm'] as String? ?? '',
        band: j['band'] as String? ?? 'good',
        score: (j['score'] as num?)?.toInt() ?? 0,
        strengths: ((j['strengths'] as List?) ?? const [])
            .map((e) => e as String)
            .toList(growable: false),
        corrections: ((j['corrections'] as List?) ?? const [])
            .map((e) =>
                SymCorrection.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        naturalVersionEn: j['natural_version_en'] as String? ?? '',
        useMore: ((j['use_more'] as List?) ?? const [])
            .map((e) => SymUseMore.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        nextStepMm: j['next_step_mm'] as String? ?? '',
        totalTokens: totalTokens ?? (j['call_tokens'] as num?)?.toInt() ?? 0,
        budget: j['budget'] is Map
            ? SymBudget.fromJson((j['budget'] as Map).cast<String, dynamic>())
            : null,
      );

  /// Persisted with each saved version so the history can render the full
  /// feedback (not just the natural rewrite). The transient [budget] is not
  /// stored — it's a live server state, meaningless after the fact.
  Map<String, dynamic> toJson() => {
        'overall_mm': overallMm,
        'band': band,
        'score': score,
        'strengths': strengths,
        'corrections': [for (final c in corrections) c.toJson()],
        'natural_version_en': naturalVersionEn,
        'use_more': [for (final u in useMore) u.toJson()],
        'next_step_mm': nextStepMm,
        'call_tokens': totalTokens,
      };
}
