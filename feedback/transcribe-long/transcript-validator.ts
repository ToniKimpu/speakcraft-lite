/**
 * Post-transcription validation — detect garbage / hallucinated output
 * from Gemini when audio is mostly silence or very low volume.
 *
 * This is the Deno/Edge copy. The Node/Cloud Run copy lives at
 * shared/transcript-validator.ts. Keep these two files in sync manually
 * when changing validation logic — both runtimes import directly without
 * any cross-runtime bundling indirection (which proved to be brittle on
 * Supabase Edge's bundler).
 */

export interface ValidationResult {
  valid: boolean
  /** Short user-facing message when invalid */
  reason?: string
  /** Detailed log message for server-side debugging */
  detail?: string
}

// ── Thresholds ──────────────────────────────────────────────────────────────

// Low-density floors are deliberately permissive. A thin transcript from a
// quiet/distant mic or a meeting with long pauses is still worth keeping —
// discarding it reverts the note to a "Voice memo —" placeholder, which reads
// to the user as "the app ignored my recording" (this was the #1 cause of
// recordings showing up as voice memos). These floors now catch only the
// near-silent case (a word or two hallucinated out of minutes of silence);
// genuine hallucination loops are caught by the high-density ceilings and the
// repetition GARBAGE_PATTERNS below, which are intentionally unchanged.
const MIN_WORDS_PER_SECOND = 0.03
const MAX_WORDS_PER_SECOND = 6.0
const MIN_WORDS_FOR_LONG_AUDIO = 3
const DENSITY_CHECK_MIN_DURATION = 30

function isNonSpaceDelimitedScript(text: string): boolean {
  // Burmese (U+1000-109F), Thai (U+0E00-0E7F), CJK (U+4E00-9FFF),
  // Hiragana/Katakana (U+3040-30FF), Khmer (U+1780-17FF), Lao (U+0E80-0EFF)
  const nonLatinPattern = /[က-႟฀-๿一-鿿぀-ヿក-៿຀-໿]/g
  const matches = text.match(nonLatinPattern)
  if (!matches) return false
  const nonWs = text.replace(/\s/g, '').length
  return nonWs > 0 && matches.length / nonWs > 0.3
}

const GARBAGE_PATTERNS: { pattern: RegExp; label: string }[] = [
  { pattern: /^\s*\{[\s]*"/, label: 'starts with JSON object' },
  { pattern: /^\s*\[[\s]*"/, label: 'starts with JSON array' },
  { pattern: /^\s*\{[\s]*"refinedText"\s*:/, label: 'JSON with refinedText key' },
  { pattern: /^\s*\{[\s]*"title"\s*:/, label: 'JSON with title key' },
  { pattern: /^```/, label: 'starts with code fence' },
  { pattern: /\b([a-zA-Z]{2,})\b(?:\s+\1\b){9,}/, label: 'excessive word repetition' },
  // Script-agnostic short-phrase repetition — Gemini hallucination loop.
  // Threshold of 10 avoids false positives on natural rhetorical refrains.
  { pattern: /(.{2,30}?)(?:\1){10,}/su, label: 'short-phrase repetition loop' },
  { pattern: /(.)\1{30,}/su, label: 'single-character runaway' },
  // Timestamp degeneration — the model emits subtitle cues or a counted run
  // of timestamps instead of (or alongside) speech. stripTimestamps() removes
  // these; these patterns flag a transcript that is mostly timestamp garbage.
  { pattern: /\d{1,2}(?::\d{2}){1,2}(?:[.,]\d{1,3})?[ \t]*-->[ \t]*\d{1,2}/, label: 'SRT/VTT subtitle cues' },
  { pattern: /(?:\d{1,2}(?::\d{2}){1,2}[ \t]*){8,}/, label: 'timestamp counting degeneration' },
  { pattern: /\[inaudible\]/i, label: 'contains [inaudible] placeholder' },
  { pattern: /\[unclear\]/i, label: 'contains [unclear] placeholder' },
  { pattern: /\[music\]/i, label: 'contains [music] placeholder' },
  { pattern: /\[silence\]/i, label: 'contains [silence] placeholder' },
  { pattern: /I cannot transcribe/i, label: 'model refusal' },
  { pattern: /I'm unable to/i, label: 'model refusal' },
  { pattern: /no speech was detected/i, label: 'model reports no speech' },
  { pattern: /the audio (is|appears|seems) (to be )?(silent|empty|blank)/i, label: 'model reports silence' },
  { pattern: /there is no (speech|audio|voice|sound)/i, label: 'model reports no audio' },
]

export function validateTranscript(
  transcript: string,
  durationSeconds = 0,
): ValidationResult {
  const trimmed = transcript.trim()

  if (!trimmed) {
    return {
      valid: false,
      reason: 'No speech detected in the recording.',
      detail: 'Transcript is empty',
    }
  }

  for (const { pattern, label } of GARBAGE_PATTERNS) {
    if (pattern.test(trimmed)) {
      return {
        valid: false,
        reason: 'No clear speech could be detected. Please try recording in a quieter environment or speak closer to the microphone.',
        detail: `Garbage pattern matched: ${label}`,
      }
    }
  }

  if (durationSeconds >= DENSITY_CHECK_MIN_DURATION && !isNonSpaceDelimitedScript(trimmed)) {
    const wordCount = trimmed.split(/\s+/).filter(w => w.length > 0).length
    const wordsPerSecond = wordCount / durationSeconds

    if (wordCount < MIN_WORDS_FOR_LONG_AUDIO) {
      return {
        valid: false,
        reason: 'Recording was too quiet — no clear speech could be detected.',
        detail: `Only ${wordCount} words from ${durationSeconds}s of audio`,
      }
    }

    if (wordsPerSecond < MIN_WORDS_PER_SECOND) {
      return {
        valid: false,
        reason: 'Recording was too quiet — no clear speech could be detected.',
        detail: `Word density too low: ${wordsPerSecond.toFixed(3)} w/s (${wordCount} words, ${durationSeconds}s)`,
      }
    }

    if (wordsPerSecond > MAX_WORDS_PER_SECOND) {
      return {
        valid: false,
        reason: 'No clear speech could be detected. Please try recording in a quieter environment or speak closer to the microphone.',
        detail: `Word density suspiciously high: ${wordsPerSecond.toFixed(2)} w/s (${wordCount} words, ${durationSeconds}s) — likely hallucinated`,
      }
    }
  }

  if (durationSeconds >= DENSITY_CHECK_MIN_DURATION && isNonSpaceDelimitedScript(trimmed)) {
    const charCount = trimmed.replace(/\s/g, '').length
    const charsPerSecond = charCount / durationSeconds

    if (charCount < MIN_WORDS_FOR_LONG_AUDIO) {
      return {
        valid: false,
        reason: 'Recording was too quiet — no clear speech could be detected.',
        detail: `Only ${charCount} chars from ${durationSeconds}s of audio (non-Latin script)`,
      }
    }

    if (charsPerSecond < 0.15) {
      return {
        valid: false,
        reason: 'Recording was too quiet — no clear speech could be detected.',
        detail: `Char density too low: ${charsPerSecond.toFixed(3)} c/s (${charCount} chars, ${durationSeconds}s)`,
      }
    }

    // Burmese stacks multiple Unicode characters per spoken syllable
    // (consonant + medial + vowel + final), so a fast Burmese speaker
    // legitimately produces 20-40 c/s. The hallucination loops we want
    // to catch are an order of magnitude higher (the production case
    // that drove this check was 996 c/s). Threshold of 70 keeps real
    // fast-talker recordings clean while still catching the loop case.
    if (charsPerSecond > 70) {
      return {
        valid: false,
        reason: 'No clear speech could be detected. Please try recording in a quieter environment or speak closer to the microphone.',
        detail: `Char density suspiciously high: ${charsPerSecond.toFixed(2)} c/s (${charCount} chars, ${durationSeconds}s) — likely hallucinated`,
      }
    }
  }

  return { valid: true }
}

/**
 * Remove timestamp artifacts the model sometimes emits despite the prompt:
 * SRT / WebVTT subtitle cues, leftover SRT index numbers, runs of counted
 * timestamps (a known degeneration), and bracketed inline markers.
 *
 * A clock time the speaker actually says ("the meeting is at 10:30") is left
 * intact — only machine-style timestamp formatting is stripped. Regexes avoid
 * the `s`/`u` flags so the Deno and Node copies stay byte-identical.
 */
export function stripTimestamps(input: string): string {
  if (!input) return input
  let text = input

  // SRT / WebVTT cue lines — "00:00:01,000 --> 00:00:04,000",
  // "00:00.000 --> 00:03.000" (with or without trailing milliseconds).
  text = text.replace(
    /^[^\n]*\d{1,2}(?::\d{2}){1,2}(?:[.,]\d{1,3})?[ \t]*-->[ \t]*\d{1,2}(?::\d{2}){1,2}(?:[.,]\d{1,3})?[^\n]*$/gm,
    '',
  )

  // A run of 4+ counted timestamps separated only by whitespace — the
  // "00:00 00:01 00:02 …" degeneration loop.
  text = text.replace(/(?:\d{1,2}(?::\d{2}){1,2}[ \t]*){4,}/g, ' ')

  // Line-leading timestamp markers — "00:04 spoken words…" → "spoken words…".
  // The model prefixes each line/segment with a timecode despite the prompt.
  // Anchored to line start + followed by whitespace/EOL, so a clock time the
  // speaker says mid-sentence ("meet at 10:30") is left intact.
  text = text.replace(/^[ \t]*\d{1,2}(?::\d{2}){1,2}(?=[ \t]|$)[ \t]*/gm, '')

  // Bracketed inline markers — "[00:12]", "(1:45)", "[00:00:05]".
  text = text.replace(/[[(]\s*\d{1,2}(?::\d{2}){1,2}\s*[\])]/g, '')

  // Inline position timecodes the model injects BETWEEN words mid-sentence
  // ("… လုပ် 00:01 အဲ့အခါ …" / "… တွေ 00:00 ပေါ့နော်။ 00:01 နောက် …"). Strip a
  // bare MM:SS / HH:MM:SS token that stands alone between whitespace or sentence
  // punctuation (incl. Burmese ၊ ။). This also removes a standalone spoken clock
  // time like "10:30" — an acceptable trade vs. timecodes littering the text.
  text = text.replace(
    /(^|[\s.,!?၊။])\d{1,2}(?::\d{2}){1,2}(?=$|[\s.,!?၊။])/g,
    '$1',
  )

  // Leftover bare SRT index numbers sitting alone on a line.
  text = text.replace(/^[ \t]*\d{1,4}[ \t]*$/gm, '')

  // Collapse the whitespace / blank lines left behind.
  text = text
    .replace(/[ \t]{2,}/g, ' ')
    .replace(/[ \t]+\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
  return text.trim()
}
