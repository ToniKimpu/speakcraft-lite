import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/topic_progress.dart';
import 'package:speakcraft/services/app_database/app_database.dart';

/// Source of per-topic practice progress, keyed by `topicId`.
///
/// Two implementations are planned:
/// - [LocalTopicProgressRepository] — derives progress from the local Drift
///   session history. Used now (no auth dependency).
/// - A future `SupabaseTopicProgressRepository` reading `user_topic_progress`
///   for `auth.uid()` — drops in once auth ships, no UI change. See
///   `SUGGESTED_TOPICS_SUPABASE_PLAN.md`.
abstract class TopicProgressRepository {
  /// Returns a map of `topicId -> progress` for the current user.
  Future<Map<String, TopicProgress>> loadProgress();
}

/// Derives practiced-state from `DailySpeakingSessionTable`: a topic counts as
/// practiced once it has at least one session row. Only curated suggested
/// topics get progress — the `own` / `inferred` sentinels and null topic ids
/// (just-talk) are ignored.
class LocalTopicProgressRepository implements TopicProgressRepository {
  static const _ignoredTopicIds = {'own', 'inferred'};

  @override
  Future<Map<String, TopicProgress>> loadProgress() async {
    try {
      final rows =
          await AppDatabase.instance().dailySpeakingSessionTable.select().get();
      final byTopic = <String, TopicProgress>{};
      for (final row in rows) {
        final topicId = row.topicId;
        if (topicId == null || _ignoredTopicIds.contains(topicId)) continue;

        final score = _scoreOf(row.feedbackJson);
        final createdAt = row.createdAt;
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

  /// Decodes the stored feedback just far enough to read its score. Returns 0
  /// if the blob can't be parsed (best-effort — a bad row must not break the
  /// whole list).
  int _scoreOf(String feedbackJson) {
    try {
      final map = Map<String, dynamic>.from(jsonDecode(feedbackJson) as Map);
      return DailySpeakingFeedback.fromJson(map).score;
    } catch (_) {
      return 0;
    }
  }
}
