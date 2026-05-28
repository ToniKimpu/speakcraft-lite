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
      explanationMm:
          'အလုပ်အကြောင်း ပြောတဲ့ vocabulary တွေ ကောင်းပါတယ်။ Grammar အပိုင်းမှာ singular/plural နဲ့ present perfect tense ကို ပိုဂရုစိုက်ပါ။ နောက်တစ်ခါ "for/since" ကိုလည်း ပြန်လေ့လာကြည့်ပါ။',
      totalTokens: 1640,
    ),
    const DailySpeakingFeedback(
      score: 42,
      level: CefrLevel.elementary,
      inferredTopic: 'My family',
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
      explanationMm:
          'အခြေခံကို ပြောနိုင်ပါတယ်။ Speaking pace ကို နည်းနည်း ပိုနှေးနှေး ပြောကြည့်ပါ၊ ပိုသေချာစေဖို့ပါ။ Subject-verb agreement (s ထည့်တာ) ကို နောက်တစ်ပတ်ထဲမှာ အာရုံစိုက်ပြီး လေ့ကျင့်ပါ။',
      totalTokens: 1380,
    ),
  ];
}
