# Daily Speaking — Feedback JSON schema

The contract between our backend (Gemini) and the app for one practice session.
The learner sends **audio or text**; the model returns **one JSON object** in this
shape. A full example lives in [`feedback_schema.example.json`](feedback_schema.example.json).

> Status: **proposal under review.** The AI path is currently stubbed
> (`daily_speaking_service_stubs.dart`); this is the target contract to implement
> when the real Gemini call goes live.

---

## 1. Design in one idea

We return the learner's words **three ways, and they all describe the same text**:

1. `transcript` — the original paragraph, plain. (The "Yours" view reads this.)
2. `native_rewrite` — the native paragraph, plain. (The split-bottom reads this.)
3. `sentences[]` — the **annotated overlay**: the same text broken into sentences,
   and each sentence broken into runs of text — plain runs and flagged runs.
   This is what powers the tappable highlights and the sentence-aligned split.

The model does the markup; the app never has to re-find an error inside a string.
`transcript`/`native_rewrite` are the canonical paragraphs to *display*;
`sentences[]` is the structured layer to *highlight*.

```jsonc
"sentences": [
  {
    "original": "My family have four peoples.",   // what the learner said
    "native":   "My family has four people.",      // native version of THIS sentence
    "changed":  true,                               // native != original
    "segments": [                                   // original, split into runs
      { "text": "my family " },                     // plain run (no type)
      { "text": "have", "type": "grammar",
        "correction": "has", "reason_mm": "…" },    // flagged run
      { "text": " four " },
      { "text": "peoples", "type": "grammar",
        "correction": "people", "reason_mm": "…" },
      { "text": "." }
    ]
  }
]
```

### Invariants the model must honour (per sentence)
1. **For each sentence, joining its `segments[].text` reproduces that sentence's
   `original` exactly.** This is what makes the highlight overlay align perfectly
   — no character offsets, which LLMs count unreliably. We *validate* this on the
   client; on mismatch we fall back to the plain `transcript` with no highlights
   (never broken markup).
2. **Joining all `sentences[].original` with a single space reproduces
   `transcript`; joining all `sentences[].native` with a single space reproduces
   `native_rewrite`.** So the paragraphs and the per-sentence breakdown always
   agree.

---

## 2. Top-level object

| Field | Type | Req | Notes |
|---|---|---|---|
| `schema_version` | int | ✓ | Bump on breaking changes. Currently `1`. |
| `score` | int (0–100) | ✓ | Overall score. |
| `level` | enum | ✓ | `beginner` \| `elementary` \| `intermediate` \| `upper_intermediate` \| `advanced` \| `fluent` |
| `inferred_topic` | string? | – | What the AI thinks the learner talked about (just-talk path). |
| `duration_seconds` | int | ✓ | Length of the take. |
| `word_count` | int | ✓ | Words spoken/written. |
| `speaking_pace_wpm` | int | ✓ | Voice only; `0` for text. |
| `transcript` | string | ✓ | The original paragraph, plain. The "Yours" view's canonical text. Equals all `sentences[].original` joined with a space. |
| `native_rewrite` | string | ✓ | The native paragraph, plain. The split-bottom's canonical text. Equals all `sentences[].native` joined with a space. |
| `sub_scores` | object? | – | `{ grammar, vocabulary, fluency, pronunciation }`, each 0–100. |
| **`sentences`** | array | ✓ | **The heart — see §3.** The annotated overlay that drives the highlights and the split compare. |
| `strengths` | string[] | – | Cross-cutting praise (not tied to a span). |
| `grammar_patterns` | string[] | – | Recurring patterns observed across the talk. |
| `pronunciation_notes` | string[] | – | Sound-level notes (voice only). |
| `collocations` | string[] | – | **Suggestions to learn**, seeded by the topic — natural pairings the learner *could* have used. NOT pulled from the transcript and NOT errors. |
| `idioms` | object[] | – | `{ expression, meaning_mm }` — **suggestions to learn**: idioms/phrasal verbs that fit the topic, which the learner did not use. |
| `target_phrase_results` | object[] | – | Suggested-topic path: `{ phrase_en, used, used_correctly }`. |
| `explanation_mm` | string | – | Overall Burmese summary. |
| `total_tokens` | int | – | Token usage for this call (for the credit system). |

Everything in the bottom group is **aggregate / non-positional** — it is *not*
tied to a specific place in the text, so it stays as plain lists.

---

## 3. `sentences[]` — the heart

### FeedbackSentence
| Field | Type | Req | Notes |
|---|---|---|---|
| `original` | string | ✓ | The learner's sentence, verbatim. Equals the join of its `segments[].text`. |
| `native` | string | ✓ | Native-sounding version of this one sentence. If nothing needed changing, `native == original`. |
| `changed` | bool | ✓ | `true` when `native` differs from `original`. Drives emphasis in the split view. |
| `segments` | array | ✓ | `original` split into ordered runs (see below). |

### FeedbackSegment
| Field | Type | Req | Notes |
|---|---|---|---|
| `text` | string | ✓ | The run of text. Plain runs have **only** this field. |
| `type` | enum | – | Present only on flagged runs: `grammar` \| `vocab` \| `interference` \| `filler`. |
| `correction` | string | flagged | The corrected form. May be `""` (e.g. a filler word to delete). |
| `reason_mm` | string | – | **Optional** short Burmese explanation. One clause — keep it tight. |
| `reason_en` | string | – | **Optional** short English explanation. One clause. |

**Reasons are optional and language-driven.** The learner picks a `reason_lang`
preference — `mm` (Burmese only), `en` (English only), `both`, or `none` — and
the model returns only the requested reason field(s). Intermediate learners who
want full English immersion choose `en` or `none`; beginners choose `mm`. Keep
each reason to a single short clause (it's the biggest lever on output tokens —
see §6). The app shows whichever fields are present; when both are present it
shows Burmese first, then English.

### Segment `type` → how the app renders it
| `type` | Meaning | Highlight |
|---|---|---|
| `grammar` | Grammatical error (agreement, articles, tense…) | warning/orange |
| `vocab` | A weak word → a better one | info/blue |
| `interference` | Burmese→English literal translation | red |
| `filler` | "um", "uh", "like"… | muted/grey |

Tapping a flagged run opens a sheet with `correction` + `reason_mm`.

---

## 4. Single source of truth (no duplicate lists)

The old schema had separate `fixes`, `vocab_upgrades`, `interference_notes`,
`filler_words`, and `sentence_rewrites` lists. **All of these are now derived
from `sentences[]` on the client**, so the inline highlight and the summary list
can never disagree:

| Feedback-tab list | Derived from |
|---|---|
| Things to fix | segments where `type == grammar` |
| Better word choices | segments where `type == vocab` |
| Burmese-interference | segments where `type == interference` |
| Filler words (+ counts) | segments where `type == filler` |
| Sentence rewrites | sentences where `changed == true` (`original` → `native`) |

> **Removed from the JSON:** `fixes`, `vocab_upgrades`, `interference_notes`,
> `filler_words`, `sentence_rewrites`.
>
> **Kept (not derived):** `transcript` and `native_rewrite` stay as explicit
> plain-text fields — they're the canonical paragraphs to display and the
> baseline we validate `sentences[]` against. The model emits them directly.

---

## 5. How the two views consume it

**Highlight view** (Review screen, default) — render each sentence's `segments`
in order; flagged runs get their colour + a tap target. The whole transcript is
just every segment concatenated.

**Split / compare view** (Review screen, only when any sentence has
`changed == true`) — one row per sentence: `original` on top, `native` on the
bottom, with changed sentences emphasised. Because it's sentence-aligned, the
learner sees *exactly* what changed, not two paragraph blobs.

---

## 6. Reliability rules (when we wire the real call)

1. **Enforce the shape with Gemini structured output** (`responseSchema`) so the
   model can't drift from this contract.
2. **Validate on the client:** join `segments[].text` and compare to the
   transcript. If they don't match (or `sentences` is missing/empty), **fall back
   to a plain, un-highlighted transcript** — never render broken markup.
3. **Respect the feedback menu:** the learner chooses which categories to analyse,
   so segments only carry the `type`s that were requested. The same schema covers
   "grammar only" through "everything".
4. **Respect `reason_lang`:** a request parameter (`mm` \| `en` \| `both` \|
   `none`), not a response field. The model fills only the matching reason
   field(s) on each flagged segment. `none` returns no reasons at all — smallest
   payload, for learners who just want the corrected text. Reasons are short by
   construction; with ~30 flags in a 5-minute take they are the dominant share
   of output tokens, so this is also the main cost/size dial.

---

## 7. Open questions (flagged for review)

- **Filler inline vs. count-only.** The example highlights `Um,` as a `filler`
  segment, but colouring every "um" in a 5-minute talk may be noisy. Alternative:
  keep `filler` segments out and surface only an aggregate count in the Feedback
  tab. *Leaning: count-only.*
- **`original` per sentence.** Kept here for clarity/validation even though it's
  reconstructable from `segments`. Drop it to shrink the payload? *Leaning: keep.*
