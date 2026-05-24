import 'package:drift/drift.dart';
import 'package:pmp_english/model/video_step_progress/video_step_progress.dart';

@UseRowClass(VideoStepProgress)
class VideoStepProgressTable extends Table {
  TextColumn get youtubeId => text()();
  TextColumn get stepKey => text()();
  IntColumn get state => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastOpenedAt => dateTime().nullable()();
  IntColumn get openCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {youtubeId, stepKey};
}
