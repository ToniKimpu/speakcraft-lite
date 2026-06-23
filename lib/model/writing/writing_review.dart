/// The structured result of an AI grading pass over a `free_write` answer.
///
/// Shape mirrors the JSON the `writing-review` grader returns (a single generic
/// prompt fed each unit's per-exercise rubric — see [Grading]). Kept as a plain
/// hand-written class, consistent with the rest of the Phase-0 writing models.
library;

class WritingReview {
  const WritingReview({
    required this.verdict,
    required this.praiseMm,
    required this.issues,
    required this.correctedText,
    required this.tipMm,
    this.totalTokens = 0,
  });

  /// `great` · `good` · `needs_work` — drives the feedback colour/title.
  final String verdict;

  /// One warm Burmese line of encouragement.
  final String praiseMm;

  /// The specific fixes found (empty when the answer is clean).
  final List<WritingIssue> issues;

  /// The learner's text rewritten correctly. May carry `{v}`/`{t}` highlight
  /// markup. Empty when there was nothing to correct.
  final String correctedText;

  /// One short Burmese takeaway tip.
  final String tipMm;

  /// Total tokens the grading call billed (0 for the on-device mock or the
  /// server's no-LLM junk short-circuit). Shown as a cost meter.
  final int totalTokens;

  bool get isClean => issues.isEmpty;

  factory WritingReview.fromJson(Map<String, dynamic> json) => WritingReview(
        verdict: json['verdict'] as String? ?? 'good',
        praiseMm: json['praise_mm'] as String? ?? '',
        issues: ((json['issues'] as List?) ?? const [])
            .map((e) => WritingIssue.fromJson((e as Map).cast<String, dynamic>()))
            .toList(growable: false),
        correctedText: json['corrected_text'] as String? ?? '',
        tipMm: json['tip_mm'] as String? ?? '',
        totalTokens: (json['total_tokens'] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'verdict': verdict,
        'praise_mm': praiseMm,
        'issues': [for (final i in issues) i.toJson()],
        'corrected_text': correctedText,
        'tip_mm': tipMm,
      };
}

/// One correction: what was wrong, the fix, and a short Burmese why.
class WritingIssue {
  const WritingIssue(
      {required this.wrong, required this.fix, required this.whyMm});
  final String wrong;
  final String fix;
  final String whyMm;

  factory WritingIssue.fromJson(Map<String, dynamic> json) => WritingIssue(
        wrong: json['wrong'] as String? ?? '',
        fix: json['fix'] as String? ?? '',
        whyMm: json['why_mm'] as String? ?? '',
      );

  Map<String, dynamic> toJson() =>
      {'wrong': wrong, 'fix': fix, 'why_mm': whyMm};
}
