# Promo reel (showcase) — how to record the ad

An auto-playing, self-contained marketing reel built from the app's own design
system. Point a screen recorder at it and capture one ~31-second loop.

## What it is

- A single route, `PmpRoutes.showcasePage` (`/showcase`), driven by one
  `AnimationController` of `kShowcaseDuration` (31s) → deterministic, no network,
  loops forever.
- Seven scenes: Hook → Home + streak → Lesson hub → **Shadowing karaoke**
  (the real `HighlightBackground` painter) → Key takeaways → Record & compare →
  CTA + confetti.
- Bilingual captions (EN + Myanmar) in the lower third.
- **Mock data only** — nothing pulls from Supabase/YouTube/Bunny.

## How to open it

Debug builds only: **Profile → "Play promo reel (debug)"** (the entry is wrapped
in a `kDebugMode` guard, so it never ships in release).

It starts immediately in immersive mode (no status/nav bars). Tap once to reveal
play/pause, restart and close controls for 3 seconds.

## Editing the reel

Everything timing/content lives in `showcase_director.dart`:

- `kSceneWindows` — each scene's `[start, end)` in seconds. Keep them contiguous
  (one's `end` == the next's `start`) so the cross-fade stays continuous.
- `kCaptions` — the bilingual headline per scene.
- `cannedShadowLine()` — the karaoke sentence + per-word timings.
- `kTakeawayChips` — the vocab cards.

Each scene widget (`widgets/scenes/*.dart`) receives `t` = seconds since that
scene became active, and animates off it via the `seg(...)` helper +
`FadeRise` / `FadePop` in `widgets/showcase_fx.dart`.

## Recording tips

- **Build:** run a `--release` (or at least profile) build for smooth 60fps and
  no debug banner. The debug entry still appears in profile builds.
- **Device:** record on a real phone or an emulator at its native resolution.
- **Vertical:** target 1080×1920 (Reels/TikTok/Shorts). A 9:19.5 phone screen
  crops cleanly; record the whole screen — the reel is already full-bleed.
- **Capture:** Android built-in screen recorder, `adb shell screenrecord`, or
  `scrcpy --record reel.mp4`. Start the recorder, open the reel, let one full
  loop play, then trim to a single 0→31s pass in any editor (CapCut / DaVinci).
- **Audio:** the reel is silent by design — add music + a voiceover in the
  editor so you control the mix.

## Not for end users

This screen is a production tool. The only entry point is the debug-gated
Profile shortcut; there is no user-facing navigation to it.
