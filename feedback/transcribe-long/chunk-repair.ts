import type { GoogleGenAI } from '@google/genai'
import { Type } from '@google/genai'
import { shouldRefine } from './meeting/refine.ts'
import { detectDominantLanguage } from './refine-utils.ts'

/**
 * Per-chunk light-touch Burmese ASR repair — DIFF-ONLY design.
 *
 * Standard transcription has no repair step — raw Gemini output flows straight
 * into the final styled refine (and verbatim into "Keep Original"). This pass
 * fixes obvious transcription defects WITHOUT touching meaning, grammar, tone,
 * or sentence structure, before that final refine:
 *   1. mis-hearings (homophones, mis-segmented compounds, wrong loanwords),
 *   2. timestamp / subtitle-cue artifacts the speaker never said,
 *   3. segments mis-transcribed in the WRONG language (English where the
 *      speaker clearly spoke Burmese) — rewritten back into Burmese.
 *
 * Why diff-only (not the meeting Pass-2 full echo): the echo design round-trips
 * the ENTIRE transcript through gemini-2.5-flash-lite, so every segment is
 * regenerated and subtle paraphrases from a weak model slip past the guard —
 * staging output diverged from (and could regress below) the raw transcription.
 * Here the model returns ONLY the segments it changed ({index,text}); every
 * other segment stays byte-identical to the input. Worst case is a literal
 * no-op, so the repaired transcript is "at least as good as" the unrepaired one
 * by construction.
 *
 * Burmese-only (gated on the chunk's dominant language) and never throws —
 * returns the input unchanged on any error or for a non-Burmese chunk.
 */

// Output is just the changed segments now, so we can batch large without
// risking the 8192 output-token cap that forced ~1200-char batches in the echo
// design. Keep batches modest so a single flaky call reverts little.
const BATCH_CHARS = 2500
const REPAIR_PROMPT = `
You are a light-touch Burmese (Myanmar) transcript repairer.

You receive a numbered list of speech-to-text segments from a Burmese recording.
Identify ONLY the segments that need a fix and return a corrected version of
just those. Most segments need NO change — an empty list is the common, correct
answer.

WHAT TO FIX
- Mis-hearings: a homophone, a mis-segmented compound (Burmese words split or
  joined wrong), or a wrong loanword transliteration, where the intended word is
  unambiguous from the surrounding context.
- Timestamp / subtitle artifacts: if a segment contains clock timestamps,
  SRT/VTT cue numbers, or "-->" ranges the speaker did not say (e.g. "00:12",
  "[00:01:23]", "00:00:05,000 --> 00:00:08,000"), remove ONLY those artifacts
  and keep the spoken words intact.
- Wrong language: the recording is Burmese. If a segment was transcribed in
  English (or romanised Burmese) where the speaker clearly spoke Burmese —
  judging from the surrounding Burmese segments — rewrite it in Burmese,
  preserving the meaning, tone, and dialect. This is a transcription error, NOT
  the speaker switching languages.
- Truncated sentences: if a segment clearly cuts off mid-thought and the
  intended ending is obvious from the surrounding context, complete it
  MINIMALLY — a few words to close the thought, in the speaker's own voice.
  Don't be extreme: never invent new facts, names, numbers, or clauses the
  speaker did not imply. If the completion isn't obvious, leave it as-is.

WHAT NOT TO DO — STRICT
- Do NOT rephrase, formalise, condense, summarise, or "clean up" Burmese that is
  already Burmese and already reads correctly. Keep the speaker's own words,
  grammar, dialect, slang, tone, and word choice.
- Do NOT add new information, opinions, facts, names, or numbers the speaker did
  not say.
- NEVER drop or alter the final Burmese verb-ending particle (တယ်, ပါတယ်, မယ်,
  ပါမယ်, ဘူး, ပါ, ပါပြီ, နေတယ်, ထားတယ်, လိုက်တယ်, မှာ, ပေါ့) — it carries tense and meaning.
- Genuine code-switching STAYS: English words or phrases the speaker actually
  said (brand names, technical terms, loanwords) must be kept exactly. Only fix
  English that is a mis-transcription of Burmese speech.
- If a segment already reads correctly, return it UNCHANGED.

OUTPUT: a JSON object { "fixes": [ { "index": <the segment number as given>, "text": "<corrected full segment>" } ] }
`.trim()
const REPAIR_SCHEMA = {
  type: Type.OBJECT,
  properties: {
    fixes: {
      type: Type.ARRAY,
      items: {
        type: Type.OBJECT,
        properties: { index: { type: Type.INTEGER }, text: { type: Type.STRING } },
        required: ['index', 'text'],
      },
    },
  },
  required: ['fixes'],
}

// ─── Guard (language-aware) ────────────────────────────────────────────────
// Kept local (not the meeting validateRefinedSegment) so the standard pipeline
// can allow the two larger-but-legitimate edits — timestamp removal and a
// wrong-language→Burmese rewrite — without loosening the meeting guard. Keep in
// sync with services/transcribe-chunk/src/lib/chunk-repair.ts.

// Longest-first so "ပါတယ်" matches before "တယ်".
const BURMESE_VERB_PARTICLES = [
  'နေပါတယ်', 'ထားပါတယ်', 'လိုက်ပါတယ်',
  'ပါတယ်', 'ပါမယ်', 'ပါပြီ', 'ပါဘူး',
  'နေတယ်', 'ထားတယ်', 'လိုက်တယ်',
  'တယ်', 'မယ်', 'ဘူး', 'ပြီ', 'ပေါ့', 'ပါ', 'မှာ',
]
const stripTrailingPunct = (s: string): string => String(s ?? '').replace(/[။၊.\?!,;:]+\s*$/u, '').trim()
function endingParticle(s: string): string | null {
  const stripped = stripTrailingPunct(s)
  for (const p of BURMESE_VERB_PARTICLES) if (stripped.endsWith(p)) return p
  return null
}
// Per-SEGMENT Burmese test for the guard. detectDominantLanguage needs ~12
// Burmese chars to fire, which short real sentences (greetings, "ဟုတ်ကဲ့",
// "ဒါပေါ့") don't reach — they'd then bypass the particle/shrink guard and the
// model could quietly truncate them. Count any meaningful Burmese instead, so
// short and code-switched Burmese stay protected; only near-pure-Latin segments
// (an English mis-transcription) read as non-Burmese and may be rewritten.
function isBurmese(s: string): boolean {
  let n = 0
  for (const ch of String(s ?? '')) { const c = ch.codePointAt(0)!; if (c >= 0x1000 && c <= 0x109f) n++ }
  return n >= 4
}
// Drop clock/cue artifacts before the length comparison so legitimate timestamp
// removal doesn't read as "the model deleted spoken words".
const TIMESTAMP_TOKENS = /(\d{1,2}:\d{2}(?::\d{2})?(?:[.,]\d{1,3})?|-->)/g
const withoutTimestamps = (s: string): string => s.replace(TIMESTAMP_TOKENS, ' ').replace(/\s+/g, ' ').trim()

/**
 * Decide whether to keep the model's change to a segment. Reverts:
 *  - empty refinement (a segment can't be deleted via replacement),
 *  - turning Burmese speech into another language (never translate out),
 *  - a dropped/altered Burmese verb particle on a Burmese→Burmese edit,
 *  - >15% content shrink on a Burmese→Burmese edit (timestamps excluded).
 * A wrong-language→Burmese rewrite legitimately changes length, so the shrink
 * and particle checks don't apply to it.
 */
function guardKeep(original: string, refined: string): { kept: string; reverted: boolean } {
  if (refined === original) return { kept: refined, reverted: false }
  if (typeof refined !== 'string' || refined.trim().length === 0) return { kept: original, reverted: true }
  const origB = isBurmese(original)
  const refB = isBurmese(refined)
  if (origB && !refB) return { kept: original, reverted: true }
  if (origB && refB) {
    const op = endingParticle(original)
    if (op && endingParticle(refined) !== op) return { kept: original, reverted: true }
    if (refined.length < withoutTimestamps(original).length * 0.85) return { kept: original, reverted: true }
  }
  return { kept: refined, reverted: false }
}

export interface ChunkRepairResult {
  /** Repaired text (or the original, unchanged, when skipped/errored). */
  text: string
  /** Summed Gemini usageMetadata across batches, or null. */
  usage: { promptTokenCount: number; candidatesTokenCount: number; totalTokenCount: number } | null
  /** Count of guard reverts (model changes rejected as regressions). */
  reverts: number
  /** True when no Gemini call ran (non-Burmese chunk, empty, or every batch errored). */
  skipped: boolean
}

interface Seg { rawIndex: number; core: string }

// Split keeping the Burmese sentence terminator ။ attached. We do NOT trim the
// raw pieces — joining them with '' reconstructs the input exactly, so applying
// a fix touches only its segment and leaves all surrounding whitespace intact.
function splitRaw(text: string): string[] {
  return text.split(/(?<=။)/)
}

function intoBatches(segs: Seg[]): Seg[][] {
  const batches: Seg[][] = []
  let cur: Seg[] = []
  let len = 0
  for (const s of segs) {
    cur.push(s)
    len += s.core.length
    if (len >= BATCH_CHARS) { batches.push(cur); cur = []; len = 0 }
  }
  if (cur.length) batches.push(cur)
  return batches
}

interface BatchFix { rawIndex: number; text: string }

async function repairBatch(
  ai: GoogleGenAI,
  model: string,
  segs: Seg[],
): Promise<{ fixes: BatchFix[]; reverts: number; usage: unknown }> {
  const numbered = segs.map((s, i) => `${i + 1}. ${s.core}`).join('\n')
  const response = await ai.models.generateContent({
    model,
    contents: { parts: [{ text: `Repair these ${segs.length} Burmese segments. Return only the ones you changed:\n\n${numbered}` }] },
    config: {
      systemInstruction: REPAIR_PROMPT,
      responseMimeType: 'application/json',
      responseSchema: REPAIR_SCHEMA,
      temperature: 0,
      maxOutputTokens: 4096,
    },
  })
  const usage = response.usageMetadata ?? null
  let raw: Array<{ index?: unknown; text?: unknown }> = []
  try {
    const obj = JSON.parse(response.text ?? '{}')
    if (Array.isArray(obj?.fixes)) raw = obj.fixes
  } catch { /* malformed JSON → no fixes for this batch */ }

  const fixes: BatchFix[] = []
  let reverts = 0
  for (const fx of raw) {
    const j = Number(fx?.index) - 1
    if (!Number.isInteger(j) || j < 0 || j >= segs.length) continue
    const seg = segs[j]
    if (!seg) continue
    const g = guardKeep(seg.core, typeof fx?.text === 'string' ? fx.text.trim() : '')
    if (g.reverted) { reverts++; continue }
    if (g.kept !== seg.core) fixes.push({ rawIndex: seg.rawIndex, text: g.kept })
  }
  return { fixes, reverts, usage }
}

export async function repairChunkBurmese(
  ai: GoogleGenAI,
  model: string,
  text: string,
): Promise<ChunkRepairResult> {
  const dominantLanguage = text ? detectDominantLanguage(text) : null
  if (!text || !shouldRefine(dominantLanguage)) {
    return { text, usage: null, reverts: 0, skipped: true }
  }

  const rawSegs = splitRaw(text)
  const segs: Seg[] = []
  rawSegs.forEach((s, i) => { const core = s.trim(); if (core) segs.push({ rawIndex: i, core }) })
  if (!segs.length) return { text, usage: null, reverts: 0, skipped: true }

  // Each batch is an independent Gemini call; a failed batch yields no fixes.
  const results = await Promise.all(
    intoBatches(segs).map((batch) =>
      repairBatch(ai, model, batch).catch(() => ({ fixes: [] as BatchFix[], reverts: 0, usage: null })),
    ),
  )

  const usage = { promptTokenCount: 0, candidatesTokenCount: 0, totalTokenCount: 0 }
  let reverts = 0
  let ranAny = false
  const replacements = new Map<number, string>()
  for (const r of results) {
    reverts += r.reverts
    for (const f of r.fixes) replacements.set(f.rawIndex, f.text)
    if (r.usage && typeof r.usage === 'object') {
      ranAny = true
      const u = r.usage as Record<string, number>
      usage.promptTokenCount += u.promptTokenCount ?? 0
      usage.candidatesTokenCount += u.candidatesTokenCount ?? 0
      usage.totalTokenCount += u.totalTokenCount ?? 0
    }
  }

  // skipped reflects "no Gemini call ran", not "text unchanged" — a successful
  // call that proposed zero net fixes still cost tokens and must be logged,
  // while the text stays byte-identical to the input.
  if (replacements.size === 0) return { text, usage: ranAny ? usage : null, reverts, skipped: !ranAny }

  // Rebuild touching only changed segments; preserve each segment's original
  // leading/trailing whitespace so the rest of the transcript is byte-identical.
  const out = rawSegs.map((s, i) => {
    const fix = replacements.get(i)
    if (fix === undefined) return s
    const lead = s.match(/^\s*/)?.[0] ?? ''
    const trail = s.match(/\s*$/)?.[0] ?? ''
    return lead + fix + trail
  })
  return { text: out.join(''), usage, reverts, skipped: false }
}
