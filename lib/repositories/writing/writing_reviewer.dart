import 'dart:convert';

import '../../model/writing/writing_review.dart';
import '../../model/writing/writing_unit.dart';
import '../../services/supabase_service.dart';

/// Grades a `free_write` answer for one unit. One implementation talks to the
/// real `writing-review` endpoint; another is an on-device mock so the UX works
/// end-to-end before the backend exists. Swapping is a one-line change in the
/// practice page.
abstract class WritingReviewer {
  Future<WritingReview> review({
    required WritingExercise exercise,
    required String text,
  });
}

/// Builds the request payload sent to the grader — the per-unit rubric + the
/// model answer + the learner's text. This is the single generic contract that
/// lets one prompt grade every unit: the data says what's being practised.
Map<String, dynamic> buildReviewRequest({
  required WritingExercise exercise,
  required String text,
}) {
  final g = exercise.grading;
  return {
    'grammar_point': g?.grammarPoint ?? '',
    'rule': g?.rule ?? '',
    'must_check': g?.mustCheck ?? const <String>[],
    'common_mm_errors': g?.commonMmErrors ?? const <String>[],
    'ignore': g?.ignore ?? const ['punctuation', 'capitalization'],
    'model_answer': exercise.model,
    'learner_text': text,
  };
}

/// The real grader — calls the `writing-review` Supabase edge function (which
/// runs the generic prompt on Gemini Flash Lite) and parses its JSON into a
/// [WritingReview]. Throws on transport / non-2xx so the page can fall back to
/// revealing the model answer.
class RemoteWritingReviewer implements WritingReviewer {
  const RemoteWritingReviewer();

  @override
  Future<WritingReview> review({
    required WritingExercise exercise,
    required String text,
  }) async {
    final res = await supabase.functions.invoke(
      'writing-review',
      body: buildReviewRequest(exercise: exercise, text: text),
    );
    final data = res.data;
    final map = data is String
        ? jsonDecode(data) as Map<String, dynamic>
        : (data as Map).cast<String, dynamic>();
    if (map['error'] != null) {
      throw Exception('writing-review: ${map['error']}');
    }
    return WritingReview.fromJson(map);
  }
}

/// An on-device stand-in for the AI grader. It catches the obvious be-agreement
/// slips with light heuristics and otherwise gives warm, encouraging feedback —
/// enough to drive the real feedback UI. NOT a real grader; the remote one
/// replaces it. Deterministic (no randomness) so behaviour is predictable.
class MockWritingReviewer implements WritingReviewer {
  const MockWritingReviewer();

  static final List<(RegExp, String, String)> _agreement = [
    (RegExp(r'\bI\s+(is|are)\b', caseSensitive: false), 'am', 'I → am'),
    (
      RegExp(r'\b(he|she|it)\s+(am|are)\b', caseSensitive: false),
      'is',
      'he / she / it → is'
    ),
    (
      RegExp(r'\b(you|we|they)\s+(am|is)\b', caseSensitive: false),
      'are',
      'you / we / they → are'
    ),
  ];

  @override
  Future<WritingReview> review({
    required WritingExercise exercise,
    required String text,
  }) async {
    // Simulate the network round-trip so loading states are exercised.
    await Future<void>.delayed(const Duration(milliseconds: 900));

    final trimmed = text.trim();
    final wordCount =
        trimmed.isEmpty ? 0 : trimmed.split(RegExp(r'\s+')).length;

    final issues = <WritingIssue>[];
    var corrected = trimmed;
    for (final (re, correctBe, whyMm) in _agreement) {
      for (final m in re.allMatches(trimmed)) {
        final subject = m.group(1)!; // the matched subject word
        final wrong = m.group(0)!; // e.g. "She are"
        final fix = '$subject $correctBe';
        issues.add(WritingIssue(wrong: wrong, fix: fix, whyMm: whyMm));
        corrected = corrected.replaceAll(wrong, fix);
        if (issues.length >= 3) break;
      }
      if (issues.length >= 3) break;
    }

    // Too short to judge → a gentle nudge rather than a verdict.
    if (wordCount > 0 && wordCount < 4) {
      return const WritingReview(
        verdict: 'needs_work',
        praiseMm: 'စလေး စလုပ်ထားတာ ကောင်းပါတယ်! 👍',
        issues: [],
        correctedText: '',
        tipMm: 'နောက်ထပ် sentence လေးတွေ ထပ်ဖြည့်ပြီး ပြန်ကြိုးစားကြည့်ပါ။',
      );
    }

    final clean = issues.isEmpty;
    return WritingReview(
      verdict: clean ? 'great' : (issues.length >= 3 ? 'needs_work' : 'good'),
      praiseMm: clean
          ? 'အရမ်းကောင်းပါတယ်! am / is / are ကို မှန်မှန် သုံးထားတယ်။ 🎉'
          : 'ကြိုးစားထားတာ တွေ့ရတယ်! အောက်က အမှားလေးတွေ ပြင်လိုက်ရင် ပိုပြည့်စုံပါပြီ။',
      issues: issues,
      correctedText: clean ? '' : corrected,
      tipMm:
          'Subject နဲ့ be ကို တွဲကြည့်ပါ — I → am ၊ he / she / it → is ၊ you / we / they → are ။',
    );
  }
}
