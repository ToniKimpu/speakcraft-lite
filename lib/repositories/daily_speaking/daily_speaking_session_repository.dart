import 'dart:convert';

import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/services/supabase_service.dart';

/// Reads Daily Speaking history from Supabase (`daily_speaking_sessions`,
/// written by the edge function) — replacing the local Drift cache so history +
/// audio replay work across devices/web. Audio lives in the shared
/// `user-recordings` bucket; replay resolves a signed URL on demand.
class DailySpeakingSessionRepository {
  static const _bucket = 'user-recordings';

  DailySpeakingSession _fromRow(Map<String, dynamic> r) {
    final feedbackRaw = r['feedback'];
    final feedback = feedbackRaw is Map
        ? DailySpeakingFeedback.fromJson(Map<String, dynamic>.from(feedbackRaw))
        : const DailySpeakingFeedback(score: 0);
    final topic = r['topic'];
    return DailySpeakingSession(
      id: (r['id'] as num).toInt(),
      topicId: r['topic_id'] as String?,
      onRamp: r['on_ramp'] as String? ?? DailySpeakingOnRamp.justTalk,
      inputMode: r['input_mode'] as String? ?? DailySpeakingInputMode.voice,
      inputText: r['input_text'] as String?,
      feedback: feedback,
      createdAt: r['created_at'] == null
          ? null
          : DateTime.tryParse(r['created_at'] as String),
      topicAttemptId: r['topic_attempt_id'] as String?,
      revisionNumber: (r['revision_number'] as num?)?.toInt() ?? 1,
      // Now a Storage object path (was a local file path); replay resolves a
      // signed URL via [audioUrl].
      audioPath: r['audio_path'] as String?,
      topicJson: topic == null ? null : jsonEncode(topic),
    );
  }

  /// All of the current user's sessions (RLS-scoped), newest first. Only
  /// `completed` rows — async jobs in flight (`queued`/`processing`) or failed
  /// (`error`) carry no feedback and must not surface in history.
  Future<List<DailySpeakingSession>> list() async {
    final rows = await supabase
        .from('daily_speaking_sessions')
        .select()
        .eq('status', 'completed')
        .order('created_at', ascending: false);
    return (rows as List)
        .map((e) => _fromRow(e as Map<String, dynamic>))
        .toList();
  }

  /// The session just written by the edge function for this attempt+revision
  /// (used to build the result screen's session from the server row).
  Future<DailySpeakingSession?> latestFor({
    required String topicAttemptId,
    required int revisionNumber,
  }) async {
    final rows = await supabase
        .from('daily_speaking_sessions')
        .select()
        .eq('topic_attempt_id', topicAttemptId)
        .eq('revision_number', revisionNumber)
        .eq('status', 'completed')
        .order('created_at', ascending: false)
        .limit(1);
    final list = rows as List;
    if (list.isEmpty) return null;
    return _fromRow(list.first as Map<String, dynamic>);
  }

  /// The most recent earlier version of the same attempt chain (for the v2+
  /// A/B "hear your progress" + score-delta strip).
  Future<DailySpeakingSession?> previousVersion({
    required String topicAttemptId,
    required int revisionNumber,
  }) async {
    final rows = await supabase
        .from('daily_speaking_sessions')
        .select()
        .eq('topic_attempt_id', topicAttemptId)
        .lt('revision_number', revisionNumber)
        .eq('status', 'completed')
        .order('revision_number', ascending: false)
        .limit(1);
    final list = rows as List;
    if (list.isEmpty) return null;
    return _fromRow(list.first as Map<String, dynamic>);
  }

  /// Every version of one attempt chain, ascending by revision (progression
  /// recap + next-revision calc).
  Future<List<DailySpeakingSession>> chain(String topicAttemptId) async {
    final rows = await supabase
        .from('daily_speaking_sessions')
        .select()
        .eq('topic_attempt_id', topicAttemptId)
        .eq('status', 'completed')
        .order('revision_number', ascending: true);
    return (rows as List)
        .map((e) => _fromRow(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> delete(DailySpeakingSession s) async {
    final path = s.audioPath;
    if (path != null && path.isNotEmpty) {
      try {
        await supabase.storage.from(_bucket).remove([path]);
      } catch (_) {/* best-effort file cleanup */}
    }
    await supabase.from('daily_speaking_sessions').delete().eq('id', s.id);
  }

  /// A short-lived signed URL for a stored recording, or null if there's none.
  Future<String?> audioUrl(String? audioPath, {int expiresIn = 3600}) async {
    if (audioPath == null || audioPath.isEmpty) return null;
    try {
      return await supabase.storage
          .from(_bucket)
          .createSignedUrl(audioPath, expiresIn);
    } catch (_) {
      return null;
    }
  }
}
