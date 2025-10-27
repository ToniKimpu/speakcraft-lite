import 'package:drift/drift.dart';

import '../model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';

@UseRowClass(UserRecordedSentenceAudio)
class UserRecordedSentenceAudioTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sentenceId => text()();
  TextColumn get youtubeId => text()();
  TextColumn get audioPath => text()();
  TextColumn get audioName => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
