import 'package:drift/drift.dart';

import '../../services/app_database/app_database.dart';

/// Local store for Listening Challenge marks — the sentences a learner couldn't
/// catch by ear, per lesson. Nothing leaves the device.
class ListeningChallengeRepository {
  final _db = AppDatabase.instance();

  /// Marked sentence indices for a lesson, ascending.
  Future<List<int>> markedIndices(String youtubeId) async {
    final rows = await (_db.select(_db.challengeMarkTable)
          ..where((t) => t.youtubeId.equals(youtubeId))
          ..orderBy([(t) => OrderingTerm(expression: t.sentenceIndex)]))
        .get();
    return rows.map((r) => r.sentenceIndex).toList();
  }

  /// Marks one sentence (idempotent — re-marking the same one is a no-op).
  Future<void> addMark(String youtubeId, int sentenceIndex, int positionMs) {
    return _db.into(_db.challengeMarkTable).insert(
          ChallengeMarkTableCompanion.insert(
            youtubeId: youtubeId,
            sentenceIndex: sentenceIndex,
            positionMs: Value(positionMs),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Clears one mark ("got it now").
  Future<void> removeMark(String youtubeId, int sentenceIndex) {
    return (_db.delete(_db.challengeMarkTable)
          ..where((t) =>
              t.youtubeId.equals(youtubeId) &
              t.sentenceIndex.equals(sentenceIndex)))
        .go();
  }

  /// Clears every mark for a lesson (start the challenge over).
  Future<void> clear(String youtubeId) {
    return (_db.delete(_db.challengeMarkTable)
          ..where((t) => t.youtubeId.equals(youtubeId)))
        .go();
  }
}
