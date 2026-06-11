# Suggested Topics → Supabase + Practiced-State — Implementation Guide

> **For the implementing agent:** Read this top-to-bottom, then `lib/screens/daily_speaking/CLAUDE.md`
> and the root `CLAUDE.md` (toolchain). This migrates the **suggested-topic** bank from a bundled
> JSON asset to **Supabase**, enriches each topic, and adds **"already practiced" handling**
> (sink + badge, never hidden). It is **phased** — Phase 1 ships now; Phase 2's cross-device piece
> waits for auth; Phase 3 waits for the Gemini key. Respect those boundaries.

## Toolchain (do not skip)

Pinned to **Flutter 3.35.6 via FVM**. Never run global `flutter`/`dart`. Use the **direct binary**
(the `fvm` wrapper has broken pub resolution here):

```
.fvm/flutter_sdk/bin/flutter pub get
.fvm/flutter_sdk/bin/dart run build_runner build --delete-conflicting-outputs
.fvm/flutter_sdk/bin/flutter analyze
```

Regenerate after editing any `@freezed`/`@JsonSerializable` model or Drift table. Never hand-edit
`*.freezed.dart` / `*.g.dart`.

---

## Current state (what you're changing)

- Topics bundled at `assets/daily_speaking/topics/topics.json` (3 entries), loaded by
  `lib/bloc/daily_speaking/daily_speaking_topic_bloc.dart` → `_loadFromAssets`.
- Model `lib/model/daily_speaking/daily_speaking_topic.dart` (`DailySpeakingTopic`) already has:
  `id`, `title`, `prompt_en`, `prompt_mm`, `difficulty` (beginner/intermediate/advanced),
  `duration_target_seconds`, `vocabulary[]` (`term`/`definition_mm`/`example_en`),
  `target_phrases[]` (`phrase_en`/`translation_mm`), `warmup_questions[]`, `tags[]`, `created_at`.
  **The model does NOT change** — Supabase rows must deserialize via `DailySpeakingTopic.fromJson`.
- List UI `lib/screens/daily_speaking/suggested/suggested_topic_list_page.dart`: a `TabBar`
  (Beginner / Intermediate / Advanced), a **"New this week"** horizontal rail (topics with
  `createdAt` < 7 days), last-tab persisted in SharedPreferences, a `_NewBadge`, per-tab list sorted
  new-first by `createdAt`.
- Sessions persist **only to local Drift** (`DailySpeakingSessionTable`) with `topicId` +
  `feedbackJson` (the feedback carries `score`, an `int`). No server-side per-user record yet.
- Supabase client: `lib/services/supabase_service.dart` → `final supabase = Supabase.instance.client`.
  Prod project is `yoolagzhgxilukjsypbh` (the one the admin app + all migrations live on; **test on
  the prod flavor**). The dev flavor project is paused.

## Confirmed decisions (do not re-litigate)

1. **Practiced topics → sink + badge, NOT hide.** Fresh first; practiced get a ✓ badge + best score
   and sink to the bottom of their tab (or a collapsed "Practice again" group). Never removed.
2. **Content → JSONB on the topic row.** Filter/sort fields are real columns; vocab/phrases/warmups
   are JSONB. No normalized child tables for MVP.
3. **Per-user practiced-state → dedicated `user_topic_progress` table** (needs auth/user_id).
4. **`practiced(topic) = ≥1 session for that topicId`** (any revision). Track `best_score` +
   `last_practiced_at` too — they feed the card.

---

## Phase 1 — Topic bank to Supabase (BUILD NOW, no auth, no Gemini)

### 1a. Supabase schema (DDL — for the admin app / you to apply; see "Admin app" section)

> Apply on the **prod** project (`yoolagzhgxilukjsypbh`) via the admin app's linked Supabase CLI
> (that's where all migrations live). Provided here as DDL; do NOT assume the mobile repo applies it.

```sql
-- Topic bank. Filter/sort fields are columns; rich content is JSONB so it maps
-- 1:1 to DailySpeakingTopic.fromJson with no model churn.
create table public.daily_speaking_topics (
  id                       text primary key,              -- slug, e.g. 'first-day-at-work'
  title                    text not null,
  prompt_en                text not null,
  prompt_mm                text not null default '',
  difficulty               text not null default 'beginner'
                             check (difficulty in ('beginner','intermediate','advanced')),
  duration_target_seconds  int  not null default 180,
  vocabulary               jsonb not null default '[]'::jsonb,  -- [{term, definition_mm, example_en}]
  target_phrases           jsonb not null default '[]'::jsonb,  -- [{phrase_en, translation_mm}]
  warmup_questions         jsonb not null default '[]'::jsonb,  -- ["...", "..."]
  tags                     text[] not null default '{}',
  is_published             boolean not null default false,
  sort_order               int not null default 0,         -- manual featuring; lower = higher
  created_at               timestamptz not null default now(),
  updated_at               timestamptz not null default now()
);

-- keep updated_at fresh
create or replace function public.touch_updated_at() returns trigger as $$
begin new.updated_at = now(); return new; end; $$ language plpgsql;
create trigger trg_topics_touch before update on public.daily_speaking_topics
  for each row execute function public.touch_updated_at();

-- RLS: anyone (incl. anon) may read PUBLISHED topics; writes are admin-only
-- (service role / admin app bypasses RLS).
alter table public.daily_speaking_topics enable row level security;
create policy "read published topics"
  on public.daily_speaking_topics for select
  using (is_published = true);
```

**JSONB key contract (must match `fromJson` exactly):**
- `vocabulary[]` item: `{ "term": "...", "definition_mm": "...", "example_en": "..." }`
- `target_phrases[]` item: `{ "phrase_en": "...", "translation_mm": "..." }`
- `warmup_questions`: array of plain strings.
- `difficulty`: one of `beginner` | `intermediate` | `advanced`.

### 1b. Mobile fetch + cache

Modify `DailySpeakingTopicBloc` (`lib/bloc/daily_speaking/daily_speaking_topic_bloc.dart`):

- Replace `_loadFromAssets` with `_loadFromSupabase`:
  ```dart
  final rows = await supabase
      .from('daily_speaking_topics')
      .select()
      .eq('is_published', true)
      .order('sort_order', ascending: true)
      .order('created_at', ascending: false);
  return rows.map((e) => DailySpeakingTopic.fromJson(Map<String, dynamic>.from(e)))
             .toList(growable: false);
  ```
- **Keep `topics.json` as an offline fallback:** on any fetch error, fall back to `_loadFromAssets`
  so the screen still works offline / if the table is empty. (Don't delete the asset.)
- **Cache** the fetched rows so a returning user doesn't wait on the network every open. Two
  acceptable approaches — pick the lighter one:
  - **In-memory + SharedPreferences timestamp:** cache the raw JSON list + a `last_fetched`; reuse if
    fresh (e.g. < 6h) else refetch. Simplest.
  - **Drift cache table** (`DailySpeakingTopicCacheTable`, store raw JSON blob + fetched_at): survives
    restarts, more work. Only do this if you want true offline-after-first-load.
  - For MVP, in-memory + SharedPreferences is fine. Note the Drift option for later.
- This BLoC stays **page-scoped** (it's created in `SuggestedTopicListPage`); no change to providers.

### 1c. Seed real content

Hand-author ~10–15 topics (across the 3 difficulties) directly in Supabase via the admin app (or a
one-off SQL insert) so the bank feels alive. Each must have non-trivial `vocabulary` /
`target_phrases` / `warmup_questions` — that richness is the whole point ("the app feels helpful").
Until the admin UI exists, an SQL `insert` seeded from the existing `topics.json` shape is fine.

**Phase 1 needs no auth and no Gemini.** Ships independently.

---

## Phase 2 — Practiced-state (sink + badge)

Build the **UI now** against an **interim local source**, with a clean seam so the server source
drops in when auth lands. Do NOT build the `user_topic_progress` table before auth exists.

### 2a. The progress abstraction (build now)

Introduce a small value object + repository so the list page doesn't care where progress comes from:

```dart
class TopicProgress {            // plain class or @freezed
  final String topicId;
  final int attempts;
  final int bestScore;           // 0–100
  final DateTime lastPracticedAt;
}

abstract class TopicProgressRepository {
  /// topicId -> progress, for the current user.
  Future<Map<String, TopicProgress>> loadProgress();
}
```

- **`LocalTopicProgressRepository` (Phase 2 now):** query `DailySpeakingSessionTable` grouped by
  `topicId` — `attempts = count`, `bestScore = max` of the decoded `feedbackJson` score
  (decode via `DailySpeakingFeedback.fromJson`, same as `DailySpeakingHistoryBloc._rowToSession`),
  `lastPracticedAt = max(createdAt)`. Ignore `topicId in ('own','inferred', null)` — only curated
  suggested topics get progress here.
- **`SupabaseTopicProgressRepository` (Phase 2b, when auth lands):** `select` from
  `user_topic_progress` for `auth.uid()`. Swap the binding; nothing in the UI changes.

### 2b. Server table (DDL — apply ONLY when auth is live)

```sql
create table public.user_topic_progress (
  user_id           uuid not null references auth.users(id) on delete cascade,
  topic_id          text not null references public.daily_speaking_topics(id) on delete cascade,
  attempts          int  not null default 0,
  best_score        int  not null default 0,
  last_practiced_at timestamptz not null default now(),
  primary key (user_id, topic_id)
);

alter table public.user_topic_progress enable row level security;
create policy "read own progress"   on public.user_topic_progress
  for select using (auth.uid() = user_id);
create policy "upsert own progress" on public.user_topic_progress
  for insert with check (auth.uid() = user_id);
create policy "update own progress" on public.user_topic_progress
  for update using (auth.uid() = user_id);
```

> **Preferred:** have the **daily-speaking-review edge function** upsert this row when a session
> completes (it already runs server-side for budget) rather than trusting the client. Keep the
> client-upsert RLS as a fallback. Use `greatest(best_score, new_score)` on conflict.

### 2c. List-page changes (`suggested_topic_list_page.dart`)

The page already sorts new-first within each difficulty tab. Layer practiced-state on top:

1. Pass a `Map<String, TopicProgress>` into the list (load it alongside topics — either fold it into
   `DailySpeakingTopicState.loaded(topics, progress)` or a small second BlocBuilder/FutureBuilder).
2. **Sort within each tab:** unpracticed first; then practiced. Keep new-first as the tiebreaker
   among unpracticed. Among practiced, sort by `lastPracticedAt` desc.
   ```
   unpracticed (new-first by createdAt)  →  practiced (recent-first by lastPracticedAt)
   ```
3. **Optional collapse:** if a tab has many practiced topics, render them under a collapsed
   "Practice again (N)" `ExpansionTile`-style header at the bottom. For MVP, sinking + a divider
   labeled "Practiced" is enough — collapse is a nice-to-have.
4. **`_TopicCard` badge:** when `progress[topic.id] != null`, show a **✓ Practiced** chip + the
   **best score** (e.g. "Best 82") in the meta row, alongside the existing time / phrase-count.
   Add a `_PracticedBadge` mirroring `_NewBadge`'s style (use `PmpColors.success500` accent). A topic
   can show both New and Practiced only in edge cases — prefer Practiced if both.
5. **"New this week" rail:** exclude already-practiced topics from the rail (the rail is a discovery
   surface — showing practiced ones there defeats it).

### 2d. Trigger a progress refresh

After a session completes (return from the feedback flow), the list should reflect the new
practiced-state. Simplest: reload progress in `initState`/on route re-focus, or expose a
`refresh` event on whatever holds the progress map. Don't over-engineer — a reload when the list
page is shown is fine.

---

## Phase 3 — Gemini batch-seeding (LATER, when the key lands)

Reuse the **same `expand_topic` engine** built for own-topic prep (see `OWN_TOPIC_AI_PREP_PLAN.md`):
run it server-side / offline to generate `vocabulary` / `target_phrases` / `warmup_questions` for a
new topic title → admin reviews/edits → publishes to `daily_speaking_topics`. One expansion engine,
two uses (live own-topic prep + batch suggested-topic seeding). No mobile change for this phase.

---

## Admin app — what to add (you flagged this)

The web admin app (`pmp_english_admin`, which owns prod-Supabase migrations) needs CRUD for the new
tables. Scope for the admin side (separate repo — note it, don't build it here):

- **Topics management screen:** list / create / edit / publish-toggle / reorder (`sort_order`)
  `daily_speaking_topics`. Form fields = the columns above, with **repeatable sub-forms** for the
  JSONB arrays:
  - Vocabulary rows: `term`, `definition_mm`, `example_en`.
  - Target-phrase rows: `phrase_en`, `translation_mm`.
  - Warmup-question rows: plain strings.
- **Validation** to keep the JSONB shape exactly matching `DailySpeakingTopic.fromJson` (snake_case
  keys; difficulty enum). A bad shape will silently break the mobile parse.
- **Publish gate:** `is_published` controls mobile visibility (RLS reads only published) — so admins
  can draft topics without exposing them.
- Apply both DDL blocks above as **migrations** in the admin app's Supabase CLI (Phase 1 table now;
  `user_topic_progress` when auth ships).
- (Phase 3) an "AI-generate scaffold" button that calls the expand engine to pre-fill the JSONB
  sub-forms for review.

---

## Theme & localization (mandatory)

- **Theme:** match `suggested_topic_list_page.dart` exactly. Colors from `Theme.of(context).colorScheme`
  + `PmpColors` (`success500` for the Practiced badge/accent, `warning500`, `destructive400` already
  used per difficulty). Text via `PmpTextStyles` (`body1Semi`, `label2Regular`, `sub`, `subBold`).
  Reuse the `_NewBadge` recipe for `_PracticedBadge`. No raw `Color(0x…)` / `TextStyle(...)` literals.
- **Localization:** every string via `AppLocalizations.of(context).txtDs…` backed by
  `lib/l10n/intl_en.arb`. New keys to add: `txtDsPracticed` ("Practiced"), `txtDsBestScore` (param,
  e.g. "Best {score}"), `txtDsPracticeAgain` ("Practice again"). Regenerate l10n after editing the
  ARB. AI/admin-authored Burmese content stays as data.

---

## Definition of done

**Phase 1**
- [ ] `daily_speaking_topics` table created on prod Supabase (via admin app migration) + ~10–15 seeded published topics with rich JSONB content.
- [ ] `DailySpeakingTopicBloc` fetches from Supabase, caches, and falls back to `topics.json` offline.
- [ ] List page renders Supabase topics identically to before; `flutter analyze` clean; codegen run.

**Phase 2 (UI now, server when auth lands)**
- [ ] `TopicProgress` + `TopicProgressRepository` with `LocalTopicProgressRepository` (Drift sessions).
- [ ] List sorts unpracticed-first, practiced sunk; `_PracticedBadge` + best score on practiced cards.
- [ ] "New this week" rail excludes practiced topics.
- [ ] New `txtDs*` strings added + l10n regenerated; theme matches; no literals.
- [ ] `user_topic_progress` DDL written into the guide/admin app but **NOT** applied until auth — clearly marked.

**Phase 3** — deferred; documented only.

## Reference files (read, don't blindly copy)

- `lib/bloc/daily_speaking/daily_speaking_topic_bloc.dart` — the loader to repoint to Supabase.
- `lib/screens/daily_speaking/suggested/suggested_topic_list_page.dart` — the list UI to extend.
- `lib/bloc/daily_speaking/daily_speaking_history_bloc.dart` — `_rowToSession` shows how to decode
  `feedbackJson` → `DailySpeakingFeedback` (for `bestScore`).
- `lib/tables/daily_speaking_session_table.dart` — the session table the local progress reads.
- `lib/model/daily_speaking/daily_speaking_topic.dart` — the unchanged model + exact JSON keys.
- `lib/services/supabase_service.dart` — the `supabase` client singleton.
- `lib/config/pmp_colors.dart`, `pmp_text_styles.dart` — design tokens.
- `OWN_TOPIC_AI_PREP_PLAN.md` — the expand engine reused for Phase 3 seeding.
```
