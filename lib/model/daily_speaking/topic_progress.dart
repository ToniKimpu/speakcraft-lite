/// Per-user practice progress for a single suggested topic.
///
/// Drives the suggested-topic list's "fresh first, practiced sunk + badge"
/// behaviour. For the MVP this is derived locally from the Drift session
/// history ([LocalTopicProgressRepository]); when auth lands it will come from
/// the server `user_topic_progress` table instead. See
/// `SUGGESTED_TOPICS_SUPABASE_PLAN.md`.
class TopicProgress {
  const TopicProgress({
    required this.topicId,
    required this.attempts,
    required this.bestScore,
    required this.lastPracticedAt,
  });

  final String topicId;
  final int attempts;

  /// Best overall score (0–100) the learner has earned on this topic.
  final int bestScore;
  final DateTime lastPracticedAt;
}
