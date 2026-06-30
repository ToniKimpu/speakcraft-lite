import 'dart:convert';

import '../../model/speak_your_mind/sym_feedback.dart';
import '../../model/speak_your_mind/sym_models.dart';
import '../../services/supabase_service.dart';

/// Reviews a learner's produced piece and returns structured, encouraging
/// feedback. The real implementation calls the `speak-your-mind-review` Supabase
/// edge function, which holds the Gemini key, runs the prompt server-side, and
/// enforces the per-day token budget. A mock drives the UI with no network.
abstract class SymReviewer {
  Future<SymFeedback> review({
    required SymTopic topic,
    required String text,
  });
}

/// Thrown when the server refuses the call for budget reasons — the UI shows a
/// "come back tomorrow" or "upgrade" screen instead of a generic error.
class SymBudgetException implements Exception {
  const SymBudgetException({
    required this.reason,
    this.limit = 0,
    this.used = 0,
    this.isPremium = false,
    this.resetAt,
  });

  /// 'budget_exceeded' (daily limit hit) or 'trial_expired' (free 3 days up).
  final String reason;
  final int limit;
  final int used;
  final bool isPremium;
  final DateTime? resetAt;

  bool get isTrialExpired => reason == 'trial_expired';

  @override
  String toString() => 'SymBudgetException($reason)';
}

/// The live reviewer for every build (the edge function does auth + budget).
SymReviewer defaultSymReviewer() => const EdgeFnSymReviewer();

// ── Edge function ────────────────────────────────────────────────────────────

class EdgeFnSymReviewer implements SymReviewer {
  const EdgeFnSymReviewer();

  @override
  Future<SymFeedback> review({
    required SymTopic topic,
    required String text,
  }) async {
    final res = await supabase.functions.invoke(
      'speak-your-mind-review',
      body: {
        'topic_title': topic.titleEn,
        'prompt': topic.produce.promptEn,
        'moves': [for (final m in topic.toolbox) m.moveEn],
        'hints': topic.produce.coverageHints,
        'learner_text': text.trim(),
      },
    );

    final data = res.data;
    final map = data is String
        ? jsonDecode(data) as Map<String, dynamic>
        : (data as Map).cast<String, dynamic>();

    final err = map['error'];
    if (err != null) {
      if (err == 'budget_exceeded' || err == 'trial_expired') {
        throw SymBudgetException(
          reason: err as String,
          limit: (map['limit'] as num?)?.toInt() ?? 0,
          used: (map['used'] as num?)?.toInt() ?? 0,
          isPremium: map['is_premium'] as bool? ?? false,
          resetAt: DateTime.tryParse(map['reset_at'] as String? ?? ''),
        );
      }
      throw Exception('speak-your-mind-review: $err');
    }
    return SymFeedback.fromJson(map);
  }
}

// ── Mock (no network; deterministic) ─────────────────────────────────────────

/// On-device stand-in so the produce flow can be exercised without the backend.
/// NOT a real grader. Not used by default — swap it in for manual UI testing.
class MockSymReviewer implements SymReviewer {
  const MockSymReviewer();

  @override
  Future<SymFeedback> review({
    required SymTopic topic,
    required String text,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final trimmed = text.trim();
    final lower = trimmed.toLowerCase();
    final words = trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;

    final corrections = <SymCorrection>[];
    final reList = <(RegExp, String, String)>[
      (RegExp(r'\bI\s+is\b'), 'I am', "'I' နဲ့ တွဲရင် 'am' သုံးပါ။"),
      (RegExp(r'\bi\b'), 'I', "'I' ကို အမြဲ စာလုံးကြီးနဲ့ ရေးပါ။"),
    ];
    for (final (re, fix, why) in reList) {
      final m = re.firstMatch(trimmed);
      if (m != null) {
        corrections.add(SymCorrection(
            original: m.group(0)!, fixed: fix, whyMm: why, type: 'grammar'));
      }
      if (corrections.length >= 3) break;
    }

    final useMore = <SymUseMore>[];
    for (final move in topic.toolbox) {
      final touched = move.items.any((c) =>
          c.highlight.isNotEmpty && lower.contains(c.highlight.toLowerCase()));
      if (!touched && move.items.isNotEmpty) {
        useMore.add(SymUseMore(
          moveEn: move.moveEn,
          exampleEn: move.items.first.textEn,
          whyMm: 'ဒီအချက်ကို ထည့်ပြောရင် ပိုပြည့်စုံပါတယ်။',
        ));
      }
      if (useMore.length >= 2) break;
    }

    final score = words < 15 ? 58 : (corrections.isEmpty ? 84 : 74);
    return SymFeedback(
      overallMm: words < 15
          ? 'စလေး စလုပ်ထားတာ ကောင်းပါတယ်! နောက်ထပ် ဝါကျလေးတွေ ထပ်ဖြည့်ကြည့်ပါ။ 👍'
          : 'အရမ်းကြိုးစားထားတာ တွေ့ရတယ်! ကိုယ်ပိုင်အကြောင်း ပြောထွက်တာ အကောင်းဆုံးပါ။ 🎉',
      band: score >= 85 ? 'great' : (score >= 65 ? 'good' : 'keep_going'),
      score: score,
      strengths: const ['You wrote about your own life — that\'s the goal!'],
      corrections: corrections,
      naturalVersionEn: trimmed,
      useMore: useMore,
      nextStepMm: 'နောက် version မှာ အပေါ်က move တစ်ခုလောက် ထပ်ထည့်ကြည့်ပါ။',
    );
  }
}
