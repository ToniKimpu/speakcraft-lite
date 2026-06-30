/// One version (v1, v2, …) of a produce attempt: what the learner wrote and the
/// feedback for it. Persisted as a JSON array on the session row so the history
/// can show the whole version chain and open any one in full detail.
library;

import 'sym_feedback.dart';

class SymVersion {
  const SymVersion({
    required this.version,
    required this.text,
    required this.score,
    required this.band,
    required this.naturalVersion,
    required this.tokens,
    this.feedback,
  });

  final int version;
  final String text;
  final int score;
  final String band;
  final String naturalVersion;
  final int tokens;

  /// The full AI feedback for this version (corrections, strengths, use-more,
  /// overall comment, next step). Null for legacy sessions saved before full
  /// feedback was persisted — the detail screen falls back to text + natural.
  final SymFeedback? feedback;

  Map<String, dynamic> toJson() => {
        'version': version,
        'text': text,
        'score': score,
        'band': band,
        'natural_version': naturalVersion,
        'tokens': tokens,
        if (feedback != null) 'feedback': feedback!.toJson(),
      };

  factory SymVersion.fromJson(Map<String, dynamic> j) => SymVersion(
        version: (j['version'] as num?)?.toInt() ?? 1,
        text: j['text'] as String? ?? '',
        score: (j['score'] as num?)?.toInt() ?? 0,
        band: j['band'] as String? ?? 'good',
        naturalVersion: j['natural_version'] as String? ?? '',
        tokens: (j['tokens'] as num?)?.toInt() ?? 0,
        feedback: j['feedback'] is Map
            ? SymFeedback.fromJson(
                (j['feedback'] as Map).cast<String, dynamic>())
            : null,
      );
}
