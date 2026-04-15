import 'package:drift/drift.dart';
import 'package:pmp_english/model/saved_vocabulary_word/saved_vocabulary_word.dart';

@UseRowClass(SavedVocabularyWord)
class SavedVocabularyWordTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Normalized lowercase word — unique key.
  TextColumn get word => text().unique()();

  TextColumn get pos => text().withDefault(const Constant(''))();
  TextColumn get ipa => text().withDefault(const Constant(''))();
  TextColumn get definitionEn => text().withDefault(const Constant(''))();
  TextColumn get definitionMy => text().withDefault(const Constant(''))();

  /// JSON-serialized `List<VocabularyExample>` — Drift doesn't do nested
  /// lists; serializing keeps this table flat.
  TextColumn get examplesJson => text().withDefault(const Constant('[]'))();

  TextColumn get sourceYoutubeId => text().nullable()();
  TextColumn get sourceSentence => text().nullable()();

  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
}
