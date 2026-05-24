# Listening & Shadowing — Learner Feedback Roadmap

Scoped guide for work inside `lib/screens/listening_and_shadowing/`. Read together with the root `CLAUDE.md`.

## Current state (as of 2026-05-23)

Entry: `listening_list_page.dart` → `sheets/actions_bottom_sheet.dart` opens one of four modes:

1. **Watch** — `youtube_video_page.dart` + `widgets/subtitle_pager.dart`
2. **View Explanation** — `sentence_explanation_*.dart` (Bunny CDN JSON)
3. **Shadowing** — `shadowing_page.dart` (karaoke highlight, 60fps via `Ticker` extrapolation)
4. **Record & Compare** — `speech_practice_session_page.dart` + `recording_voice_widgets/`

**The gap:** users can record themselves but get **zero feedback**. No transcript, no score, no "you missed this word." Everything else is content consumption. The roadmap below closes that loop.

## Pre-requisite (BLOCKING for #1, #2, #4)

User does **not** have an OpenAI / Whisper API key yet. Before starting #1:
- User obtains an OpenAI API key.
- Add to `.envs/.env.dev` and `.envs/.env.prod` as `OPENAI_API_KEY=…`
- Expose via `lib/config/env.dart` (follow existing `Env.bunnyListeningAPIKey` pattern).
- Never commit the key. Never log it.

#3 (playback speed) has no API dependency — can be done anytime.

## Home screen scope (v1)

For v1 the app is **focused on Listening & Shadowing as the headline feature.** Other modules are deprioritized but not deleted:

- **`lib/screens/main/home_screen.dart`** — the "Useful Spoken Patterns" card is commented out (not deleted) with a `// HIDDEN for V1` note. Restore it when v2 broadens scope. Bookmarks card stays — it complements Listening (saved vocab from subtitles will land there).
- Do not add new home-screen cards while we're in v1.
- Routes for the hidden module (`PmpRoutes.dayList` and friends) remain wired — nothing else in the codebase needs to change.

## Roadmap — build in this order

### #3 — Playback speed control on shadowing (DO FIRST, ~1–2 hrs)
Isolated, no backend, big UX win for beginners.

- `shadowing_page.dart` + `shadowing_widgets/shadowing_player.dart`
- YouTube iframe supports 0.5 / 0.75 / 1.0 / 1.25 / 1.5 via `_controller.setPlaybackRate(double)` (check `youtube_player_flutter` API).
- Add a small speed chip/dropdown in the player controls. Persist last-used speed in `GlobalAppState` or `SharedPreferences`.

### #1 — Whisper-based speech feedback (the main feature)
1 Whisper call per saved recording. ~$0.001/sentence. **#2 piggybacks on the same call.**

Files to create:
- `lib/services/whisper_service.dart` — single method `Future<String> transcribe(File audioFile, {String language = 'en'})`. Calls `https://api.openai.com/v1/audio/transcriptions` with `model=whisper-1`, multipart upload, Bearer auth. Upload the `.m4a` (or `.mp4` audio track) directly — Whisper accepts both. 25 MB limit (we're well under).
- `lib/screens/listening_and_shadowing/utils/pronunciation_score.dart` — pure function `score(target, transcript) → { score:0-100, missedWords:[], addedWords:[], wrongWords:[] }`. Use word-level Levenshtein / WER. No deps.
- `lib/bloc/sentence_score/sentence_score_bloc.dart` — freezed bloc holding `idle | transcribing | scored(result) | error(message)`. Follow existing bloc pattern in `lib/bloc/`.

Files to modify:
- `speech_practice_session_page.dart` — after `Recorder.onStop` saves audio file, fire `SentenceScoreEvent.score(audioPath, targetText)`. Show inline result.
- `dialogs/save_recording_dialog.dart` — display score + word diff after save (target sentence with missed words struck-through, wrong words highlighted).
- `recording_voice_widgets/user_recorded_list.dart` — add score chip per row.

Cost guard: debounce / dedupe so we don't transcribe twice if user double-taps save. Show a "transcribing…" spinner.

### #2 — Sentence mastery tracking (piggybacks on #1)
**No additional Whisper cost.** Pure local persistence + a query screen.

Files to create:
- `lib/tables/sentence_practice_score_table.dart` — Drift table:
  ```
  youtubeId TEXT, sentenceId TEXT, bestScore INT, attemptCount INT,
  lastPracticedAt INT, bestTranscript TEXT, PRIMARY KEY (youtubeId, sentenceId)
  ```
  Mirror the structure of `AiSentencePracticeTable` / `ListeningPracticeAnswerTable`.
  **Run** `fvm dart run build_runner build --delete-conflicting-outputs` after adding.
- `lib/screens/listening_and_shadowing/weak_sentences_page.dart` — queries `bestScore < 70`, lists them grouped by listening. Tap → jump straight into `speech_practice_session_page` at that sentence.

Files to modify:
- `speech_practice_session_page.dart` — after score is computed (#1), upsert into the Drift table (keep max of old/new score, increment attemptCount).
- `sheets/actions_bottom_sheet.dart` — add a 5th action: "Practice weak sentences" → opens `weak_sentences_page`.
- `recording_voice_widgets/user_recorded_list.dart` — show attempt count + best score per sentence header.

### #4 — Slow-loop drill mode (last)
State machine on top of existing recorder. 1 Whisper call per loop iteration (~$0.005 per 5-rep drill session — fine).

Files to create:
- `lib/screens/listening_and_shadowing/utils/drill_loop_controller.dart` — pure Dart class managing phases:
  ```
  enum DrillPhase { idle, playTarget, waitSilence, recording, playRecording, replayTarget }
  ```
  Owns one `Timer` for the silence gap (= sentence duration). Calls into YouTube controller + audio recorder + audio player via injected callbacks. No widgets, fully unit-testable.

Files to modify:
- `speech_practice_session_page.dart` — add a "Drill" toggle near the recorder. When on, replace manual buttons with the drill controller. Reuses existing `_controller`, `_audioRecorder`, `_audioPlayer`. The page already manually pauses at `_endDuration` (line 116) — that logic moves into the drill controller's `playTarget` phase.
- `recording_voice_widgets/recorder.dart` — add an `autoMode` flag so the drill controller can start/stop programmatically without the manual record UI.

## v2 — UX consolidation (after v1 feedback loop is shipped)

**Problem with the current four-button bottom sheet** (`sheets/actions_bottom_sheet.dart`): Watch / View Explanation / Shadowing / Record & Compare presents the user with four pre-commitments before they've even seen the content. Watch and Shadowing overlap heavily, "Shadowing" is jargon, "Record & Compare" overpromises, the flows are siloed (can't jump from a hard sentence in Watch into Explain or Record without backing out), and there's no resume-where-you-left-off.

**v2 direction — one unified player, per-sentence actions:**

- Tap a video → goes directly into a single player screen (no bottom sheet menu, or at most a "Start" vs "Resume" choice).
- Layout: video at top, karaoke-highlighted subtitles in the middle (always on, no more "highlight type" toggle), per-sentence action bar at the bottom:

  ```
  [1.0x speed]  [🎤 Record this]  [💡 Explain this]  [🔁 Drill loop]
  ```

- "Mode" becomes a per-sentence choice inside the player, not a pre-commitment at the menu. User stays in flow.
- Sentence-level state (current score from #2, attempt count, last-practiced-at) shown inline next to each sentence so progress is visible while practicing.
- Resume: persist `{listeningId, lastSentenceIndex}` per user on every sentence change; show "Resume at sentence 7" on the listening list row.

**Files that would change in v2 (rough sketch — don't start until v1 is shipped):**

- `sheets/actions_bottom_sheet.dart` — collapse to a single "Start / Resume" entry, or remove entirely (list row taps go straight to the player).
- `listening_list_page.dart` — each list row shows progress (e.g. "7/12 sentences practiced, avg 78"), tap goes straight to player.
- New: `lib/screens/listening_and_shadowing/unified_player_page.dart` — the merged screen. Reuses `shadowing_widgets/shadowing_player.dart`, the karaoke highlights from `shadowing_page.dart`, the recorder from `recording_voice_widgets/`, and pulls explanations inline (bottom sheet from the action bar, not a separate screen).
- `shadowing_page.dart`, `youtube_video_page.dart`, `speech_practice_session_page.dart` — eventually deleted once unified player covers them. Keep around during transition until parity is proven.

**Why wait?** The unified player is a UX bet; building it on top of a broken feedback loop hides whether the loop itself is working. Ship #1+#2+#3 inside the current screens first — if learners engage, then it's safe to invest in the v2 rewrite.

## What we explicitly decided AGAINST for v1

- **Selfie video recording.** Files would be ~18–90 MB/min even at 480p; mostly redundant with audio + transcript feedback. Revisit only if learners ask.
- **Screen recording** (capture YouTube + face into one mp4). Android `MediaProjection` permission prompt every time, YouTube audio capture unreliable, ToS grey area. Not worth it.
- **Per-phoneme pronunciation scoring.** Whisper transcript diffing is "good enough"; phoneme analysis is a much harder problem and not where the biggest learning gains are.
- **More highlight type variants.** Three is enough.
- **More content-consumption surface area** before the feedback loop is closed.

## Whisper cost cheat sheet

- Pricing: $0.006 per minute of **audio duration** (not file size, not format).
- A typical shadowing sentence ≈ 5–10 sec → ~$0.001 per attempt.
- 1000 users × 50 attempts/day ≈ $300/day. Plan accordingly before public launch.
- Sending `.mp4` vs `.m4a` vs `.mp3` = same cost. Whisper strips video server-side.
- If a clip ever approaches 25 MB, strip the video stream with `ffmpeg_kit_flutter` (`-vn -acodec copy`, ~100ms, no re-encode). Adds ~10–40 MB to APK — only add if needed.

## Design principle for this module

> Learners improve when they get **immediate, specific, actionable feedback on their own output**, and can drill the parts they're weak on. Every feature here should either deliver that feedback or shorten the loop to it.

If a proposed feature doesn't do one of those two things, push back before building.
