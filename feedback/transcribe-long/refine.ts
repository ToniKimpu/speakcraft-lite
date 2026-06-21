/**
 * Pass 2 — Burmese-only light-touch refinement.
 *
 * Text-only Gemini call. Fixes obvious mis-heard words / mis-segmented
 * compounds / wrong loanwords WITHOUT rewriting sentences or correcting
 * the speaker's grammar/dialect/word choice.
 *
 * Includes programmatic post-validation: if the model dropped a Burmese
 * verb-ending particle (the proven failure mode), revert that segment.
 * Without this guard, ~60% of model-proposed refinements are regressions.
 *
 * Spike reference: scripts/spike-output/lite-threepass-script.mjs
 */

import type { GoogleGenAI } from '@google/genai'
import type { createServiceClient } from '../supabase-client.ts'
import { PASS2_REFINEMENT_INSTRUCTION, PASS2_REFINEMENT_SCHEMA } from './prompts.ts'

type ServiceClient = ReturnType<typeof createServiceClient>

// Burmese verb-ending particles, longest-first so we match "ပါတယ်" before "တယ်".
const BURMESE_VERB_PARTICLES = [
  'နေပါတယ်', 'ထားပါတယ်', 'လိုက်ပါတယ်',
  'ပါတယ်', 'ပါမယ်', 'ပါပြီ', 'ပါဘူး',
  'နေတယ်', 'ထားတယ်', 'လိုက်တယ်',
  'တယ်', 'မယ်', 'ဘူး', 'ပြီ', 'ပါ',
]

function stripTrailingPunct(s: string): string {
  return String(s ?? '').replace(/[။၊\.\?!,;:]+\s*$/u, '').trim()
}

function endingParticle(s: string): string | null {
  const stripped = stripTrailingPunct(s)
  for (const p of BURMESE_VERB_PARTICLES) {
    if (stripped.endsWith(p)) return p
  }
  return null
}

interface ValidationResult {
  kept: string
  reverted: boolean
  reason: string
}

export function validateRefinedSegment(original: string, refined: string): ValidationResult {
  if (refined === original) return { kept: refined, reverted: false, reason: 'unchanged' }
  if (typeof refined !== 'string' || refined.length === 0) {
    return { kept: original, reverted: true, reason: 'empty-refinement' }
  }
  const origP = endingParticle(original)
  const refP = endingParticle(refined)
  if (origP && refP !== origP) {
    return { kept: original, reverted: true, reason: `dropped verb particle "${origP}" → ending "${refP ?? '(none)'}"` }
  }
  if (refined.length < original.length * 0.85) {
    return { kept: original, reverted: true, reason: `length dropped ${original.length}→${refined.length} chars` }
  }
  return { kept: refined, reverted: false, reason: 'accepted' }
}

export function shouldRefine(dominantLanguage: string | null | undefined): boolean {
  if (!dominantLanguage) return false
  return /burmese|myanmar/i.test(dominantLanguage)
}

export interface RefineResult {
  skipped: boolean
  reason: string | null
  elapsedMs: number
  usage: unknown
  // null when skipped/errored. Otherwise: full array, one entry per input
  // segment, with the validation guard already applied.
  refined: string[] | null
  // Raw model output, before validation, for debugging.
  refinedRaw: string[] | null
  reverts: Array<{ index: number; reason: string }>
  error: string | null
}

export interface RefineOptions {
  ai: GoogleGenAI
  model: string
  // DB-driven overrides (system_prompts.content / temperature / max_output_tokens).
  // Omit to use the in-repo PASS2_REFINEMENT_INSTRUCTION defaults.
  systemInstruction?: string
  temperature?: number
  maxOutputTokens?: number
  segments: Array<{ text: string }>
  dominantLanguage: string | null | undefined
  // Optional: when provided, the refined_text column on transcription_segments
  // is updated for each segment whose refined text differs from original.
  service?: ServiceClient
  jobId?: string
}

export async function refinePass2({
  ai, model, segments, dominantLanguage,
  systemInstruction = PASS2_REFINEMENT_INSTRUCTION,
  temperature = 0,
  maxOutputTokens = 8192,
  service, jobId,
}: RefineOptions): Promise<RefineResult> {
  const startMs = Date.now()

  if (!shouldRefine(dominantLanguage)) {
    return {
      skipped: true,
      reason: `dominantLanguage="${dominantLanguage}" — Burmese refinement not applicable`,
      elapsedMs: 0, usage: null, refined: null, refinedRaw: null, reverts: [], error: null,
    }
  }
  if (!segments.length) {
    return {
      skipped: true, reason: 'no segments to refine',
      elapsedMs: 0, usage: null, refined: null, refinedRaw: null, reverts: [], error: null,
    }
  }

  const numbered = segments.map((s, i) => `${i + 1}. ${s.text ?? ''}`).join('\n')

  let usage: unknown = null
  let refinedRaw: string[] | null = null
  let error: string | null = null

  try {
    const response = await ai.models.generateContent({
      model,
      contents: { parts: [{ text: `Refine these ${segments.length} Burmese transcript segments (light touch only):\n\n${numbered}` }] },
      config: {
        systemInstruction,
        responseMimeType: 'application/json',
        responseSchema: PASS2_REFINEMENT_SCHEMA,
        temperature,
        maxOutputTokens,
      },
    })
    usage = response.usageMetadata ?? null
    const obj = JSON.parse(response.text ?? '{}')
    if (Array.isArray(obj?.refined) && obj.refined.length === segments.length) {
      refinedRaw = obj.refined
    } else {
      error = `Refined array length mismatch: got ${obj?.refined?.length}, expected ${segments.length}`
    }
  } catch (e) {
    error = (e as Error).message ?? String(e)
  }

  if (error || !refinedRaw) {
    return {
      skipped: false, reason: null,
      elapsedMs: Date.now() - startMs,
      usage, refined: null, refinedRaw, reverts: [], error,
    }
  }

  // Apply the validation guard segment-by-segment.
  const reverts: Array<{ index: number; reason: string }> = []
  const refined = refinedRaw.map((r, i) => {
    const v = validateRefinedSegment(segments[i].text, r)
    if (v.reverted) reverts.push({ index: i, reason: v.reason })
    return v.kept
  })

  // Best-effort: update refined_text on each segment row that actually changed.
  if (service && jobId) {
    for (let i = 0; i < refined.length; i++) {
      if (refined[i] !== segments[i].text) {
        service
          .from('transcription_segments')
          .update({ refined_text: refined[i] })
          .eq('job_id', jobId)
          .eq('segment_index', i)
          .then(({ error: e }) => {
            if (e) console.error(`[transcribe-meeting] refined_text update ${i} failed:`, e.message)
          })
      }
    }
  }

  return {
    skipped: false, reason: null,
    elapsedMs: Date.now() - startMs,
    usage, refined, refinedRaw, reverts, error: null,
  }
}
