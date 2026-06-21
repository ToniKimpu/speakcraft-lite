import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/topic_progress.dart';
import 'package:speakcraft/repositories/daily_speaking/daily_speaking_session_repository.dart';

/// Source of per-topic practice progress, keyed by `topicId`.
abstract class TopicProgressRepository {
  /// Returns a map of `topicId -> progress` for the current user.
  Future<Map<String, TopicProgress>> loadProgress();
}

/// Derives practiced-state from the user's Supabase `daily_speaking_sessions`:
/// a topic counts as practiced once it has at least one session row. Only
/// curated suggested topics get progress — the `own` / `inferred` sentinels and
/// null topic ids (just-talk) are ignored.
///
/// (Name kept for drop-in compatibility; it now reads Supabase, not local Drift,
/// since the session store moved server-side.)
class LocalTopicProgressRepository implements TopicProgressRepository {
  static const _ignoredTopicIds = {'own', 'inferred'};
  final DailySpeakingSessionRepository _repo = DailySpeakingSessionRepository();

  @override
  Future<Map<String, TopicProgress>> loadProgress() async {
    try {
      final sessions = await _repo.list();
      final byTopic = <String, TopicProgress>{};
      for (final s in sessions) {
        final topicId = s.topicId;
        if (topicId == null || _ignoredTopicIds.contains(topicId)) continue;

        final score = s.feedback.score;
        final createdAt = s.createdAt ?? DateTime.now();
        final existing = byTopic[topicId];
        if (existing == null) {
          byTopic[topicId] = TopicProgress(
            topicId: topicId,
            attempts: 1,
            bestScore: score,
            lastPracticedAt: createdAt,
          );
        } else {
          byTopic[topicId] = TopicProgress(
            topicId: topicId,
            attempts: existing.attempts + 1,
            bestScore: score > existing.bestScore ? score : existing.bestScore,
            lastPracticedAt: createdAt.isAfter(existing.lastPracticedAt)
                ? createdAt
                : existing.lastPracticedAt,
          );
        }
      }
      return byTopic;
    } catch (e) {
      AppLogger.instance
          .error('LocalTopicProgressRepository load failed: $e', error: e);
      return const {};
    }
  }
}
