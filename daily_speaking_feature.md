# Daily Speaking — "Choose your feedback" feature

Design spec for letting a learner pick **what kind of feedback** they want
*after* recording/writing and *before* the AI call. Turns a fixed report into a
focused coaching session and naturally controls token cost per request.

> Status: **design approved, not yet built.** No free/premium gating — every
> learner gets the full menu. Some options are pre-selected (a "recommended"
> default set); the learner can add or remove any of them.

## Flow

```
Record (voice ≤5min)  /  Write (text)
        │
        ▼ stop / done
┌─────────────────────────────────┐
│   Choose your feedback          │   ← NEW screen, shared by all on-ramps
│                                 │
│   [Recommended] [Sound natural] │   preset cards (one-tap, apply a bundle)
│   [Grammar focus] [Everything]  │
│                                 │
│   ▸ Customize  (grouped list,   │
│     defaults pre-ticked,        │
│     fully editable)             │
│                                 │
│   ⚡ cost hint · [Get feedback] │
└─────────────────────────────────┘
        │  requested_sections: [...]
        ▼
DailySpeakingBloc.submit(input, sections)
        ▼  edge fn builds prompt from sections only
Result page → renders only the requested sections
```

- Screen sits **after capture, before send**, so the choice is made with the
  content fresh.
- Voice-only options (pace/pauses, filler words, pronunciation) **auto-hide on
  the write path**.
- A preset card just applies a bundle to the checklist; the learner can still
  open Customize and tweak. Selection state is what gets submitted.

## The feedback menu

Always-on core (never a toggle, cheap, orienting): **score, CEFR level,
strengths, Burmese summary.**

Pre-selected defaults are marked ✓ (the "Recommended" preset). Everything is
available to everyone.

### 1. Accuracy
| Option | Default | Cost | Notes |
|---|:--:|:--:|---|
| Sentence fixes (original → corrected + Burmese reason) | ✓ | ⚡ | exists today as `fixes` |
| Grouped grammar patterns (tenses / articles / S-V agreement) |  | ⚡⚡ | shows recurring patterns, not one-offs |
| Burmese-interference errors (direct MM→EN translations) |  | ⚡⚡ | high value for this audience |

### 2. Vocabulary
| Option | Default | Cost | Notes |
|---|:--:|:--:|---|
| Better word choices (basic → precise) | ✓ | ⚡⚡ |  |
| Collocations (natural word pairings) |  | ⚡⚡ |  |
| Idioms & phrasal verbs |  | ⚡⚡ | 2–3 they could have used |
| Repetition / range |  | ⚡ | flags overused words |

### 3. Style & naturalness
| Option | Default | Cost | Notes |
|---|:--:|:--:|---|
| Whole rewrite (one polished version) | ✓ | ⚡⚡ | exists today as `nativeRewrite` |
| Sentence-by-sentence rewrite |  | ⚡⚡⚡ | granular; most expensive |
| Register / tone (casual vs professional) |  | ⚡⚡ |  |
| Flow & connectors (cohesion, filler) |  | ⚡⚡ |  |

### 4. Delivery — voice only
| Option | Default | Cost | Notes |
|---|:--:|:--:|---|
| Pronunciation notes |  | ⚡ | exists today as `pronunciationNotes` |
| Pace & pauses |  | ⚡ | wpm exists; add hesitation/long-pause flags |
| Filler words (um / uh / like count) |  | ⚡ |  |

### 5. Content & structure
| Option | Default | Cost | Notes |
|---|:--:|:--:|---|
| Structure (beginning / middle / end) |  | ⚡⚡ |  |
| Depth / idea development |  | ⚡⚡ | "stated the fact, gave no reason/example" |
| On-topic relevance |  | ⚡ | only on suggested / own-topic paths |

### 6. Progress & scoring
| Option | Default | Cost | Notes |
|---|:--:|:--:|---|
| Sub-scores (grammar / vocab / fluency / pron) |  | ⚡⚡ |  |
| "Reach the next CEFR level" tips |  | ⚡ |  |
| Compare to last session |  | ⚡ | from local Drift history, no extra tokens |

## Presets (each applies a bundle to the checklist)

- **Recommended** *(default on open)* — core + sentence fixes + better word
  choices + whole rewrite. Balanced, medium cost.
- **Sound more natural** — vocab upgrades, collocations, idioms, sentence
  rewrites, whole rewrite, register/tone.
- **Grammar focus** — grouped grammar patterns, Burmese-interference, sentence
  fixes, sub-scores.
- **Everything** — all options applicable to the input type.

## Build status (implemented)

Shipped on `feat/daily_speaking_p2_p3`:

- `model/daily_speaking/feedback_section.dart` — catalog of 11 selectable
  sections + presets + defaults (single source of truth for keys).
- `DailySpeakingFeedback` extended with the new optional fields
  (`vocabUpgrades`, `collocations`, `idioms`, `grammarPatterns`,
  `interferenceNotes`, `sentenceRewrites`, `fillerWords`, `subScores`).
- `requested_sections` threaded through `SessionInput` → bloc events →
  `_serializeInput`; the stub honors the selection (blanks unrequested fields).
- `feedback/choose_feedback_page.dart` — presets + grouped checklist, defaults
  in `shared_preferences` (`ds_feedback_sections`), voice-only auto-hide.
- All four capture pages now navigate to the choose screen (route
  `dailySpeakingChooseFeedback`) instead of submitting directly; the choose
  screen owns submit + spinner + success nav.
- Result page renders all new sections (skill bars, vocab upgrades,
  collocations/filler chips, idioms, sentence rewrites, grammar patterns,
  Burmese-interference cards).

Notes / deferred:

- The menu currently exposes 11 sections. The doc's fuller list (repetition,
  register/tone, flow, pace/pauses, structure, depth, relevance, next-level,
  compare-to-last) is **reserved** — add the catalog entry + model field +
  result widget when wanted.
- ~~New screen/section labels are inline English (not in the ARB).~~
  **DONE:** all daily-speaking UI strings were migrated into `intl_en.arb`
  (`txtDs*` keys); no hardcoded literals remain. Add an `intl_my.arb` to ship
  Burmese. New strings must use `l10n`, never literals.
- Edge function must read `requested_sections` and only emit those sections.

## Build impact (original plan)

- **New screen** `feedback/choose_feedback_page.dart`, shared by all four
  capture exits (just-talk, own-topic voice, write path, suggested record).
- **Request contract** gains `requested_sections: [...]`; `_serializeInput`
  carries it; the edge fn builds the prompt conditionally so only requested
  sections cost tokens.
- **Model** `DailySpeakingFeedback` grows optional fields for the new sections
  (collocations, idioms, grouped grammar, sub-scores, filler count,
  comparison). All `@Default` empty → the result page's existing "render
  section iff non-empty" pattern handles partial payloads with little rework.
- **Stub adapter** extended to honor `requested_sections` so the new screen is
  walkable before the Gemini key lands.
- **Defaults persistence**: remember the learner's last selection on-device
  (see Storage below).

## Storage decision

- **Session history + feedback**: stays in **local Drift**
  (`dailySpeakingSessionTable`). The app already enforces a single-device lock,
  which removes the main reason to sync history across devices.
- **Feedback-option defaults / last-used selection**: on-device only (small
  preference, not worth a server round-trip).
- **Server-side logging** (which sections were requested, token spend, budget):
  belongs in the **edge function** when the Gemini key lands — server writes,
  not client writes. No client→Supabase work needed now.

> Net: **local-only on the client for now.** Revisit a Supabase mirror only if
> we later want cross-device history or product analytics that the edge
> function can't cover.

---

# The version loop (v1 → v2 → v3 …)

Design spec for turning the one-shot "Try this topic again" button into a real
**iterate-and-improve loop**. The learner records on a topic (v1), gets
*coaching* feedback, polishes, retries (v2), and watches their score climb —
the productive-skill core loop made visible and rewarding.

> Status: **implemented** on `feat/daily_speaking_p2_p3` (behind the stub).
> Decisions: **(1) whole-rewrite is a terminal reveal** — hidden during
> iterations, shown once at the end.
>
> **UPDATE (superseded):** the loop was originally suggested + own-topic only,
> with just-talk terminal. **All three on-ramps now loop** — just-talk seeds its
> loop from the AI's `inferredTopic` (synthesized into a topic on submit; see
> `DailySpeakingBloc._inferredTopic`). The first just-talk attempt is still pure
> free-talk; the loop is offered after. So `_supportsLoop` is now always true,
> the rewrite is hidden from every on-ramp's menu, and just-talk gets the same
> Polish & retry / terminal reveal / ✨ re-view as the others. References below
> to "just-talk stays terminal / keeps the rewrite" reflect the old design.

## Why rewrite must be a terminal reveal (the duplicate problem)

The feedback menu mixes two philosophies:

- **Coach me** — sentence fixes, grammar patterns, what-to-improve,
  Burmese-interference. These give the learner *work to do*.
- **Give me the answer** — whole rewrite, sentence-by-sentence rewrite. These
  hand over the finished version.

A retry loop only works with the **coach-me** half. If v1's feedback already
contains the whole rewrite, v2 has nothing left to do but retype the AI's
paragraph — it becomes parroting, and the "improvement" is just the rewrite
echoed back (the duplicate). So:

- **During iterations (v1…vN):** rewrite + sentence-rewrite are **hidden** from
  the choose-feedback menu. The learner gets coaching only.
- **At the end** (learner taps **"I'm done with this topic"**): the whole
  rewrite is **revealed once** as a "compare your best effort to a native
  version" payoff. Pedagogically stronger and kills the duplication.

## Flow

```
Suggested / own-topic prep
        │
        ▼ record (v1)
   Choose feedback  (coaching options; rewrite hidden)
        │
        ▼
   Result (v1)  ──►  [ Polish & retry ]   [ I'm done with this topic ]
        │                   │                        │
        │                   ▼                        ▼
        │            record (v2)              ✨ Whole-rewrite reveal
        │            Choose feedback                 "compare to your v_last"
        │            + "Compare to v1"               (terminal screen)
        │                   │
        └───────◄───────────┘   loop until "I'm done"
```

- **Just talk**: loops too (see UPDATE above) — v1 is free-talk, then the AI's
  inferred topic carries forward as a focus banner in the just-talk recorder.
- Each retry carries the **same topic** forward (already wired for suggested;
  own-topic reuses its synthetic `id='own'` topic).

## What changes per revision

- **Menu is context-aware.** First attempt (v1) = current default set.
  Revisions (v2+) = same coaching options, but **rewrite / sentence-rewrite
  removed**, and the reserved **"Compare to last session"** section becomes
  the natural default (it's free — computed from local Drift history, no extra
  tokens). The version loop is exactly the trigger that reserved section was
  waiting for.
- **Result header** shows `v2 · compare to v1`: the score delta
  (e.g. 64 → 78), and a "you addressed 3 of 5 flagged sentences" line derived
  by diffing v(n-1)'s `fixes` against vN's text.

## Data model

Sessions chain instead of standing alone. Add to
`dailySpeakingSessionTable` (→ Drift schema bump):

- `topicAttemptId` (String) — shared across every version of one attempt;
  generated when v1 starts.
- `revisionNumber` (int) — 1 for v1, 2 for v2, … rendered as `v{n}`.

`DailySpeakingSession` (the row class) grows the same two fields. v1 mints a
fresh `topicAttemptId`; "Polish & retry" forwards it + `revisionNumber + 1`
through the route args alongside the existing `topic`. History can then group
a chain under its topic and show the climb.

> Local-only, consistent with the storage decision above — no Supabase work.

## Build impact (when we code it)

- **Drift**: two columns + schema migration; mirror in the row class + BLoC
  insert.
- **Route args**: `topicAttemptId` + `revisionNumber` threaded from result →
  prep/record → choose → result (extend, don't restructure — same pattern the
  `topic` arg already follows).
- **Choose screen**: hide rewrite/sentence-rewrite + default-on compare-to-last
  when `revisionNumber > 1`. Small `sectionsForMode`-style branch.
- **Result page**: version header + delta strip (`if revisionNumber > 1`); add
  the **"Polish & retry"** + **"I'm done"** CTAs (suggested/own-topic only;
  gated like the existing "Try this topic again").
- **Terminal reveal**: a lightweight final screen (or result variant) that
  shows only the whole rewrite + side-by-side with the learner's last version.
- **Reserved → wired**: implement the "Compare to last session" catalog entry +
  model field + result widget (was reserved; the loop activates it).

## Build status (implemented) — and where it differs from the plan

Shipped pieces:

- **Data**: `dailySpeakingSessionTable` gained `topicAttemptId` (nullable) +
  `revisionNumber` (default 1); Drift schema **v5 → v6** with an `addColumn`
  migration (old rows become standalone v1s). Mirrored on `DailySpeakingSession`
  and through `DailySpeakingBloc` submit events → `_persist` (which mints the
  chain id on the first attempt via `microsecondsSinceEpoch` — no uuid dep).
- **Hiding the rewrite**: driven by *on-ramp*, not revision —
  `feedback_section.dart` adds `kTerminalRevealSections` + a
  `sectionsForMode(includeTerminalReveal:)` flag. Any loop-capable on-ramp
  (suggested / own-topic) hides whole-rewrite + sentence-rewrite from the menu
  on **every** attempt incl. v1; just-talk keeps them. The choose screen also
  shows a "you'll get a native rewrite at the end" note + a version banner.
- **Result page**: `_VersionCompareStrip` (shown when `revisionNumber > 1`) +
  `_polishAndRetry` / `_finishTopic` CTAs. Retry routes back to the matching
  capture page by `(onRamp, inputMode)`.
- **Terminal reveal**: `feedback/final_rewrite_page.dart` (route
  `dailySpeakingFinalRewrite`).

Two deliberate deviations from the design above:

1. **Compare = auto-rendered local strip, not a menu section.** Rather than a
   "Compare to last session" checkbox, the result page reads the previous
   version's score straight from Drift and shows the delta (`v3 · Up 14 from
   v2`). It's genuinely free (no tokens), so it needn't be opt-in. The
   heuristic *"addressed 3 of 5 flagged sentences"* line is **deferred** — it's
   better computed server-side by the edge function than guessed on-device.
2. **Terminal reveal bypasses the bloc and creates no new row — but merges
   back into the final one.** `FinalRewritePage` calls
   `DailySpeakingService().reviewSession(...)` directly with
   `requested_sections: [whole_rewrite, sentence_rewrite]`. The practice attempts
   are the v1…vN rows; the reveal is just the model answer for the last one, so
   the rewrite's token cost is paid exactly once. To keep it re-viewable, the
   generated `nativeRewrite` / `sentenceRewrites` are **merged into the final
   session's stored `feedbackJson`** (`FinalRewritePage._persistRewrite`, keyed
   by `sessionId`) — no new row, just an update. Reopening that session from
   history then renders the native version inline via the result page's existing
   `nativeRewrite` / `sentenceRewrites` sections, at no extra token cost. The
   live side-by-side ("Your version" vs "Native version") renders on **both**
   paths — `FinalRewritePage.learnerWords` carries the typed text or the voice
   transcript (see "Review the input" below).

---

# Review the input — transcript, paragraph display, history chains, audio replay

Sessions used to be "write-only": we kept the feedback and discarded the
learner's own input. This follow-up (`feat/daily_speaking_p2_p3`) stops
discarding it. Three locked decisions drove the build (2026-06-05): voice
transcript is **always-on core** (not a menu checkbox); audio is retained
**only for the active attempt chain** (older chains pruned); the transcript
**reuses the existing `inputText` column** (no separate column).

## 1. Transcript + show-the-paragraph

- `DailySpeakingFeedback` gains `transcript` (`@JsonKey(name: 'transcript')`,
  default `''`). The edge function MUST return it for voice sessions — Gemini
  already reads the audio, so the marginal token cost is small. It is **core**,
  not gated by `requested_sections` (`_applyRequestedSections` never blanks it).
- `DailySpeakingBloc._submitVoice` writes `feedback.transcript` into the
  session's `inputText`. So `inputText` is now "the learner's words" for both
  paths — transcript for voice, typed text for write.
- `feedback_result_page.dart` renders a **"What you said" / "What you wrote"**
  card (`_InputCard`) from `session.inputText`.
- The terminal reveal's side-by-side now works for voice too: the result page
  forwards `session.inputText` as `learnerWords` →
  `FinalRewritePage.learnerWords` (decoupled from `text`, which stays the AI
  input for the write path).

## 2. History version chains

`daily_speaking_history_page.dart` groups each day's rows by `topicAttemptId`
into `_ChainTile` (multi-version) vs `_SessionTile` (singleton). Legacy rows
(null id) and just-talk (unique id per session) stay singletons. The chain tile
shows the topic, the latest score, the climb ("3 versions · up 14 from v1"), and
a tappable score chip per version → its full feedback. Grouping is within a day
(version loops happen in one sitting; cross-day chains, which the UX doesn't
steer toward, split across day headers — acceptable).

## 3. Audio replay + A/B (keep-active-chain)

- Drift `dailySpeakingSessionTable` gains `audioPath` (nullable). Schema
  **v6 → v7**, `addColumn` migration.
- On a voice submit, `DailySpeakingBloc._persistAudio` copies the temp clip into
  `<app-docs>/daily_speaking_audio/<attemptId>_v<rev>.<ext>` and stores the
  path. Best-effort: a copy failure logs and returns null, never blocks
  feedback.
- `_pruneAudioExceptChain(attemptId)` deletes the saved files + clears
  `audioPath` for every chain **except** the active one — the keep-active-chain
  policy. So only the topic currently being practised (and its earlier versions,
  for A/B) keeps audio on disk.
- `widgets/session_audio_player.dart` (`SessionAudioPlayer`) is a self-contained
  just_audio play/pause/scrub widget. The result page shows a single player on
  v1 ("Your recording") and, on v2+, loads the previous version's clip and
  stacks both ("Hear your progress", `v1` / `v2 (this one)`) — the A/B replay.
  If the older clip was pruned, it degrades to the single current player.
- **Deferred (tier B):** waveform + tap-a-fix-line-to-seek needs word-level
  timestamps from the AI; not built. History tiles don't get players (audio is
  mostly pruned away from older rows by design).

## 4. Resume a topic from history ("Polish & retry" after coming back)

A learner who tapped Done (out of time, etc.) can later reopen the session from
history and keep improving — the productive loop, picked up days later.

- Drift `dailySpeakingSessionTable` gains `topicJson` (nullable). Schema
  **v7 → v8**, `addColumn`. `DailySpeakingBloc._persist` stores `topic.toJson()`
  for every on-ramp that has a topic — including just-talk, whose synthesized
  inferred topic is stored too (null only when nothing was inferred / legacy).
  This recovers the **own-topic prompt**, which was otherwise lost (own-topic
  persists only `topicId = 'own'`), and means resume needs **no dependency on
  the topic bank** for suggested.
- `DailySpeakingSession.decodedTopic` (extension) rebuilds the topic from
  `topicJson`. The result page's `_resumableTopic = topic ?? decodedTopic`, so
  "Polish & retry" now shows even when the page was opened from history.
- **Continues the chain from its latest version**: `_nextRevisionForChain()`
  reads the max `revisionNumber` for the `topicAttemptId` and adds 1, so
  polishing an old entry appends (a v3 chain → v4), never overwrites.
- **`_canRetry` vs `_canReveal`:** retry is offered live AND from history (only
  needs a topic — `_resumableTopic != null`, true for all on-ramps now). The
  reveal button (`_canReveal`) shows whenever there's no saved native version
  yet and there's input to rewrite. Label is **"I'm done — see native version"**
  live, **"See native version"** from history.
- **Missed-the-reveal recovery (important):** a learner who tapped plain *Done*
  and skipped the reveal is NOT stuck. From history the reveal regenerates from
  the saved `inputText` via the **text path** — even for a voice session whose
  audio was pruned, because the rewrite only needs the words. `_finishTopic`
  falls back to `inputText` when there's no live input (`_hasLiveInput`), then
  persists the result so the ✨ chip + inline section take over afterwards.
  Tokens still paid once. Applies to all on-ramps, just-talk included.
- Just-talk resumes via its inferred topic (routes back through the just-talk
  recorder, which shows a "Talk about: …" banner; `onRamp` stays `just_talk`).
  History tiles now also label
  rows with `decodedTopic.title` (the real typed own-topic text) instead of the
  `'own'` sentinel / the AI's inferred guess.
- A resumed attempt is a normal new session row (counts against the daily quota
  banner, which is decorative anyway — real budget is server-side).

## Edge-function contract impact (when the Gemini key lands)

The edge function must additionally return `transcript` for voice sessions
(always, regardless of `requested_sections`). Everything else (audio capture,
history, replay, pruning, resume) is client-side and already live behind the
stub.
