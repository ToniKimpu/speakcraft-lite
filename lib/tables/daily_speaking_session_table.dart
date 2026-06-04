import 'package:drift/drift.dart';

/// Local cache of past Daily Speaking sessions for the history screen.
///
/// IMPORTANT: This table is for **history UI only**. It is NOT the source of
/// truth for the per-month session budget — that lives in the edge function.
/// See `memory/project_daily_speaking_module.md`.
class DailySpeakingSessionTable extends Table {
  late final id = integer().autoIncrement()();
  late final topicId = text().nullable()();
  late final onRamp = text()();
  late final inputMode = text()();
  late final inputText = text().nullable()();

  /// Serialized [DailySpeakingFeedback]. Kept as JSON so adding fields to the
  /// feedback shape doesn't require a Drift schema migration.
  late final feedbackJson = text()();
  late final totalTokens = integer()();

  /// Version-loop chaining (schema v6). [topicAttemptId] groups v1, v2, … of one
  /// topic attempt; [revisionNumber] is the position in that chain (1-based).
  /// Nullable / default 1 so pre-v6 rows migrate cleanly as standalone v1s.
  late final topicAttemptId = text().nullable()();
  late final revisionNumber = integer().withDefault(const Constant(1))();

  /// Local filesystem path to the saved recording (schema v7, voice only).
  /// Audio is retained only for the active attempt chain and pruned when a new
  /// chain starts (see `DailySpeakingBloc._pruneAudioExceptChain`), so this is
  /// null for the text path and for pruned older sessions.
  late final audioPath = text().nullable()();

  /// Serialized [DailySpeakingTopic] for loop-capable on-ramps (schema v8).
  /// Lets the learner resume the topic from history ("Polish & retry") without
  /// depending on the topic bank — and recovers the own-topic prompt, which is
  /// otherwise lost (own-topic stores only `topicId = 'own'`). Null for
  /// just-talk and legacy rows.
  late final topicJson = text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
