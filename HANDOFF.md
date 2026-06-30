 hi pls take a look again this 'D:\PMP_Projects\speakcraft-mobile\lib\screens\daily_speaking\history' I want to add polish & retry in history too, and
  currently in history detail, I don't see all feedback we see in feedback I meant in history it contain only 'yours' and 'neutral' version, and if possible,
  currently our history is not obvious just 'refrsh' icon, can we improve that too?


# 📋 Session Handoff — SpeakCraft Lite

> Read this first, then continue. Last updated end of the Vocabulary + "Speak Your Mind" session.

## Where we are
Two features were built. **Vocabulary is done & live.** **"Speak Your Mind" is a fresh prototype awaiting review on the phone.**

---

## ✅ DONE & shipped (committed + Supabase live)

**Vocabulary module** — online-only (Supabase + computed Bunny audio):
- **Beginner** (L1): 29 groups, full audio — **FREE**
- **Intermediate** (L2): 21 groups, full audio — **PREMIUM (locked)**
- **Upper** (L3): "coming soon" (V2)
- **Premium gating**: DB `is_free` flag (only L1 = true) + client-side enforcement via `lib/screens/.../premium_gate.dart`. Migration `20260628160000_vocab_is_free.sql` already pushed to PROD.
- **IPA fix**: IPA now renders in `GoogleFonts.notoSans()` (global font lacked phonetic glyphs).

---

## 🟡 PROTOTYPE — built, compiles clean ("No issues found!"), NOT committed

**"Speak Your Mind"** — new standalone home card (cyan, lightbulb icon). Teaches learners who *know grammar but can't speak* to **produce** their own ideas. One lesson so far: **"Giving your opinion."**

**Format** = a guided pager / scaffolded ladder (support fades each step):
1. Goal + Point→Reason→Example shape
2. Toolkit — 4 sentence frames, each w/ meaning, when-to-use, 🔊 audio
3. Rung 1 — Fill the frame (own life)
4. Rung 2 — Answer with a frame
5. Rung 3 — Point→Reason→Example (model = 3 labelled lines)
6. Rung 4 — Speak freely (30s prompt + mic cue)
7. Done

Every produce-step has a **"Show model answer"** reveal (English + 🔊 + Burmese). Fully bilingual, bundled JSON, **no backend**.

**Files (all new / uncommitted):**
- `assets/speak_your_mind/giving_opinions.json`
- `lib/model/speak_your_mind/sym_models.dart`, `sym_loader.dart`
- `lib/screens/speak_your_mind/speak_your_mind_page.dart`, `sym_lesson_page.dart`
- Wiring: `lib/config/pmp_routes.dart` (`speakYourMind` + `speakYourMindLesson`), `lib/screens/main/home_screen.dart` (card), `pubspec.yaml` (`assets/speak_your_mind/`)

**Deferred on purpose:** Rung 4 does NOT record/AI-grade — it's self-compare-to-model. Next layer (if format approved) = record (`record` pkg / `Recorder` widget) + AI feedback (writing-review-style endpoint), optionally pre-generated Burmese narration.

---

## ⏭️ Next steps
1. **Build/run the app** to review Speak Your Mind on the phone (needs a fresh build — all new Dart + bundled asset; Supabase data is already live).
2. Give feedback on **format / pedagogy**.
3. Then decide:
   - Commit the prototype?
   - Keep as its own home pillar, or fold into a "Speaking" hub with Daily Speaking?
   - Add the recording + AI-feedback layer?
   - Productionize content to Supabase?

---

## ⚙️ Project rules (don't forget)
- **NEVER** use global `flutter`/`dart`. Use FVM-pinned `.fvm/flutter_sdk/bin/flutter` (3.35.6). `analyze` triggers `pub get` (can clobber `pubspec.lock`).
- Supabase: **PROD** = `yoolagzhgxilukjsypbh` (user tests prod flavor), **DEV** = `sxvinmhindryyaztzktn`. Migrations live in `speakcraft-admin/supabase/migrations/` → applied with `supabase db push`.
- **Secrets:** `GEMINI_API_KEY` in `.envs/.env.dev` (gitignored, bundled into APK — read-only keys only). Bunny read-WRITE key in `.bunny.env` (repo root, gitignored, never bundled). `SUPABASE_SERVICE_ROLE_KEY` in admin `.env.local`. Scratchpad scripts touching keys are NOT committed. Don't commit `.claude/settings.local.json`. Admin repo: commit only our files, no git remote.
- **EdgeTTS voices:** EN `en-GB-RyanNeural` (words) / `en-GB-SoniaNeural` (examples); **Burmese `my-MM-NilarNeural` (f) / `my-MM-ThihaNeural` (m)**. Gemini does NOT support Burmese TTS.
- **Bunny audio is computed, not stored**: `bunny/<levelFolder>/<group>/<slug>.mp3` ({1:beginner,2:intermediate,3:upper}); examples `<slug>-ex<N>.mp3`. `has_audio` boolean gates playback.

---

## 🗑️ Cleanup note
This `HANDOFF.md` is a scratch handoff — delete it (or move to memory) once the next session has picked up, so it doesn't get committed.
