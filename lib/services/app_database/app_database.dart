import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:pmp_english/tables/ai_sentence_practice/ai_sentence_practice_table.dart';

import '../../model/ai_sentence_practice/ai_sentence_practice.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [AiSentencePracticeTable],
)
class AppDatabase extends _$AppDatabase {
  static final _instance = AppDatabase._();

  AppDatabase._() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static AppDatabase instance() => _instance;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'PMP_English_database',
      native: const DriftNativeOptions(
          // By default, `driftDatabase` from `package:drift_flutter` stores the
          // database files in `getApplicationDocumentsDirectory()`.
          // databaseDirectory: getApplicationSupportDirectory,
          ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
