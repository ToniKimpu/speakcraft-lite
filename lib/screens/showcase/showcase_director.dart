/// Timing + content "score sheet" for the auto-playing ad showcase.
///
/// Everything that defines WHEN something happens lives here so the host
/// ([ShowcasePage]) and the individual scenes read from one source of truth.
/// All times are in **seconds from the start of the loop**. The whole reel is
/// driven by a single [AnimationController] of [kShowcaseDuration] seconds, so
/// playback is frame-perfect and deterministic — ideal for screen recording.
library;

import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/subtitle_word.dart';

/// The ordered scenes of the reel.
enum ShowcaseScene { hook, home, lessonHub, shadowing, takeaways, record, cta }

/// Total reel length. The host controller runs 0 → this, then loops.
const double kShowcaseDuration = 31.0;

/// Cross-fade window (seconds) between consecutive scenes. Because scene
/// windows are contiguous (one's end == the next's start), the outgoing scene's
/// fade-out overlaps the incoming scene's fade-in, giving a clean dissolve.
const double kCrossfade = 0.5;

/// A scene's [start, end) slot on the master timeline.
class SceneWindow {
  const SceneWindow(this.scene, this.start, this.end);
  final ShowcaseScene scene;
  final double start;
  final double end;
  double get duration => end - start;
}

/// Contiguous scene windows. Keep them touching (no gaps) so the cross-fade
/// math in the host produces a continuous dissolve.
const List<SceneWindow> kSceneWindows = [
  SceneWindow(ShowcaseScene.hook, 0.0, 3.0),
  SceneWindow(ShowcaseScene.home, 3.0, 7.0),
  SceneWindow(ShowcaseScene.lessonHub, 7.0, 11.0),
  SceneWindow(ShowcaseScene.shadowing, 11.0, 19.0),
  SceneWindow(ShowcaseScene.takeaways, 19.0, 23.0),
  SceneWindow(ShowcaseScene.record, 23.0, 28.0),
  SceneWindow(ShowcaseScene.cta, 28.0, kShowcaseDuration),
];

/// Bilingual caption for a scene (English headline + Myanmar support line).
class SceneCaption {
  const SceneCaption(this.en, this.mm);
  final String en;
  final String mm;
}

const Map<ShowcaseScene, SceneCaption> kCaptions = {
  ShowcaseScene.hook: SceneCaption(
    'Speak English with confidence',
    'ယုံကြည်မှုအပြည့်နဲ့ အင်္ဂလိပ်စကားပြောပါ',
  ),
  ShowcaseScene.home: SceneCaption(
    'Your daily English coach',
    'သင့်ရဲ့ နေ့စဉ် အင်္ဂလိပ်စာ နည်းပြ',
  ),
  ShowcaseScene.lessonHub: SceneCaption(
    'A guided path for every video',
    'ဗီဒီယိုတိုင်းအတွက် အဆင့်ဆင့် လမ်းညွှန်',
  ),
  ShowcaseScene.shadowing: SceneCaption(
    'Shadow real videos — word by word',
    'တကယ့်ဗီဒီယိုတွေကို စာလုံးလိုက် လိုက်ဆိုပါ',
  ),
  ShowcaseScene.takeaways: SceneCaption(
    'Lock in the key words & phrases',
    'အရေးကြီးတဲ့ စကားလုံးတွေ မှတ်သားပါ',
  ),
  ShowcaseScene.record: SceneCaption(
    'Record yourself. Hear your progress.',
    'ကိုယ့်အသံ ဖမ်းပြီး တိုးတက်မှုကို နားထောင်ပါ',
  ),
  ShowcaseScene.cta: SceneCaption(
    'Start speaking today',
    'ဒီနေ့ပဲ စတင်ပြောဆိုလိုက်ပါ',
  ),
};

/// Clamped, normalized progress of [t] within the window [a, b] → 0..1.
/// The workhorse for all per-scene sub-animations.
double seg(double t, double a, double b) =>
    b <= a ? (t >= b ? 1.0 : 0.0) : ((t - a) / (b - a)).clamp(0.0, 1.0);

/// The canned sentence used for the karaoke "shadow" scene. Word timings are
/// 0-based seconds; the scene feeds an animated position into the real
/// [HighlightBackground] painter so the highlight is identical to production.
SubtitleLine cannedShadowLine() => SubtitleLine(
      id: 'showcase-1',
      start: 0.5,
      end: 4.7,
      text: "I've been working on my pronunciation every single day.",
      burmese: 'ငါ နေ့တိုင်း အသံထွက်ကို လေ့ကျင့်နေတာ ကြာပြီ။',
      words: [
        SubtitleWord(word: "I've", start: 0.5, end: 0.85, score: 1),
        SubtitleWord(word: 'been', start: 0.85, end: 1.15, score: 1),
        SubtitleWord(word: 'working', start: 1.15, end: 1.6, score: 1),
        SubtitleWord(word: 'on', start: 1.6, end: 1.85, score: 1),
        SubtitleWord(word: 'my', start: 1.85, end: 2.15, score: 1),
        SubtitleWord(word: 'pronunciation', start: 2.15, end: 3.1, score: 1),
        SubtitleWord(word: 'every', start: 3.1, end: 3.5, score: 1),
        SubtitleWord(word: 'single', start: 3.5, end: 3.95, score: 1),
        SubtitleWord(word: 'day.', start: 3.95, end: 4.5, score: 1),
      ],
    );

/// When (scene-local seconds) the karaoke fill begins. Gives the video frame a
/// beat to settle before the highlight sweeps.
const double kShadowKaraokeStart = 1.2;

/// Vocabulary chips revealed one-by-one in the Key Takeaways scene.
class TakeawayChip {
  const TakeawayChip(this.word, this.gloss);
  final String word;
  final String gloss;
}

const List<TakeawayChip> kTakeawayChips = [
  TakeawayChip('pronunciation', 'အသံထွက်'),
  TakeawayChip('fluent', 'ကျွမ်းကျင်စွာ ပြောနိုင်'),
  TakeawayChip('confident', 'ယုံကြည်မှုရှိ'),
  TakeawayChip('every single day', 'နေ့စဉ်မပျက်'),
];
