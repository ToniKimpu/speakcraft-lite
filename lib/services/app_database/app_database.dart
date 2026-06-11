import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../model/saved_term/saved_term.dart';
import '../../model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';
import '../../model/video_step_progress/video_step_progress.dart';
import '../../tables/daily_speaking_session_table.dart';
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
    DailySpeakingSessionTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  static final _instance = AppDatabase._();

  AppDatabase._() : super(_openConnection());

  static AppDatabase instance() => _instance;

  @override
  int get schemaVersion => 9;

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
        if (from < 5) {
          await m.createTable(dailySpeakingSessionTable);
        }
        if (from < 6) {
          // Version-loop columns. Added separately so v5 installs keep their
          // existing daily-speaking history.
          await m.addColumn(
            dailySpeakingSessionTable,
            dailySpeakingSessionTable.topicAttemptId,
          );
          await m.addColumn(
            dailySpeakingSessionTable,
            dailySpeakingSessionTable.revisionNumber,
          );
        }
        if (from < 7) {
          // Saved-recording path for the audio player / A/B replay. Added
          // separately so v6 installs keep their existing history.
          await m.addColumn(
            dailySpeakingSessionTable,
            dailySpeakingSessionTable.audioPath,
          );
        }
        if (from < 8) {
          // Serialized topic so a chain can be resumed ("Polish & retry") from
          // history. Old rows stay null → no resume button, which is correct.
          await m.addColumn(
            dailySpeakingSessionTable,
            dailySpeakingSessionTable.topicJson,
          );
        }
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
