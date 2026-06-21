import { createServiceClient } from './supabase-client.ts'

// Deno / Edge copy. The Cloud Run side has its own equivalents:
//   - getAudioPipelineConfig → services/transcribe-chunk/src/lib/ai.ts
//   - enhanceTranscriptionPrompt → shared/transcription-prompts.ts
// KEEP THRESHOLDS + PROMPT WORDING IN SYNC when changing either side.

/**
 * Audio pipeline configuration — read from app_config table.
 * These values control both server-side transcription behavior
 * and are served to the mobile app for client-side preprocessing.
 */
export interface AudioPipelineConfig {
  preprocessEnabled: boolean
  normalizeTargetDb: number
  noiseGateThresholdDb: number
  compressorRatio: number
  compressorThresholdDb: number
  highPassHz: number
  lowVolumeWarningDb: number
  lowVolumeDurationMs: number
  transcriptionTemperature: number
}

const AUDIO_CONFIG_KEYS = [
  'audio_preprocess_enabled',
  'audio_normalize_target_db',
  'audio_noise_gate_threshold_db',
  'audio_compressor_ratio',
  'audio_compressor_threshold_db',
  'audio_high_pass_hz',
  'audio_low_volume_warning_db',
  'audio_low_volume_duration_ms',
  'transcription_temperature',
]

const DEFAULTS: AudioPipelineConfig = {
  preprocessEnabled: true,
  normalizeTargetDb: -16,
  noiseGateThresholdDb: -45,
  compressorRatio: 3,
  compressorThresholdDb: -20,
  highPassHz: 80,
  lowVolumeWarningDb: -45,
  lowVolumeDurationMs: 3000,
  transcriptionTemperature: 0.2,
}

export async function getAudioPipelineConfig(): Promise<AudioPipelineConfig> {
  const service = createServiceClient()
  const { data: rows } = await service
    .from('app_config')
    .select('key, value')
    .in('key', AUDIO_CONFIG_KEYS)

  const cfg: Record<string, string> = {}
  for (const row of rows ?? []) {
    if (row.value != null) cfg[row.key] = row.value
  }

  return {
    preprocessEnabled: cfg.audio_preprocess_enabled !== 'false',
    normalizeTargetDb: parseFloat(cfg.audio_normalize_target_db) || DEFAULTS.normalizeTargetDb,
    noiseGateThresholdDb: parseFloat(cfg.audio_noise_gate_threshold_db) || DEFAULTS.noiseGateThresholdDb,
    compressorRatio: parseFloat(cfg.audio_compressor_ratio) || DEFAULTS.compressorRatio,
    compressorThresholdDb: parseFloat(cfg.audio_compressor_threshold_db) || DEFAULTS.compressorThresholdDb,
    highPassHz: parseFloat(cfg.audio_high_pass_hz) || DEFAULTS.highPassHz,
    lowVolumeWarningDb: parseFloat(cfg.audio_low_volume_warning_db) || DEFAULTS.lowVolumeWarningDb,
    lowVolumeDurationMs: parseInt(cfg.audio_low_volume_duration_ms) || DEFAULTS.lowVolumeDurationMs,
    transcriptionTemperature: parseFloat(cfg.transcription_temperature) || DEFAULTS.transcriptionTemperature,
  }
}

/**
 * Per-chunk Burmese ASR repair gate, controlled per tier:
 * `chunk_repair_enabled_free` for free/guest, `chunk_repair_enabled_pro` for
 * pro/premium. Both default ON — e.g. free off + pro on = repair Pro only.
 * Defaults ON on a missing row or read error. Keep in sync with the Cloud Run
 * copy (services/transcribe-chunk/src/lib/ai.ts).
 */
export async function isChunkRepairEnabled(tier: 'free' | 'pro' | 'premium'): Promise<boolean> {
  try {
    const service = createServiceClient()
    const { data, error } = await service
      .from('app_config')
      .select('key, value')
      .in('key', ['chunk_repair_enabled_free', 'chunk_repair_enabled_pro'])
    if (error) {
      console.error('[chunk-repair] config read failed, defaulting ON:', error)
      return true
    }
    const cfg: Record<string, unknown> = {}
    for (const r of data ?? []) cfg[r.key] = r.value
    const truthy = (v: unknown): boolean => v == null || v === true || v === 'true' // absent → on
    // Premium follows the Pro toggle; guests resolve to 'free' upstream.
    return truthy(tier === 'free' ? cfg.chunk_repair_enabled_free : cfg.chunk_repair_enabled_pro)
  } catch (err) {
    console.error('[chunk-repair] config read threw, defaulting ON:', err)
    return true
  }
}

/**
 * Hardcoded fallback for audio quality enhancement.
 * The active version can be overridden from the `system_prompts` table
 * (type = 'transcription_audio_quality') without redeploying.
 */
const AUDIO_QUALITY_PROMPT_V1 = `
AUDIO QUALITY:
- Skip genuinely inaudible words silently — no placeholders.
- Transcribe only intentional speech; ignore background noise.`

export function enhanceTranscriptionPrompt(
  baseInstruction: string,
  config: AudioPipelineConfig,
  audioQuality: 'good' | 'low' | 'unknown' = 'unknown',
  dbPromptOverride?: string | null,
): string {
  if (!config.preprocessEnabled) return baseInstruction
  if (audioQuality === 'good') return baseInstruction
  const enhancement = dbPromptOverride ?? AUDIO_QUALITY_PROMPT_V1
  return `${baseInstruction}\n${enhancement}`
}
