import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:pmp_english/tables/ai_sentence_practice_table.dart';

import '../../model/ai_sentence_practice/ai_sentence_practice.dart';
import '../../model/exercise_user_answer/exercise_user_answer.dart';
import '../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../tables/listening_practice_answer_table.dart';
import '../../tables/spoken_pattern_exercise_answer_table.dart';
import '../../tables/user_example_answer_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AiSentencePracticeTable,
    UserExampleAnswerTable,
    ListeningPracticeAnswerTable,
    SpokenPatternExerciseAnswerTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  static final _instance = AppDatabase._();

  AppDatabase._() : super(_openConnection());

  static AppDatabase instance() => _instance;

  @override
  int get schemaVersion => 2; // incremented for the new table

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        // Create all tables from scratch
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // await customStatement('PRAGMA foreign_keys = OFF');

        // // Add migrations for new tables
        // if (from < 2) {
        //   await m.createTable(userExampleAnswerTable);
        // }

        // if (kDebugMode) {
        //   final wrongForeignKeys =
        //       await customSelect('PRAGMA foreign_key_check').get();
        //   assert(
        //     wrongForeignKeys.isEmpty,
        //     '${wrongForeignKeys.map((e) => e.data)}',
        //   );
        // }
        // await customStatement('PRAGMA foreign_keys = ON;');
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static QueryExecutor _openConnection() {
    const flavor = String.fromEnvironment('flavor', defaultValue: 'dev');
    return driftDatabase(
      name: 'PMP_database_$flavor',
      native: const DriftNativeOptions(),
    );
  }
}
