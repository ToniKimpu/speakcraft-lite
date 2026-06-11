# Writing Practice — Implementation Guide

> **For the implementing agent (next session):** Read this top-to-bottom, then the root
> `CLAUDE.md` (toolchain) and `lib/screens/daily_speaking/CLAUDE.md` (the module this mirrors).
> This adds a **standalone Writing Practice module** to the main app — a *taught* curriculum:
> **Teach → Practice → Feedback → Retry**. Architecturally it mirrors Daily Speaking, but it is
> **Supabase-backed, not Drift** (the web app is coming — Supabase is the single source of truth).
> **Build stub-first** (no Gemini key yet), exactly like daily-speaking.

## Toolchain (do not skip)
Flutter **3.35.6 via FVM**. Never run global `flutter`/`dart`. Use the direct binary:
```
.fvm/flutter_sdk/bin/flutter pub get
.fvm/flutter_sdk/bin/dart run build_runner build --delete-conflicting-outputs
.fvm/flutter_sdk/bin/flutter analyze
```
Regenerate after any `@freezed`/`@JsonSerializable` change. Never hand-edit `*.freezed.dart`/`*.g.dart`.

---

## Confirmed product decisions (do not re-litigate)
1. **Standalone module**, on the home screen **under the Daily Speaking card**.
2. **Leveled PATH** — Level 1 → 2 → 3. For MVP, levels are **guidance, not a hard gate** (show the
   path + completion + "next recommended"; hard unlock is deferred — it needs per-user progress = auth).
3. **Four task types** (room to add more): `sentence`, `paragraph`, `picture`, `chart`.
   **Order:** ship the text-only types (`sentence` + `paragraph`) first; add the vision types
   (`picture` + `chart`) second.
4. **New `WritingFeedback` schema** (NOT a reuse of `DailySpeakingFeedback`) — IELTS-criteria backbone.
5. **Supabase-first storage** — content bank, per-user progress, and submission/feedback history all
   live in Supabase. Drift is at most an optional mobile cache; **never the source of truth**. Web is
   Supabase-only. (This is deliberately different from daily-speaking, which is Drift-local.)

## Storage model & the auth dependency
- **`writing_lessons`** — public-read content bank (no auth). **Buildable now.**
- **`user_writing_progress`** + **`writing_submissions`** — per-user, **RLS own-rows**, keyed by
  `user_id` → **depend on auth** ([[auth-improvement-plan]] is "do first"). The *practice + feedback*
  flow itself needs no auth (you can write → get feedback without saving); **persistence lights up
  when auth lands**. Don't build a Drift fallback for these — just no-op the save until auth exists.

---

## The four task types
| Type | Practice | Feedback emphasis | Vision? |
|------|----------|-------------------|---------|
| `sentence` | Write 1–3 sentences using a **target structure** (Even though / During / In spite of / a tense) | Did they use the structure correctly? (coverage checklist) | no |
| `paragraph` | Write a short **guided paragraph** on a prompt (opinion / story / email) | Cohesion, structure, target phrases used | no |
| `picture` | **Describe an image** | Accuracy vs the image (key elements mentioned) | **yes** |
| `chart` | **IELTS Task 1** — describe a graph/trend | Data accuracy + trend vocabulary; IELTS band | **yes** |

---

## Supabase schema (DDL — apply via the admin app's CLI, prod `yoolagzhgxilukjsypbh`)

> Mirror the `daily_speaking_topics` migration style (see admin
> `supabase/migrations/20260612090000_daily_speaking_topics.sql`). Filter/sort fields are columns;
> the rich teach/task content is JSONB so it maps 1:1 to the Flutter model.

```sql
-- 1. Content bank (public read of published, non-deleted).
create table public.writing_lessons (
  id            text primary key default (gen_random_uuid())::text,
  level         int  not null default 1,            -- 1 / 2 / 3 ...
  order_in_level int not null default 0,            -- position within the level
  type          text not null check (type in ('sentence','paragraph','picture','chart')),
  title         text not null,
  -- teach step: { concept_en, concept_mm, rule_en, rule_mm, examples:[{en,mm}] }
  teach         jsonb not null default '{}'::jsonb,
  -- task step (shape varies by type — see "Task JSONB shapes" below)
  task          jsonb not null default '{}'::jsonb,
  -- picture/chart only: storage path in the writing-images bucket
  image_path    text,
  tags          text[] not null default '{}',
  is_published  boolean not null default false,
  is_deleted    boolean not null default false,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);
create index writing_lessons_level_idx on public.writing_lessons (is_published, level, order_in_level);
-- reuse the existing public.touch_updated_at() trigger fn from the topics migration
create trigger trg_writing_lessons_touch before update on public.writing_lessons
  for each row execute function public.touch_updated_at();

alter table public.writing_lessons enable row level security;
create policy "writing lessons readable when published" on public.writing_lessons
  for select to authenticated, anon using (is_published = true and is_deleted = false);
grant select on table public.writing_lessons to authenticated, anon;
grant all    on table public.writing_lessons to service_role;

-- 2. Per-user progress (AUTH REQUIRED — apply when auth ships).
create table public.user_writing_progress (
  user_id        uuid not null references auth.users(id) on delete cascade,
  lesson_id      text not null references public.writing_lessons(id) on delete cascade,
  attempts       int  not null default 0,
  best_score     int  not null default 0,
  best_band      numeric(2,1),                       -- IELTS tasks only
  completed      boolean not null default false,
  last_attempt_at timestamptz not null default now(),
  primary key (user_id, lesson_id)
);
alter table public.user_writing_progress enable row level security;
create policy "read own writing progress"   on public.user_writing_progress for select using (auth.uid() = user_id);
create policy "upsert own writing progress" on public.user_writing_progress for insert with check (auth.uid() = user_id);
create policy "update own writing progress" on public.user_writing_progress for update using (auth.uid() = user_id);

-- 3. Submission + feedback history (AUTH REQUIRED — apply when auth ships).
create table public.writing_submissions (
  id              bigint generated by default as identity primary key,
  user_id         uuid not null references auth.users(id) on delete cascade,
  lesson_id       text not null references public.writing_lessons(id) on delete cascade,
  attempt_chain_id text not null,                    -- groups v1, v2 … of one attempt (retry loop)
  revision_number int not null default 1,
  draft_text      text not null,
  feedback_json   jsonb not null,                    -- the WritingFeedback payload
  score           int,
  band            numeric(2,1),
  total_tokens    int not null default 0,
  created_at      timestamptz not null default now()
);
create index writing_submissions_user_idx on public.writing_submissions (user_id, created_at desc);
alter table public.writing_submissions enable row level security;
create policy "read own submissions"   on public.writing_submissions for select using (auth.uid() = user_id);
create policy "insert own submissions" on public.writing_submissions for insert with check (auth.uid() = user_id);
```
> **Preferred:** the `writing-review` edge function (service role) writes `writing_submissions` +
> upserts `user_writing_progress` after grading, so progress is server-authoritative. Keep the
> client-insert RLS as a fallback.

### Task JSONB shapes (must match the Flutter model's `fromJson`)
- `sentence`: `{ "prompt_en","prompt_mm","target_structures":[{"phrase_en","note_mm"}],"min_sentences","max_sentences" }`
- `paragraph`: `{ "prompt_en","prompt_mm","target_structures":[{"phrase_en","note_mm"}],"word_min","word_max" }`
- `picture`: `{ "prompt_en","prompt_mm","key_points":[{"point_en","note_mm"}] }` (image via `image_path`)
- `chart`: `{ "prompt_en","prompt_mm","chart_type","key_trends":[{"point_en","note_mm"}],"data_vocab":[{"term","definition_mm"}] }` (image via `image_path`)

### Images
Add a **public** Supabase Storage bucket `writing-images` (or reuse Bunny if you prefer the listening
pattern). The admin uploads chart/picture images there; `image_path` stores the object path; the app
builds the URL. The edge function fetches the image to pass to Gemini.

---

## Flutter side

### Models (`lib/model/writing/`)
- `writing_lesson.dart` — `@freezed WritingLesson`: id, level, orderInLevel, `WritingTaskType type`,
  title, `WritingTeach teach`, `WritingTask task` (see below), imagePath, tags. `fromJson` maps the
  JSONB. `WritingTaskType` enum (sentence/paragraph/picture/chart) with `@JsonValue`.
  - `WritingTeach` = conceptEn, conceptMm, ruleEn?, ruleMm?, `List<ExamplePair> examples` ({en,mm}).
  - `WritingTask` = one freezed class with all-optional fields across types (promptEn, promptMm,
    targetStructures:[{phraseEn,noteMm}], keyPoints, keyTrends, dataVocab, minSentences, maxSentences,
    wordMin, wordMax, chartType). Simpler than a sealed union and tolerant of new types. The UI reads
    only the fields relevant to `type`.
- `writing_feedback.dart` — `@freezed WritingFeedback` (the new schema):
  - `int score` (0–100), `double? band` (IELTS only),
  - `WritingSubScores subScores` { taskAchievement, coherenceCohesion, lexicalResource,
    grammaticalRange } (each 0–100),
  - `List<WritingCorrection> corrections` { original, corrected, reasonEn, reasonMm,
    `CorrectionKind kind` = grammar|spelling|wordChoice|punctuation },
  - `String modelAnswer` (improved/native version — gated reveal),
  - `String explanationMm`,
  - `List<CoverageItem> coverage` { labelEn, used(bool), noteMm } — target structures used / key
    points mentioned (AI-checked vs the image for visual tasks),
  - `List<String> strengths`, `List<String> topFixes`, `int totalTokens`.
  - snake_case `@JsonKey`s to match the edge-function contract.

### Service + BLoC (mirror daily-speaking)
- `lib/services/writing/writing_service.dart` — `useStubResponse` switch; `reviewWriting(WritingInput)`
  → stub returns canned `WritingFeedback` (1–2 samples per task type), real path posts to
  `supabase.functions.invoke('writing-review', ...)`. `WritingInput` = { lessonId, type, draftText,
  taskContext (target structures / key points), imagePath? }.
- `lib/services/writing/writing_service_stubs.dart` — canned feedback (delete when real).
- `lib/bloc/writing/writing_lesson_bloc.dart` — loads `writing_lessons` from Supabase
  (public read; network-first + in-memory cache; NO asset fallback needed, but tolerate empty), groups
  by level. Mirror `DailySpeakingTopicBloc` but Supabase-only.
- `lib/bloc/writing/writing_review_bloc.dart` — submit draft → submitting → success(feedback) → error.
  On success (when auth exists) persist to `writing_submissions` + upsert progress; else skip persist.
- `lib/bloc/writing/writing_progress` — a `WritingProgressRepository` abstraction (like
  `TopicProgressRepository`): `SupabaseWritingProgressRepository` (auth) is the real one; until auth,
  return empty progress (no Drift interim — Supabase-first).

### Screens (`lib/screens/writing/`)
1. `writing_path_page.dart` — the **levels path**: sections per Level (1/2/3), lesson cards showing
   type icon, title, completion ✓ + best score/band (from progress). "Continue" points at the next
   incomplete lesson. Soft guidance, no hard lock (MVP).
2. `writing_teach_page.dart` — the **Teach** step: concept (EN), Burmese explanation, rule, worked
   examples (EN/MM), and the image for picture/chart. CTA "Start writing".
3. `writing_practice_page.dart` — the **Practice** step: task prompt, a proper **multi-line editor**
   (live word/char count vs target), passive **target-structure / key-point reminder chips**, and the
   image shown for picture/chart. Submit → review bloc.
4. `writing_feedback_page.dart` — the **Feedback** step: overall score (+ IELTS band when present),
   the four **sub-score bars**, **annotated corrections**, the **coverage checklist** (✅/⬜), the
   **model answer** behind a try-first reveal, Burmese explanation, strengths/top-fixes. Offers
   **"Revise & try again"** (retry loop: same lesson, `attempt_chain_id` + incremented
   `revision_number`) and **"Done"**.

### Home screen
Add a **Writing Practice** `ModuleWidget` in `lib/screens/main/home_screen.dart` directly under the
Daily Speaking card → routes to `writing_path_page`. Add routes in `pmp_routes.dart`
(`/writing`, `/writing/teach`, `/writing/practice`, `/writing/feedback`).

### Edge function (separate task; not in the first branch)
`supabase/functions/writing-review/index.ts` — Gemini Flash-Lite. Input: lesson/task context + draft
(+ image bytes for picture/chart, fetched from `writing-images`). Output: JSON matching
`WritingFeedback.fromJson`. **Multimodal** for the visual types (Gemini sees the image and grades
description accuracy). Deduct credits server-side; write submission + upsert progress.

---

## Admin authoring (web admin — `pmp_english_admin`)
Mirror the daily-speaking-topics feature you just built (table + columns + form-sheet + actions +
queries + validation + page + sidebar item "Writing"):
- CRUD over `writing_lessons`: level, order_in_level, type (select), title, publish toggle.
- **Type-aware form**: show the right sub-form for the selected `type` (target_structures repeatable
  rows for sentence/paragraph; key_points for picture; key_trends + data_vocab for chart). Teach block
  (concept_en/mm, rule, examples repeatable). `useFieldArray` like the topics form.
- **Image upload** for picture/chart → `writing-images` bucket (reuse the listening `ThumbnailUpload`).
- Apply the migrations above as admin CLI migrations (content table now; the two auth-gated tables
  when auth ships).

---

## Theme & localization (mandatory)
- Theme-aware via `Theme.of(context).colorScheme` + `PmpColors` + `PmpTextStyles` (works in both light
  "Scholar Teal" and dark themes — see the polished `own_topic_prep_page.dart` for the house style:
  gradient CTAs, tonal chips, rounded cards). No raw color/text literals.
- **All UI strings** via `AppLocalizations` / `lib/l10n/intl_en.arb` (`txtWriting*` keys). Regenerate
  l10n after editing the ARB. AI/admin-authored Burmese (concept_mm, note_mm, explanation_mm) stays as
  data.

---

## Phasing & Definition of Done
**Phase 1 — text types, content + flow (no auth, no Gemini)**
- [ ] `writing_lessons` table + admin authoring; seed a few `sentence` + `paragraph` lessons across L1/L2.
- [ ] Models (`WritingLesson`, `WritingFeedback`), stub service, lesson + review blocs.
- [ ] Path → Teach → Practice → Feedback (+ retry) screens, stub feedback, home card + routes.
- [ ] Theme-aware, localized, `flutter analyze` 0 errors, codegen run.

**Phase 2 — vision types**
- [ ] `picture` + `chart` task forms + `writing-images` bucket + admin image upload.
- [ ] Practice/Teach/Feedback render the image; stub vision feedback; coverage checklist vs key points.

**Phase 3 — persistence + real AI (rides on auth + Gemini)**
- [ ] Apply `user_writing_progress` + `writing_submissions` (auth); wire progress repo + history.
- [ ] Deploy `writing-review` edge fn (multimodal); flip `useStubResponse=false`; meter via credits.

## Reference files (read, don't blindly copy)
- `lib/screens/daily_speaking/**` + `lib/bloc/daily_speaking/**` — the architecture this mirrors
  (entry/list, prep, record→here it's a text editor, feedback result, retry loop).
- `lib/bloc/daily_speaking/daily_speaking_topic_bloc.dart` — Supabase fetch + cache pattern.
- `lib/services/daily_speaking/daily_speaking_service.dart` (+ stubs) — the stub/real switch to mirror.
- `SUGGESTED_TOPICS_SUPABASE_PLAN.md` + the admin `daily_speaking_topics` feature — the curated-bank +
  admin-authoring pattern to clone for `writing_lessons`.
- `lib/screens/daily_speaking/own_topic/own_topic_prep_page.dart` — current house visual style.
- `lib/config/pmp_colors.dart`, `pmp_text_styles.dart` — design tokens.
