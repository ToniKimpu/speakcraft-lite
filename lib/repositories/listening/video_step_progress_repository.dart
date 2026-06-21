import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';
import 'package:speakcraft/services/supabase_service.dart';

/// Supabase-backed lesson step progress (replaces the local Drift
/// VideoStepProgressTable). Keyed by youtube_id + step_key per user; reads rely
/// on RLS to scope to the current user, writes go through the
/// `upsert_video_progress` RPC (resolves the user from auth.uid()).
class VideoStepProgressRepository {
  VideoStepProgress _fromRow(Map<String, dynamic> r) => VideoStepProgress(
        youtubeId: r['youtube_id'] as String,
        stepKey: r['step_key'] as String,
        state: (r['state'] as int?) ?? 0,
        openCount: (r['open_count'] as int?) ?? 0,
        lastOpenedAt: r['last_opened_at'] == null
            ? null
            : DateTime.tryParse(r['last_opened_at'] as String),
      );

  Future<List<VideoStepProgress>> loadAll() async {
    final rows = await supabase.from('listening_video_progress').select();
    return (rows as List)
        .map((e) => _fromRow(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<VideoStepProgress>> loadVideo(String youtubeId) async {
    final rows = await supabase
        .from('listening_video_progress')
        .select()
        .eq('youtube_id', youtubeId);
    return (rows as List)
        .map((e) => _fromRow(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> upsert({
    required String youtubeId,
    required String stepKey,
    required int state,
    required int openCount,
  }) async {
    await supabase.rpc('upsert_video_progress', params: {
      'p_youtube_id': youtubeId,
      'p_step_key': stepKey,
      'p_state': state,
      'p_open_count': openCount,
    });
  }
}
