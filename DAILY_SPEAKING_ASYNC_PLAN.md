# Daily Speaking — Async (Job + Poll) Pipeline Plan

## Why

The `daily-speaking-review` edge function is **synchronous**: the app opens one HTTP
request and waits for the whole Gemini call. A 5-minute clip's call duration is
*variable* (depends on Gemini load) and sometimes exceeds the edge worker's
wall-clock limit → the worker is killed → `WORKER_RESOURCE_LIMIT (546)` →
`DailySpeakingBusyException`. It's a **coin flip** (works sometimes, fails
sometimes), which is unacceptable for a paid feature.

A length cap can't fix this — it only changes the odds. **Certainty comes from
making the work a resumable job that retries until it succeeds**, and from
splitting the slow part so each piece reliably fits a worker. Reference: the
production `transcribe-long` function (in `feedback/transcribe-long/`).

## Key design decisions (from the reference)

1. **Job + poll**: submit returns a `session_id` in ~1s; Gemini runs in the
   background; the app polls the session row until `status` is terminal. Nobody
   holds a long connection → the client never times out.
2. **Resumable + sweep-retry**: a cron re-invokes any job stuck/errored. Since a
   5-min call works *sometimes*, retrying converges to *always*.
3. **Split transcribe / analyze, right model per step** (the big insight):
   - **Transcribe (audio → text)** on **flash-lite** — forgiving task, cheap,
     and what the reference uses for transcription.
   - **Analyze (text → feedback)** on **flash** — the structured judgment
     (categorising fixes, word choice) where lite was "too general/unreliable".
   - Cheaper than all-flash (audio runs on lite), better than all-lite (judgment
     runs on flash), and each call is shorter → less wall-clock pressure.
4. **Audio in Storage** (already done) — request body stays tiny.
5. **Output validation** — reject hallucinated/garbage output (silence loops,
   refusals) with a friendly reason instead of saving junk. Port
   `feedback/transcribe-long/transcript-validator.ts`.
6. **`EdgeRuntime.waitUntil` + self-invoke** to run each step in a *fresh worker*
   with a fresh time budget.

## Target architecture

```
Client                     daily-speaking-review        daily-speaking-process        DB row
  │ upload audio→Storage         (SUBMIT)                   (WORKER, _internal)
  │ POST review ───────────────► auth+quota+validate
  │                              INSERT status='queued' ─────────────────────────────► [queued]
  │                              waitUntil(invoke process,'transcribe')
  │ ◄──────── {session_id} ◄──── (returns ~1s)
  │                                                         transcribe: lite, audio→text
  │ poll row every 2s ──────────────────────────────────────────────────────────────► [transcribing]
  │ ◄ status='transcribing'                                 validate transcript
  │                                                         UPDATE transcript ───────► [analyzing]
  │                                                         waitUntil(invoke,'analyze')
  │                                                         analyze: flash, text→feedback
  │ poll ───────────────────────────────────────────────────────────────────────────► [analyzing]
  │                                                         UPDATE feedback,'completed'► [completed]
  │ poll ───────────────────────────────────────────────────────────────────────────► [completed]
  │ ◄ status='completed' + feedback → show result

daily-speaking-sweep (cron, every 1 min): re-invoke any row stuck in a non-terminal
status past a timeout, or status='error' with attempts < MAX. Guarantees completion.
```

## Phased rollout

Build in stages so you're never stuck and never over-build. Each phase is
shippable. We size 1→2→3 with a **measurement** (Phase 0).

### Phase 0 — Measure (tiny, do first)
- Add `console.log("DSR_DONE geminiMs=…")` right after the Gemini call.
- Run several 5-min clips; record `geminiMs` and whether they 546.
- **Decision gate:** if single calls are usually < the worker limit and only the
  *held connection* was the problem, Phase 1 alone fixes it. If single calls
  themselves blow the limit, we need Phase 2 (split) and maybe Phase 3 (chunk).

### Phase 1 — Foundation: job + poll + sweep (the bulk of the value)
Keeps the **current single combined Gemini call**, just makes it async + retryable.

**DB migration** (`daily_speaking_sessions`):
- `status text not null default 'completed'` — values: `queued` |
  `processing` | `completed` | `error`. Default `completed` so legacy rows read
  as done.
- `error_message text`
- `attempts int not null default 0`
- `processing_started_at timestamptz`
- Index on `(status, processing_started_at)` for the sweep.

**Edge: `daily-speaking-review` becomes SUBMIT-only**
- Auth + quota gate + validate `audio_path` (fast).
- `INSERT` row with `status='queued'`, the topic/on_ramp/chain fields, `audio_path`.
- `EdgeRuntime.waitUntil(invokeProcess(session_id))` (fetch self → process fn,
  service-role auth, `_internal:true`).
- Return `{ session_id }` immediately (HTTP 202).

**Edge: new `daily-speaking-process`** (`_internal`, service role)
- Compare-and-set `status` `queued`→`processing`, stamp `processing_started_at`.
  (Guard so sweep + waitUntil can't double-process.)
- Download audio → run the existing Gemini review call → validate → `UPDATE`
  row with `feedback`, tokens, `ai_model`, `status='completed'`.
- On failure: `attempts++`, `status='error'`, `error_message`. (Sweep will retry
  if attempts < MAX; else it stays errored.)

**Edge: new `daily-speaking-sweep`** (cron via `pg_cron`/scheduled function, 1 min)
- `SELECT` rows where `status='processing' AND processing_started_at < now()-'2 min'`
  OR `status IN ('queued','error') AND attempts < MAX_ATTEMPTS`.
- Re-invoke `daily-speaking-process` for each. Idempotent (re-running overwrites
  feedback).

**Client** (`daily_speaking_service` + bloc + repo)
- `reviewSession`: upload audio → invoke `daily-speaking-review` → get
  `session_id` → **poll** `daily_speaking_sessions` by id every ~2s until
  `status` ∈ {completed, error}, with a client cap (~5 min).
  - `completed` → deserialize `feedback`, return.
  - `error` → throw with `error_message` (typed: limit / no-speech / busy).
  - client cap reached → throw a "still processing — check history shortly"
    state (the job keeps running server-side; it'll appear in history).
- Bloc `submitting` state stays during polling (optionally surface
  `processing`/`analyzing` substatus for nicer UX).
- Repo: `Future<DailySpeakingSession?> byId(int id)` / a status fetch.

**Quota accounting** (IMPORTANT)
- Gate at submit on `session_count` (free 1/day) as today, BUT the usage RPC must
  count only **non-error** sessions (or only `completed`), so a failed/retried
  job doesn't burn the user's daily quota or double-count on retry.
- Tokens are known only at completion → token sum already keys off the row's
  token columns, which are written at completion. No change needed beyond the
  status filter.

**Acceptance:** a 5-min clip never shows a dead-end "busy"; worst case the
spinner runs longer, then the result appears (sweep covers worker deaths). No
double quota charge on retry.

### Phase 2 — Split transcribe (lite) / analyze (flash)
Only if Phase 0 shows single combined calls are too slow, OR for quality/cost.

**DB:** add `transcript text` (intermediate) if not reusing `input_text`.
**`daily-speaking-process`** gains a `phase` arg:
- `phase='transcribe'`: audio → text on **flash-lite** (transcription-only
  prompt) → validate → store `transcript` → `status='analyzing'` →
  `waitUntil(invokeProcess(id,'analyze'))`.
- `phase='analyze'`: read `transcript` → feedback on **flash** (the existing
  analysis prompt, but **text input** instead of audio) → store feedback →
  `completed`.
- Each phase = a fresh worker → the slow audio step and the judgment step never
  share one budget.
**Sweep** re-invokes at the correct phase based on `status`.

**Acceptance:** analysis always fits (text-only is fast); only transcription can
be slow, and it's now isolated + on the cheap model.

### Phase 3 — Chunk transcription (only if a single transcribe call is still too big)
Full `transcribe-long` treatment for the transcribe phase:
- Client (or submit fn) splits audio into ~chunks; store `storage_chunks[]`,
  `total_chunks`.
- `phase='transcribe'` processes one chunk, accumulates `transcript`, carries
  `previous_context` (last ~500 chars) + `deduplicateOverlap`, then self-invokes
  the next chunk (fresh worker each). When the last chunk lands → `analyze`.
**Acceptance:** any length transcribes reliably; no single worker does it all.

### Phase 4 — Polish (independent, adopt anytime)
- **Output validation**: port `transcript-validator.ts` (trim English-specific
  garbage patterns) — reject silence/hallucination with a friendly message.
- **Realtime instead of polling** (optional): subscribe to the session row for
  instant updates, drop the 2s poll.
- **Admin-configurable models per tier** (optional, like `getAIConfig`): models
  in a config table → change flash/lite without redeploy.

## Cross-cutting concerns

- **Idempotency:** every phase overwrites its own output, so re-running is safe.
  Guard double-processing with a compare-and-set on `status` (only proceed if the
  row is in the expected pre-state).
- **Security:** `daily-speaking-process` and `-sweep` are service-role
  (`_internal`); validate `audio_path` starts with the owner's uid (already do).
  The submit fn stays user-JWT-gated.
- **`waitUntil` death:** if the submit worker dies before dispatching, the row is
  `queued` and the sweep picks it up → still processed.
- **Client abandons (app closed):** job completes server-side, shows in history.
- **MAX_ATTEMPTS:** ~5. After that, leave `status='error'` for good; the result
  page shows a retry button (free — no quota spent).
- **`@google/genai` SDK + Files API:** optional adoption; lets us drop the 20MB
  inline ceiling for the transcribe step. Not required for ≤5-min speech.

## Files touched (estimate)

Admin (`pmp_english_admin`):
- `supabase/migrations/…_daily_speaking_async.sql` (status/attempts/etc.)
- `supabase/functions/daily-speaking-review/index.ts` (→ submit-only)
- `supabase/functions/daily-speaking-process/index.ts` (new worker)
- `supabase/functions/daily-speaking-sweep/index.ts` (new cron) + pg_cron schedule
- (Phase 2/3) transcribe/analyze prompt split; (Phase 4) validator port

Mobile (`speakcraft-mobile`):
- `lib/services/daily_speaking/daily_speaking_service.dart` (submit → poll)
- `lib/bloc/daily_speaking/daily_speaking_bloc.dart` (submitting stays through poll)
- `lib/repositories/daily_speaking/daily_speaking_session_repository.dart` (byId/status)
- Optional: a `processing` substatus in the spinner UI

## Rollback

Async is additive (new columns default to `completed`; new functions are
separate). To revert: point `daily_speaking_service` back at the synchronous
invoke and stop the sweep cron. Old completed sessions are unaffected throughout.

## Open questions to resolve before/while building

1. **Phase 0 measurement:** is a single combined call usually under the worker
   limit? (Decides whether we need Phase 2/3 now or later.)
2. **Polling vs Realtime** for the client (start with polling).
3. **Exact worker wall-clock limit** on the current Supabase plan (informs the
   sweep stuck-timeout and whether splitting is mandatory).
4. **Quota semantics on failure:** confirm the usage RPC filters out `error`
   rows so retries/failures don't burn the daily quota.
