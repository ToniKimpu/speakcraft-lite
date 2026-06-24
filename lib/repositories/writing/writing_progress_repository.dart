import '../../services/app_database/app_database.dart';

/// Local (Drift) per-unit completion for the writing module. A unit is marked
/// done when the learner finishes its practice ladder; completion is purely a
/// progress marker — units stay redoable.
class WritingProgressRepository {
  final _db = AppDatabase.instance();

  /// Mark a unit complete (idempotent — re-finishing just refreshes the date).
  Future<void> markDone(String unitId) =>
      _db.into(_db.writingProgressTable).insertOnConflictUpdate(
            WritingProgressTableCompanion.insert(unitId: unitId),
          );

  /// Live set of completed unit ids — drives the green-check states on the path.
  Stream<Set<String>> watchCompleted() => _db
      .select(_db.writingProgressTable)
      .watch()
      .map((rows) => rows.map((r) => r.unitId).toSet());
}
