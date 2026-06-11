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
- All on-ramps converge on `feedback/feedback_result_page.dart`, which renders
  the version-loop CTAs ("Polish & retry" / "I'm done — see native version").
  (Originally only suggested looped via a "Try this topic again" CTA; the loop
  now covers all three on-ramps — see "The version loop" below.)
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
  - **Collocations + idioms share one `phrases` list** (`PhraseSuggestion`,
    `kind` = collocation|idiom). `_applyRequestedSections` filters that one list
    by `kind` so the two menu toggles stay independent. Each `PhraseSuggestion`
    carries `meaning_mm`/`meaning_en` + `examples[{en,mm}]` so the result-page
    chips are **tap-to-learn** (bottom sheet with meaning + example sentences) —
    a learner who doesn't know "watch the sunrise" can tap to find out. The edge
    function must emit this richer shape (the old bare-string `collocations` +
    meaning-only `idioms` were replaced; `IdiomSuggestion` is gone).
- **"Better word choices" (`vocab_upgrades`) renders on the result page whenever
  non-empty, regardless of schema version.** It's a vocabulary enrichment the
  learner opts into (sibling of phrases), NOT a transcript error category — so it
  is NOT gated behind `showInlineLists` like grammar fixes / interference are.
  (Under v2 the same `vocab` segments are *also* highlighted inline on the Review
  screen; that's a second view, not a replacement. Earlier the inline list was
  wrongly gated and vanished under v2 — don't re-add that gate.)
- All UI strings are **localized via `lib/l10n/intl_en.arb`** (`txtDs*` keys),
  including the choose menu, result page, version loop, and review surfaces.
  **Do not add hardcoded literals** — add a `txtDs*` key and use
  `AppLocalizations.of(context).txtDs…` (the section/preset/group label helpers
  in `choose_feedback_page.dart` take a `BuildContext` for this reason). The
  Burmese (`my`) ARB is not created yet; add it to ship Burmese. AI-returned
  content (`explanation_mm`, `reason_mm`, `meaning_mm`) is already bilingual and
  stays as data. See `daily_speaking_feature.md`.

## The version loop (v1 → v2 → …)

**All three on-ramps** are iterate-and-improve loops. Suggested + own-topic use
the chosen topic; just-talk seeds its loop from the AI's `inferredTopic`
(synthesized into a topic on submit in `DailySpeakingBloc._inferredTopic`; the
first attempt is still pure free-talk, the loop is offered after). The result
page offers **"Polish & retry"** (re-capture the same topic, carrying
`topicAttemptId` + an incremented `revisionNumber`) and **"Done"**.
Polishing a just-talk session routes back through the just-talk recorder (so
`onRamp` stays `just_talk`) with the inferred topic shown as a focus banner. The
loop, audio A/B, and resume-from-history all apply to just-talk too. See
`daily_speaking_feature.md`.

**Native rewrite is no longer a gated reveal.** Under the v2 annotated-transcript
schema each attempt's feedback already carries its own native version
(`sentences[].native`), surfaced in the Review & highlights screen's *Compare*
view. So `FinalRewritePage`/route `dailySpeakingFinalRewrite` was **retired**,
and "Done" simply finishes — showing a local-data progression recap
(`_ProgressionRecap`: v1→v2→… score deltas, no AI call) when the chain has 2+
versions. The reveal isn't "spoiling the answer" because native is regenerated
per attempt; retrying earns a fresh native mirror of the improved attempt.

- Sessions chain via `topicAttemptId` + `revisionNumber` on
  `dailySpeakingSessionTable` (**schema v6**); the id is minted in
  `DailySpeakingBloc._persist` on the first attempt.
- During the loop, whole-rewrite + sentence-rewrite are hidden from the choose
  menu (`kTerminalRevealSections` + `sectionsForMode(includeTerminalReveal:)`) —
  handing over the answer mid-loop turns the retry into copying. They appear
  once, at the terminal reveal, paid for exactly once.
- v2+ results show `_VersionCompareStrip`: the score delta vs the previous
  version, read from local Drift (no tokens).
- NOTE: the `kTerminalRevealSections` menu-hiding (above) predates the v2 schema,
  where native ships in every response regardless of the menu — so it's legacy /
  under review.

## The three on-ramps converge

> **Speaking only — no text input.** This is speaking practice, so the write
> path was retired (route `dailySpeakingWritePath` + `write_path/` deleted). The
> `DailySpeakingInputMode.text` enum value and the result page's "What you wrote"
> branch stay only so any legacy text history row still deserializes/renders;
> nothing creates a text session anymore.
>
> **Import audio is a capture method, not an on-ramp.** Each record page
> (`just_record`, `own_topic_record`, `suggested_topic_record`) offers an
> "Import a recording instead" button under the mic — `widgets/import_audio_sheet.dart`
> (`ImportInsteadButton` + `showImportAudioSheet`). It picks/validates a file
> (format / ≤5 min / ≤25 MB) and returns a local path; the page routes into
> choose-feedback with its **own** `onRamp` + `topic` context, just swapping in
> the imported `audioPath`. So an imported clip on the suggested on-ramp still
> gets the target-phrase checklist. (There is no standalone import on-ramp/route;
> the old `dailySpeakingImportAudio` route + `import_audio/` page were removed.)

```
[ Just talk       ]   [ Own topic ]              [ Suggested topic ]
        │                  │                            │
        │                  ▼                            ▼
        │           own_topic_prep_page     suggested_topic_list_page
        │                  │                            │
        │                  ▼                            ▼
        │           own_topic_record         suggested_topic_prep_page
        │             (voice)                           │
        ▼                  │                            ▼
just_record_page           │                  suggested_topic_record_page
        │                  │                            │
        ▼                  ▼                            ▼
   widgets/session_recorder.dart (5-min hard cap)   (voice)
        │
        ▼
DailySpeakingBloc.submitVoice
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

| On-ramp        | topic carried?                       | targetPhraseResults? | loops? |
|----------------|--------------------------------------|----------------------|--------|
| Just talk      | synthetic from AI `inferredTopic` (`id='inferred'`, saved on submit) | no  | yes (v1 free, then focus banner) |
| Own topic      | synthetic, `id='own'` (saved on submit) | no                | yes    |
| Suggested      | curated topic from bank              | yes                  | yes    |

## Activating the real Gemini path (when the key lands)

Order, exact actions:

1. Add `GEMINI_API_KEY` to the Supabase project secrets — **not** the client
   `.env`. See [[reference-ai-via-supabase-edge-functions]].
2. Deploy `supabase/functions/daily-speaking-review/index.ts` (separate task;
   not in this branch). The function must return JSON matching
   `DailySpeakingFeedback.fromJson` — see the freezed model for the exact
   shape, including snake_case keys via `@JsonKey`. For **voice** sessions it
   must always return `transcript` (the learner's words) — it's core, not gated
   by `requested_sections`; the bloc stores it into `inputText`. See
   "Review the input" in `daily_speaking_feature.md`.
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
