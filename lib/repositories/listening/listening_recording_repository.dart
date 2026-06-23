import 'dart:io';

import 'package:drift/drift.dart';

import 'package:speakcraft/model/listening/listening_recording.dart';
import 'package:speakcraft/services/app_database/app_database.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';

/// Local (Drift + phone files) storage for user voice recordings.
///
/// Replaces the previous Supabase-backed version: the recorded `.m4a` stays in
/// the app documents directory and a row in [UserRecordedSentenceAudioTable]
/// indexes it ([ListeningRecording.audioPath] holds the on-device file path).
/// The per-sentence cap (free 1 / premium 5) is enforced here by trimming the
/// oldest takes + their files. Nothing leaves the device — no storage/egress
/// cost, works offline.
///
/// Recordings are keyed by the listening's int id, stored in the table's
/// `youtubeId` column (this feature is the table's only consumer).
class ListeningRecordingRepository {
  final _db = AppDatabase.instance();

  String _key(int listeningId) => 'L$listeningId';

  /// All of this video's recordings (any sentence), oldest first. The UI filters
  /// by sentence.
  Future<List<ListeningRecording>> list({required int listeningId}) async {
    final rows = await (_db.select(_db.userRecordedSentenceAudioTable)
          ..where((t) => t.youtubeId.equals(_key(listeningId)))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc),
          ]))
        .get();
    return rows
        .map((r) => ListeningRecording(
              id: r.id ?? 0,
              listeningId: listeningId,
              sentenceId: r.sentenceId,
              audioPath: r.audioPath,
              createdAt: r.createdAt,
            ))
        .toList();
  }

  /// Indexes a freshly recorded file (left in place on disk) and trims the
  /// sentence back to the cap, deleting the dropped files.
  Future<void> save({
    required int listeningId,
    required String sentenceId,
    required File audio,
  }) async {
    final key = _key(listeningId);
    await _db.into(_db.userRecordedSentenceAudioTable).insert(
          UserRecordedSentenceAudioTableCompanion.insert(
            sentenceId: sentenceId,
            youtubeId: key,
            audioPath: audio.path,
            audioName: audio.path.split('/').last,
          ),
        );

    final cap = hasPremiumAccess() ? 5 : 1;
    final takes = await (_db.select(_db.userRecordedSentenceAudioTable)
          ..where((t) => t.youtubeId.equals(key))
          ..where((t) => t.sentenceId.equals(sentenceId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.asc),
          ]))
        .get();
    if (takes.length > cap) {
      for (final row in takes.take(takes.length - cap)) {
        await _deleteRow(row.id, row.audioPath);
      }
    }
  }

  Future<void> delete(ListeningRecording rec) =>
      _deleteRow(rec.id, rec.audioPath);

  Future<void> _deleteRow(int? id, String audioPath) async {
    try {
      final f = File(audioPath);
      if (await f.exists()) await f.delete();
    } catch (_) {}
    if (id != null) {
      await (_db.delete(_db.userRecordedSentenceAudioTable)
            ..where((t) => t.id.equals(id)))
          .go();
    }
  }
}
