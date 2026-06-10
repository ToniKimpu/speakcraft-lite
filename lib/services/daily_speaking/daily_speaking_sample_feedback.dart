// GENERATED-FRIENDLY: a verbatim copy of
// `lib/screens/daily_speaking/feedback/feedback_schema.example.5min.json`,
// embedded so the stub can render the v2 (annotated-transcript) schema in the
// real result/review flow before the Gemini edge function is live.
//
// Delete this together with `daily_speaking_service_stubs.dart` once
// `DailySpeakingService.useStubResponse` flips to false.
import 'dart:convert';

import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';

/// The 5-minute "hometown / Bagan trip" sample, parsed into a feedback object.
final DailySpeakingFeedback kSampleFiveMinFeedback =
    DailySpeakingFeedback.fromJson(
  jsonDecode(_kSampleFiveMinJson) as Map<String, dynamic>,
);

const String _kSampleFiveMinJson = r'''
{
  "schema_version": 1,
  "score": 54,
  "level": "elementary",
  "inferred_topic": "My hometown and a trip to Bagan",
  "duration_seconds": 300,
  "word_count": 226,
  "speaking_pace_wpm": 45,
  "transcript": "Um, today I want to talk about my hometown. My hometown is a small city in the middle of Myanmar. It call Magway and it is very hot place. Many people there is farmer. I born in 1998 and I grow up there. When I am child, I very like to play near the river. The river is call Ayeyarwady. Last year, I make a trip to Bagan with my family. Bagan is famous for, uh, many old pagoda. We wake up early morning to see the sunrise. The view was very beautiful and I feel so happy. We rent, um, a electric bike and go around. I take many photos for remember this trip. The food in Bagan is very delicious specially the tea leaf salad. I think Myanmar food is the best food in the world. After three days, we come back to home. I miss Bagan very much and I want to go again. In the future, I hope I can travel to many country. I want to improve my English so I can talk with foreigner. My family have a small shop in the market. My mother sell vegetable and my father help her. Every morning they wake up very early to open the shop. Sometimes I help them in the weekend. I am very proud of my family and my hometown.",
  "native_rewrite": "Today I want to talk about my hometown. My hometown is a small city in the middle of Myanmar. It is called Magway and it is a very hot place. Many people there are farmers. I was born in 1998 and I grew up there. When I was a child, I really liked to play near the river. The river is called Ayeyarwady. Last year, I made a trip to Bagan with my family. Bagan is famous for its many old pagodas. We woke up early in the morning to see the sunrise. The view was very beautiful and I felt so happy. We rented an electric bike and went around. I took many photos to remember this trip. The food in Bagan is very delicious, especially the tea leaf salad. I think Myanmar food is the best food in the world. After three days, we came back home. I miss Bagan very much and I want to go again. In the future, I hope I can travel to many countries. I want to improve my English so I can talk with foreigners. My family has a small shop in the market. My mother sells vegetables and my father helps her. Every morning they wake up very early to open the shop. Sometimes I help them on weekends. I am very proud of my family and my hometown.",
  "sub_scores": {
    "grammar": 45,
    "vocabulary": 58,
    "fluency": 60,
    "pronunciation": 50
  },
  "sentences": [
    {
      "original": "Um, today I want to talk about my hometown.",
      "native": "Today I want to talk about my hometown.",
      "changed": true,
      "segments": [
        { "text": "Um, ", "type": "filler", "correction": "", "reason_mm": "‘Um’ လို ဖြည့်စကားလုံးကို ဖြုတ်လိုက်ပါ။" },
        { "text": "today I want to talk about my hometown." }
      ]
    },
    {
      "original": "My hometown is a small city in the middle of Myanmar.",
      "native": "My hometown is a small city in the middle of Myanmar.",
      "changed": false,
      "segments": [
        { "text": "My hometown is a small city in the middle of Myanmar." }
      ]
    },
    {
      "original": "It call Magway and it is very hot place.",
      "native": "It is called Magway and it is a very hot place.",
      "changed": true,
      "segments": [
        { "text": "It " },
        { "text": "call", "type": "grammar", "correction": "is called", "reason_mm": "Passive ဖြစ်လို့ ‘is called’ လို့ သုံးပါ။" },
        { "text": " Magway and it is " },
        { "text": "very hot place", "type": "grammar", "correction": "a very hot place", "reason_mm": "ရေတွက်လို့ရတဲ့ နာမ်တစ်ခုရှေ့မှာ ‘a’ ထည့်ပါ။" },
        { "text": "." }
      ]
    },
    {
      "original": "Many people there is farmer.",
      "native": "Many people there are farmers.",
      "changed": true,
      "segments": [
        { "text": "Many people there " },
        { "text": "is", "type": "grammar", "correction": "are", "reason_mm": "‘people’ က အများကိန်းဖြစ်လို့ ‘are’။" },
        { "text": " " },
        { "text": "farmer", "type": "grammar", "correction": "farmers", "reason_mm": "လူအများကြောင့် ‘farmers’ လို့ ‘s’ ထည့်ပါ။" },
        { "text": "." }
      ]
    },
    {
      "original": "I born in 1998 and I grow up there.",
      "native": "I was born in 1998 and I grew up there.",
      "changed": true,
      "segments": [
        { "text": "I " },
        { "text": "born", "type": "grammar", "correction": "was born", "reason_mm": "‘was born’ လို့ passive past သုံးပါ။" },
        { "text": " in 1998 and I " },
        { "text": "grow", "type": "grammar", "correction": "grew", "reason_mm": "အတိတ်ဖြစ်လို့ ‘grew’။" },
        { "text": " up there." }
      ]
    },
    {
      "original": "When I am child, I very like to play near the river.",
      "native": "When I was a child, I really liked to play near the river.",
      "changed": true,
      "segments": [
        { "text": "When I " },
        { "text": "am child", "type": "grammar", "correction": "was a child", "reason_mm": "အတိတ် + article ‘a’ နဲ့ ‘was a child’။" },
        { "text": ", I " },
        { "text": "very like", "type": "interference", "correction": "really liked", "reason_mm": "မြန်မာ ‘အရမ်းကြိုက်’ ကို တိုက်ရိုက်မပြန်ပါနဲ့၊ ‘really liked’။" },
        { "text": " to play near the river." }
      ]
    },
    {
      "original": "The river is call Ayeyarwady.",
      "native": "The river is called Ayeyarwady.",
      "changed": true,
      "segments": [
        { "text": "The river is " },
        { "text": "call", "type": "grammar", "correction": "called", "reason_mm": "Passive ဖြစ်လို့ ‘called’။" },
        { "text": " Ayeyarwady." }
      ]
    },
    {
      "original": "Last year, I make a trip to Bagan with my family.",
      "native": "Last year, I made a trip to Bagan with my family.",
      "changed": true,
      "segments": [
        { "text": "Last year, I " },
        { "text": "make", "type": "grammar", "correction": "made", "reason_mm": "‘Last year’ အတိတ်ဖြစ်လို့ ‘made’။" },
        { "text": " a trip to Bagan with my family." }
      ]
    },
    {
      "original": "Bagan is famous for, uh, many old pagoda.",
      "native": "Bagan is famous for its many old pagodas.",
      "changed": true,
      "segments": [
        { "text": "Bagan is famous for" },
        { "text": ", uh, ", "type": "filler", "correction": "", "reason_mm": "‘uh’ ဖြည့်စကားလုံးကို ဖြုတ်ပါ။" },
        { "text": "many " },
        { "text": "old pagoda", "type": "grammar", "correction": "old pagodas", "reason_mm": "‘many’ နောက်မှာ အများကိန်း ‘pagodas’။" },
        { "text": "." }
      ]
    },
    {
      "original": "We wake up early morning to see the sunrise.",
      "native": "We woke up early in the morning to see the sunrise.",
      "changed": true,
      "segments": [
        { "text": "We " },
        { "text": "wake", "type": "grammar", "correction": "woke", "reason_mm": "အတိတ်ဖြစ်လို့ ‘woke’။" },
        { "text": " up " },
        { "text": "early morning", "type": "grammar", "correction": "early in the morning", "reason_mm": "‘in the morning’ လို့ preposition ထည့်ပါ။" },
        { "text": " to see the sunrise." }
      ]
    },
    {
      "original": "The view was very beautiful and I feel so happy.",
      "native": "The view was very beautiful and I felt so happy.",
      "changed": true,
      "segments": [
        { "text": "The view was very beautiful and I " },
        { "text": "feel", "type": "grammar", "correction": "felt", "reason_mm": "အတိတ်ဖြစ်လို့ ‘felt’။" },
        { "text": " so happy." }
      ]
    },
    {
      "original": "We rent, um, a electric bike and go around.",
      "native": "We rented an electric bike and went around.",
      "changed": true,
      "segments": [
        { "text": "We " },
        { "text": "rent", "type": "grammar", "correction": "rented", "reason_mm": "အတိတ်ဖြစ်လို့ ‘rented’။" },
        { "text": ", um, ", "type": "filler", "correction": "", "reason_mm": "‘um’ ကို ဖြုတ်ပါ။" },
        { "text": "a electric", "type": "grammar", "correction": "an electric", "reason_mm": "သရသံ ‘e’ ရှေ့မှာ ‘an’ သုံးပါ။" },
        { "text": " bike and " },
        { "text": "go", "type": "grammar", "correction": "went", "reason_mm": "အတိတ်ဖြစ်လို့ ‘went’။" },
        { "text": " around." }
      ]
    },
    {
      "original": "I take many photos for remember this trip.",
      "native": "I took many photos to remember this trip.",
      "changed": true,
      "segments": [
        { "text": "I " },
        { "text": "take", "type": "grammar", "correction": "took", "reason_mm": "အတိတ်ဖြစ်လို့ ‘took’။" },
        { "text": " many photos " },
        { "text": "for remember", "type": "interference", "correction": "to remember", "reason_mm": "ရည်ရွယ်ချက်ပြရင် ‘to + verb’ သုံးပါ၊ ‘for’ မဟုတ်ပါ။" },
        { "text": " this trip." }
      ]
    },
    {
      "original": "The food in Bagan is very delicious specially the tea leaf salad.",
      "native": "The food in Bagan is very delicious, especially the tea leaf salad.",
      "changed": true,
      "segments": [
        { "text": "The food in Bagan is very delicious " },
        { "text": "specially", "type": "vocab", "correction": "especially", "reason_mm": "‘especially’ (အထူးသဖြင့်) လို့ သုံးတာ ပိုမှန်ပါတယ်။" },
        { "text": " the tea leaf salad." }
      ]
    },
    {
      "original": "I think Myanmar food is the best food in the world.",
      "native": "I think Myanmar food is the best food in the world.",
      "changed": false,
      "segments": [
        { "text": "I think Myanmar food is the best food in the world." }
      ]
    },
    {
      "original": "After three days, we come back to home.",
      "native": "After three days, we came back home.",
      "changed": true,
      "segments": [
        { "text": "After three days, we " },
        { "text": "come", "type": "grammar", "correction": "came", "reason_mm": "အတိတ်ဖြစ်လို့ ‘came’။" },
        { "text": " " },
        { "text": "back to home", "type": "interference", "correction": "back home", "reason_mm": "‘home’ ရှေ့မှာ ‘to’ မလိုပါ၊ ‘back home’။" },
        { "text": "." }
      ]
    },
    {
      "original": "I miss Bagan very much and I want to go again.",
      "native": "I miss Bagan very much and I want to go again.",
      "changed": false,
      "segments": [
        { "text": "I miss Bagan very much and I want to go again." }
      ]
    },
    {
      "original": "In the future, I hope I can travel to many country.",
      "native": "In the future, I hope I can travel to many countries.",
      "changed": true,
      "segments": [
        { "text": "In the future, I hope I can travel to many " },
        { "text": "country", "type": "grammar", "correction": "countries", "reason_mm": "‘many’ နောက်မှာ အများကိန်း ‘countries’။" },
        { "text": "." }
      ]
    },
    {
      "original": "I want to improve my English so I can talk with foreigner.",
      "native": "I want to improve my English so I can talk with foreigners.",
      "changed": true,
      "segments": [
        { "text": "I want to improve my English so I can talk with " },
        { "text": "foreigner", "type": "grammar", "correction": "foreigners", "reason_mm": "လူအများကို ဆိုလို့ ‘foreigners’။" },
        { "text": "." }
      ]
    },
    {
      "original": "My family have a small shop in the market.",
      "native": "My family has a small shop in the market.",
      "changed": true,
      "segments": [
        { "text": "My family " },
        { "text": "have", "type": "grammar", "correction": "has", "reason_mm": "‘family’ singular ဖြစ်လို့ ‘has’။" },
        { "text": " a small shop in the market." }
      ]
    },
    {
      "original": "My mother sell vegetable and my father help her.",
      "native": "My mother sells vegetables and my father helps her.",
      "changed": true,
      "segments": [
        { "text": "My mother " },
        { "text": "sell", "type": "grammar", "correction": "sells", "reason_mm": "‘My mother’ (သူမ) နဲ့တွဲရင် ‘sells’။" },
        { "text": " " },
        { "text": "vegetable", "type": "grammar", "correction": "vegetables", "reason_mm": "အမျိုးမျိုးဖြစ်လို့ ‘vegetables’။" },
        { "text": " and my father " },
        { "text": "help", "type": "grammar", "correction": "helps", "reason_mm": "‘My father’ (သူ) နဲ့တွဲရင် ‘helps’။" },
        { "text": " her." }
      ]
    },
    {
      "original": "Every morning they wake up very early to open the shop.",
      "native": "Every morning they wake up very early to open the shop.",
      "changed": false,
      "segments": [
        { "text": "Every morning they wake up very early to open the shop." }
      ]
    },
    {
      "original": "Sometimes I help them in the weekend.",
      "native": "Sometimes I help them on weekends.",
      "changed": true,
      "segments": [
        { "text": "Sometimes I help them " },
        { "text": "in the weekend", "type": "interference", "correction": "on weekends", "reason_mm": "‘on weekends’ လို့ သုံးတာ ပိုသဘာဝကျပါတယ်။" },
        { "text": "." }
      ]
    },
    {
      "original": "I am very proud of my family and my hometown.",
      "native": "I am very proud of my family and my hometown.",
      "changed": false,
      "segments": [
        { "text": "I am very proud of my family and my hometown." }
      ]
    }
  ],
  "strengths": [
    "You kept going for the full five minutes without giving up — that takes real stamina.",
    "Your talk was well organised: hometown first, then your trip, then your family.",
    "You used nice descriptive words like 'beautiful', 'delicious', and 'proud'."
  ],
  "grammar_patterns": [
    "Past-tense verbs slip back into present (make→made, wake→woke, take→took, feel→felt).",
    "Subject–verb agreement in present simple (have→has, sell→sells, help→helps).",
    "Missing articles before singular nouns (a/an).",
    "Plural -s dropped after numbers and quantities (people, pagodas, countries)."
  ],
  "pronunciation_notes": [
    "'th' sounds in 'the' and 'three' sometimes come out as 't' or 'd'.",
    "Final consonants get dropped — 'trip' and 'shop' lose their endings.",
    "Word stress drifts on longer words like 'especially' and 'delicious'."
  ],
  "collocations": [
    "take a trip (rather than 'make a trip')",
    "watch the sunrise",
    "famous for its temples",
    "grow up in a small town",
    "a close-knit family",
    "brush up on my English"
  ],
  "idioms": [
    { "expression": "off the beaten track", "meaning_mm": "ခရီးသွားများ သိပ်မရောက်တတ်တဲ့ နေရာ။" },
    { "expression": "home sweet home", "meaning_mm": "ကိုယ့်အိမ်လောက် သက်တောင့်သက်သာရှိတဲ့ နေရာ မရှိဘူး။" },
    { "expression": "the trip of a lifetime", "meaning_mm": "တစ်သက်တာမှာ တစ်ကြိမ်သာ ကြုံရတဲ့ အထူးခရီး။" }
  ],
  "target_phrase_results": [],
  "explanation_mm": "ငါးမိနစ်လုံး ရပ်နားမသွားဘဲ ဆက်ပြောနိုင်တာ အရမ်းကောင်းပါတယ်။ အကြောင်းအရာကိုလည်း ဇာတ်ဇတ်နဲ့ စီစဉ်ထားတာ ကောင်းပါတယ်။ အဓိက ပြင်ရမှာက အတိတ်ကို ပြောတဲ့အခါ ကြိယာကို past tense (made, woke, took, felt) ပြောင်းဖို့နဲ့ present simple မှာ ကတ္တားနဲ့ ကြိယာ သဟဇာတဖြစ်အောင် (has, sells, helps) လုပ်ဖို့ပါ။ ထို့အပြင် ရေတွက်လို့ရတဲ့ နာမ်ရှေ့မှာ ‘a/an’ ထည့်ဖို့နဲ့ မြန်မာလို တိုက်ရိုက်ပြန်ဆိုတဲ့ ‘very like’, ‘for remember’, ‘back to home’ တို့ကို ရှောင်ဖို့ပါ။ ဒီအချက်တွေကို တစ်ဆင့်ချင်း ပြင်သွားရင် သိသိသာသာ တိုးတက်လာပါလိမ့်မယ်။",
  "total_tokens": 3050
}
''';
