import type { GoogleGenAI } from '@google/genai'
import { getActiveSystemPrompt } from './system-prompts.ts'
import { logAiUsage, extractTokenUsage } from './ai-logger.ts'
import { createServiceClient } from './supabase-client.ts'

/**
 * Styles whose refined output must equal the transcript verbatim.
 *
 * For these we skip the refinement LLM call entirely. Feeding a long
 * transcript through a generative JSON round-trip makes the model
 * summarise it instead of reproducing it — and any transcript over
 * ~40k chars physically cannot fit in one response (output-token
 * ceiling). The only safe "keep original" is to pass the transcript
 * straight through and generate the title separately.
 *
 * Matched case-insensitively against the style's canonical English name.
 * The Node/Cloud Run copy lives in services/transcribe-chunk/src/lib/refine.ts
 * and the Next.js copy in src/lib/services/refine.ts — keep them in sync.
 */
const PASSTHROUGH_STYLE_NAMES = ['keep original']

export function isPassthroughStyle(name: string | null | undefined): boolean {
  return !!name && PASSTHROUGH_STYLE_NAMES.includes(name.trim().toLowerCase())
}

/**
 * Robustly parse a Gemini refine JSON response into { refinedText, title }.
 * Gemini intermittently wraps JSON in ```` ```json ```` fences and emits
 * literal (unescaped) newlines inside string values — a bare JSON.parse then
 * fails and the raw, fence-wrapped string leaks into the note body. This strips
 * fences, escapes in-string newlines, and tries multiple candidates. Returns
 * null only when every candidate fails (caller falls back to verbatim text).
 * Ported from src/lib/services/refine.ts so all refine copies parse alike.
 */
export function parseRefineJson(raw: string): { refinedText?: string; title?: string } | null {
  const stripped = raw.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/, '').trim()
  const repairNewlines = (s: string): string => {
    let inString = false
    let result = ''
    for (let i = 0; i < s.length; i++) {
      const ch = s[i]
      if (ch === '"' && (i === 0 || s[i - 1] !== '\\')) inString = !inString
      if (inString && ch === '\n') result += '\\n'
      else if (inString && ch === '\r') result += '\\r'
      else result += ch
    }
    return result
  }
  const candidates = [stripped, repairNewlines(stripped), raw, raw.match(/\{[\s\S]*\}/)?.[0] ?? '']
  for (const candidate of candidates) {
    try {
      const result = JSON.parse(candidate)
      if (result.refinedText || result.title) {
        return { refinedText: result.refinedText, title: result.title }
      }
    } catch { /* try next candidate */ }
  }
  return null
}

/**
 * Detect the dominant non-Latin script in a transcript and return a language
 * name we can drop straight into the prompt. A *named* target ("write in
 * Burmese") holds up far better against an English-heavy style guide (e.g.
 * Meeting Notes, whose instruction lists English headings to "use exactly as
 * shown") than the vague "same language as the input", which weak models like
 * gemini-3.1-flash-lite happily ignore. Returns null when the text is Latin /
 * mixed / too short to call, so the caller falls back to "same language".
 */
export function detectDominantLanguage(text: string): string | null {
  const ranges: [string, number, number][] = [
    ['Burmese', 0x1000, 0x109f], ['Thai', 0x0e00, 0x0e7f], ['Lao', 0x0e80, 0x0eff],
    ['Khmer', 0x1780, 0x17ff], ['Korean', 0xac00, 0xd7a3], ['Japanese', 0x3040, 0x30ff],
    ['Chinese', 0x4e00, 0x9fff], ['Hindi', 0x0900, 0x097f], ['Bengali', 0x0980, 0x09ff],
    ['Tamil', 0x0b80, 0x0bff], ['Arabic', 0x0600, 0x06ff], ['Hebrew', 0x0590, 0x05ff],
    ['Russian', 0x0400, 0x04ff], ['Greek', 0x0370, 0x03ff],
  ]
  const counts: Record<string, number> = {}
  for (const ch of text) {
    const c = ch.codePointAt(0)!
    for (const [name, lo, hi] of ranges) {
      if (c >= lo && c <= hi) { counts[name] = (counts[name] ?? 0) + 1; break }
    }
  }
  const top = Object.entries(counts).sort((a, b) => b[1] - a[1])[0]
  return top && top[1] >= 12 ? top[0] : null
}

/**
 * Build a refinement prompt locally — the canonical copy used by the `refine`
 * edge function, `chat-save-note`, and the long/import `inlineRefine` paths for
 * `language === 'ORIGINAL'` (which must NOT go through the DB
 * `refinement_wrapper` template — that template translates output to a single
 * target language). Keep in sync with src/lib/services/refine.ts and
 * services/transcribe-chunk/src/lib/refine.ts.
 *
 * Language handling: the OUTPUT LANGUAGE directive is hoisted to the very top
 * AND repeated at the bottom (bracketing the English style guide), names a
 * concrete language when detectable, and explicitly tells the model the English
 * headings in the style guide are a template to be translated — otherwise an
 * English-heavy style overrides "keep the source language" on weak models.
 */
export function buildRefinementPrompt(
  styleName: string,
  styleDescription: string,
  promptInstruction: string,
  language: string,
  text: string,
  /** Known dominant language (e.g. from the overview pass). Used for the
   *  ORIGINAL path so the prompt can name a concrete language even for
   *  Latin-script input, where codepoint detection can't (it would otherwise
   *  say "the SAME language…" and the model can drift, e.g. English→French). */
  detectedLanguageHint?: string | null,
  /** When true, instruct the model to emit the rewritten content as PLAIN
   *  Markdown (no JSON envelope, no title) — required for clean token streaming.
   *  The caller supplies the title separately (it's the style/action name). */
  plainMarkdown = false,
): string {
  // 'ORIGINAL' = preserve source. 'NONE' = explicit Burmese (back-compat).
  const isOriginal = language === 'ORIGINAL'
  const hint = detectedLanguageHint?.trim() || null
  const detected = isOriginal ? (hint ?? detectDominantLanguage(text)) : null
  const langName = isOriginal
    ? (detected ?? 'the SAME language as the raw transcript')
    : (language === 'NONE' ? 'Contemporary Burmese (Modern Register)' : language)
  const goalLine = isOriginal
    ? `**Output Language (MANDATORY):** Write EVERYTHING — title, every section heading, every label, every bullet — in **${langName}**. Do NOT translate to English.`
    : `**Output Language (MANDATORY):** You MUST write ALL output in **${langName}**.`
  const sourceClause = isOriginal && detected
    ? `\n- The raw transcript is in ${detected}. Preserve English loanwords / proper nouns as actually spoken, but everything you author must be in ${detected}.`
    : isOriginal
      ? `\n- Detect the transcript's language and write everything in that same language; preserve loanwords as spoken.`
      : `\n- If the transcript is in another language, translate sense-for-sense so it reads as if a native expert wrote it.`
  const rulesBlock = `### OUTPUT LANGUAGE RULES [READ LAST — OVERRIDES THE STYLE GUIDE ABOVE]
- Write the title and the ENTIRE refinedText — headings, labels, bullets, and prose — in **${langName}**.${sourceClause}
- The section headings, labels, and examples in the style guide above are written in English ONLY as a template. You MUST translate every one of them into ${langName} (e.g. an English "### Summary" heading must come out as the ${langName} word for "Summary"). Never emit an English heading${isOriginal ? ' unless the transcript itself is English' : ''}.
- Preserve cultural conventions of ${langName} (e.g., Burmese honorifics, Japanese keigo, Thai particles).`
  return `You are AtanNote AI. Transform raw voice transcripts into polished, professional content.

### OUTPUT LANGUAGE — HIGHEST PRIORITY (applies to everything below)
${goalLine}

### INPUT
**Raw Transcript:**
"${text}"

### GOALS
- **Style:** ${styleName}
- **Directive:** ${styleDescription}

### INSTRUCTIONS (structure / formatting only — NOT the output language)
${promptInstruction}

### EXAMPLE (illustrates structure only — your output must be in ${langName})
Raw: "so yeah the meeting went um pretty well I think we should uh move forward with option B because it saves cost"
Refined (structure only): "The meeting concluded positively. **Recommendation:** proceed with Option B for its cost efficiency."

${rulesBlock}

### FORMATTING
Use Markdown: headers, bold, italic, and bullet lists for scannability.
${plainMarkdown
  ? `\n### OUTPUT\nOutput ONLY the rewritten content, as clean Markdown. No JSON, no code fences, no title line, no preamble or sign-off — start directly with the content.`
  : `\n### TITLE\nGenerate a concise title (3-7 words) in ${langName}. No metadata.\n\n### OUTPUT FORMAT\nRespond with ONLY this JSON:\n{\n  "title": "...",\n  "refinedText": "..."\n}`}`
}

/**
 * Generate a short note title from the start of the text.
 *
 * A tiny, output-capped call — it reads only the first ~1k chars, so it
 * cannot truncate the body the way full refinement does. Never throws:
 * returns '' on failure so callers fall back to a default title.
 */
export async function generateNoteTitle(
  ai: GoogleGenAI,
  model: string,
  userId: string | null,
  text: string,
): Promise<string> {
  const service = createServiceClient()
  const snippet = text.slice(0, 1000)
  const template = await getActiveSystemPrompt('title_generation')
  const prompt = template
    ? template.replace('{{TEXT}}', snippet)
    : `Generate a concise, professional 3-7 word title in the same language as the text below. Output only the title — no quotes, no trailing punctuation.\n\n"${snippet}"`

  const startMs = Date.now()
  try {
    const response = await ai.models.generateContent({
      model,
      contents: prompt,
      config: { temperature: 0.4, maxOutputTokens: 100 },
    })
    logAiUsage(service, {
      userId,
      operation: 'title',
      model,
      ...extractTokenUsage(response.usageMetadata),
      processingMs: Date.now() - startMs,
      metadata: { source: 'passthrough_refine' },
    })
    return response.text?.trim().replace(/^["']|["']$/g, '') || ''
  } catch (e) {
    console.warn('[refine-utils] Title generation failed:', e)
    return ''
  }
}
