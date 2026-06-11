import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// Canned `DailySpeakingFeedback` payloads used while the Gemini edge function
/// is not yet deployed. Three variants (high / mid / low score with topic
/// hits) so the result UI is exercised end-to-end without a live API.
///
/// Delete this file once `DailySpeakingService.useStubResponse` flips to
/// `false`.
class DailySpeakingServiceStubs {
  /// Own-topic AI prep stub: an expanded [DailySpeakingTopic] built from the
  /// learner's raw [topicText]. Mirrors what the future `daily-speaking-prep`
  /// edge function will return — `id: 'own'` sentinel preserved, bilingual
  /// (Burmese strings are *data*, not localized UI), and topic-interpolated so
  /// the whole prep flow is demoable for any typed subject. The vocab / phrases
  /// / warmups are intentionally general-purpose (usable for any monologue)
  /// since this is a generic template, not a topic-aware scaffold yet.
  static DailySpeakingTopic expandedTopic(String topicText) {
    final t = topicText.trim();
    return DailySpeakingTopic(
      id: 'own',
      title: t,
      promptEn:
          'Talk about "$t" for about three minutes. Describe your experience, '
          'share a few specific details, and explain why it matters to you.',
      promptMm:
          '"$t" အကြောင်း ၃ မိနစ်လောက် ပြောကြည့်ပါ။ ကိုယ်တွေ့အတွေ့အကြုံတွေ၊ '
          'အသေးစိတ်အချက်အလက်အနည်းငယ် မျှဝေပြီး ဘာကြောင့် အရေးကြီးတယ်ဆိုတာ ရှင်းပြပါ။',
      vocabulary: const [
        TopicVocabItem(
          term: 'memorable',
          definitionMm: 'မှတ်မိလွယ်တဲ့၊ စွဲမှတ်စရာကောင်းတဲ့။',
          exampleEn: 'It was a really memorable experience for me.',
        ),
        TopicVocabItem(
          term: 'in particular',
          definitionMm: 'အထူးသဖြင့်၊ တိတိကျကျ ဆိုရရင်။',
          exampleEn: 'One moment in particular stood out to me.',
        ),
        TopicVocabItem(
          term: 'overall',
          definitionMm: 'အလုံးစုံ ခြုံငုံကြည့်ရင်။',
          exampleEn: 'Overall, it was a positive experience.',
        ),
      ],
      targetPhrases: const [
        TopicTargetPhrase(
          phraseEn: 'Let me start by saying ...',
          translationMm: 'အစချီပြောရရင် ...',
        ),
        TopicTargetPhrase(
          phraseEn: 'One thing I really enjoy is ...',
          translationMm: 'ကျွန်တော် တကယ်နှစ်သက်တဲ့ အရာတစ်ခုက ...',
        ),
        TopicTargetPhrase(
          phraseEn: 'What stands out to me is ...',
          translationMm: 'ကျွန်တော့်အတွက် အထင်ရှားဆုံးက ...',
        ),
        TopicTargetPhrase(
          phraseEn: 'If I had to sum it up, ...',
          translationMm: 'အကျဉ်းချုပ်ပြောရရင် ...',
        ),
      ],
      warmupQuestions: [
        'When did you first get into $t?',
        'What do you like most about $t?',
        'Is there anything challenging about $t?',
        'How might $t change for you in the future?',
      ],
    );
  }

  /// Follow-up "ask" deltas — small extra batches the prep bloc appends to the
  /// already-loaded topic. Kept tiny + general-purpose; the real edge function
  /// would return topic-aware deltas.
  static const List<TopicVocabItem> moreVocabDelta = [
    TopicVocabItem(
      term: 'for instance',
      definitionMm: 'ဥပမာအားဖြင့်။',
      exampleEn: 'For instance, last week something similar happened.',
    ),
    TopicVocabItem(
      term: 'to be honest',
      definitionMm: 'အမှန်အတိုင်း ပြောရရင်။',
      exampleEn: "To be honest, I wasn't sure at first.",
    ),
  ];

  static const List<TopicVocabItem> harderWordsDelta = [
    TopicVocabItem(
      term: 'compelling',
      definitionMm: 'စိတ်ဝင်စားဖွယ်ကောင်းပြီး ဆွဲဆောင်မှုရှိတဲ့။',
      exampleEn: 'There was a compelling reason behind my choice.',
    ),
    TopicVocabItem(
      term: 'nuanced',
      definitionMm: 'အသေးစိတ် ကွဲပြားမှုလေးတွေ ပါဝင်တဲ့။',
      exampleEn: 'My feelings about it are a bit more nuanced than that.',
    ),
  ];

  static const List<TopicTargetPhrase> usefulPhrasesDelta = [
    TopicTargetPhrase(
      phraseEn: 'That reminds me of ...',
      translationMm: 'အဲဒါက ကျွန်တော့်ကို ... ကို သတိရစေတယ်။',
    ),
    TopicTargetPhrase(
      phraseEn: 'On the other hand, ...',
      translationMm: 'တစ်ဖက်ကကြည့်ရင်တော့ ...',
    ),
  ];

  static const List<String> howToStartDelta = [
    'You could open with: "I\'d like to talk about ..."',
    'Or set the scene: "This is something I think about a lot because ..."',
  ];
  static final List<DailySpeakingFeedback> cannedResponses = [
    const DailySpeakingFeedback(
      score: 88,
      level: CefrLevel.upperIntermediate,
      inferredTopic: 'Weekend plans',
      transcript:
          'So last weekend I go to market with my sister. I am there for 2 '
          'hours and we buy some snacks and look around. It was a lot of fun '
          'and the food is very good. I very like spending time with her.',
      durationSeconds: 142,
      wordCount: 224,
      speakingPaceWpm: 95,
      strengths: [
        'Clear pronunciation of consonants',
        'Good use of past simple throughout',
        'Natural connectors ("and then", "after that")',
      ],
      fixes: [
        FeedbackFix(
          original: 'I go to market yesterday.',
          corrected: 'I went to the market yesterday.',
          reasonMm:
              '"yesterday" ဆိုတဲ့အခါ past simple သုံးပါ။ "the market" ဆိုပြီး article ထည့်ပါ။',
        ),
        FeedbackFix(
          original: 'I am there for 2 hours.',
          corrected: 'I was there for 2 hours.',
          reasonMm: 'အတိတ်မှာ ဖြစ်ပျက်ခဲ့တာဆိုတော့ "was" သုံးပါ။',
        ),
      ],
      nativeRewrite:
          'Last weekend I went to the market with my sister. We were there for about two hours, just browsing around and grabbing some snacks.',
      pronunciationNotes: [
        '"th" sound in "there" can be softer',
      ],
      grammarPatterns: [
        'Past simple: solid, but watch articles before nouns ("the market").',
        'You dropped "the/a" a few times — common when translating from Burmese.',
      ],
      interferenceNotes: [
        FeedbackFix(
          original: 'I very like the food.',
          corrected: 'I really like the food.',
          reasonMm:
              'မြန်မာလို "အရမ်းကြိုက်တယ်" ကို တိုက်ရိုက်ပြန်ထားတာ။ အင်္ဂလိပ်လို "very like" မသုံးပါ — "really like" သုံးပါ။',
        ),
      ],
      vocabUpgrades: [
        VocabUpgrade(
          original: 'good',
          suggestion: 'rewarding',
          reasonMm: '"good" အစား ပိုတိကျတဲ့ စကားလုံး သုံးကြည့်ပါ။',
        ),
        VocabUpgrade(
          original: 'a lot of fun',
          suggestion: 'a great time',
          reasonMm: 'ပိုသဘာဝကျတဲ့ collocation ဖြစ်ပါတယ်။',
        ),
      ],
      phrases: [
        PhraseSuggestion(
          phrase: 'grab some snacks',
          meaningMm: 'စားစရာ အမြန်အလွယ် ဝယ်ယူတာ။',
          meaningEn: 'to quickly get some food to eat',
          examples: [
            PhraseExample(
              en: "Let's grab some snacks before the movie.",
              mm: 'ရုပ်ရှင်မကြည့်ခင် စားစရာလေး ဝယ်ရအောင်။',
            ),
          ],
        ),
        PhraseSuggestion(
          phrase: 'spend time with family',
          meaningMm: 'မိသားစုနဲ့ အတူ အချိန်ဖြုန်းတာ။',
          meaningEn: 'to be together with your family',
          examples: [
            PhraseExample(
              en: 'On weekends I spend time with my family.',
              mm: 'စနေ၊ တနင်္ဂနွေဆို မိသားစုနဲ့ အချိန်ကုန်တယ်။',
            ),
          ],
        ),
        PhraseSuggestion(
          phrase: 'kill time',
          kind: PhraseKind.idiom,
          meaningMm: 'အချိန်ဖြုန်းရင်း စောင့်နေတာ။',
          meaningEn: 'to do something while waiting, to pass the time',
          examples: [
            PhraseExample(
              en: 'We killed time at the mall before the bus came.',
              mm: 'ဘတ်စ်ကားမလာခင် ကုန်တိုက်မှာ အချိန်ဖြုန်းနေခဲ့တယ်။',
            ),
          ],
        ),
        PhraseSuggestion(
          phrase: 'now and then',
          kind: PhraseKind.idiom,
          meaningMm: 'ရံဖန်ရံခါ။',
          meaningEn: 'sometimes, but not often',
          examples: [
            PhraseExample(
              en: 'Now and then we eat out.',
              mm: 'ရံဖန်ရံခါ အပြင်မှာ စားကြတယ်။',
            ),
          ],
        ),
      ],
      sentenceRewrites: [
        SentenceRewrite(
          original: 'We were there for about two hours just looking.',
          rewrite: 'We spent a couple of hours just browsing around.',
        ),
      ],
      fillerWords: [
        FillerWord(word: 'um', count: 4),
        FillerWord(word: 'like', count: 2),
      ],
      subScores: SubScores(
        grammar: 82,
        vocabulary: 86,
        fluency: 90,
        pronunciation: 88,
      ),
      explanationMm:
          'အလုံးစုံအနေနဲ့ ပြောတာ ရှင်းရှင်းလင်းလင်း ဖြစ်ပါတယ်။ Past tense မှ verb form တွေပေါ်တွင်တော့ ပြန်အာရုံစိုက်ဖို့လိုပါမယ်။ Speaking pace 95 wpm က intermediate အတွက် သင့်တင့်ပါတယ်။',
      targetPhraseResults: [
        TargetPhraseResult(
          phraseEn: 'I was supposed to ...',
          used: true,
          usedCorrectly: true,
        ),
        TargetPhraseResult(
          phraseEn: 'It turned out that ...',
          used: false,
          usedCorrectly: false,
        ),
      ],
      totalTokens: 1820,
    ),
    const DailySpeakingFeedback(
      score: 64,
      level: CefrLevel.intermediate,
      inferredTopic: 'My job',
      transcript:
          'I work in there since 3 years. My colleague are very kind to me '
          'always. The work is busy but I enjoy it. Sometimes I make mistake '
          'but they help me and I learn from it.',
      durationSeconds: 95,
      wordCount: 121,
      speakingPaceWpm: 76,
      strengths: [
        'Good vocabulary range for work topics',
        'Confident delivery',
      ],
      fixes: [
        FeedbackFix(
          original: 'I work in there since 3 years.',
          corrected: 'I have worked there for three years.',
          reasonMm:
              'အချိန်ကာလအတိုင်းအတာ ဆိုရင် "for" သုံးပါ၊ ဆက်လုပ်နေတဲ့ အလုပ်ဆိုရင် present perfect သုံးပါ။',
        ),
        FeedbackFix(
          original: 'My colleague are very kind.',
          corrected: 'My colleagues are very kind.',
          reasonMm: 'အများကိန်းဆိုရင် "colleagues" လို့ "s" ထည့်ပါ။',
        ),
        FeedbackFix(
          original: 'Sometimes I make mistake.',
          corrected: 'Sometimes I make mistakes.',
          reasonMm: 'အကြိမ်များတဲ့ mistake တွေ ဆိုလို့ "mistakes" သုံးပါ။',
        ),
      ],
      nativeRewrite:
          "I've been working there for three years now. My colleagues are really kind — sometimes I make mistakes, but they always help me out.",
      pronunciationNotes: [
        '"colleagues" — stress on the first syllable: COL-leagues',
      ],
      grammarPatterns: [
        'Present perfect for ongoing situations needs work ("have worked").',
        'Plural "s" was missing a couple of times.',
      ],
      interferenceNotes: [
        FeedbackFix(
          original: 'I work since 3 years.',
          corrected: 'I have worked for three years.',
          reasonMm:
              'မြန်မာစဉ်းစားပုံအတိုင်း "since 3 years" ဖြစ်နေတာ။ ကာလအတိုင်းအတာဆို "for" သုံးပြီး present perfect သုံးပါ။',
        ),
      ],
      vocabUpgrades: [
        VocabUpgrade(
          original: 'kind',
          suggestion: 'supportive',
          reasonMm: 'အလုပ်ခွင်အကြောင်းဆို "supportive" က ပိုသင့်တော်ပါတယ်။',
        ),
      ],
      phrases: [
        PhraseSuggestion(
          phrase: 'make a mistake',
          meaningMm: 'အမှားတစ်ခု လုပ်မိတာ။',
          meaningEn: 'to do something wrong',
          examples: [
            PhraseExample(
              en: "Everyone makes a mistake sometimes.",
              mm: 'လူတိုင်း တစ်ခါတစ်လေ အမှားလုပ်မိတတ်တယ်။',
            ),
          ],
        ),
        PhraseSuggestion(
          phrase: 'get along with colleagues',
          meaningMm: 'လုပ်ဖော်ကိုင်ဖက်တွေနဲ့ သင့်မြတ်တာ။',
          meaningEn: 'to have a friendly relationship with coworkers',
          examples: [
            PhraseExample(
              en: 'I get along well with my colleagues.',
              mm: 'လုပ်ဖော်ကိုင်ဖက်တွေနဲ့ အဆင်ပြေပြေ ရှိတယ်။',
            ),
          ],
        ),
        PhraseSuggestion(
          phrase: 'have my back',
          kind: PhraseKind.idiom,
          meaningMm: 'ကူညီထောက်ပံ့ပေးတယ်။',
          meaningEn: 'to support and protect someone',
          examples: [
            PhraseExample(
              en: 'My team always has my back.',
              mm: 'ကျွန်တော့်အဖွဲ့က အမြဲ ကျွန်တော့်ကို ထောက်ပံ့ပေးတယ်။',
            ),
          ],
        ),
      ],
      sentenceRewrites: [
        SentenceRewrite(
          original: 'My colleague are very kind to me always.',
          rewrite: 'My colleagues are always really kind to me.',
        ),
      ],
      fillerWords: [
        FillerWord(word: 'uh', count: 5),
      ],
      subScores: SubScores(
        grammar: 58,
        vocabulary: 68,
        fluency: 70,
        pronunciation: 64,
      ),
      explanationMm:
          'အလုပ်အကြောင်း ပြောတဲ့ vocabulary တွေ ကောင်းပါတယ်။ Grammar အပိုင်းမှာ singular/plural နဲ့ present perfect tense ကို ပိုဂရုစိုက်ပါ။ နောက်တစ်ခါ "for/since" ကိုလည်း ပြန်လေ့လာကြည့်ပါ။',
      totalTokens: 1640,
    ),
    const DailySpeakingFeedback(
      score: 42,
      level: CefrLevel.elementary,
      inferredTopic: 'My family',
      transcript:
          'My family have four peoples. My father work in factory and my '
          'mother stay at home. I have one sister. We are happy together.',
      durationSeconds: 58,
      wordCount: 64,
      speakingPaceWpm: 66,
      strengths: [
        'Brave attempt at a full topic',
        'Family vocabulary attempted',
      ],
      fixes: [
        FeedbackFix(
          original: 'My family have four peoples.',
          corrected: 'My family has four people.',
          reasonMm:
              '"family" က ဒီနေရာမှာ singular အနေနဲ့ ယူပါ။ "people" က plural already ဖြစ်တယ် — "peoples" မထည့်ပါ။',
        ),
        FeedbackFix(
          original: 'My father work in factory.',
          corrected: 'My father works at a factory.',
          reasonMm:
              'Third person singular ဆိုရင် verb မှာ "s" ထည့်ပါ (works)။ Workplace ဆိုရင် "at" သုံးပါ။',
        ),
      ],
      nativeRewrite:
          'There are four people in my family. My father works at a factory, and my mother stays at home. I have one younger sister.',
      pronunciationNotes: [
        'Try to slow down between sentences',
        '"works" — make the "s" audible',
      ],
      grammarPatterns: [
        'Subject-verb agreement: add "s" for he/she/it ("works").',
        '"family" takes a singular verb ("has").',
      ],
      interferenceNotes: [
        FeedbackFix(
          original: 'My family have four peoples.',
          corrected: 'My family has four people.',
          reasonMm:
              'မြန်မာလို "လူလေးယောက်" ကို တိုက်ရိုက်ပြန်တာ။ "people" က plural ဖြစ်ပြီးသား — "peoples" မထည့်ပါ။',
        ),
      ],
      vocabUpgrades: [
        VocabUpgrade(
          original: 'stays at home',
          suggestion: 'is a homemaker',
          reasonMm: 'ပိုသဘာဝကျတဲ့ အသုံးအနှုန်းပါ။',
        ),
      ],
      phrases: [
        PhraseSuggestion(
          phrase: 'a close-knit family',
          meaningMm: 'အချင်းချင်း အရမ်းရင်းနှီးတဲ့ မိသားစု။',
          meaningEn: 'a family whose members are very close',
          examples: [
            PhraseExample(
              en: 'We are a close-knit family.',
              mm: 'ကျွန်တော်တို့က ရင်းနှီးတဲ့ မိသားစုပါ။',
            ),
          ],
        ),
        PhraseSuggestion(
          phrase: 'under one roof',
          kind: PhraseKind.idiom,
          meaningMm: 'အိမ်တစ်အိမ်တည်းမှာ အတူနေတယ်။',
          meaningEn: 'living together in the same house',
          examples: [
            PhraseExample(
              en: 'Three generations live under one roof.',
              mm: 'မျိုးဆက်သုံးဆက် အိမ်တစ်အိမ်တည်းမှာ အတူနေကြတယ်။',
            ),
          ],
        ),
      ],
      sentenceRewrites: [
        SentenceRewrite(
          original: 'My father work in factory.',
          rewrite: 'My father works at a factory.',
        ),
      ],
      fillerWords: [
        FillerWord(word: 'um', count: 7),
      ],
      subScores: SubScores(
        grammar: 36,
        vocabulary: 44,
        fluency: 48,
        pronunciation: 42,
      ),
      explanationMm:
          'အခြေခံကို ပြောနိုင်ပါတယ်။ Speaking pace ကို နည်းနည်း ပိုနှေးနှေး ပြောကြည့်ပါ၊ ပိုသေချာစေဖို့ပါ။ Subject-verb agreement (s ထည့်တာ) ကို နောက်တစ်ပတ်ထဲမှာ အာရုံစိုက်ပြီး လေ့ကျင့်ပါ။',
      totalTokens: 1380,
    ),
  ];
}
