# Daily Speaking Practice — module guide

Scoped guide for work inside `lib/screens/daily_speaking/`. Read together with
the root `CLAUDE.md`. Companion to `lib/screens/listening_and_shadowing/CLAUDE.md` —
that module is **receptive skill**, this one is **productive skill**.

## Concept

A daily ~3-minute "free talk." Learner records (P1+P2+P3) or writes (P2) a
short monologue and Gemini Flash-Lite (via Supabase edge function) returns
structured feedback: score, level, strengths, fixes, native rewrite, Burmese
`explanation_mm`, and — when a topic was preselected — a checklist of target
phrases (✅ used / ⬜ missed).

## Current state — `feat/daily_speaking_practice` branch

The branch ships a **complete P1 flow** wired to a **stub adapter** so the
full UX (record → submit → result → history → Drift persistence) is testable
end-to-end without the Gemini API.

### What's wired right now

- Home tile → `daily_speaking_entry_page.dart` (3 on-ramp cards; only
  "Just talk" is enabled).
- "Just talk" → `just_record/just_record_page.dart` (mic UI with 5-min cap)
  → spinner ~2s → `feedback/feedback_result_page.dart` (full result UI).
- History accessible via the app-bar icon on the entry page or by re-reading
  Drift on demand.
- `SessionLimitBanner` shows "N of 3 today" derived from Drift rows (decorative
  — real budget is server-side).

### What's stubbed

- `services/daily_speaking/daily_speaking_service.dart` has
  `static const bool useStubResponse = true;`
- 3 canned responses in `daily_speaking_service_stubs.dart` (high / mid / low
  scores) — picked by `input.hashCode % 3` so the result UI is exercised in
  all states.

## Architecture map

```
lib/
  model/daily_speaking/
    daily_speaking_topic.dart        # Topic, vocab, target phrases, difficulty
    daily_speaking_feedback.dart     # what the edge fn must return
    daily_speaking_session.dart      # Drift row class + on-ramp/mode consts
  tables/
    daily_speaking_session_table.dart
  services/daily_speaking/
    daily_speaking_service.dart      # stub <-> real switch
    daily_speaking_service_stubs.dart  # delete when useStubResponse=false
  bloc/daily_speaking/
    daily_speaking_bloc.dart         # submit + persist
    daily_speaking_history_bloc.dart # Drift-backed history, sessionsToday
    daily_speaking_topic_bloc.dart   # loads assets/.../topics.json
  screens/daily_speaking/
    daily_speaking_entry_page.dart   # 3 on-ramps card (P2/P3 disabled)
    just_record/                     # P1 — wired
    own_topic/                       # P2 stub — route registered, UI is placeholder
    write_path/                      # P2 stub
    suggested/                       # P3 stub — topic_bloc already loads JSON
    feedback/                        # P1 — wired; shared by all on-ramps
    history/                         # P1 — wired
    widgets/                         # SessionRecorder + SessionLimitBanner
assets/daily_speaking/
  topics/topics.json                 # seed of 3 topics for the P3 path
```

`DailySpeakingBloc` and `DailySpeakingHistoryBloc` are global singletons (see
`main_providers.dart`). `DailySpeakingTopicBloc` is page-scoped because the
topic bank only matters inside the suggested-topic flow.

## The three on-ramps converge

```
[ Suggested topic ]  (P3, disabled)
[ Own topic       ]  (P2, disabled)
[ Just talk       ]  (P1, ENABLED)
        │
        ▼
*_record_page    (uses widgets/session_recorder.dart, 5-min hard cap)
        │
        ▼
DailySpeakingBloc.submitVoice   →  service.reviewSession(SessionInput.voice(...))
                                    ├─ stub:   one of 3 canned responses
                                    └─ real:   supabase.functions.invoke('daily-speaking-review', ...)
        │
        ▼
Drift insert (history only — NOT the budget source of truth)
        │
        ▼
feedback_result_page (shared by all on-ramps)
```

All on-ramps end up at the same `DailySpeakingSession` Drift row and the same
result screen. Only differences:

| On-ramp        | topic in row?       | targetPhraseResults? |
|----------------|---------------------|----------------------|
| Just talk      | no (inferred field) | no                   |
| Own topic      | user-typed string   | no                   |
| Suggested      | curated topic id    | yes                  |

## Activating the real Gemini path (when the key lands)

Order, exact actions:

1. Add `GEMINI_API_KEY` to the Supabase project secrets — **not** the client
   `.env`. See [[reference-ai-via-supabase-edge-functions]].
2. Deploy `supabase/functions/daily-speaking-review/index.ts` (separate task;
   not in this branch). The function must return JSON matching
   `DailySpeakingFeedback.fromJson` — see the freezed model for the exact
   shape, including snake_case keys via `@JsonKey`.
3. In `services/daily_speaking/daily_speaking_service.dart`, change
   `static const bool useStubResponse = true;` → `false`.
4. Verify `_serializeInput` matches the edge function's expected body shape
   (currently: `on_ramp`, `input_mode`, optional `topic`, plus either
   `audio_base64`+`audio_format` or `text`). Confirm audio format with the
   first live test call — Gemini accepts m4a directly.
5. Delete `services/daily_speaking/daily_speaking_service_stubs.dart` and
   remove the import from the service file.
6. Replace `SessionLimitBanner`'s client-side count with the
   `sessions_remaining` field that the edge function should return.

## Activating P2 / P3

P2 (own-topic + write-path):
- Build out the placeholder screens at `own_topic/*` and `write_path/*`.
- Flip the `enabled: false` on the matching `_OnRampCard` calls in
  `daily_speaking_entry_page.dart`.

P3 (suggested topics):
- Fill out the placeholder screens at `suggested/*`.
- Decide whether to keep the topic bank as a bundled asset or migrate to
  Bunny CDN (mirror `Env.bunnyListeningAPIKey` + a `daily-speaking-topics/`
  bucket folder, swap the loader in `daily_speaking_topic_bloc.dart`).
- Add new topics to `assets/daily_speaking/topics/topics.json`. Each topic
  shape must satisfy `DailySpeakingTopic.fromJson`.

## What's deliberately NOT in this branch

- **Edge function code.** Out of scope until the key exists.
- **Localization keys for daily-speaking strings.** Inline English for now;
  follow the listening module's pattern (it shipped i18n in a follow-up
  commit `a77e811`).
- **Server-side budget enforcement.** Client banner is decorative.
- **Premium gating overlay.** Existing auth flow gates the whole app; no
  extra entry-page wrapper needed here yet.
- **Tests.** Add once the real edge function exists and we know the actual
  response payload to assert against.

## Key files to reference, not copy

- `lib/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart:96-137` —
  the canonical edge-function-invoke pattern this module's BLoC mirrors.
- `lib/tables/ai_sentence_practice_table.dart` — Drift table shape to mirror
  (we deliberately did NOT use `@UseRowClass` here because feedback is stored
  as JSON, so manual row→model mapping in the BLoC keeps Drift and the
  freezed model decoupled).
- `lib/screens/listening_and_shadowing/recording_voice_widgets/recorder.dart`
  — the existing recorder. `SessionRecorder` here is a parallel implementation
  (NOT a wrapper) because: (1) it auto-stops at 5 min, (2) onComplete
  surfaces the path directly without the save-dialog interleave.

## Design principle for this module

> Productive practice + immediate, structured feedback + a Burmese-language
> explanation = the loop. Anything that doesn't deliver one of those three
> shouldn't go here. If a feature only helps consumption, it belongs in
> Listening & Shadowing.
