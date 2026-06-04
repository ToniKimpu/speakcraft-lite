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

## Current state — P1 + P2 + P3 all built behind the stub adapter

`feat/daily_speaking_practice` shipped P1. `feat/daily_speaking_p2_p3`
follows up with P2 (own topic + write path) and P3 (suggested topics with
scaffolding + retry loop). Every on-ramp is now clickable end-to-end against
the stub adapter — no Gemini key needed to walk through the full UX.

### What's wired right now

- Home tile → `daily_speaking_entry_page.dart` — all three cards active
  (greyed only when the daily session quota is exhausted).
- **Just talk** → `just_record/just_record_page.dart` → spinner → result.
- **Own topic** → `own_topic/own_topic_prep_page.dart` (topic textfield + 5
  suggestion chips) → forks via two CTAs:
  - `own_topic/own_topic_record_page.dart` (voice with topic banner pinned)
  - `write_path/write_path_page.dart` (multi-line text, 60–1500 chars)
- **Suggested topic** →
  `suggested/suggested_topic_list_page.dart` (grouped by difficulty —
  Beginner / Intermediate / Advanced; each card shows prompt preview,
  ~target time, target-phrase count) →
  `suggested/suggested_topic_prep_page.dart` (prompt EN+MM, vocab chips with
  tap-to-expand definition popover, target phrase cards, warmup questions)
  → `suggested/suggested_topic_record_page.dart` (recorder with topic
  prompt banner + passive target-phrase chips).
- All on-ramps converge on `feedback/feedback_result_page.dart`. The
  suggested path also passes the `topic` through the route arguments so the
  result page can render a **"Try this topic again"** CTA — only enabled
  when `onRamp == suggested` and `topic != null`, so just-talk / own-topic
  stay terminal.
- History accessible via the app-bar icon on the entry page; persists in
  Drift `dailySpeakingSessionTable` (schema v5).
- `SessionLimitBanner` shows "N of 3 today" derived from Drift rows
  (decorative — real budget is server-side).

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

## "Choose your feedback" step (between capture and the AI call)

After recording/writing, every on-ramp routes to
`feedback/choose_feedback_page.dart` (route `dailySpeakingChooseFeedback`)
**before** submitting. The learner picks which optional sections they want;
the selection becomes `requested_sections` so unrequested sections cost no
tokens. Capture pages no longer submit directly — the choose screen owns the
submit + spinner + success navigation.

- Catalog/presets/defaults: `model/daily_speaking/feedback_section.dart`
  (single source of truth for the section keys — they're the wire contract).
- Defaults persist in `shared_preferences` under `ds_feedback_sections`.
- Voice-only options (pronunciation, filler words) auto-hide on the write path.
- The stub (`daily_speaking_service.dart#_applyRequestedSections`) blanks any
  field whose section wasn't requested, mirroring what the real edge function
  must do. The edge function MUST read `requested_sections` and emit only those.
- Section/preset/group **labels are inline English** in the choose + result
  pages (localize later). See `daily_speaking_feature.md` for the full design.

## The version loop (v1 → v2 → …)

Suggested + own-topic are iterate-and-improve loops; just-talk stays one-shot.
The result page offers **"Polish & retry"** (re-capture the same topic, carrying
`topicAttemptId` + an incremented `revisionNumber`) and **"I'm done — see native
version"** (`feedback/final_rewrite_page.dart`, route `dailySpeakingFinalRewrite`).

- Sessions chain via `topicAttemptId` + `revisionNumber` on
  `dailySpeakingSessionTable` (**schema v6**); the id is minted in
  `DailySpeakingBloc._persist` on the first attempt.
- During the loop, whole-rewrite + sentence-rewrite are hidden from the choose
  menu (`kTerminalRevealSections` + `sectionsForMode(includeTerminalReveal:)`) —
  handing over the answer mid-loop turns the retry into copying. They appear
  once, at the terminal reveal, paid for exactly once.
- v2+ results show `_VersionCompareStrip`: the score delta vs the previous
  version, read from local Drift (no tokens).
- The terminal reveal makes a rewrite-only `reviewSession` call **directly** (not
  via the bloc) and does **not** persist a history row. See
  `daily_speaking_feature.md` ("The version loop") for the rationale + deviations.

## The three on-ramps converge

```
[ Just talk       ]   [ Own topic ]                  [ Suggested topic ]
        │                  │                                 │
        │                  ▼                                 ▼
        │           own_topic_prep_page          suggested_topic_list_page
        │                  │                                 │
        │           ┌──────┴──────┐                          ▼
        │           ▼             ▼                  suggested_topic_prep_page
        │   own_topic_record  write_path_page                │
        │     (voice)          (text input)                  ▼
        │           │             │                  suggested_topic_record_page
        ▼           │             │                          │
just_record_page    │             │                          │
        │           │             │                          │
        ▼           ▼             ▼                          ▼
   widgets/session_recorder.dart (5-min hard cap)   (voice)
        │
        ▼
DailySpeakingBloc.submitVoice / submitText
        │
        ▼
DailySpeakingService.reviewSession
   ├─ stub:   one of 3 canned responses (high/mid/low)
   └─ real:   supabase.functions.invoke('daily-speaking-review', ...)
        │
        ▼
Drift insert  (DailySpeakingSessionTable — history only, NOT budget)
        │
        ▼
feedback_result_page (shared)
   ├─ target_phrase_checklist  iff feedback.targetPhraseResults.isNotEmpty
   └─ "Try this topic again"   iff route arg `topic != null` AND
                                   session.onRamp == suggested
```

All on-ramps end up at the same `DailySpeakingSession` Drift row and the same
result screen. The differences are entirely in route arguments and what the
feedback payload happens to include:

| On-ramp        | topic carried?            | targetPhraseResults? | retry button? |
|----------------|---------------------------|----------------------|---------------|
| Just talk      | none (inferred by Gemini) | no                   | no            |
| Own topic      | synthetic, `id='own'`     | no                   | no            |
| Suggested      | curated topic from bank   | yes                  | yes           |

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

## Topic bank — where it lives

Currently bundled at `assets/daily_speaking/topics/topics.json` and loaded
by `DailySpeakingTopicBloc`. Add new topics here — each entry must satisfy
`DailySpeakingTopic.fromJson` (snake_case keys, see the freezed model).

When the bank grows past ~50 entries, migrate to Bunny CDN: mirror the
listening JSON pattern (`Env.bunnyListeningAPIKey` style key, new bucket
folder `daily-speaking-topics/`) and swap `_loadFromAssets` in
`daily_speaking_topic_bloc.dart`. The `DailySpeakingTopic` model doesn't
change.

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
