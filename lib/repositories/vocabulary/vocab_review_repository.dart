import 'package:drift/drift.dart';

import '../../services/app_database/app_database.dart';

/// Spaced-review (Leitner-lite) state for vocabulary practice.
///
/// Each practised word/expression lives in a box 1..5. A correct answer
/// promotes it a box (longer interval before it's due again); a wrong answer
/// drops it to box 1. The Review screen surfaces words whose [dueAt] has passed.
class VocabReviewRepository {
  VocabReviewRepository({AppDatabase? db}) : _db = db ?? AppDatabase.instance();
  final AppDatabase _db;

  /// Interval before a word in each box (1..5) is due again.
  static const _intervals = <Duration>[
    Duration(minutes: 10), // box 1 — just learned / got wrong: back soon
    Duration(days: 1),
    Duration(days: 3),
    Duration(days: 7),
    Duration(days: 16),
  ];

  /// Records a practice result, updating the word's box + next-due time.
  Future<void> recordResult(String groupId, String wordRaw, bool correct) async {
    final word = wordRaw.trim().toLowerCase();
    if (word.isEmpty) return;
    final t = _db.vocabReviewTable;
    final existing = await (_db.select(t)
          ..where((r) => r.groupId.equals(groupId) & r.word.equals(word)))
        .getSingleOrNull();
    final box = correct ? ((existing?.box ?? 1) + 1).clamp(1, 5) : 1;
    final due = DateTime.now().add(_intervals[box - 1]).millisecondsSinceEpoch;
    await _db.into(t).insertOnConflictUpdate(
          VocabReviewTableCompanion.insert(
            groupId: groupId,
            word: word,
            box: Value(box),
            dueAt: Value(due),
            seen: Value((existing?.seen ?? 0) + 1),
            correct: Value((existing?.correct ?? 0) + (correct ? 1 : 0)),
          ),
        );
  }

  /// Live count of words currently due — for the home "Review" badge.
  Stream<int> watchDueCount() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final q = _db.select(_db.vocabReviewTable)
      ..where((r) => r.dueAt.isSmallerOrEqualValue(now));
    return q.watch().map((rows) => rows.length);
  }

  /// Due words (oldest first), each as (groupId, word) — for the review queue.
  Future<List<({String groupId, String word})>> dueItems({int limit = 20}) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final rows = await (_db.select(_db.vocabReviewTable)
          ..where((r) => r.dueAt.isSmallerOrEqualValue(now))
          ..orderBy([(r) => OrderingTerm(expression: r.dueAt)])
          ..limit(limit))
        .get();
    return [for (final r in rows) (groupId: r.groupId, word: r.word)];
  }
}
