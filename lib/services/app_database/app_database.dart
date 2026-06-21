import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../model/saved_term/saved_term.dart';
import '../../model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';
import '../../model/video_step_progress/video_step_progress.dart';
import '../../tables/listening_practice_answer_table.dart';
import '../../tables/saved_term_table.dart';
import '../../tables/user_recorded_sentence_audio_table.dart';
import '../../tables/video_step_progress_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    ListeningPracticeAnswerTable,
    UserRecordedSentenceAudioTable,
    SavedTermTable,
    VideoStepProgressTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  static final _instance = AppDatabase._();

  AppDatabase._() : super(_openConnection());

  static AppDatabase instance() => _instance;

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 3) {
          await customStatement(
            'DROP TABLE IF EXISTS saved_vocabulary_word_table',
          );
          await m.createTable(savedTermTable);
        }
        if (from < 4) {
          await m.createTable(videoStepProgressTable);
        }
        // NOTE: schema v5–v8 built up the daily_speaking_session_table. That
        // module was removed in this (standalone) app, so its create/alter
        // steps are gone and the table is dropped in the v10 step below.
        if (from < 9) {
          // The "Useful Spoken Patterns" (days) and "Practice with AI" modules
          // were removed from the app. Drop their now-orphaned local tables so
          // upgrading installs don't carry dead data.
          await customStatement(
              'DROP TABLE IF EXISTS ai_sentence_practice_table');
          await customStatement(
              'DROP TABLE IF EXISTS user_example_answer_table');
          await customStatement(
              'DROP TABLE IF EXISTS spoken_pattern_exercise_answer_table');
        }
        if (from < 10) {
          // Daily Speaking module removed in the standalone build. Drop its
          // now-orphaned local history table so upgrading installs don't carry
          // dead data.
          await customStatement(
              'DROP TABLE IF EXISTS daily_speaking_session_table');
        }
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
