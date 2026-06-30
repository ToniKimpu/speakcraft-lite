# YouTube Import — Feature Plan

> **Status (2026-07-01):** Phases 1–6 **DONE** (backend deployed, Flutter wiring
> analyze-clean). Remaining: **Phase 7** (polish), and ⚠️ set the
> **`YOUTUBE_API_KEY`** secret before a real end-to-end import works. Untested on
> a device: the SnapTube/VidMate intent and a real import round-trip.

User-imported YouTube videos that become full **Listening & Shadowing** lessons.
The user pastes a YouTube link, supplies the audio (via file upload or by handing
off to SnapTube/VidMate), and the app turns it into a lesson that flows through
the *exact same* lesson hub as curated content.

> **Why it reuses everything:** an imported video is just a `Listening`
> (`model/listening/listening.dart`). Once we produce its subtitle/feature JSON,
> the existing hub, shadowing, challenge, explanation, and progress machinery
> work on it unchanged.

---

## Locked decisions

| Decision | Choice |
|---|---|
| Storage | **Supabase (synced)** — per-user table + feature JSON in **Supabase Storage** (NOT Bunny). Survives reinstall, syncs across devices, powers the "My Videos" tab. Bunny stays for curated content only. |
| Access gating | **Free lifetime quota** (reuse the `youtube_import` meter pattern). |
| Free user gets | **Watch (subtitles) + Burmese (MM) translation**. Other 5 steps locked (upsell). |
| Premium user gets | All 6 steps; each enriched step **generated lazily on first open**, cached. |
| Lesson depth | Mirror curated **6-step** lesson. Free import baseline = subtitle + MM; rest premium. |
| Enrichment model | **`gemini-2.5-flash-lite`** (not a premium model) — keeps per-video cost ~1–2¢. Used for refine, translate, and all enrichment. |
| Free duration cap | **≤ 10 min** (caps Whisper at ~$0.06). Premium: looser cap (~30–60 min). |
| Transcription | Whisper-class ASR with **word-level** timestamps (WhisperX or OpenAI `verbose_json` word granularity — needed for shadowing). |

---

## The 6 lesson steps & their JSON schemas (grounded in `assets/grit/`)

Visibility is path-driven (`lib/screens/listening_and_shadowing/utils/lesson_steps.dart`):
`watch, keyTakeaways, explanation, shadowing, record, challenge`. An empty path
hides a step — **except** for imports, where locked-but-ungenerated steps must
still show (as premium upsell). See "Gating" below.

### 1. Watch — `main_subtitle.json`
```jsonc
[{ "id": 1, "start": 12.923, "end": 21.798,
   "english": "...", "burmese": "...",
   "explanation_url": "<folder>/sentence_explanation_data/<slug>.json" }]
```
- `english` from ASR (after a cleanup pass: punctuation + sentence splitting).
- `burmese` from MM translation (free baseline includes this).
- `explanation_url` points to the per-sentence explanation (lazy; may not exist yet).

### 2. Explanation — per-sentence files (no index)
- The sentence list is derived from `main_subtitle.json`; each line's
  `explanation_url` points at its own file (`explanation/NNNN.json`), generated
  lazily as the learner pages. For imports the list shows **every** sentence even
  before its file exists.
- **Per sentence**: the canonical **`__template.json`** shape rendered by
  `SentenceExplanationJsonView`:
```jsonc
{ "title": "Short English headline",
  "main": { "english": "...", "burmese": "...", "highlights": ["..."] },
  "terms": [{ "number": 1, "kind": "Noun|Verb|Phrase|Grammar Pattern|...",
              "term": "...", "translation_my": "...", "definition_my": "...",
              "examples": [{ "english": "...", "burmese": "..." }] }],
  "note": { "title_my": "စကားပြောမှတ်ချက်", "body_my": "..." } }
```
> ⚠️ The local `assets/grit/sentence_explanation_data/*.json` files use an older
> `{sentence_id, words[]}` shape — **legacy**, do not target it. Generate to the
> `__template.json` shape.

### 3. Shadowing — `shadowing.json`
```jsonc
[{ "id": "#001", "start": 12.923, "end": 21.798, "text": "...",
   "words": [{ "word": "When", "start": 12.923, "end": 13.063, "score": 1.0 }] }]
```
- Per unit: the sentence `text` + **word-level** timings (from Whisper word
  timestamps; `score` is WhisperX-only, defaulted to 1.0 for OpenAI Whisper).

### 4. Record — `record_subtitle.json`
```jsonc
[{ "id": "#001", "start": 12.923, "end": 21.798,
   "data": [{ "start": 12.923, "end": 21.798, "text": "..." }] }]
```
- Chunked shape (`data[]`), distinct from shadowing's `words[]`.

### 5. Key Takeaways — `key_takeaways.json`
```jsonc
{ "video_id": "...", "youtube_id": "...", "title": "...", "title_my": "...",
  "summary_my": "...", "takeaway_count": 21,
  "takeaways": [{ "id": 1, "category": "grammar_pattern|vocabulary|...",
    "headword": "...", "gloss_my": "...", "explanation_my": "...",
    "examples": [{ "english": "...", "burmese": "...", "highlight": ["..."] }],
    "source": { "english": "...", "sentence_id": 5 }, "tip_my": "..." }] }
```

### 6. Challenge — derived from `main_subtitle.json` (no generation)
The "graduation" step: listen with subtitles hidden and mark the sentences you
can't catch. Built **client-side** from the subtitle data — no separate JSON, no
LLM call.

> **`multiple_choice` and `vocabulary` are NOT generated for imports.** Neither is
> an actual lesson step in `visibleLessonSteps` (`watch, keyTakeaways, explanation,
> shadowing, record, challenge`). `multiple_choice.json` exists in curated `grit/`
> assets but isn't consumed by the hub; `hasVocabularies` is `false` for imports.
> The `multiple_choice_path` column is left vestigial.

---

## Generation mapping (what each step costs / when it runs)

| Step | Source | When | Cost |
|---|---|---|---|
| ASR transcript + word timings | Uploaded audio → Whisper | At import | ~$0.06 (10 min) |
| **Refine** (merge fragments → clean sentences) | Gemini, 1 call | At import | <½¢ |
| `main_subtitle` English | from refine | At import | — |
| MM translation (`burmese`) | Gemini | At import (**free baseline**) | ~$0.001 |
| `shadowing` | Whisper word restructure | At import | ~free |
| `key_takeaways` | Gemini | **Lazy** on first open (premium) | <½¢ |
| `record` (Speak on your own, grouped) | Gemini grouping pass | **Lazy** on first open (premium) | <½¢ |
| `sentence_explanation` per sentence | Gemini (template shape) | **Lazy** per sentence as paged (premium) | ~½¢/sentence |
| `challenge` | client-side from subtitle | on open | free |

Token usage (Gemini in/out) + `whisper_audio_sec` accumulate on the
`user_imports` row (`increment_import_tokens` RPC) for cost monitoring.
Worst-case fully-used free import ≈ **~$0.06** (Whisper dominates; refine +
translate are sub-cent).

---

## Backend services

A small Express app (or Supabase Edge Functions to match the existing pattern):

Implemented as **Supabase Edge Functions** (match the existing pattern):

1. **`POST /yt-meta`** `{ url }` → YouTube Data API v3 (`part=snippet,contentDetails`)
   → `{ youtubeId, title, channelTitle, thumbnailUrl, durationSeconds, sourceUrl }`.
2. **`POST /yt-transcribe`** (multipart audio + meta) → premium/quota/**duration
   gate** (gates on `max(youtubeDuration, clientAudioDurationSec)`) → Whisper
   (word + segment) → **refine pass** (merge fragments, timings rebuilt from
   original segments) → MM translation → builds `main_subtitle` + `shadowing` in
   public `user-imports` bucket → inserts `user_imports` row. Returns
   `durationMismatch` flag. Accumulates Gemini tokens + `whisper_audio_sec`.
3. **`POST /yt-enrich`** `{ import_id, step, line_id? }` → premium-only, idempotent
   (returns cached if path set). `step` ∈ `record` | `key_takeaways` |
   `explanation`. Gemini returns sentence-id refs only; all start/end/text derived
   from stored subtitle (no invented timestamps). `explanation` writes one file
   per sentence + updates that line's `explanation_url`, returns `{ url, data }`.
   Accumulates tokens.

Secrets (never client-exposed): **`YOUTUBE_API_KEY`** (⚠️ still to be set),
`OPENAI_API_KEY`, `GEMINI_API_KEY`.

---

## Supabase schema

```
user_imports
  id              uuid pk
  user_id         uuid  -> auth.users
  youtube_id      text
  title           text
  thumbnail_url   text
  duration_sec    int
  source_url      text          -- canonical watch URL
  subtitle_path   text          -- storage path to main_subtitle.json
  shadowing_path  text
  record_path     text
  -- lazily-populated; empty until generated:
  key_takeaways_path        text default ''
  sentence_explanation_path text default ''
  multiple_choice_path      text default ''
  created_at      timestamptz default now()
```
- Feature JSON lives in the public **Supabase Storage** bucket `user-imports`
  (NOT Bunny — Bunny is curated-only) at `<user_id>/<import_id>/<file>.json`.
- **Explanation loader change** ✅ DONE: both explanation loaders + Key Takeaways
  use `explanation_url` / path **as-is when absolute** (imports), prepending the
  Bunny base only for relative (curated) paths.
- RLS: owner SELECT + DELETE; INSERT/UPDATE via service role (Edge Functions).
- Quota = `COUNT(user_imports)` for the user (rows inserted only on success);
  caps in `youtube_import_config` (free lifetime, free/premium duration).
- Token columns: `gemini_input_tokens`, `gemini_output_tokens`, `whisper_audio_sec`
  (cumulative, via `increment_import_tokens` RPC).

A repo `Listening` is built from a `user_imports` row at read time (map columns →
`Listening` fields; `youtubeId`, `title`, `thumbnail`, `start=0`, `end=duration`,
paths from storage URLs).

---

## Flutter changes

### Listening list → two tabs
`lib/screens/listening_and_shadowing/listening_list_page.dart`:
- Wrap body in a `TabBar`/`TabBarView`: **Library** (curated, existing list) and
  **My Videos** (user imports).
- Library keeps `_ModuleIntroCard`. My Videos gets its own empty-state
  ("Paste a YouTube link to turn any video into a lesson") + an import entry
  point (`+` in app bar or FAB).
- Imports list reuses `_ListeningCard` (built from `user_imports` → `Listening`).

### Import screen (new) — route `PmpRoutes.youtubeImport`
Flow:
1. **Paste YouTube URL** (mandatory). On submit → `GET /yt-meta`.
   - Extract video ID via regex (`watch?v=`, `youtu.be/`, `shorts/`).
   - Show preview card: thumbnail + title + duration.
   - Enforce free duration cap (≤10 min) + quota pre-check before enabling actions.
2. Until a **valid** URL resolves, both action buttons are **disabled**.
3. Two actions (enabled after URL resolves):
   - **① Get the audio** → deep-link to SnapTube/VidMate (see below).
   - **② Import audio** → file picker → optional compress → upload to `/transcribe`.
4. After file pick: compare uploaded audio duration vs `durationSeconds` (±~3 s);
   warn on mismatch (subtitles may be out of sync).
5. On success: create `user_imports` row + store subtitle/shadowing JSON → open in
   the existing lesson hub. Lands in **My Videos**.

### SnapTube / VidMate hand-off (Android only)
- `android_intent_plus`: `ACTION_SEND`, `type=text/plain`, `EXTRA_TEXT=<url>`,
  `package=com.snaptube.premium` (SnapTube) / `com.nemo.vidmate` (VidMate).
- Add `<queries>` entries for those packages in `AndroidManifest.xml` (Android 11+
  visibility) to detect-if-installed and show only present apps; else a fallback
  ("Get SnapTube/VidMate") opening their site.
- Acceptable because the app is **not** Play-Store-distributed.

### Gating
- Free user: `watch` + MM subtitle available. Other 5 steps shown **locked**.
- Premium user: tapping a locked/ungenerated step → spinner → `POST /generate-step`
  → cache path on the `user_imports` row → render.
- Needs an imports-aware variant of `visibleLessonSteps` that **shows all 6**
  (locking ungenerated ones) rather than hiding empty paths. Curated lessons keep
  today's hide-on-empty behavior.

---

## Build phases

1. **Backend** ✅ DONE (deployed to remote `speakcraft`): `yt-meta` + `yt-transcribe`
   with **duration guard** (`max(youtube, clientAudio)`), **refine pass** (merge
   Whisper fragments, timings preserved), MM translation, token tracking. Builds
   `main_subtitle` + `shadowing` (record is now lazy). Migration
   `20260630140000_youtube_imports`. ⚠️ **Pending: set `YOUTUBE_API_KEY` secret**.
   TODO later: >25 MB chunking for long premium imports.
2. **Supabase** ✅ DONE: `user_imports` table + RLS + public `user-imports` bucket +
   `youtube_import_config` quota/caps. Token columns + `increment_import_tokens`
   added in `20260701120000_user_imports_tokens`.
3. **Flutter import screen** ✅ DONE: `YoutubeImportPage` (`PmpRoutes.youtubeImport`)
   — URL gate → `yt-meta` preview → file pick (on-device duration read +
   mismatch warning) → `yt-transcribe` → opens the lesson hub.
   `YoutubeImportRepository` + `UserImport.toListening()`. "Get audio" = copy-link +
   open-video bottom sheet (proper SnapTube/VidMate intent is Phase 5).
4. **Tabs** ✅ DONE: `ListeningListPage` split into **Library** (curated) / **My
   Videos** (imports). Import entry point + empty state live in the My Videos tab
   — NOT a home-screen card. The existing single Listening home card opens this.
5. **SnapTube/VidMate** ✅ DONE: `downloader_handoff.dart` (Android-only) detects
   installed apps via `AndroidIntent.canResolveActivity()` and hands the link off
   with `ACTION_SEND` (`text/plain`, `EXTRA_TEXT`) to `com.snaptube.premium` /
   `com.nemo.vidmate`. "Get audio" sheet shows "Send to <app>" (installed) or
   "Get <app>" (opens their site), with Copy-link / Open-video fallbacks; iOS
   shows fallbacks only. Manifest `<queries>` package entries added.
   `android_intent_plus` dependency added.
6. **Lazy enrichment + gating** ✅ DONE: `yt-enrich` (record / key_takeaways /
   explanation) deployed. `Listening.importId` marks imports; `visibleLessonSteps`
   shows the generatable steps for imports; `isFree:false` → free users get
   Watch + MM only, the rest premium-locked. Hub generates key_takeaways/record on
   tap (blocking "Preparing…" dialog → `yt-enrich` → path populated → open);
   explanation list shows every sentence and the pager generates each one on
   demand. Explanation loaders + Key Takeaways handle absolute import URLs.
7. **Polish**: progress UX, error states, quota-exhausted upsell, optional A/V
   sync nudge. _(Not started.)_

---

## Open questions / risks

- **Whisper host** — RESOLVED: server uses **OpenAI `whisper-1`** (`verbose_json`,
  word + segment). 25 MB cap; >25 MB chunking still TODO for long premium imports.
- **A/V sync**: uploaded audio vs YouTube playback can drift if the file is trimmed
  differently. Client now warns on a >15% / >60 s mismatch before upload; a manual
  ±0.5 s subtitle nudge in the player is still a possible Phase 7 safety valve.
- **Explanation shape** — RESOLVED: `__template.json` is the only target; the
  legacy `{sentence_id, words[]}` files are deprecated.
- **Quota / caps**: defaults in `youtube_import_config` — free lifetime **5**,
  free duration **600 s**, premium **3600 s** (admin-editable). Confirm final values.
```
