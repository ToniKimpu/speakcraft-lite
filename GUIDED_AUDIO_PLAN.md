# Guided-lesson audio — plan

Add native-voice audio to the guided "Start here" lessons so a beginner can
**hear** the model before imitating it. Covers: the model paragraph, each
sentence (line-by-line shadowing), and each vocab word (pronunciation).

Status: **POC done** for `01-self-intro` (bundled assets). This doc is the plan
to roll out to **all ~60 lessons** on Bunny CDN.

---

## 1. Approach (and why)

**Pre-generate audio offline; the app only plays files.** The model paragraph,
sentences, and vocab never change per user, so generating them once and shipping
the files is strictly better than runtime TTS:

- no runtime dependency on an unofficial endpoint, works offline, zero latency
- every clip can be listened to / approved before release
- free, and one consistent voice across the app

We generate with **`edge-tts`** (Microsoft Edge neural voices — free, no API key).

> **Licensing note (commercial app).** `edge-tts` talks to the undocumented Edge
> "Read Aloud" endpoint; the voices aren't clearly licensed for commercial
> redistribution. The license-clean path is **Azure TTS**, which exposes the
> *same voice names*. Plan: ship the MVP with `edge-tts`; if/when needed,
> regenerate via Azure — the audio stays identical because the voice is the same.

**Runtime TTS is only for dynamic text** (e.g. reading back the learner's own
assembled paragraph or AI feedback) — out of scope here; use `flutter_tts` or a
cloud call for that later.

---

## 2. What exists after the POC

- **`tools/guided_tts.py`** — generator. Reads a lesson JSON and writes
  `paragraph.mp3`, `s{index}.mp3`, `v_{vocabId}.mp3`. Voice/rate configurable.
  - `python tools/guided_tts.py` → all lessons
  - `python tools/guided_tts.py <file.json>` → one lesson
  - `python tools/guided_tts.py --voice en-US-GuyNeural --rate "-25%" <file>`
- **`assets/daily_speaking/guided/audio/guided_self_intro/`** — 11 clips, 232 KB,
  voice `en-US-JennyNeural` (bundled for review only).
- **`guided_lesson_page.dart`** — speaker buttons on the model paragraph header,
  each sentence card, and the vocab sheet. One shared `_GuidedAudio` player
  (tapping a new clip stops the previous). Buttons self-hide when the asset is
  missing (POC bundled-asset probe — replaced by `has_audio` in production).

---

## 3. Size & cost (60 lessons)

Per lesson ≈ 1 paragraph + ~6 sentences + ~10 vocab ≈ 17 clips. Real datapoint:
`self-intro` (shortest) = 11 clips / 232 KB. Longer L3 lessons run bigger.

- **Total ≈ 25–40 MB** for 60 lessons (~17–27 MB if encoded at 32 kbps).
- **Bunny storage**: ~30 MB → fractions of a cent / month.
- **Egress** (with on-device caching, so each clip downloads once per device):
  worst case per user ≈ the full 30 MB. At ~$0.01–0.045/GB:
  - 10k users × 30 MB ≈ 300 GB → ~$3–14 (lifetime)
  - 100k users × 30 MB ≈ 3 TB → ~$30–135 (lifetime)

Conclusion: store on **Bunny** (matches Listening), keep the app small, cache
locally. Egress is a non-issue as long as we cache.

---

## 4. Naming convention & where the URL comes from

**No per-clip URLs in the JSON.** The app derives every URL from one CDN base +
the lesson id + a fixed scheme (identical to what the generator emits):

```
{CDN_BASE}/daily_speaking/guided/{lessonId}/paragraph.mp3
                                            /s{index}.mp3        # 0-based
                                            /v_{vocabId}.mp3
```

- `CDN_BASE` lives in config/env (reuse the existing Bunny pull zone). One value.
- `lessonId` = the lesson's existing `id` (e.g. `guided_self_intro`).
- `index` = sentence position; `vocabId` = the vocab item's `id`.

**The only content change:** add a lesson-level **`has_audio` (bool, default
false)** so the app knows whether to render speaker buttons. (Remote files can't
be cheaply probed the way the bundled POC does.) When the guided content moves to
Supabase, this is just one boolean column.

Why convention over per-clip URLs:
- ~1,000 hand-maintained URLs vs **one** base value
- regenerating audio never requires rewriting JSON
- generator, uploader, and app all share a single source of truth for paths

---

## 5. Pipeline (per lesson, repeatable)

1. **Generate** — `python tools/guided_tts.py <lesson.json>` (chosen voice/rate).
2. **Review** — listen; regenerate if a clip is off (re-run is idempotent).
3. **Upload to Bunny** — push `audio/{lessonId}/*` to the pull zone under
   `daily_speaking/guided/{lessonId}/` (mirror `bunny_push.py`).
4. **Mark `has_audio: true`** on the lesson (JSON now; Supabase column later).

A `tools/guided_audio_push.py` (Bunny upload) is TODO — model it on the existing
`bunny_push.py`.

---

## 6. App changes for production (from the POC)

- **Swap bundled assets → streamed + cached URLs.** Replace `setAsset(path)` with
  a caching network source so each clip downloads once and is served from disk
  after (e.g. `just_audio` `LockCachingAudioSource(Uri.parse(url))`). `_audioBase`
  changes from an asset path to `{CDN_BASE}/daily_speaking/guided/{lessonId}`.
- **Gate buttons on `has_audio`**, not the bundled-asset probe in
  `_SpeakerButton._check()`.
- **Config**: add `CDN_BASE` for guided audio (reuse Listening's Bunny zone).
- Remove the temporary `assets/daily_speaking/guided/audio/...` bundle + its
  `pubspec.yaml` entry once streaming lands (or keep a tiny offline core — see
  Open decisions).

---

## 7. Voice & rate (decisions)

- **Default voice:** `en-US-JennyNeural` (clear US female). Alternatives to weigh:
  `en-US-GuyNeural` (US male), `en-GB-SoniaNeural` (UK female).
- **Speed:** consider generating a slow variant (`--rate "-25%"`) for beginners,
  exposed as a per-clip slow toggle. Would ~double clip count/size if shipped for
  every clip — decide before bulk generation.

---

## 8. Rollout checklist (all ~60 lessons)

- [ ] Finalize voice (+ whether to ship a slow variant).
- [ ] `tools/guided_audio_push.py` (Bunny upload).
- [ ] App: streaming + `LockCachingAudioSource`, `CDN_BASE` config, `has_audio` gate.
- [ ] Generate + review all lessons; upload; set `has_audio: true`.
- [ ] Decide bundled-offline-core vs pure-CDN (Open decisions).
- [ ] Remove POC bundle + pubspec entry (or keep curated offline core).
- [ ] (Later) regenerate via Azure if commercial licensing requires it.

---

## 9. Open decisions

1. **Storage**: pure Bunny+cache (recommended) vs hybrid (bundle the 60 paragraph
   clips ~12–15 MB for offline core, stream the rest).
2. **Slow variant**: ship per-clip slow audio, or skip for v1?
3. **Voice**: confirm Jenny, or compare alternatives first.
4. **Licensing**: `edge-tts` for launch, Azure-regenerate later — confirm OK.
