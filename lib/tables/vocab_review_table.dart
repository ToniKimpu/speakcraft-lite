import 'package:drift/drift.dart';

/// Leitner-lite spaced-review state for vocabulary — one row per
/// (group, word/expression) the learner has practised.
///
/// [box] is the Leitner box (1..5). A correct answer promotes the word one box
/// (longer interval); a wrong answer drops it back to box 1. [dueAt] is when the
/// word next becomes due for review, derived from the box interval.
class VocabReviewTable extends Table {
  TextColumn get groupId => text()();

  /// The taught word/expression (normalised lowercase) — the exercise answer.
  TextColumn get word => text()();

  /// Leitner box 1..5 (higher = longer interval / better known).
  IntColumn get box => integer().withDefault(const Constant(1))();

  /// Epoch milliseconds when this word is next due.
  IntColumn get dueAt => integer().withDefault(const Constant(0))();

  /// Counters for simple stats / weakest-first ordering.
  IntColumn get seen => integer().withDefault(const Constant(0))();
  IntColumn get correct => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {groupId, word};
}
