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
- New screen/section **labels are inline English** (not in the ARB), matching
  this module's original "inline first" convention. Localize in a later pass.
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
> Decisions: **(1) suggested + own-topic only** — "just talk" stays terminal.
> **(2) whole-rewrite is a terminal reveal** — hidden during iterations, shown
> once at the end.

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

- **Just talk**: no version loop. Result page stays terminal (no "polish &
  retry"), exactly as today.
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
2. **Terminal reveal does NOT persist a history row and bypasses the bloc.**
   `FinalRewritePage` calls `DailySpeakingService().reviewSession(...)` directly
   with `requested_sections: [whole_rewrite, sentence_rewrite]`. The practice
   attempts are the v1…vN rows; the reveal is just the model answer for the last
   one, so the rewrite's token cost is paid exactly once, at the end. For voice
   there's no transcript, so the side-by-side ("Your version" vs "Native
   version") only renders on the write path; voice shows the native version
   alone.
