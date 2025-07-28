import 'dart:math';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'services/app_database/app_database.dart';

class FakeDataRepository {
  Future<void> insertFakeAiSentencePracticeData() async {
    final db = AppDatabase.instance();
    final random = Random();

    final List<String> inputs = [
      "He go to school every day.",
      "She not like coffee.",
      "I has a new phone.",
      "They is coming tomorrow.",
      "The dog eat the food.",
      "My friend live in Yangon.",
      "He do his homework.",
      "We was late to class.",
      "She have three sisters.",
      "It not raining today.",
      "I am go to market.",
      "He walk fastly.",
      "They has many cars.",
      "My cat like sleep.",
      "We not finish the work.",
      "She cooking dinner now.",
      "He speak English good.",
      "They doesn't knows me.",
      "The boy don't plays outside.",
      "It are very cold."
    ];

    final List<String> corrected = [
      "He goes to school every day.",
      "She doesn't like coffee.",
      "I have a new phone.",
      "They are coming tomorrow.",
      "The dog eats the food.",
      "My friend lives in Yangon.",
      "He does his homework.",
      "We were late to class.",
      "She has three sisters.",
      "It is not raining today.",
      "I am going to the market.",
      "He walks fast.",
      "They have many cars.",
      "My cat likes to sleep.",
      "We haven't finished the work.",
      "She is cooking dinner now.",
      "He speaks English well.",
      "They don't know me.",
      "The boy doesn't play outside.",
      "It is very cold."
    ];

    final List<String> explanationMM = [
      "subject နှင့် verb မကိုက်လို့ goes လို့ပြောင်းရန်လိုသည်။",
      "negative sentence တွင် 'doesn't' အသုံးပြုရန်လိုသည်။",
      "have ဟာ I နဲ့သုံးရတာဖြစ်သည်။",
      "plural subject ဖြစ်လို့ are ဖြစ်ရမည်။",
      "singular subject ဖြစ်လို့ eats ဖြစ်ရမည်။",
      "live => lives (third person singular)",
      "do => does (he)",
      "was => were (we)",
      "have => has (she)",
      "not raining => is not raining",
      "am go => am going",
      "fastly => fast (adverb form)",
      "has => have (they)",
      "like => likes",
      "not finish => haven't finished",
      "cooking => is cooking",
      "good => well (adverb)",
      "doesn't knows => don't know",
      "don't plays => doesn't play",
      "are => is (it)"
    ];

    final now = DateTime.now();
    for (int day = 0; day < 4; day++) {
      final date = now.subtract(Duration(days: day));
      for (int i = 0; i < 5; i++) {
        final index = day * 5 + i;

        await db.aiSentencePracticeTable.insertOnConflictUpdate(
          AiSentencePracticeTableCompanion(
            inputSentence: Value(inputs[index]),
            correctedSentence: Value(corrected[index]),
            explanation: Value(explanationMM[index]),
            totalTokensUsed: Value(20 + random.nextInt(50)),
            createdAt: Value(DateTime(
              date.year,
              date.month,
              date.day,
              random.nextInt(23),
              random.nextInt(59),
            )),
          ),
        );
      }
    }

    debugPrint('✅ Inserted 20 fake practice rows');
  }
}
