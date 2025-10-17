import 'package:drift/drift.dart';
import 'package:pmp_english/model/listening_practice_answer/listening_practice_answer.dart';

@UseRowClass(ListeningPracticeAnswer)
class ListeningPracticeAnswerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get groupId => text()();
  IntColumn get questionId => integer()();
  TextColumn get userAnswer => text().nullable()();
  IntColumn get timeSpent => integer()();
  BoolColumn get isCorrect => boolean()();
}
