import { createServiceClient } from './supabase-client.ts'

export type PromptType =
  | 'transcription'
  | 'transcription_audio_quality'
  | 'refinement_wrapper'
  | 'chat_system'
  | 'chat_summary'
  | 'title_generation'
  | 'chat_save_note'
  | 'meeting_diarize'
  | 'meeting_refine'
  | 'meeting_summarize'
  | 'meeting_extract'
  | 'meeting_overview'

export async function getActiveSystemPrompt(
  type: PromptType,
): Promise<string | null> {
  const service = createServiceClient()
  const { data } = await service
    .from('system_prompts')
    .select('content')
    .eq('type', type)
    .eq('is_active', true)
    .single()
  return data?.content ?? null
}

/**
 * Full prompt config for prompt types that own model / sampling settings
 * (Meeting Mode passes today; eventually transcription + refinement too).
 * Any field can be null — the call site falls back to its in-repo default.
 */
export interface PromptConfig {
  content: string
  model: string | null
  temperature: number | null
  maxOutputTokens: number | null
}

export async function getActivePromptConfig(
  type: PromptType,
): Promise<PromptConfig | null> {
  const service = createServiceClient()
  const { data } = await service
    .from('system_prompts')
    .select('content, model, temperature, max_output_tokens')
    .eq('type', type)
    .eq('is_active', true)
    .single()
  if (!data) return null
  return {
    content: data.content,
    model: (data.model as string | null) ?? null,
    temperature: data.temperature !== null ? Number(data.temperature) : null,
    maxOutputTokens: (data.max_output_tokens as number | null) ?? null,
  }
}
