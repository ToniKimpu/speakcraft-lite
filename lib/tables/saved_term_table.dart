import 'package:drift/drift.dart';
import 'package:pmp_english/model/saved_term/saved_term.dart';

@UseRowClass(SavedTerm)
class SavedTermTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get term => text()();
  TextColumn get kind => text().withDefault(const Constant(''))();

  TextColumn get translationMy => text().nullable()();
  TextColumn get definitionMy => text().nullable()();

  /// JSON-serialized `List<VocabularyExample>` — Drift doesn't do nested
  /// lists; serializing keeps this table flat.
  TextColumn get examplesJson => text().withDefault(const Constant('[]'))();

  TextColumn get sourceTitle => text().nullable()();
  TextColumn get sourceSentence => text().nullable()();

  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
}
