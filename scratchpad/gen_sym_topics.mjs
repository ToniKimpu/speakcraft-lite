// Speak Your Mind — topic generator (Gemini), plan-first.
//
// Step 1 (frame): plan the topic meta + 14–15 communicative MOVE titles.
// Step 2 (fill):   generate 3–4 chunks for EACH planned move (parallel).
// This guarantees breadth (≥12 moves) — a single-shot call "satisfices" and
// returns too few. Validates highlight ∈ text_en, tag enum, Burmese present.
// Output → scratchpad/sym_generated/<id>.json. NOT committed.
//
// Run:  node scratchpad/gen_sym_topics.mjs

import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { resolve } from 'node:path';

const ROOT = resolve(import.meta.dirname, '..');
const OUT_DIR = resolve(ROOT, 'scratchpad/sym_generated');
mkdirSync(OUT_DIR, { recursive: true });

const envText = readFileSync(resolve(ROOT, '.envs/.env.dev'), 'utf8');
const KEY = (envText.match(/^GEMINI_API_KEY=(.+)$/m) || [])[1]?.trim();
if (!KEY) throw new Error('GEMINI_API_KEY not found in .envs/.env.dev');
const MODELS = ['gemini-3.1-flash-lite', 'gemini-2.5-flash'];

const gold = JSON.parse(
  readFileSync(resolve(ROOT, 'assets/speak_your_mind/my_family.json'), 'utf8'),
);
const goldMoveList = gold.toolbox.map((m) => `- ${m.move_en} (${m.move_mm})`).join('\n');
const goldChunks = JSON.stringify(gold.toolbox[0].items, null, 2);

const MIN_MOVES = 12;
const TARGET_MOVES = 15;

const LEVEL = 3;
const DISCUSS = { domain_en: 'Discussing issues', domain_mm: 'ပြဿနာနဲ့ ခေတ်ပြိုင်ခေါင်းစဉ်များ ဆွေးနွေးခြင်း', kind: 'discuss' };
const briefs = [
  { ...DISCUSS, id: 'climate_and_environment', title_en: 'Climate & the Environment',
    focus: 'the environment — climate change, pollution, what is causing it, its effects, what people and governments can do, your view.' },
  { ...DISCUSS, id: 'technology_and_ai', title_en: 'Technology & AI',
    focus: 'how technology and AI are changing life and work — the benefits, the risks, effects on jobs and people, your view on the future.' },
  { ...DISCUSS, id: 'education_today', title_en: 'Education Today',
    focus: 'education — problems with the current system, exams vs real skills, what should change, the role of teachers, your view.' },
  { ...DISCUSS, id: 'health_and_modern_life', title_en: 'Health & Modern Life',
    focus: 'health in modern life — stress, fast food, sitting all day, mental health, causes, effects, what people can do, your view.' },
  { ...DISCUSS, id: 'the_future_of_work', title_en: 'The Future of Work',
    focus: 'how work is changing — automation, remote work, the job market, what skills will matter, the risks and opportunities, your view.' },
  { ...DISCUSS, id: 'news_and_misinformation', title_en: 'News & Misinformation',
    focus: 'news and fake news online — why misinformation spreads, its effects on society, how to tell real from fake, your view.' },
  { ...DISCUSS, id: 'rich_and_poor', title_en: 'Rich & Poor',
    focus: 'the gap between rich and poor — causes, effects on society, whether it is fair, what could reduce it, your view.' },
  { ...DISCUSS, id: 'english_in_our_lives', title_en: 'English in Our Lives',
    focus: 'the role of English — why it matters for work and study, its effect on local languages and culture, the pressure to learn it, your view.' },
  { ...DISCUSS, id: 'young_people_today', title_en: 'Young People Today',
    focus: 'young people today — how their lives differ from past generations, screens and social media, pressures they face, your view.' },
  { ...DISCUSS, id: 'life_in_the_future', title_en: 'Life in the Future',
    focus: 'how life might change in the next 20 years — technology, cities, work, the environment, your hopes and worries.' },
];

const FRAME_SCHEMA = {
  type: 'object',
  properties: {
    title_mm: { type: 'string' },
    promise_en: { type: 'string' }, promise_mm: { type: 'string' },
    intro_en: { type: 'string' }, intro_mm: { type: 'string' },
    moves: {
      type: 'array',
      items: {
        type: 'object',
        properties: { move_en: { type: 'string' }, move_mm: { type: 'string' } },
        required: ['move_en', 'move_mm'],
      },
    },
    produce: {
      type: 'object',
      properties: {
        prompt_en: { type: 'string' }, prompt_mm: { type: 'string' },
        min_words: { type: 'integer' }, max_words: { type: 'integer' },
        coverage_hints: { type: 'array', items: { type: 'string' } },
        speak_aloud_en: { type: 'string' }, speak_aloud_mm: { type: 'string' },
      },
      required: ['prompt_en', 'prompt_mm', 'min_words', 'max_words',
        'coverage_hints', 'speak_aloud_en', 'speak_aloud_mm'],
    },
  },
  required: ['title_mm', 'promise_en', 'promise_mm', 'intro_en', 'intro_mm',
    'moves', 'produce'],
};

const CHUNKS_SCHEMA = {
  type: 'object',
  properties: {
    items: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          text_en: { type: 'string' },
          highlight: { type: 'string' },
          swap_en: { type: 'string' },
          gloss_mm: { type: 'string' },
          tag: { type: 'string', enum: ['simple', 'natural', 'advanced'] },
        },
        required: ['text_en', 'highlight', 'swap_en', 'gloss_mm', 'tag'],
      },
    },
  },
  required: ['items'],
};

const SYSTEM = `You are an ESL curriculum author writing "Speak Your Mind" topics for
Burmese (Myanmar) adult learners who know grammar/vocabulary but freeze when they try
to PRODUCE their own English. A topic is a TOOLBOX of usable phrases grouped by
communicative "move" (a function you can do when talking about the topic). Burmese
must be correct, natural Unicode Myanmar (meaning, not word-for-word). Use authentic
Myanmar context where natural (Yangon, Mandalay, pagoda, tea shop, kyat) but keep
phrases reusable. Match the tone and depth of the gold example "My Family".`;

async function callGemini(promptText, responseSchema) {
  let lastErr;
  for (const model of MODELS) {
    for (let attempt = 0; attempt < 2; attempt++) {
      try {
        const res = await fetch(
          `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${KEY}`,
          {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              systemInstruction: { parts: [{ text: SYSTEM }] },
              contents: [{ role: 'user', parts: [{ text: promptText }] }],
              generationConfig: {
                responseMimeType: 'application/json',
                responseSchema,
                temperature: 0.8,
                maxOutputTokens: 8192,
              },
            }),
          },
        );
        if (!res.ok) { lastErr = `${model} HTTP ${res.status}: ${(await res.text()).slice(0, 200)}`; continue; }
        const data = await res.json();
        const text = (data?.candidates?.[0]?.content?.parts ?? [])
          .map((p) => p.text ?? '').join('').trim();
        if (!text) { lastErr = `${model}: empty`; continue; }
        return JSON.parse(text);
      } catch (e) { lastErr = `${model}: ${e.message}`; }
    }
  }
  throw new Error(lastErr);
}

const kindGuidance = (b) => {
  if (b.kind === 'story') {
    return `This is a STORY topic. The moves should walk through telling a real PAST experience in order: ` +
      `setting the scene (when/where/who), what happened (in sequence), the turning point or problem, ` +
      `how you felt, the outcome, and looking back. Use natural PAST tense (was/were, went, did, felt). ` +
      `The produce prompt asks the learner to TELL their own story.`;
  }
  if (b.kind === 'discuss') {
    return `This is an ISSUE / CURRENT-TOPIC discussion. The moves should be functions for discussing a ` +
      `broad issue: introducing the issue, describing the current situation, giving different ` +
      `perspectives/sides, explaining causes, explaining effects/consequences, comparing, giving your ` +
      `own view, suggesting solutions, and concluding. Use discussion language ("There's a lot of debate ` +
      `about…", "On one hand… on the other hand…", "This has led to…", "One possible solution is…", ` +
      `"It's a complex issue…"). The produce prompt asks the learner to DISCUSS the issue and share their view.`;
  }
  return `This is an OPINION topic. The moves should be functions for giving a view: stating your opinion, ` +
    `giving reasons, giving an example from your life, agreeing/disagreeing, weighing both sides, and ` +
    `concluding. Use opinion language ("I think…", "In my opinion…", "I'd say…", "On the other hand…"). ` +
    `The produce prompt asks the learner to give THEIR opinion with reasons.`;
};

async function frame(b) {
  // Retry until the plan has enough moves.
  for (let attempt = 0; attempt < 3; attempt++) {
    const f = await callGemini(
      `Plan the topic "${b.title_en}" (Level ${LEVEL}). Focus: ${b.focus}\n\n` +
      `${kindGuidance(b)}\n\n` +
      `Return the topic FRAME: title_mm, promise_en/mm, intro_en/mm, a "produce" block ` +
      `(prompt asks them to write 8–12 sentences; min_words 80, max_words 250; ` +
      `coverage_hints = 6–8 short English tags echoing the moves; speak_aloud_* = "read your final answer aloud 2–3 times…" same style as gold), ` +
      `and a list of EXACTLY ${TARGET_MOVES} distinct communicative "moves" (move_en + move_mm). ` +
      `Each move is one thing a learner can DO when telling this story / giving this opinion, ordered logically. ` +
      `You MUST return at least ${MIN_MOVES} moves — breadth matters.\n\n` +
      `For STRUCTURE reference (not content), the gold topic "My Family" used these ${gold.toolbox.length} moves:\n${goldMoveList}`,
      FRAME_SCHEMA,
    );
    if ((f.moves?.length ?? 0) >= MIN_MOVES) return f;
  }
  throw new Error(`frame never reached ${MIN_MOVES} moves`);
}

async function chunksFor(b, move) {
  const r = await callGemini(
    `Topic "${b.title_en}", move "${move.move_en}" (${move.move_mm}).\n` +
    `Generate between 3 and 7 example chunks for THIS move only — at least 3, and more ` +
    `(up to 7) only when the move genuinely warrants richer variety. Order them ` +
    `simple → natural → advanced (tag each).\n` +
    `${b.kind === 'story'
      ? 'Write the examples in natural PAST tense, as if telling a story (was/were, went, did, felt).'
      : b.kind === 'discuss'
      ? 'Write the examples as discussion statements about the issue in general (present tense; e.g. "Many people believe…", "This is becoming a serious problem…", "One major cause is…", "This could lead to…").'
      : "Write the examples as opinion statements using opinion language (I think…, In my opinion…, I'd say…)."}\n` +
    `Rules: "highlight" MUST be an exact substring of "text_en" (copy verbatim). ` +
    `"swap_en" = " · "-separated alternative fillers for the highlighted slot (may be ""). ` +
    `"gloss_mm" = natural Burmese meaning.\n\n` +
    `Style reference (gold chunks for "Saying your family size"):\n${goldChunks}`,
    CHUNKS_SCHEMA,
  );
  return (r.items ?? []).map((c) => ({
    text_en: c.text_en,
    highlight: healHighlight(c.text_en ?? '', c.highlight ?? ''),
    swap_en: c.swap_en ?? '',
    gloss_mm: c.gloss_mm ?? '', tag: c.tag ?? '', audio: '',
  }));
}

/// Snap a highlight to the real substring of text_en. The model sometimes
/// lowercases a sentence-initial phrase or adds a "…" placeholder; a
/// case-insensitive match recovers the exact span, else we drop the highlight.
function healHighlight(textEn, hl) {
  if (!hl) return '';
  if (textEn.includes(hl)) return hl;
  const i = textEn.toLowerCase().indexOf(hl.toLowerCase());
  return i >= 0 ? textEn.substring(i, i + hl.length) : '';
}

function validate(topic) {
  const issues = [];
  if (topic.toolbox.length < MIN_MOVES) {
    issues.push(`only ${topic.toolbox.length} moves (need ≥${MIN_MOVES})`);
  }
  const tags = new Set(['simple', 'natural', 'advanced']);
  topic.toolbox.forEach((m, mi) => {
    if (!m.move_mm?.trim()) issues.push(`move ${mi + 1}: empty move_mm`);
    if (m.items.length < 3) issues.push(`move ${mi + 1} ("${m.move_en}"): only ${m.items.length} chunks`);
    m.items.forEach((c, ci) => {
      const where = `move ${mi + 1} item ${ci + 1}`;
      if (c.highlight && !c.text_en.includes(c.highlight)) {
        issues.push(`${where}: highlight "${c.highlight}" NOT in text_en`);
      }
      if (!tags.has(c.tag)) issues.push(`${where}: bad tag "${c.tag}"`);
      if (!c.gloss_mm?.trim()) issues.push(`${where}: empty gloss_mm`);
    });
  });
  return issues;
}

const summary = [];
for (const b of briefs) {
  process.stdout.write(`\n▶ ${b.id} … planning`);
  try {
    const f = await frame(b);
    process.stdout.write(` ${f.moves.length} moves, filling…`);
    const filled = await Promise.all(
      f.moves.map((m) => chunksFor(b, m).then((items) => ({ ...m, items }))),
    );
    const toolbox = filled.filter((m) => m.items.length >= 3);
    const topic = {
      id: b.id, level: LEVEL, domain_en: b.domain_en, domain_mm: b.domain_mm,
      title_en: b.title_en, title_mm: f.title_mm,
      promise_en: f.promise_en, promise_mm: f.promise_mm,
      intro_en: f.intro_en, intro_mm: f.intro_mm,
      toolbox: toolbox.map((m) => ({ move_en: m.move_en, move_mm: m.move_mm, items: m.items })),
      produce: { ...f.produce },
    };
    const issues = validate(topic);
    const chunks = topic.toolbox.reduce((s, m) => s + m.items.length, 0);
    writeFileSync(resolve(OUT_DIR, `${b.id}.json`), JSON.stringify(topic, null, 2) + '\n', 'utf8');
    process.stdout.write(` → ${topic.toolbox.length} moves, ${chunks} phrases, ${issues.length} issue(s)`);
    issues.slice(0, 6).forEach((i) => process.stdout.write(`\n    ⚠ ${i}`));
    summary.push({ id: b.id, moves: topic.toolbox.length, chunks, issues: issues.length });
  } catch (e) {
    process.stdout.write(` FAILED — ${e.message}`);
    summary.push({ id: b.id, error: e.message });
  }
}

console.log('\n\n── Summary ──');
for (const s of summary) {
  console.log(s.error ? `✗ ${s.id}: ${s.error}`
    : `${s.issues ? '⚠' : '✓'} ${s.id}: ${s.moves} moves, ${s.chunks} phrases, ${s.issues} issue(s)`);
}
console.log(`\nFiles in: ${OUT_DIR}`);
