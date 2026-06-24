import 'package:drift/drift.dart';

/// Local record of completed writing units — one row per finished unit. A unit
/// counts as "done" once the learner reaches the end of its practice ladder
/// (any score). Redoable: the row only marks completion, it never blocks
/// re-practice.
class WritingProgressTable extends Table {
  TextColumn get unitId => text()();
  DateTimeColumn get completedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {unitId};
}
