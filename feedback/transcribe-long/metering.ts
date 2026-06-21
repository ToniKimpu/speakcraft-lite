import type { createServiceClient } from './supabase-client.ts'

type ServiceClient = ReturnType<typeof createServiceClient>

/**
 * Transcription metering kill switch. Reads `transcription_metering_enabled`
 * from app_config. Returns false (off) on any error or missing row — a config
 * problem can never start enforcing limits by accident. See MONETIZATION_PLAN.md §4.
 */
export async function isMeteringEnabled(service: ServiceClient): Promise<boolean> {
  const { data, error } = await service
    .from('app_config')
    .select('value')
    .eq('key', 'transcription_metering_enabled')
    .maybeSingle()

  if (error) {
    console.error('[metering] Failed to read transcription_metering_enabled:', error)
    return false
  }
  // JSONB value may come back as boolean true or string "true".
  return data?.value === true || data?.value === 'true'
}

export type QuotaReason =
  | 'ok'
  | 'recording_too_long'
  | 'daily_limit_reached'
  | 'monthly_limit_reached'

export interface TranscriptionQuotaVerdict {
  allowed: boolean
  reason: QuotaReason
  // `guest` resolves for anonymous accounts (see check_transcription_quota).
  // Mobile builds that predate this tier should treat unknown tiers as the
  // free upsell — the error string still works as a generic upgrade prompt.
  tier: 'guest' | 'free' | 'pro' | 'premium'
  maxMinutesPerRecording: number
  dailyLimit: number
  dailyUsed: number
  monthlyLimit: number
  monthlyUsed: number
}

/**
 * Pre-flight transcription quota check (per-recording length cap → daily
 * count → monthly backstop). Returns the structured verdict, or an error
 * string if the RPC itself failed.
 */
export async function checkTranscriptionQuota(
  service: ServiceClient,
  userId: string,
  durationMinutes: number,
): Promise<{ verdict: TranscriptionQuotaVerdict | null; error: string | null }> {
  const { data, error } = await service.rpc('check_transcription_quota', {
    p_user_id: userId,
    p_duration_minutes: durationMinutes,
  })
  if (error || !data) {
    console.error('[metering] check_transcription_quota failed:', error)
    return { verdict: null, error: 'Failed to check transcription quota' }
  }
  return { verdict: data as TranscriptionQuotaVerdict, error: null }
}

/**
 * Build the HTTP 402 body for a denied verdict — a human-readable `error`
 * plus structured fields the web app uses to render the right paywall.
 * Keeps a `limit`/`remaining` shape so already-released mobile builds, which
 * parse `{ error, remaining, limit }`, still degrade gracefully.
 */
export function quotaDeniedBody(v: TranscriptionQuotaVerdict): Record<string, unknown> {
  let error: string
  let limit: number
  switch (v.reason) {
    case 'recording_too_long':
      // Guests see a sign-up CTA; everyone else sees the upgrade CTA. Both
      // strings still contain "longer" so older mobile builds matching on
      // the previous wording continue to surface the same paywall path.
      error = v.tier === 'guest'
        ? `Guest recordings are capped at ${v.maxMinutesPerRecording} min. Sign up free for longer recordings.`
        : `This recording is longer than your plan allows (up to ${v.maxMinutesPerRecording} min). Upgrade for longer recordings.`
      limit = v.maxMinutesPerRecording
      break
    case 'daily_limit_reached':
      error = `You've reached today's transcription limit (${v.dailyLimit}/day). Try again tomorrow, or upgrade.`
      limit = v.dailyLimit
      break
    case 'monthly_limit_reached':
    default:
      // Exact string the shipped app + web friendlyTranscriptionError match on.
      error = 'Monthly transcription minutes exceeded'
      limit = v.monthlyLimit
      break
  }
  return {
    error,
    reason: v.reason,
    tier: v.tier,
    limit,
    maxMinutesPerRecording: v.maxMinutesPerRecording,
    dailyLimit: v.dailyLimit,
    dailyUsed: v.dailyUsed,
    monthlyLimit: v.monthlyLimit,
    monthlyUsed: v.monthlyUsed,
    remaining: v.reason === 'monthly_limit_reached'
      ? Math.max(v.monthlyLimit - v.monthlyUsed, 0)
      : undefined,
  }
}
