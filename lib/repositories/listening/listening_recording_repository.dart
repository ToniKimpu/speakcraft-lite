import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:speakcraft/model/listening/listening_recording.dart';
import 'package:speakcraft/services/supabase_service.dart';

/// Supabase-backed storage for user voice recordings (replaces the old local
/// Drift table + phone files). Audio lives in the private `user-recordings`
/// bucket; rows in `public.listening_recordings`. The per-sentence cap
/// (free = 1 / premium = 5) is enforced server-side by the `save_recording`
/// RPC — this client only uploads, calls it, and cleans up the dropped files.
class ListeningRecordingRepository {
  static const _bucket = 'user-recordings';

  /// All of the current user's recordings for one video (RLS scopes to them),
  /// oldest first. The UI filters by sentence; loading per-video keeps one load
  /// per screen instead of a round-trip on every sentence change.
  Future<List<ListeningRecording>> list({required int listeningId}) async {
    final rows = await supabase
        .from('listening_recordings')
        .select()
        .eq('listening_id', listeningId)
        .order('created_at', ascending: true);
    return (rows as List)
        .map((e) => ListeningRecording.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Uploads a new take, enforces the per-sentence cap via `save_recording`,
  /// and removes any files the cap dropped. The bucket path is keyed by the
  /// auth uid so a single RLS policy isolates each user's audio.
  Future<void> save({
    required int listeningId,
    required String sentenceId,
    required File audio,
  }) async {
    final uid = supabase.auth.currentUser!.id;
    final ts = DateTime.now().millisecondsSinceEpoch;
    final path = '$uid/listening/$listeningId/$ts.m4a';

    await supabase.storage.from(_bucket).upload(
          path,
          audio,
          fileOptions: const FileOptions(contentType: 'audio/mp4', upsert: true),
        );

    // RPC inserts the row and returns the storage paths it dropped to honour
    // the cap; we delete those files via the Storage API (SQL can't).
    final dropped = await supabase.rpc('save_recording', params: {
      'p_listening_id': listeningId,
      'p_sentence_id': sentenceId,
      'p_audio_path': path,
    });
    final droppedPaths = (dropped as List?)?.cast<String>() ?? const <String>[];
    if (droppedPaths.isNotEmpty) {
      await supabase.storage.from(_bucket).remove(droppedPaths);
    }
  }

  /// Removes a recording: the Storage file first, then the row.
  Future<void> delete(ListeningRecording rec) async {
    await supabase.storage.from(_bucket).remove([rec.audioPath]);
    await supabase.from('listening_recordings').delete().eq('id', rec.id);
  }

  /// A short-lived signed URL to stream a private recording for playback.
  Future<String> signedUrl(String audioPath, {int expiresIn = 3600}) {
    return supabase.storage.from(_bucket).createSignedUrl(audioPath, expiresIn);
  }
}
