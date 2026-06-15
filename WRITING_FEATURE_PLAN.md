# Writing Practice — Implementation Guide (v2: Grammar Foundation)

> **For the implementing agent:** Read this top-to-bottom, then the root `CLAUDE.md`
> (toolchain) and `lib/screens/daily_speaking/CLAUDE.md` (the module this mirrors).
> This adds a **standalone Writing Practice module** — a *taught* curriculum whose
> **foundation levels ARE a grammar course**: **Teach → Practice (ladder) → Feedback → Retry**.
> Architecturally it mirrors Daily Speaking but is **Supabase-backed at ship** (web app is
> coming). **Build stub-first** (no Gemini key yet) and **local-JSON-first** (prototype the
> content as bundled JSON, swap to Supabase only at the end — keys map 1:1 so it's a copy).

## Toolchain (do not skip)
Flutter **3.35.6 via FVM**. Never run global `flutter`/`dart`. Use the direct binary:
```
.fvm/flutter_sdk/bin/flutter pub get
.fvm/flutter_sdk/bin/dart run build_runner build --delete-conflicting-outputs
.fvm/flutter_sdk/bin/flutter analyze
```

---

## The big idea (decided via brainstorm 2026-06-14)

Three things were tangled in the founder's head — **grammar (knowledge)**, **writing (skill)**,
and **level (altitude)**. The resolution: **grammar and writing are the same ladder at different
heights.** Grammar is the *bottom rungs* of the writing path. So there is **ONE module**, and its
early levels are the grammar course; by Level 3 the same path *is* IELTS prep.

### Confirmed decisions (do NOT re-litigate)
1. **One module** ("Writing"), on the home screen **under the Daily Speaking card**. Grammar is its
   foundation, **not** a separate module.
2. **Leveled PATH** L1 → L2 → L3. MVP: levels are **guidance, not a hard gate**. Placement =
   **self-select + soft nudge** (clear level descriptions; drill scores + AI feedback recommend
   dropping/advancing). A real placement quiz is deferred (needs scoring + auth).
3. **Unit-style structure** (like *English Grammar in Use*): `Level → Section → Unit`. A **Unit** is
   the atom = one grammar point = `Teach` + an ordered `Exercises` ladder. Self-contained, like
   Murphy's two-page spread.
4. **`grammar_drill` (auto-graded) is the beginner on-ramp, built FIRST** — objective, instant, free
   (no Gemini), shippable today. It's the answer to "guide them first if they're weak in grammar."
5. **The practice ladder, split by grader:**
   - **Auto-graded (tap, in-app, free, instant):** `mcq`, `gap_fill`, `reorder`, `correct_error`.
   - **AI-graded (type OR handwrite-and-scan):** `join` (combine two sentences), `transform`
     (rewrite keeping meaning), `make_question`/`make_negative` (when open), `free_write`.
   The mechanical Murphy drills become free auto-graded taps; the open, thinking exercises become
   AI/tutor-checked writing. A single `grade: "ai"` flag on an exercise routes it.
6. **Handwrite-and-scan ("study with a real tutor"):** for production exercises the task is given in
   **Burmese** ("write these N sentences in your notebook"), the learner writes by hand, **scans with
   the camera**, and Gemini **transcribes + grades in one multimodal call**. UX rule: **always show
   the transcription back to confirm/correct before feedback locks** (never penalize OCR misreads).
   - **Store the transcription only**, not the photo (cheaper, more private).
   - **Both input modes** — default to / encourage notebook+scan, but offer a **"type instead"**
     fallback. (Reuses the same multimodal `writing-review` pipeline planned for `picture`/`chart`.)
7. **Authoring = AI-generated into our template, founder reviews** (editor-in-chief). The fixed
   teach template + exercise taxonomy is what makes AI batch-authoring reliable.
8. **L1 grammar floor = `be` (am/is/are) → present simple.** (Not gentler word-order pre-work.)
9. **Storage: local-JSON-first during the build → Supabase-only at ship.** JSON keys mirror the
   Supabase JSONB 1:1. End-state is Supabase-only (online-only app, **no Drift**).
10. **Toolkit + shared lexicon (added 2026-06-14 — the depth fix).** A bare rule + drills is the
    "cheap" floor. Each unit ships a **toolkit**: the **verbs** and **frequency/time words** the
    learner builds with, each with **EN + Burmese gloss + bilingual example**. Words live in a
    **shared lexicon** (master vocabulary), and a unit references them by **id list** — authored
    once, reused across units. A **verb entry stores every form** (`base/third/past/past_participle/
    ing`) so each tense-unit pulls the form it needs (present uses `third`, past reuses `past`).
    The teach page also ends with a **model paragraph** that *uses the toolkit in prose* — show the
    target output before they write. Production = **two handwrite-and-scan tasks**: (a) `scan_sentences`
    (5–10 sentences using ≥3 verbs + 2 time words), then (b) `scan_paragraph` (one short paragraph,
    this grammar only). Constrained prompts make AI feedback specific and gradeable.

### Our unfair advantage (write it into every lesson)
**Burmese-contrastive teaching** — flag exactly where Burmese L1 trips the learner (he/she/it `-s`
because Burmese verbs don't conjugate; articles a/an/the because Burmese has none; word order). The
books can't do this; it's the differentiator. Plus the **real-notebook handwriting** loop.

---

## Grammar scope & sequence (the foundation ladder)
Content modeled on the *method* of *English Grammar in Use* (Murphy) — **never copy its text**;
the scope/sequence is just facts, the method isn't copyrightable, we write original Burmese-aware
content (AI-drafted, founder-reviewed).

- **L1 Foundation (A1–A2):** `be` → present simple → present continuous → present vs continuous →
  past simple (reg/irreg) → articles a/an/the → plurals · countable/uncountable → subject–verb
  agreement → pronouns/possessives → prepositions of time/place · there is/are · can/can't.
- **L2 Building (B1):** past continuous → present perfect (vs past simple) → future (will vs going
  to) → comparatives/superlatives → modals (should/must/have to) → gerunds vs infinitives →
  quantifiers → adverbs of frequency → **connectors (because/so/although/but)** → 1st conditional.
- **L3 Advanced / IELTS (B2–C1):** present perfect continuous → past perfect → 2nd & 3rd
  conditionals → **passive voice · relative clauses · reported speech** → **academic linkers
  (however/moreover/despite/whereas)** → sentence variety → IELTS Task 1 trends & Task 2 essays.

L3 grammar (passive, relative clauses, academic linkers) *is* the IELTS "Grammatical Range" and
"Cohesion" criteria — so the grammar track becomes IELTS prep without switching modules.

---

## The fixed lesson template (every Unit, every level)

**TEACH (now 7 parts):**
1. **Situation** — a relatable mini-scene, grammar shown *in use* before it's named.
2. **Use** — when/why, with a **timeline** for tenses + a Burmese gloss. Concept before form.
3. **Form** — a clean table (I/you/we/they **work** · he/she/it **works** · neg · question).
4. **Burmese trap** — the specific Burmese-learner mistake ("✗ She work → ✓ She works").
5. **Examples** — several EN + MM pairs.
6. **Toolkit** — the unit's **verbs** (shown `base → third`, +s reinforced) and **frequency/time
   words** (shown with their **position rule** — the part Burmese learners get wrong), each with MM
   gloss + a bilingual example. Resolved from the **shared lexicon** by the unit's `toolkit` id lists.
7. **Model paragraph** — a short worked example that uses the toolkit in prose (see it before writing).
8. *(leads into)* the **Exercise ladder**.

**PRACTICE (ladder, climbs recognise → manipulate → produce):**
`mcq` → `gap_fill`/`reorder`(adverb position)/`correct_error` (auto) → **`scan_sentences`** (AI:
5–10 sentences using the toolkit) → **`scan_paragraph`** (AI: one short paragraph). The two scan
tasks show a collapsible **toolkit reminder** + a prominent "write in your notebook & scan" callout
(scan button disabled until Phase 3; "type instead" field is the fallback). `join`/`transform` remain
available AI kinds for other units.

**FEEDBACK:** per-item ✓/✗ + `explain_mm` for auto items; AI items return corrections + model answer
+ Burmese explanation (+ IELTS sub-scores/band for the L3 writing tasks).

---

## Local JSON shape (prototype) — keys == future Supabase JSONB

**Shared lexicon** (master vocabulary), referenced by units via id:
- `assets/writing/lexicon/verbs.json` — `{ id, mm, forms:{base,third,past,past_participle,ing},
  examples:[{en,mm}], tags:[] }`. **One entry, all forms** → reused by every tense-unit.
- `assets/writing/lexicon/time_words.json` — `{ id, en, mm, position:"before_main_verb"|
  "end_of_sentence", examples:[{en,mm}] }`. `position` drives the "where it goes" hint + reorder drills.

**One file per unit** under `assets/writing/units/<id>.json`:
```jsonc
{
  "id": "l1_present_simple", "level": 1, "section": "Present & Past", "order": 2,
  "type": "grammar_unit", "title": "Present simple (I do)", "subtitle_mm": "...",
  "teach": {
    "situation_en": "...", "situation_mm": "...",
    "use_en": "...", "use_mm": "...",
    "timeline": "—•—•—•—•—▶",
    "form": [{ "subject": "I / you / we / they", "form": "work" },
             { "subject": "he / she / it", "form": "works" }],
    "trap_en": "...", "trap_mm": "...",
    "examples": [{ "en": "The sun rises in the east.", "mm": "..." }],
    "model_paragraph_en": "My sister is a teacher. She wakes up at six ...",
    "model_paragraph_mm": "..."
  },
  "toolkit": {                          // id lists into the shared lexicon
    "verbs": ["v_wake_up","v_go","v_work","v_study", "..."],
    "time_words": ["t_always","t_usually","t_every_day", "..."]
  },
  "exercises": [
    { "kind": "mcq", "grade": "auto", "prompt_en": "He ___ tea every morning.",
      "options": ["drink","drinks","drinking"], "answers": ["drinks"], "explain_mm": "..." },
    { "kind": "gap_fill", "grade": "auto", "prompt_en": "They ___ (not / live) here.",
      "answers": ["don't live","do not live"], "explain_mm": "..." },
    { "kind": "reorder", "grade": "auto", "prompt_en": "Put in order: always / drinks / she / tea",
      "answers": ["She always drinks tea"], "explain_mm": "frequency word before the verb ..." },
    { "kind": "correct_error", "grade": "auto", "prompt_en": "She go to school.",
      "answers": ["She goes to school","She goes to school."], "explain_mm": "..." },
    { "kind": "scan_sentences", "grade": "ai", "prompt_mm": "ဝါကျ ၅–၁၀ ကြောင်း ... scan လုပ်ပါ",
      "model": "I wake up at six every day. I usually drink coffee ...", "explain_mm": "..." },
    { "kind": "scan_paragraph", "grade": "ai", "prompt_mm": "စာပိုဒ်တို တစ်ပိုဒ် ... scan လုပ်ပါ",
      "model": "My father is a farmer. He gets up early ...", "explain_mm": "..." }
  ]
}
```
**Auto-grading** = normalize (trim, collapse spaces, lowercase, drop trailing `.`) then membership in
`answers`. **AI items** (no key yet) = type-and-reveal the `model` with an encouraging canned note;
the real path posts to the `writing-review` edge fn (multimodal for scans). `scan_*` items get the
toolkit reminder + scan callout (camera disabled until Phase 3); `picture`/`chart` (later) carry
`image_path`. At load, the teach page resolves `toolkit` ids against the lexicon (`WritingLexicon`)
into a `ResolvedToolkit` and passes it to the practice page.

---

## Build phases & Definition of Done

**Phase 0 (THIS slice — for device review): one Unit + shared lexicon, local JSON, no codegen, no Supabase.**
- [x] Shared lexicon `assets/writing/lexicon/verbs.json` (19 verbs, all forms) + `time_words.json`
      (10 frequency/time words). Burmese is a **founder-review draft**.
- [x] `assets/writing/units/l1_present_simple.json` — full Present-simple unit: 7-part teach
      (incl. model paragraph), `toolkit` id lists, ladder = mcq×2/gap_fill/reorder/correct_error
      (auto) + scan_sentences/scan_paragraph (AI).
- [x] Models `lib/model/writing/writing_unit.dart` (+ `Toolkit`, model paragraph) and
      `writing_lexicon.dart` (`LexiconVerb`/`LexiconTimeWord`/`WritingLexicon`/`ResolvedToolkit`,
      `loadWritingLexicon()`). Plain Dart (no freezed yet — prototype).
- [x] `writing_teach_page.dart` (7-part teach: renders toolkit banks as expandable rows + model
      paragraph; resolves toolkit from lexicon) → `writing_practice_page.dart` (stepper: auto-grading;
      type-and-reveal stub for AI; scan tasks show toolkit reminder + scan callout) → summary.
- [x] Home card "Writing Practice" under Daily Speaking + routes (pass `toolkit`) + pubspec assets
      (`units/` + `lexicon/`).
- [x] Theme-aware, `flutter analyze` clean.

**Phase 1 — path + more units, still local JSON.** `writing_path_page` (Level → Section → Unit
cards, soft progress); seed several L1 units; convert models to `@freezed`.

**Phase 2 — Supabase swap.** `writing_lessons` table (public-read JSONB), admin authoring (type-aware
form, mirror `daily_speaking_topics`), AI batch-authoring into the template; flip loader to Supabase.

**Phase 3 — real AI + scan + persistence (rides on auth + Gemini).** `writing-review` multimodal edge
fn (transcribe handwriting + grade); camera scan UI; `user_writing_progress` + `writing_submissions`
(RLS own-rows); meter via credits. **No Drift** — persistence no-ops until auth, then Supabase.

> **Scan flow — capture → AI region-extract → confirm & trim → grade (decided 2026-06-15).**
> A notebook page accumulates writing from several tasks (e.g. the Ex-6 sentences sit just above the
> Ex-7 paragraph), so one photo can capture *more than the current task*. This is **only** a problem
> for the handwrite+scan path — the typed line-by-line input is unambiguous (one task per screen).
> The fix is a layered, low-friction loop, not a clever cropper:
> 1. **AI region-extract.** The multimodal `writing-review` call is told the task's expected *shape*
>    from the exercise (count + person — Ex-6 = first-person "I" sentences; Ex-7 = a third-person
>    he/she paragraph) and instructed: *"the page may contain other tasks' writing; extract and grade
>    ONLY the part matching THIS task; ignore unrelated lines."* The I-vs-he/she contrast makes this
>    easy for the model, so it pre-selects the right region.
> 2. **Confirm & trim (the safety net, does double duty).** The planned "show the transcription back
>    before feedback locks" screen is **editable**: the learner sees the read-back as lines and can
>    **delete any line that isn't this task** (and fix OCR misreads) before tapping *Grade*. Handles
>    extra-page text *and* transcription errors in one step. Worst case = delete a couple of stray
>    lines; never "graded the wrong thing."
> 3. **Light anchor.** Prompt nudge: *"start this task on a new line (or write the part number)."*
>
> Product call: **one photo per task + trim** (flexible; notebooks fill up) over "one task per page".
> Only the **confirmed/trimmed transcription** is stored in `writing_submissions.draft_text` — never
> the raw photo (cheaper, more private), per decision #6.

### Supabase DDL (apply in Phase 2/3 — prod `yoolagzhgxilukjsypbh`, mirror the topics migration)
- `writing_lexicon` (public read): `id (text pk), kind ('verb'|'time_word'), mm, en, forms jsonb,
  position, examples jsonb, tags[], timestamps`. Units store toolkit id arrays in their JSONB.
- `writing_lessons` (public read of published): `id, level, section, order_in_level, type,
  title, teach jsonb, toolkit jsonb (verb/time_word id arrays), exercises jsonb, image_path,
  tags[], is_published, is_deleted, timestamps`.
- `user_writing_progress` (auth, RLS own-rows): `(user_id, lesson_id) pk, attempts, best_score,
  best_band, completed, last_attempt_at`.
- `writing_submissions` (auth, RLS own-rows): `id, user_id, lesson_id, attempt_chain_id,
  revision_number, draft_text (the transcription), feedback_json, score, band, total_tokens, created_at`.

---

## Theme & localization (mandatory at productionization)
Theme-aware via `Theme.of(context).colorScheme` + `PmpColors`/`PmpTextStyles` (light "Scholar Teal" +
dark). See `own_topic_prep_page.dart` for the house style. **All UI strings via `AppLocalizations` /
`intl_en.arb` (`txtWriting*`)** — the Phase-0 slice uses inline English like daily-speaking's
prototype did (CLAUDE.md sanctions this); intl-ize before ship. AI/authored Burmese stays as data.

## Reference files (read, don't blindly copy)
- `lib/screens/daily_speaking/**` + `lib/bloc/daily_speaking/**` — the architecture this mirrors.
- `lib/bloc/daily_speaking/daily_speaking_topic_bloc.dart` / `guided_lesson_bloc.dart` — asset+Supabase load.
- `lib/services/daily_speaking/daily_speaking_service.dart` (+ stubs) — the stub/real switch.
- `lib/screens/daily_speaking/own_topic/own_topic_prep_page.dart` — house visual style.
- `lib/config/pmp_colors.dart`, `pmp_text_styles.dart` — design tokens.
