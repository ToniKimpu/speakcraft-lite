import 'package:drift/drift.dart';

import '../../model/ai_sentence_practice/ai_sentence_practice.dart';

@UseRowClass(AiSentencePractice)
class AiSentencePracticeTable extends Table {
  late final id = integer().autoIncrement()();
  late final inputSentence = text()();
  late final correctedSentence = text().nullable()();
  late final explanation = text().nullable()();
  late final totalTokensUsed = integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
