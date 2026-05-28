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
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
