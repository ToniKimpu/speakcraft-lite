// Generates the optional "guide" (gradual-release on-ramp) block for ONE SYM
// topic and merges it into the topic JSON. Validates that every {token} in the
// template has a matching slot and vice-versa, and that a filled template reads
// as a paragraph. Run:  node scratchpad/gen_sym_guide.mjs my_family

import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';

const ROOT = resolve(import.meta.dirname, '..');
const id = process.argv[2] || 'my_family';
const TOPIC_PATH = resolve(ROOT, `assets/speak_your_mind/${id}.json`);

const envText = readFileSync(resolve(ROOT, '.envs/.env.dev'), 'utf8');
const KEY = (envText.match(/^GEMINI_API_KEY=(.+)$/m) || [])[1]?.trim();
if (!KEY) throw new Error('GEMINI_API_KEY missing');
const MODELS = ['gemini-3.1-flash-lite', 'gemini-2.5-flash'];

const topic = JSON.parse(readFileSync(TOPIC_PATH, 'utf8'));
const moveList = topic.toolbox.map((m) => `- ${m.move_en} (${m.move_mm})`).join('\n');

const schema = {
  type: 'object',
  properties: {
    model_en: { type: 'string' },
    model_mm: { type: 'string' },
    breakdown: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          text_en: { type: 'string' },
          gloss_mm: { type: 'string' },
          why_mm: { type: 'string' },
        },
        required: ['text_en', 'gloss_mm', 'why_mm'],
      },
    },
    template: { type: 'string' },
    slots: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          id: { type: 'string' },
          label_en: { type: 'string' },
          label_mm: { type: 'string' },
          hint: { type: 'string' },
          options: { type: 'array', items: { type: 'string' } },
        },
        required: ['id', 'label_en', 'label_mm', 'hint', 'options'],
      },
    },
  },
  required: ['model_en', 'model_mm', 'breakdown', 'template', 'slots'],
};

const SYSTEM = `You are an ESL author building a GUIDED first-draft scaffold for Burmese
adult learners who freeze at a blank page. Gradual release: show a worked model, then
let them fill only the changeable blanks to assemble THEIR own paragraph. Everything must
be strictly about the GIVEN topic — never about a different subject. Burmese must be
natural Unicode Myanmar. Keep sentences short, clear, and simple.`;

const prompt = `Topic: "${topic.title_en}" (domain: ${topic.domain_en}). Its toolbox moves:\n${moveList}\n\n` +
  `Build a guided first-draft scaffold STRICTLY about "${topic.title_en}". Every sentence must be ` +
  `about this topic — do NOT write about family or any other subject unless this topic is about it.\n\n` +
  `Create a "guide" with:\n` +
  `1) model_en: a natural 10–12 sentence (~70–90 word) first-person example paragraph that a learner ` +
  `could realistically write for THIS topic, drawing on the toolbox moves above. Keep sentences short ` +
  `and simple. (Story topic → tell a short PAST-tense story; opinion/discussion topic → give a clear ` +
  `view with reasons.)\n` +
  `2) model_mm: natural Burmese meaning of the whole paragraph.\n` +
  `3) breakdown: ONE entry per sentence of model_en — text_en (the exact sentence), ` +
  `gloss_mm (Burmese meaning), why_mm (Burmese: what this sentence DOES in the piece).\n` +
  `4) template: the SAME paragraph but with the changeable bits replaced by {slot} tokens ` +
  `(snake_case ids that describe the bit, e.g. {when}, {place}, {what_happened}, {my_view}, {a_reason}). ` +
  `Use 8–10 slots. The fixed framing words stay; only the bits a learner would personalise become tokens.\n` +
  `5) slots: for EACH token, an object {id (EXACTLY the token name), label_en, label_mm, hint, ` +
  `options: 3–5 natural example choices (relevant to THIS topic) a learner could tap}.\n\n` +
  `CRITICAL: every {token} in template MUST have a matching slot id, and every slot id MUST ` +
  `appear in template. When tokens are replaced by options, the paragraph must read as correct, ` +
  `natural English about "${topic.title_en}".`;

async function call() {
  let lastErr;
  for (const model of MODELS) {
    for (let i = 0; i < 2; i++) {
      try {
        const res = await fetch(
          `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${KEY}`,
          {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              systemInstruction: { parts: [{ text: SYSTEM }] },
              contents: [{ role: 'user', parts: [{ text: prompt }] }],
              generationConfig: {
                responseMimeType: 'application/json',
                responseSchema: schema,
                temperature: 0.7,
                maxOutputTokens: 8192,
              },
            }),
          },
        );
        if (!res.ok) { lastErr = `${model} HTTP ${res.status}: ${(await res.text()).slice(0, 200)}`; continue; }
        const data = await res.json();
        const text = (data?.candidates?.[0]?.content?.parts ?? [])
          .map((p) => p.text ?? '').join('').trim();
        if (text) return JSON.parse(text);
        lastErr = `${model}: empty`;
      } catch (e) { lastErr = `${model}: ${e.message}`; }
    }
  }
  throw new Error(lastErr);
}

const guide = await call();

// The model sometimes wraps slot ids in braces — normalise to bare tokens.
for (const s of guide.slots) s.id = (s.id || '').replace(/[{}\s]/g, '');

// ── Validate token ↔ slot consistency ───────────────────────────────────────
const tokens = [...guide.template.matchAll(/\{(\w+)\}/g)].map((m) => m[1]);
const slotIds = guide.slots.map((s) => s.id);
const issues = [];
for (const t of tokens) if (!slotIds.includes(t)) issues.push(`token {${t}} has no slot`);
for (const s of slotIds) {
  // Unused slots are a real error; a slot used more than once is fine —
  // replaceAll fills every occurrence (natural, e.g. a place name repeated).
  if (!tokens.includes(s)) issues.push(`slot "${s}" not used in template`);
}
for (const s of guide.slots) if (!s.options?.length) issues.push(`slot "${s.id}" has no options`);

// Filled-paragraph preview (first option per slot).
let filled = guide.template;
for (const s of guide.slots) filled = filled.replace(`{${s.id}}`, s.options?.[0] ?? s.hint);

console.log('── model_en ──\n' + guide.model_en);
console.log('\n── template ──\n' + guide.template);
console.log('\n── filled (first options) ──\n' + filled);
console.log(`\n── slots (${guide.slots.length}) ──`);
for (const s of guide.slots) console.log(`  {${s.id}}  ${s.label_en} — [${s.options.join(' · ')}]`);
console.log(`\n── breakdown: ${guide.breakdown.length} lines ──`);
console.log(issues.length ? `\n⚠ ISSUES:\n  ${issues.join('\n  ')}` : '\n✓ template/slots consistent');

if (issues.length) {
  console.log('\nNOT merged (fix issues / re-run).');
} else {
  topic.guide = guide;
  writeFileSync(TOPIC_PATH, JSON.stringify(topic, null, 2) + '\n', 'utf8');
  console.log(`\n✓ merged guide into ${TOPIC_PATH}`);
}
