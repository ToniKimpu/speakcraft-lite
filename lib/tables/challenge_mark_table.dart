import 'package:drift/drift.dart';

/// Listening Challenge — the sentences a learner marked as "couldn't catch"
/// while listening with no subtitles. One row per (lesson, sentence): re-marking
/// the same sentence is a no-op (the primary key dedupes), and they can clear a
/// mark later ("got it now"). Local-only, mirroring [VideoStepProgressTable].
class ChallengeMarkTable extends Table {
  /// The lesson's YouTube id (matches Listening.youtubeId).
  TextColumn get youtubeId => text()();

  /// Index of the marked sentence within the lesson's subtitle list.
  IntColumn get sentenceIndex => integer()();

  /// The raw playback position (ms) the learner tapped at — kept for reference.
  IntColumn get positionMs => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {youtubeId, sentenceIndex};
}
