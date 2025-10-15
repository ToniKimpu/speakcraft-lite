import 'package:drift/drift.dart';

class ListeningPracticeAnswerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get groupId => text()();
  IntColumn get questionId => integer()();
  TextColumn get userAnswer => text().nullable()();
  IntColumn get timeSpent => integer()();
  BoolColumn get isCorrect => boolean()();
}
