import 'package:drift/drift.dart';

/// One completed "Speak Your Mind" produce session: the learner's final text,
/// the AI feedback summary, and an OPTIONAL on-device voice recording. Only the
/// recording's file path is stored — the `.m4a` stays in the app documents
/// directory (nothing uploaded), mirroring [UserRecordedSentenceAudioTable].
/// Powers a practice history the learner can revisit and re-listen to.
class SymSessionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// The topic this session belongs to (e.g. `my_family`).
  TextColumn get topicId => text()();

  /// What the learner finally wrote.
  TextColumn get finalText => text()();

  /// The AI's natural rewrite (null if feedback was skipped / failed).
  TextColumn get naturalVersion => text().nullable()();

  /// Clarity score 0–100 from the last feedback pass.
  IntColumn get score => integer().nullable()();

  /// great | good | keep_going.
  TextColumn get band => text().nullable()();

  /// How many drafts (v1, v2, …) the learner went through.
  IntColumn get versions => integer().withDefault(const Constant(1))();

  /// On-device path to the voice recording (null if they didn't record).
  TextColumn get recordingPath => text().nullable()();
  TextColumn get recordingName => text().nullable()();

  /// Tokens billed across all versions of this attempt (0 for mock / skipped).
  IntColumn get tokens => integer().withDefault(const Constant(0))();

  /// JSON array of every version (v1, v2, …) in this attempt — each with its
  /// own text + feedback summary. Null/empty ⇒ a single version (use the summary
  /// columns above). Lets the history show a v1/v2 chain.
  TextColumn get versionsJson => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
