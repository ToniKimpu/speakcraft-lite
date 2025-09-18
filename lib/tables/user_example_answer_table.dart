import 'package:drift/drift.dart';

class UserExampleAnswerTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exampleId => integer()();
  TextColumn get userAnswer => text()();
}
