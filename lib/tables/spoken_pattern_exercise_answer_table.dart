import 'package:drift/drift.dart';
import 'package:pmp_english/model/exercise_user_answer/exercise_user_answer.dart';

@UseRowClass(ExerciseUserAnswer)
class SpokenPatternExerciseAnswerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patternExerciseId => integer()();
  TextColumn get userAnswer => text()();
}
