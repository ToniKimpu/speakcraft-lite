# Level 4 — IELTS Writing (design draft v0)

> **Status: paper-prototype for review. Nothing is wired into the app yet.**
> Goal: let you see *what an L4 unit is* before we build any Flutter. React to the
> shape and the tone; then I implement the model + screens.

## How L4 differs from L1–L3

| | L1–L3 (grammar units) | L4 (IELTS tasks) |
|---|---|---|
| Atom | one grammar point | one **writing task / genre** |
| Teach | situation → form → trap | task → **structure** → **band-booster language** → band-9 model |
| Practice | constrained drills + scan | **write a full essay** (type or handwrite-scan) |
| Feedback | "is this rule right?" | **4 IELTS criteria, each a band + Burmese fix** |
| The edge | Burmese-contrastive grammar | **"how to lift your band"**, Burmese-contrastive |

The advanced "control & style" moves (cohesion, nominalisation, hedging, sentence
variety) are **not** separate units here — they appear inside the teach as the
**band-boosters**: "here's band 6 → here's the same idea at band 7, and the
structure that did it."

---

## Unit shape (proposed JSON)

```jsonc
{
  "id": "l4_t2_opinion",
  "level": 4,
  "section_id": "4.1",
  "section": "Task 2 — Essays",
  "order": 1,
  "type": "ielts_task",          // NEW type (vs "grammar_unit")
  "task_type": "task2_opinion",  // task2_opinion | task2_discussion | task2_problem | ...
  "title": "Task 2: Opinion essay (agree / disagree)",
  "subtitle_mm": "ကိုယ့်သဘောထား အပြည့်အဝ ပြတဲ့ essay",

  "teach": {
    "prompt_en": "Some people think that children should begin formal education as early as possible. To what extent do you agree or disagree?",
    "prompt_mm": "ကလေးတွေဟာ ကျောင်းပညာကို တတ်နိုင်သမျှ စောစော စသင့်တယ်လို့ အချို့က ထင်ကြတယ်။ ဒီအပေါ် ဘယ်လောက်အထိ သဘောတူ / သဘောမတူလဲ။",

    "what_examiner_wants_mm": "Task 2 မှာ ✓ မေးခွန်းကို တိုက်ရိုက်ဖြေထားလား (Task Response) ✓ စဉ်းစားလို့ရအောင် စီထားလား (Coherence) ✓ စကားလုံး ကြွယ်ဝလား (Lexical Resource) ✓ grammar စုံလင် မှန်ကန်လား (Grammatical Range) — ဒီ ၄ ချက်ကို band အလိုက် အမှတ်ပေးပါတယ်။",

    // Step: STRUCTURE — the 4-paragraph skeleton, with a 1-line job for each.
    "structure": [
      { "part": "Introduction", "job_mm": "မေးခွန်းကို ကိုယ့်စကားနဲ့ ပြန်ရေး (paraphrase) ပြီး ကိုယ့်ရပ်တည်ချက် (thesis) ကို တစ်ကြောင်းနဲ့ ပြတ်ပြတ်သားသား ပြောပါ။" },
      { "part": "Body 1", "job_mm": "အဓိက အကြောင်းပြချက် ၁ — topic sentence → ရှင်းပြ → ဥပမာ။" },
      { "part": "Body 2", "job_mm": "အဓိက အကြောင်းပြချက် ၂ (ဒါမှမဟုတ် တစ်ဖက်အမြင်) — topic sentence → ရှင်းပြ → ဥပမာ။" },
      { "part": "Conclusion", "job_mm": "ကိုယ့်ရပ်တည်ချက်ကို ပြန်အကျဉ်းချုပ် — အကြောင်းအသစ် မထည့်ပါနဲ့။" }
    ],

    // Step: BAND BOOSTERS — the "control & style" moves, taught as upgrades.
    "boosters": [
      {
        "move_mm": "Cohesion — အပိုဒ်တွေ ဆက်စပ်အောင် linker သုံးပါ",
        "band6_en": "Children learn fast. Early school is good for them.",
        "band7_en": "Because young children absorb information so quickly, an early start to formal education can be highly beneficial.",
        "why_mm": "band 6 က ဝါကျတိုနှစ်ခု ဖြတ်ထားတယ်။ band 7 မှာ 'Because …' နဲ့ ချိတ်ပြီး အကြောင်း-အကျိုး တစ်ကြောင်းတည်း ဖြစ်သွားတယ် — Coherence တက်တယ်။"
      },
      {
        "move_mm": "Hedging — အပြတ် မပြောဘဲ ပညာရှင်ဆန်အောင်",
        "band6_en": "Early education makes children smarter.",
        "band7_en": "Early education appears to give children a significant academic advantage.",
        "why_mm": "'makes … smarter' က အလွန်အပြတ်အသတ်။ 'appears to / tends to' သုံးရင် သတိနဲ့ ပြောတဲ့ academic tone ဖြစ်ပြီး Lexical Resource တက်တယ်။"
      },
      {
        "move_mm": "Nominalisation — verb ကို noun ပြောင်းပြီး formal ဖြစ်အောင်",
        "band6_en": "If we teach children early, they develop faster.",
        "band7_en": "The early introduction of formal learning can accelerate a child's development.",
        "why_mm": "'we teach … they develop' (ကြိယာ) ကို 'the introduction … development' (နာမ်) ပြောင်းလိုက်တော့ စာရေးဆန်ပြီး Grammatical Range ပြတယ်။"
      }
    ],

    // Step: MODEL — a full band-9 sample (collapsible), bilingual notes.
    "model_en": "It is sometimes argued that children should enter formal education at the earliest possible age. While I acknowledge the benefits of early exposure, I largely agree that a structured start can be advantageous, provided it is age-appropriate. …(full ~270-word essay)…",
    "model_notes_mm": "ဒီ model မှာ boosters တွေ ဘယ်နေရာ သုံးထားလဲ ဆိုတာ highlight ပြထားမယ် — 'It is argued that' (impersonal), 'provided that' (cohesion), 'exposure / introduction' (nominalisation)။",

    // Common Burmese-learner traps for this task type.
    "trap_mm": "✗ မေးခွန်းကို ပြန်မဖြေဘဲ ဘာသာရပ်အကြောင်း ယေ�‌ဘုယျ ရေးချမိတာ (off-topic → Task Response ကျ)။ ✗ paragraph မခွဲဘဲ တစ်တုံးတည်း ရေးတာ။ ✗ 'I think / I think' ထပ်နေတာ — thesis ကို တစ်ခါတည်း ပြတ်ပြတ်ပြောပါ။"
  },

  // Practice = write the essay; AI grades on the 4 criteria.
  "exercises": [
    {
      "kind": "free_write",            // NEW kind (type OR handwrite-scan)
      "grade": "ai",
      "min_words": 250,
      "prompt_en": "Write your own answer to the essay prompt above (at least 250 words, ~40 min).",
      "prompt_mm": "အပေါ်က essay မေးခွန်းကို ကိုယ်တိုင် ဖြေရေးပါ (အနည်းဆုံး စကားလုံး ၂၅၀၊ ~၄၀ မိနစ်)။ စာအုပ်ထဲ ရေးပြီး scan တင်လည်းရ၊ ရိုက်ထည့်လည်းရ။",
      "grading": {
        "task": "IELTS Academic Writing Task 2 — opinion (agree/disagree) essay",
        "band_criteria": [
          "Task Response — does it answer the exact question with a clear position, developed throughout?",
          "Coherence & Cohesion — logical paragraphing, linking, progression",
          "Lexical Resource — range, precision, collocation, less repetition",
          "Grammatical Range & Accuracy — variety of structures, control"
        ],
        "return_mm": "criteria တစ်ခုစီကို band (e.g. 6.5) + အားသာချက် ၁ + အဓိက ပြင်စရာ ၁ (Burmese) ပြပါ။ ပြီးရင် overall band ခန့်မှန်း + အမှန်ပြင်ထားတဲ့ ဝါကျ ၂-၃ ခု ပြပါ။"
      }
    }
  ]
}
```

---

## What the learner sees (pager flow)

1. **THE TASK** — the prompt (EN + MM) + "what the examiner wants" (the 4 criteria, plain Burmese).
2. **STRUCTURE** — the 4-paragraph skeleton, one job per paragraph.
3. **BAND BOOSTERS** — 2–3 band 6 → band 7 upgrades (cohesion / hedging / nominalisation), Burmese-contrastive. *(this is the "control & style" content, in context)*
4. **MODEL** — a collapsible band-9 essay with the boosters highlighted.
5. **WATCH OUT** — the Burmese-learner traps for this task type.
6. **WRITE IT** — `free_write`, ~250 words, type or notebook+scan → **band feedback on the 4 criteria + Burmese fixes**.

---

## Audience & roadmap (decided 2026-06-19 — **Academic IELTS**)

Learners are mostly **Academic** (study/university), so Task 1 = **chart writing**.

- **Phase 1 — Task 2 essays (build first).** Text-only, worth ~2× Task 1, identical for
  Academic/GT, reuses the type/scan/grade pipeline. The 5 essay types: **opinion
  (agree/disagree), discussion (both views), advantages/disadvantages,
  problem/solution, two-part/direct.** This draft above is an *opinion* essay unit.
- **Phase 2 — Academic Task 1 charts (later, multimodal).** Describe a line/bar/pie/
  table/process/map. Needs an **image prompt** + multimodal grading (heavier). Same
  4-criteria engine, different teach template (no opinion; "describe trends & key
  figures objectively"; overview sentence; group data; no personal view).

### IELTS facts the design rests on (official: ielts.org / British Council / IDP)
- Task 1 ≈ 150 words / 20 min; Task 2 ≈ 250 words / 40 min; **Task 2 ≈ 2× the weight.**
- **4 criteria, equal weight, averaged → band:** Task Response · Coherence & Cohesion ·
  Lexical Resource · Grammatical Range & Accuracy. (Our band-boosters target 2/3/4.)
- Common Task 2 topics: education, technology, health, environment, government
  spending, work, crime, society, media → a `daily_speaking_topics`-style prompt bank.

## Open questions for you (after you read this)
- Tone of the Burmese — same warm teacher voice as L1–L3? (I kept it that way here.)
- Is band-9 model the right reference, or band-7 (more attainable / imitable)?
- First task type to build: **opinion (agree/disagree)** as drafted, or **discussion (both views)**?
- Band feedback depth: the per-criterion band + 1 fix shown here, or lighter?
