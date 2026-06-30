import 'dart:io';

import 'package:drift/drift.dart';

import '../../services/app_database/app_database.dart';

/// Local (Drift) store for completed Speak Your Mind produce sessions — the
/// learner's text, the AI feedback summary, and an optional on-device recording
/// path. Nothing leaves the device (no storage/egress cost; works offline),
/// mirroring [ListeningRecordingRepository].
class SymSessionRepository {
  final _db = AppDatabase.instance();

  /// Saves one finished session. [recordingPath] is the on-device `.m4a` path
  /// (null if they didn't record). Returns the new row id.
  Future<int> save({
    required String topicId,
    required String finalText,
    String? naturalVersion,
    int? score,
    String? band,
    int versions = 1,
    String? recordingPath,
    int tokens = 0,
    String? versionsJson,
  }) {
    return _db.into(_db.symSessionTable).insert(
          SymSessionTableCompanion.insert(
            topicId: topicId,
            finalText: finalText,
            naturalVersion: Value(naturalVersion),
            score: Value(score),
            band: Value(band),
            versions: Value(versions),
            recordingPath: Value(recordingPath),
            recordingName: Value(recordingPath?.split('/').last),
            tokens: Value(tokens),
            versionsJson: Value(versionsJson),
          ),
        );
  }

  /// Updates an existing session in place — used by "Polish & retry", which
  /// resumes a saved attempt and appends new versions to the same history entry
  /// (the chain grows v1 → v2 → v3) instead of spawning a separate row.
  /// [createdAt] is intentionally left untouched so the item keeps its place.
  Future<void> updateSession({
    required int id,
    required String finalText,
    String? naturalVersion,
    int? score,
    String? band,
    int versions = 1,
    String? recordingPath,
    int tokens = 0,
    String? versionsJson,
  }) {
    return (_db.update(_db.symSessionTable)..where((t) => t.id.equals(id)))
        .write(
      SymSessionTableCompanion(
        finalText: Value(finalText),
        naturalVersion: Value(naturalVersion),
        score: Value(score),
        band: Value(band),
        versions: Value(versions),
        recordingPath: Value(recordingPath),
        recordingName: Value(recordingPath?.split('/').last),
        tokens: Value(tokens),
        versionsJson: Value(versionsJson),
      ),
    );
  }

  /// One session by id (null if it was deleted) — lets the detail screen refresh
  /// after a "Polish & retry" appended a new version.
  Future<SymSessionTableData?> getById(int id) {
    return (_db.select(_db.symSessionTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// All sessions, newest first (for the history screen).
  Future<List<SymSessionTableData>> listAll() {
    return (_db.select(_db.symSessionTable)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// This topic's sessions, newest first.
  Future<List<SymSessionTableData>> listByTopic(String topicId) {
    return (_db.select(_db.symSessionTable)
          ..where((t) => t.topicId.equals(topicId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// Total tokens billed across every session — the cumulative usage meter.
  Future<int> totalTokensUsed() async {
    final rows = await _db.select(_db.symSessionTable).get();
    return rows.fold<int>(0, (sum, r) => sum + r.tokens);
  }

  /// Deletes a session and its recording file (if any).
  Future<void> delete(SymSessionTableData row) async {
    final path = row.recordingPath;
    if (path != null) {
      try {
        final f = File(path);
        if (await f.exists()) await f.delete();
      } catch (_) {}
    }
    await (_db.delete(_db.symSessionTable)..where((t) => t.id.equals(row.id)))
        .go();
  }
}
