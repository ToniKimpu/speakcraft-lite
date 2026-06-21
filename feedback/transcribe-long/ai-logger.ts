/**
 * Fire-and-forget AI usage logger for edge functions.
 * Logs token consumption, processing time, and metadata to ai_usage_logs.
 * Never blocks the response — failures are silently logged to console.
 */

import { createServiceClient } from './supabase-client.ts'

type ServiceClient = ReturnType<typeof createServiceClient>

export type AiOperation = 'transcribe' | 'refine' | 'embed' | 'chat' | 'search' | 'title' | 'summarize' | 'image-to-text'

export interface AiUsageEntry {
  userId: string | null
  /** The note this call was made for. Required for per-note cost
   *  rollups; null for calls that aren't note-scoped (admin tools,
   *  search across all notes, etc.). */
  noteId?: string | null
  operation: AiOperation
  model: string
  inputTokens?: number
  outputTokens?: number
  totalTokens?: number
  audioDurationS?: number
  fileSizeBytes?: number
  processingMs?: number
  source?: 'edge_function' | 'api_route'
  metadata?: Record<string, unknown>
}

/**
 * Extract token counts from a Gemini response's usageMetadata.
 * Works with both generateContent and embedContent responses.
 */
export function extractTokenUsage(usageMetadata: unknown): {
  inputTokens: number | undefined
  outputTokens: number | undefined
  totalTokens: number | undefined
} {
  if (!usageMetadata || typeof usageMetadata !== 'object') {
    return { inputTokens: undefined, outputTokens: undefined, totalTokens: undefined }
  }
  const meta = usageMetadata as Record<string, unknown>
  const candidates = typeof meta.candidatesTokenCount === 'number' ? meta.candidatesTokenCount : undefined
  // Thinking tokens are billed at the OUTPUT rate but reported separately from
  // candidatesTokenCount. Fold them into outputTokens so cost is accurate on
  // thinking-on models (e.g. 2.5-flash meeting passes); no-op (0) when thinking
  // is disabled (transcription sets thinkingBudget:0). totalTokenCount from the
  // API already includes thoughts, so it stays as-is.
  const thoughts = typeof meta.thoughtsTokenCount === 'number' ? meta.thoughtsTokenCount : 0
  return {
    inputTokens: typeof meta.promptTokenCount === 'number' ? meta.promptTokenCount : undefined,
    outputTokens: candidates !== undefined ? candidates + thoughts : (thoughts || undefined),
    totalTokens: typeof meta.totalTokenCount === 'number' ? meta.totalTokenCount : undefined,
  }
}

/** Fire-and-forget: log AI usage to the database. Never awaited. */
export function logAiUsage(service: ServiceClient, entry: AiUsageEntry): void {
  service
    .from('ai_usage_logs')
    .insert({
      user_id: entry.userId,
      note_id: entry.noteId ?? null,
      operation: entry.operation,
      model: entry.model,
      input_tokens: entry.inputTokens ?? null,
      output_tokens: entry.outputTokens ?? null,
      total_tokens: entry.totalTokens ?? null,
      audio_duration_s: entry.audioDurationS ?? null,
      file_size_bytes: entry.fileSizeBytes ?? null,
      processing_ms: entry.processingMs ?? null,
      source: entry.source ?? 'edge_function',
      metadata: entry.metadata ?? {},
    })
    .then(() => {})
    .catch((e: unknown) => console.warn('[ai-logger] Insert failed:', e))
}
