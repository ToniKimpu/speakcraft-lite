import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';

/// Canned `DailySpeakingFeedback` payloads used while the Gemini edge function
/// is not yet deployed. Three variants (high / mid / low score with topic
/// hits) so the result UI is exercised end-to-end without a live API.
///
/// Delete this file once `DailySpeakingService.useStubResponse` flips to
/// `false`.
class DailySpeakingServiceStubs {
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
      collocations: [
        'grab some snacks',
        'browse around',
        'spend time with family',
      ],
      idioms: [
        IdiomSuggestion(
          expression: 'kill time',
          meaningMm: 'အချိန်ဖြုန်းရင်း စောင့်နေတာ',
        ),
        IdiomSuggestion(
          expression: 'now and then',
          meaningMm: 'ရံဖန်ရံခါ',
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
      collocations: [
        'make a mistake',
        'get along with colleagues',
      ],
      idioms: [
        IdiomSuggestion(
          expression: 'have my back',
          meaningMm: 'ကူညီထောက်ပံ့ပေးတယ်',
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
      collocations: [
        'a close-knit family',
      ],
      idioms: [
        IdiomSuggestion(
          expression: 'under one roof',
          meaningMm: 'အိမ်တစ်အိမ်တည်းမှာ အတူနေတယ်',
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
