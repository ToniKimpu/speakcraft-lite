import { GoogleGenAI } from '@google/genai'
import { createServiceClient } from './supabase-client.ts'
import {
  GEMINI_MODEL_AUDIO,
  GEMINI_MODEL_AUDIO_LITE,
  GEMINI_MODEL_TEXT,
  GEMINI_MODEL_REPAIR,
} from './constants.ts'

/** Subscription tier used for per-tier model overrides. Anonymous/guest users
 *  carry the default 'free' profile tier. */
export type SubscriptionTier = 'free' | 'pro' | 'premium'

// Default model a failed attempt is RETRIED on, per tier. Mirrors the Cloud Run
// worker (services/transcribe-chunk/src/lib/ai.ts): FREE keeps the cheap lite
// model; PRO escalates to flash (loops far less on Burmese). Admin-overridable
// per tier via gemini_model_audio_retry_free / _pro (blank = these defaults).
const DEFAULT_RETRY_MODEL_FREE = 'gemini-2.5-flash-lite'
const DEFAULT_RETRY_MODEL_PRO = 'gemini-2.5-flash'

export interface AIConfig {
  apiKey: string
  braveSearchApiKey: string
  modelAudioBurmese: string
  modelAudioOther: string
  modelText: string
  modelRepair: string
  // Per-tier overrides (empty string = "use the default above"). Only Burmese
  // transcription + repair are tiered; other-language transcription and text
  // refinement stay global.
  modelAudioBurmeseFree: string
  modelAudioBurmesePro: string
  modelRepairFree: string
  modelRepairPro: string
  // Per-tier RETRY (escalation) model overrides. Empty = DEFAULT_RETRY_MODEL.
  modelAudioRetryFree: string
  modelAudioRetryPro: string
  enableWebSearch: boolean
  enableImageSearch: boolean
}

// Per-tier model resolution. Free and Pro are the admin-editable knobs; premium
// follows the Pro setting. A blank tier falls back to the prior default value
// (modelAudioBurmese / modelRepair, kept as a non-UI fallback so existing
// behaviour is unchanged), then to the built-in constant.

/** Resolve the Burmese transcription model for a tier. */
export function audioBurmeseModelForTier(cfg: AIConfig, tier: SubscriptionTier): string {
  if (tier === 'free') return cfg.modelAudioBurmeseFree || cfg.modelAudioBurmese
  return cfg.modelAudioBurmesePro || cfg.modelAudioBurmese // pro + premium
}

/** Resolve the chunk-repair model for a tier. */
export function repairModelForTier(cfg: AIConfig, tier: SubscriptionTier): string {
  if (tier === 'free') return cfg.modelRepairFree || cfg.modelRepair
  return cfg.modelRepairPro || cfg.modelRepair // pro + premium
}

/** Resolve the retry (escalation) model for a tier. Empty override → per-tier
 *  default (free=flash-lite, pro/premium=flash). */
export function audioRetryModelForTier(cfg: AIConfig, tier: SubscriptionTier): string {
  if (tier === 'free') return cfg.modelAudioRetryFree || DEFAULT_RETRY_MODEL_FREE
  return cfg.modelAudioRetryPro || DEFAULT_RETRY_MODEL_PRO // pro + premium
}

/** Resolve a profile's EFFECTIVE subscription tier for entitlement decisions.
 *
 * Mirrors the metering RPC (migration 20260522010000, get_or_init_metering):
 * `subscription_tier` is the source of truth once billing sets it, but billing
 * webhooks currently only set subscription_status/plan and never the tier
 * column — so an active/trialing subscription (or an active referral bonus)
 * must resolve to 'pro'. Without this, every paying customer reads as 'free'
 * for model selection.
 *
 * NOTE: unlike the metering RPC (migration 20260522010000), past_due is NOT
 * granted pro here — a customer behind on payment should not get the pricier
 * models, even though metering still gives them a limits grace period. Keep in
 * sync with the worker + web copies. */
export function resolveEffectiveTier(row: {
  subscription_tier?: string | null
  subscription_status?: string | null
  referral_bonus_expires_at?: string | null
} | null | undefined): SubscriptionTier {
  if (!row) return 'free'
  if (row.subscription_tier === 'premium') return 'premium'
  const bonusActive = !!row.referral_bonus_expires_at
    && new Date(row.referral_bonus_expires_at) > new Date()
  if (
    row.subscription_tier === 'pro'
    || row.subscription_status === 'active'
    || row.subscription_status === 'trialing'
    || bonusActive
  ) return 'pro'
  return 'free'
}

/** Look up a user's effective subscription tier for per-tier model selection.
 *  Defaults to 'free' when the profile/row is missing (matches anonymous/guest
 *  accounts). */
export async function getUserTier(userId: string | null | undefined): Promise<SubscriptionTier> {
  if (!userId) return 'free'
  try {
    const service = createServiceClient()
    const { data } = await service
      .from('profiles')
      .select('subscription_tier, subscription_status, referral_bonus_expires_at')
      .eq('id', userId)
      .maybeSingle()
    return resolveEffectiveTier(data)
  } catch {
    return 'free'
  }
}

/**
 * Reads admin-configurable AI models and API key from app_config.
 * Falls back to env vars / defaults if DB config unavailable.
 */
export async function getAIConfig(): Promise<AIConfig> {
  const service = createServiceClient()
  const { data: rows } = await service
    .from('app_config')
    .select('key, value, is_secret')
    .in('key', [
      'gemini_api_key',
      'brave_search_api_key',
      'gemini_model_audio_burmese',
      'gemini_model_audio_other',
      'gemini_model_text',
      'gemini_model_repair',
      'gemini_model_audio_burmese_free',
      'gemini_model_audio_burmese_pro',
      'gemini_model_repair_free',
      'gemini_model_repair_pro',
      'gemini_model_audio_retry_free',
      'gemini_model_audio_retry_pro',
      'enable_web_search',
      'enable_image_search',
    ])

  const cfg: Record<string, unknown> = {}
  for (const row of rows ?? []) {
    // Skip encrypted values — edge functions don't have the Node.js crypto
    // module needed for decryption. Use the env var fallback instead.
    if (row.is_secret) continue
    if (row.value != null) {
      cfg[row.key] = row.value
    }
  }

  return {
    apiKey: (cfg.gemini_api_key as string) || Deno.env.get('GEMINI_API_KEY')!,
    braveSearchApiKey: (cfg.brave_search_api_key as string) || Deno.env.get('BRAVE_SEARCH_API_KEY') || '',
    modelAudioBurmese: (cfg.gemini_model_audio_burmese as string) || GEMINI_MODEL_AUDIO,
    modelAudioOther: (cfg.gemini_model_audio_other as string) || GEMINI_MODEL_AUDIO_LITE,
    modelText: (cfg.gemini_model_text as string) || GEMINI_MODEL_TEXT,
    modelRepair: (cfg.gemini_model_repair as string) || GEMINI_MODEL_REPAIR,
    modelAudioBurmeseFree: (cfg.gemini_model_audio_burmese_free as string) || '',
    modelAudioBurmesePro: (cfg.gemini_model_audio_burmese_pro as string) || '',
    modelRepairFree: (cfg.gemini_model_repair_free as string) || '',
    modelRepairPro: (cfg.gemini_model_repair_pro as string) || '',
    modelAudioRetryFree: (cfg.gemini_model_audio_retry_free as string) || '',
    modelAudioRetryPro: (cfg.gemini_model_audio_retry_pro as string) || '',
    enableWebSearch: cfg.enable_web_search === true,
    enableImageSearch: cfg.enable_image_search === true,
  }
}

/** Convenience: create a GoogleGenAI instance with the resolved API key. */
export async function createAI(): Promise<{ ai: GoogleGenAI; config: AIConfig }> {
  const config = await getAIConfig()
  const ai = new GoogleGenAI({ apiKey: config.apiKey })
  return { ai, config }
}
