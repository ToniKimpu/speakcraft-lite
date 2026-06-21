import type { GoogleGenAI } from '@google/genai'
import { corsHeaders } from '../_shared/cors.ts'
import { createServiceClient, getUser } from '../_shared/supabase-client.ts'
import { createAI, type AIConfig, getUserTier, audioBurmeseModelForTier, repairModelForTier } from '../_shared/ai-client.ts'
import {
  getTranscriptionInstruction,
  getLangByCode,
} from '../_shared/constants.ts'
import { repairChunkBurmese } from '../_shared/chunk-repair.ts'
import { getActiveSystemPrompt } from '../_shared/system-prompts.ts'
import { getAudioPipelineConfig, enhanceTranscriptionPrompt, isChunkRepairEnabled } from '../_shared/audio-config.ts'
import { logAiUsage, extractTokenUsage } from '../_shared/ai-logger.ts'
import { validateTranscript, stripTimestamps } from '../_shared/transcript-validator.ts'
import { isPassthroughStyle, generateNoteTitle, buildRefinementPrompt, parseRefineJson } from '../_shared/refine-utils.ts'
import { isMeteringEnabled } from '../_shared/metering.ts'

// ── Types ────────────────────────────────────────────────────────────────────

type ServiceClient = ReturnType<typeof createServiceClient>

// ── Helpers ──────────────────────────────────────────────────────────────────

async function updateJob(
  supabase: ServiceClient,
  jobId: string,
  fields: Record<string, unknown>,
) {
  await supabase
    .from('transcription_jobs')
    .update({ ...fields, updated_at: new Date().toISOString() })
    .eq('id', jobId)
}

function deduplicateOverlap(
  previousTail: string,
  currentText: string,
): string {
  if (!previousTail || !currentText) return currentText

  const maxCheck = Math.min(previousTail.length, currentText.length, 500)
  for (let len = maxCheck; len >= 20; len--) {
    const tail = previousTail.slice(-len)
    if (currentText.startsWith(tail)) return currentText.slice(len)
  }

  const prevSentences = previousTail.split(/[။\.\n]+/).filter(Boolean)
  if (prevSentences.length > 0) {
    const lastSentence = prevSentences[prevSentences.length - 1].trim()
    if (lastSentence.length > 15 && currentText.startsWith(lastSentence)) {
      return currentText.slice(lastSentence.length)
    }
  }

  return currentText
}

// ── Inline Data Transcription (< 20MB) ──────────────────────────────────────

async function transcribeInline(
  ai: GoogleGenAI,
  model: string,
  systemInstruction: string,
  langName: string,
  base64Data: string,
  mimeType: string,
  previousContext: string | null,
  isFirstChunk: boolean,
  temperature = 0.2,
): Promise<{ text: string; usage: unknown }> {
  const contextInstruction = previousContext
    ? `\n\nFor context, the previous segment ended with: "${previousContext}"\nContinue from where this left off. Do not repeat the previous content.`
    : ''

  const chunkLabel = isFirstChunk ? 'first' : 'next'

  const response = await ai.models.generateContent({
    model,
    contents: {
      parts: [
        { inlineData: { data: base64Data, mimeType } },
        {
          text: `Transcribe this ${chunkLabel} audio segment.${contextInstruction}\n\nPerform a high-fidelity ${langName} transcription as per system instructions.`,
        },
      ],
    },
    config: { systemInstruction, temperature },
  })

  return { text: response.text ?? '', usage: response.usageMetadata }
}

// ── Files API Transcription (>= 20MB) ───────────────────────────────────────

async function transcribeViaFilesAPI(
  ai: GoogleGenAI,
  model: string,
  systemInstruction: string,
  langName: string,
  audioData: ArrayBuffer,
  mimeType: string,
  previousContext: string | null,
  isFirstChunk: boolean,
  temperature = 0.2,
): Promise<{ text: string; geminiFileName: string | null; usage: unknown }> {
  const uploadResult = await ai.files.upload({
    file: new Blob([new Uint8Array(audioData)], { type: mimeType }),
    config: { mimeType },
  })

  // Poll until ACTIVE
  let fileState = uploadResult
  for (let i = 0; i < 30; i++) {
    if (fileState.state === 'ACTIVE') break
    if (fileState.state === 'FAILED') throw new Error('Gemini file processing failed')
    await new Promise(r => setTimeout(r, 2000))
    if (fileState.name) fileState = await ai.files.get({ name: fileState.name })
  }

  if (!fileState.uri) throw new Error('Gemini file upload failed — no URI')

  const contextInstruction = previousContext
    ? `\n\nFor context, the previous segment ended with: "${previousContext}"\nContinue from where this left off. Do not repeat the previous content.`
    : ''

  const chunkLabel = isFirstChunk ? 'first' : 'next'

  const response = await ai.models.generateContent({
    model,
    contents: {
      parts: [
        { fileData: { fileUri: fileState.uri, mimeType } },
        {
          text: `Transcribe this ${chunkLabel} audio segment.${contextInstruction}\n\nPerform a high-fidelity ${langName} transcription as per system instructions.`,
        },
      ],
    },
    config: { systemInstruction, temperature },
  })

  return {
    text: response.text ?? '',
    geminiFileName: fileState.name ?? null,
    usage: response.usageMetadata,
  }
}

// ── Inline Refine ───────────────────────────────────────────────────────────

async function inlineRefine(
  ai: GoogleGenAI,
  aiConfig: AIConfig,
  service: ServiceClient,
  text: string,
  styleId: string | null,
  language: string,
  userId: string,
): Promise<{
  refinedText: string
  title: string
  resolvedStyleId: string | null
  styleName: string | null
  usage?: unknown
}> {
  let styleName: string
  let styleDescription: string
  let promptInstruction: string
  let resolvedStyleId: string | null = null

  if (styleId) {
    const { data: template } = await service
      .from('style_templates')
      .select('id, name, description, prompt_instruction')
      .eq('id', styleId)
      .single()

    if (template) {
      resolvedStyleId = template.id
      styleName = template.name
      styleDescription = template.description
      promptInstruction = template.prompt_instruction
    } else {
      const { data: custom } = await service
        .from('user_styles')
        .select('id, name, description, prompt_instruction')
        .eq('id', styleId)
        .single()

      if (custom) {
        resolvedStyleId = custom.id
        styleName = custom.name
        styleDescription = custom.description
        promptInstruction = custom.prompt_instruction
      } else {
        return { refinedText: text, title: 'Recording', resolvedStyleId: null, styleName: null }
      }
    }
  } else {
    const { data: fallback } = await service
      .from('style_templates')
      .select('id, name, description, prompt_instruction')
      .is('deleted_at', null)
      .order('is_default', { ascending: false })
      .order('sort_order', { ascending: true })
      .limit(1)
      .maybeSingle()

    if (!fallback) {
      return { refinedText: text, title: 'Recording', resolvedStyleId: null, styleName: null }
    }
    resolvedStyleId = fallback.id
    styleName = fallback.name
    styleDescription = fallback.description
    promptInstruction = fallback.prompt_instruction
  }

  // Passthrough styles ("Keep Original") keep the transcript verbatim —
  // skip the refinement LLM, which summarises/truncates long transcripts.
  if (isPassthroughStyle(styleName)) {
    const title = await generateNoteTitle(ai, aiConfig.modelText, userId, text)
    return { refinedText: text, title: title || 'Recording', resolvedStyleId, styleName }
  }

  // The DB-backed wrapper template is hardcoded around a single target
  // language ("translate sense-for-sense...") and uses {{LANGUAGE}} in
  // multiple spots. For ORIGINAL we always fall through to the local builder,
  // which has a dedicated "preserve input language, do not translate" branch.
  // Without this gate, Burmese/Thai/etc. imports come back in English whenever
  // a non-passthrough style is selected. Mirrors supabase/functions/refine.
  const wrapperTemplate =
    language === 'ORIGINAL' ? null : await getActiveSystemPrompt('refinement_wrapper')

  let prompt: string
  if (wrapperTemplate) {
    const langDisplay = language === 'NONE' ? 'Contemporary Burmese (Modern Register)' : language
    prompt = wrapperTemplate
      .replaceAll('{{TEXT}}', text)
      .replaceAll('{{STYLE_NAME}}', styleName)
      .replaceAll('{{LANGUAGE}}', langDisplay)
      .replaceAll('{{STYLE_DESCRIPTION}}', styleDescription)
      .replaceAll('{{PROMPT_INSTRUCTION}}', promptInstruction)
  } else {
    prompt = buildRefinementPrompt(styleName, styleDescription, promptInstruction, language, text)
  }

  let response
  try {
    response = await ai.models.generateContent({
      model: aiConfig.modelText,
      contents: prompt,
      config: { temperature: 0.5, responseMimeType: 'application/json' },
    })
  } catch {
    // Gemini call failed → nothing billed, no usage.
    return { refinedText: text, title: 'Recording', resolvedStyleId, styleName }
  }
  // Call succeeded (billed) → always surface usage even if JSON is malformed,
  // so a billed refine is never dropped from ai_usage_logs (undercount).
  // Robust parse (fence-strip + newline-repair + multi-candidate); null on total
  // failure → fall back to verbatim text. usage is still returned either way.
  const result = parseRefineJson(response.text ?? '') ?? {}
  return {
    refinedText: result.refinedText || text,
    title: result.title || 'Recording',
    resolvedStyleId,
    styleName,
    usage: response.usageMetadata,
  }
}

// ── Inline Embed ────────────────────────────────────────────────────────────

async function inlineEmbed(
  ai: GoogleGenAI,
  service: ServiceClient,
  text: string,
  noteId: string,
  userId: string,
  source: string = 'recording',
): Promise<void> {
  try {
    const startMs = Date.now()
    const result = await ai.models.embedContent({
      model: 'gemini-embedding-001',
      contents: text,
      config: { outputDimensionality: 768 },
    })
    const embedding = result.embeddings?.[0]?.values
    if (embedding) {
      await service
        .from('notes')
        .update({ embedding: JSON.stringify(embedding) })
        .eq('id', noteId)
    }
    logAiUsage(service, {
      userId,
      noteId,
      operation: 'embed',
      model: 'gemini-embedding-001',
      processingMs: Date.now() - startMs,
      metadata: { noteId, source },
    })
  } catch (err) {
    console.error('[transcribe-long] Embed error:', err)
  }
}

// ── Self-invoke ─────────────────────────────────────────────────────────────

function selfInvokeNextChunk(jobId: string, nextChunkIndex: number): void {
  // Fire the next-chunk request via the runtime scheduler so it outlives
  // our HTTP handler. A bare fetch promise dies with our worker before the
  // request body leaves (observed: chunk 0 finished, chunk 1 never started).
  // EdgeRuntime.waitUntil hands the promise to Supabase's runtime, which
  // keeps it alive in its own scheduler.
  const fnUrl = `${Deno.env.get('SUPABASE_URL')}/functions/v1/transcribe-long`
  const dispatchPromise = fetch(fnUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
    },
    body: JSON.stringify({ jobId, chunkIndex: nextChunkIndex, _internal: true }),
  }).catch((err: unknown) => {
    console.error(`[transcribe-long] Chunk ${nextChunkIndex} dispatch failed:`, err)
    return null
  })

  // @ts-ignore — EdgeRuntime is the Supabase Edge Functions runtime global
  if (typeof EdgeRuntime !== 'undefined' && typeof EdgeRuntime.waitUntil === 'function') {
    // @ts-ignore
    EdgeRuntime.waitUntil(dispatchPromise)
  }

  console.log(`[transcribe-long] Chunk ${nextChunkIndex} dispatched via waitUntil`)
}

// ── Main ────────────────────────────────────────────────────────────────────

const INLINE_SIZE_LIMIT = 20 * 1024 * 1024 // 20 MB — Gemini inline data limit

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const { jobId, chunkIndex = 0, _internal } = (await req.json()) as {
    jobId: string
    chunkIndex?: number
    _internal?: boolean
  }

  // Auth: external calls require JWT, internal calls use service key
  if (!_internal) {
    const user = await getUser(req)
    if (!user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), {
        status: 401,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }
  }

  if (!jobId) {
    return new Response(JSON.stringify({ error: 'Missing jobId' }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }

  const serviceClient = createServiceClient()

  // Load job
  const { data: job, error: jobError } = await serviceClient
    .from('transcription_jobs')
    .select('*')
    .eq('id', jobId)
    .single()

  if (jobError || !job) {
    return new Response(JSON.stringify({ error: 'Job not found' }), {
      status: 404,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }

  // Ownership check for external calls
  if (!_internal) {
    const user = await getUser(req)
    if (job.user_id !== user!.id) {
      return new Response(JSON.stringify({ error: 'Forbidden' }), {
        status: 403,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }
  }

  const storageChunks: string[] = job.storage_chunks ?? []
  const totalChunks = storageChunks.length

  if (totalChunks === 0) {
    await updateJob(serviceClient, jobId, {
      status: 'error',
      error_message: 'No audio chunks found in job',
    })
    return new Response(JSON.stringify({ error: 'No chunks' }), {
      status: 400,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }

  // Update total_chunks if not yet set
  if (job.total_chunks !== totalChunks) {
    await updateJob(serviceClient, jobId, { total_chunks: totalChunks })
  }

  // Resolve language + model
  const inputLanguage: string = job.input_language || 'NONE'
  const isBurmese = inputLanguage === 'NONE'
  const langName = getLangByCode(inputLanguage)?.name ?? 'Burmese'
  let systemInstruction: string
  if (isBurmese) {
    systemInstruction =
      (await getActiveSystemPrompt('transcription')) ??
      getTranscriptionInstruction(inputLanguage)
  } else {
    systemInstruction = getTranscriptionInstruction(inputLanguage)
  }

  const { ai, config: aiConfig } = await createAI()
  const audioCfg = await getAudioPipelineConfig()
  // Per-tier model overrides (Burmese transcription + repair). Other-language
  // transcription and text refinement stay global.
  const tier = await getUserTier(job.user_id as string)

  // Enhance prompt with low-volume / whisper handling instructions
  const audioQualityPrompt = await getActiveSystemPrompt('transcription_audio_quality')
  systemInstruction = enhanceTranscriptionPrompt(systemInstruction, audioCfg, 'unknown', audioQualityPrompt)

  const model = isBurmese ? audioBurmeseModelForTier(aiConfig, tier) : aiConfig.modelAudioOther
  const repairModel = repairModelForTier(aiConfig, tier)

  try {
    // ── Cancellation check ──────────────────────────────────────────────────
    // pg_net dispatches chunks asynchronously: the next-chunk request is
    // queued the moment a previous chunk's UPDATE commits, but the actual
    // HTTP invocation lands here some milliseconds-to-seconds later. In
    // that window the user (or the sweep cron) may have flipped the job
    // to 'cancelled' / 'error'. Re-read the status fresh and bail out
    // BEFORE the expensive Gemini call — saves up to one chunk's worth
    // of tokens per cancel and skips redundant Storage download too.
    //
    // Done before the "status = transcribing" flip below so a cancelled
    // job doesn't briefly toggle back to an active status (which would
    // race the chunk-advance trigger into dispatching the *next* chunk
    // before our skip-return lands).
    const { data: freshStatus } = await serviceClient
      .from('transcription_jobs')
      .select('status')
      .eq('id', jobId)
      .single()
    if (freshStatus &&
        (freshStatus.status === 'cancelled' ||
         freshStatus.status === 'error')) {
      console.log(`[transcribe-long] Chunk ${chunkIndex} skipped — `
        + `job already ${freshStatus.status}`)
      return new Response(
        JSON.stringify({ status: freshStatus.status, skipped: chunkIndex }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      )
    }

    // ── Transcribe this chunk ───────────────────────────────────────────────

    await updateJob(serviceClient, jobId, {
      status: 'transcribing',
      completed_chunks: chunkIndex,
      // Stamp the processing start once, on the first chunk, so we can later
      // separate queue/upload wait (created_at→started_at) from actual
      // transcription (started_at→completed_at).
      ...(chunkIndex === 0 ? { started_at: new Date().toISOString() } : {}),
    })

    const storagePath = storageChunks[chunkIndex]
    if (!storagePath) {
      await updateJob(serviceClient, jobId, {
        status: 'error',
        error_message: `Chunk ${chunkIndex} has no storage path — upload may have failed`,
      })
      return new Response(JSON.stringify({ error: 'Missing chunk path' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // Download chunk from Supabase Storage
    const { data: audioData, error: downloadError } = await serviceClient
      .storage
      .from('audio-recordings')
      .download(storagePath)

    if (downloadError || !audioData) {
      await updateJob(serviceClient, jobId, {
        status: 'error',
        error_message: `Failed to download chunk ${chunkIndex} from storage`,
      })
      return new Response(JSON.stringify({ error: 'Download failed' }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    const arrayBuffer = await audioData.arrayBuffer()
    // Recordings are always WebM/Opus from MediaRecorder; audio imports carry
    // the original mime in file_mime_type (e.g. audio/mpeg). Default keeps
    // behavior identical for existing recording jobs.
    const mimeType = (job.file_mime_type as string) || 'audio/webm'
    const previousContext = (job.previous_context as string) || null
    const isFirstChunk = chunkIndex === 0

    // Transcribe with retry (2 attempts)
    let chunkText = ''
    let chunkUsage: unknown = undefined
    let geminiFileToClean: string | null = null
    const chunkStartMs = Date.now()

    for (let attempt = 0; attempt < 2; attempt++) {
      try {
        if (arrayBuffer.byteLength < INLINE_SIZE_LIMIT) {
          // Small chunk — use inlineData (faster, no Files API overhead)
          const uint8 = new Uint8Array(arrayBuffer)
          let binary = ''
          for (let i = 0; i < uint8.length; i++) binary += String.fromCharCode(uint8[i])
          const base64 = btoa(binary)

          const result = await transcribeInline(
            ai, model, systemInstruction, langName,
            base64, mimeType, previousContext, isFirstChunk,
            audioCfg.transcriptionTemperature,
          )
          chunkText = result.text
          chunkUsage = result.usage
        } else {
          // Large chunk — use Gemini Files API
          const result = await transcribeViaFilesAPI(
            ai, model, systemInstruction, langName,
            arrayBuffer, mimeType, previousContext, isFirstChunk,
            audioCfg.transcriptionTemperature,
          )
          chunkText = result.text
          chunkUsage = result.usage
          geminiFileToClean = result.geminiFileName
        }
        break
      } catch (err) {
        if (attempt >= 1) {
          console.error(`[transcribe-long] Chunk ${chunkIndex} failed after 2 attempts:`, err)
          await updateJob(serviceClient, jobId, {
            status: 'error',
            error_message: `Chunk ${chunkIndex + 1}/${totalChunks} failed: ${err instanceof Error ? err.message : 'Unknown error'}`,
          })
          return new Response(JSON.stringify({ error: 'Transcription failed' }), {
            status: 500,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' },
          })
        }
        console.warn(`[transcribe-long] Chunk ${chunkIndex} attempt ${attempt + 1} failed, retrying...`)
        await new Promise(r => setTimeout(r, 2000))
      }
    }

    // Log chunk transcription usage (tokens + audio seconds) for cost tracking,
    // mirroring meeting-mode Pass 1. Append jobs already know their note; new-
    // note jobs don't yet (the note insert happens after all chunks finish), so
    // we tag the row with jobId and backfill note_id at finalization once the
    // note exists. Per-chunk audio seconds = total / chunks so the rows sum to
    // the true duration without double-counting the inter-chunk overlap.
    const totalDurationS = (job.total_duration_seconds as number) || 0
    const chunkAudioS = totalDurationS > 0 ? Math.round(totalDurationS / totalChunks) : undefined
    logAiUsage(serviceClient, {
      userId: job.user_id as string,
      noteId: (job.append_to_note_id as string | null) ?? null,
      operation: 'transcribe',
      model,
      ...extractTokenUsage(chunkUsage),
      audioDurationS: chunkAudioS,
      processingMs: Date.now() - chunkStartMs,
      fileSizeBytes: arrayBuffer.byteLength,
      metadata: { chunkIndex, totalChunks, source: (job.source as string) || 'recording', jobId },
    })

    // Cleanup Gemini file immediately if used
    if (geminiFileToClean) {
      ai.files.delete({ name: geminiFileToClean }).catch(console.error)
    }

    // Strip timestamp / subtitle-cue artifacts Gemini emits despite the
    // prompt — done per chunk so dedup + assembly only ever see clean text.
    chunkText = stripTimestamps(chunkText)

    // Deduplicate overlap text
    if (chunkIndex > 0 && previousContext) {
      chunkText = deduplicateOverlap(previousContext, chunkText)
    }

    // Burmese ASR repair (light-touch, guarded). No-op for other languages.
    // Runs after dedup so we only repair net-new text. Failures keep the
    // original text — never blocks the chunk. Gated by the chunk_repair_enabled
    // admin toggle (default on) so raw-vs-repaired can be A/B tested.
    if (await isChunkRepairEnabled(tier)) try {
      const repair = await repairChunkBurmese(ai, repairModel, chunkText)
      chunkText = repair.text
      if (!repair.skipped && repair.usage) {
        logAiUsage(serviceClient, {
          userId: job.user_id as string,
          noteId: (job.append_to_note_id as string | null) ?? null,
          operation: 'refine',
          model: repairModel,
          ...extractTokenUsage(repair.usage),
          metadata: { kind: 'chunk_repair', chunkIndex, totalChunks, reverts: repair.reverts, jobId },
        })
      }
    } catch (err) {
      console.warn('[transcribe-long] chunk repair failed, keeping original:', err)
    }

    // Accumulate transcript
    let transcript = (job.transcript as string) || ''
    transcript = transcript ? `${transcript}\n\n${chunkText}` : chunkText
    const newPreviousContext = chunkText.slice(-500)

    const isLastChunk = chunkIndex + 1 >= totalChunks

    await updateJob(serviceClient, jobId, {
      completed_chunks: chunkIndex + 1,
      transcript,
      previous_context: newPreviousContext,
      status: isLastChunk ? 'refining' : 'transcribing',
    })

    console.log(`[transcribe-long] Chunk ${chunkIndex + 1}/${totalChunks} done (${chunkText.length} chars)`)

    // ── If more chunks, self-invoke and return ────────────────────────────

    if (!isLastChunk) {
      // For audio_import jobs, the advance_transcription_chunk trigger fires
      // pg_net to invoke the next chunk when we increment completed_chunks
      // above. Recordings still use HTTP self-invoke from this worker.
      if ((job.source as string) !== 'audio_import') {
        selfInvokeNextChunk(jobId, chunkIndex + 1)
      } else {
        console.log(`[transcribe-long] Chunk ${chunkIndex + 1}/${totalChunks} done; trigger will dispatch chunk ${chunkIndex + 1}`)
      }
      return new Response(
        JSON.stringify({ status: 'continuing', chunk: chunkIndex + 1 }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      )
    }

    // ── Last chunk done — validate assembled transcript ────────────────

    const totalDuration = (job.total_duration_seconds as number) || 0
    const assembledValidation = validateTranscript(transcript, totalDuration)
    if (!assembledValidation.valid) {
      console.warn(`[transcribe-long] Transcript rejected: ${assembledValidation.detail}`)
      await updateJob(serviceClient, jobId, {
        status: 'error',
        error_message: assembledValidation.reason ?? 'No speech detected',
        completed_at: new Date().toISOString(),
      })
      // Cleanup storage chunks
      serviceClient.storage
        .from('audio-recordings')
        .remove(storageChunks.filter(Boolean))
        .catch(console.error)
      return new Response(
        JSON.stringify({ status: 'error', error: assembledValidation.reason }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
      )
    }

    // Record transcription usage for chunked audio imports. Kill-switch
    // gated, mirroring transcribe-file: an off metering state behaves as
    // pre-metering. Append-mode retries skip the charge — the original
    // attempt that created the target note already counted the audio. The
    // pre-flight length/quota check already ran in transcribe-file before
    // this job was chunked, so here we only record.
    if (
      (job.source as string) === 'audio_import' &&
      totalDuration > 0 &&
      !job.is_append &&
      await isMeteringEnabled(serviceClient)
    ) {
      const durationMinutes = Math.round((totalDuration / 60) * 100) / 100
      const { error: recordErr } = await serviceClient.rpc('record_minutes_used', {
        p_user_id: job.user_id as string,
        p_duration_minutes: durationMinutes,
      })
      if (recordErr) {
        console.error('[transcribe-long] record_minutes_used failed:', recordErr, { jobId, durationMinutes })
      }
    }

    // ── Refine + save ──────────────────────────────────────────────────

    const skipRefine = job.style_id === ''
    let refinedText = transcript
    let title = 'Recording'
    let resolvedStyleId = job.style_id as string | null
    let styleName: string | null = null
    let refineMs = 0

    if (!skipRefine) {
      try {
        const refineStartMs = Date.now()
        const refined = await inlineRefine(
          ai, aiConfig, serviceClient,
          transcript,
          job.style_id || null,
          job.language || 'NONE',
          job.user_id as string,
        )
        refineMs = Date.now() - refineStartMs
        refinedText = refined.refinedText
        title = refined.title
        resolvedStyleId = refined.resolvedStyleId || job.style_id
        styleName = refined.styleName
        // Only log refine when it actually ran — passthrough ("Keep Original")
        // returns usage:undefined; a zero-token 'refine' row would be a
        // phantom call in the per-note breakdown.
        if (refined.usage) {
          logAiUsage(serviceClient, {
            userId: job.user_id as string,
            noteId: (job.append_to_note_id as string | null) ?? null,
            operation: 'refine',
            model: aiConfig.modelText,
            ...extractTokenUsage(refined.usage),
            processingMs: refineMs,
            metadata: { language: job.language, styleId: job.style_id, source: (job.source as string) || 'recording', jobId },
          })
        }
      } catch (err) {
        console.error('[transcribe-long] Refine failed:', err)
      }
    } else {
      // No style (raw transcript) — still generate a real title instead of
      // falling back to "Recording".
      try {
        const t = await generateNoteTitle(ai, aiConfig.modelText, job.user_id as string, transcript)
        if (t) title = t
      } catch (err) {
        console.error('[transcribe-long] title generation failed:', err)
      }
    }

    // End-to-end wall-clock for this note: created_at (import began server-side)
    // → now (finalize). transcribe_ms is the remainder after refine. Stored on
    // the note so the admin listing can show "took N s" and we can compare
    // serial vs parallel dispatch later. Best-effort: never block the save.
    const jobCreatedMs = job.created_at ? Date.parse(job.created_at as string) : NaN
    const totalMs = Number.isFinite(jobCreatedMs) ? Date.now() - jobCreatedMs : null
    const processingStats = totalMs != null
      ? {
          total_ms: totalMs,
          transcribe_ms: Math.max(0, totalMs - refineMs),
          refine_ms: refineMs,
          chunks: totalChunks,
          source: (job.source as string) || 'recording',
        }
      : null

    // Ensure a real title — Keep-Original recordings (refine skipped) and
    // refine failures leave the 'Recording' default; generate one from the
    // transcript so placeholder "Voice memo — …" notes get a proper title.
    if (!title || title === 'Recording') {
      try {
        title = await generateNoteTitle(
          ai, aiConfig.modelText, job.user_id as string, refinedText || transcript,
        )
      } catch (err) {
        console.error('[transcribe-long] Title generation failed:', err)
      }
      if (!title) title = 'Recording'
    }

    // Save note
    let noteId: string | null = null

    if (job.is_append && job.append_to_note_id) {
      const { data: existingNote } = await serviceClient
        .from('notes')
        .select('original_text, refined_text, title')
        .eq('id', job.append_to_note_id)
        .single()

      if (existingNote) {
        // Empty existing original (placeholder voice-memo note that hasn't
        // been transcribed yet) — write the new transcript as-is. The
        // `${existing}\n\n${transcript}` form left a stray "\n\n" prefix
        // on first transcription, which surfaced as a leading blank line
        // in the saved note.
        const existingOriginal = (existingNote.original_text ?? '').trim()
        const combinedOriginal = existingOriginal === ''
          ? transcript
          : `${existingNote.original_text}\n\n${transcript}`
        // Title: replace the auto-generated voice-memo placeholder
        // ("Voice memo — …") or an empty title; keep a title the user
        // typed by hand. Also keep the placeholder when our generated
        // title is just the 'Recording' / 'Imported Note' fallback —
        // the date-stamped placeholder is more useful than a generic
        // fallback. Mirrors the same rule in transcribe-file.
        const existingTitle = (existingNote.title as string | null) ?? ''
        const hasRealTitle = !!title && title !== 'Recording' && title !== 'Imported Note'
        const isPlaceholder = existingTitle === '' || existingTitle.startsWith('Voice memo —')
        const keepTitle = !isPlaceholder || !hasRealTitle
        await serviceClient
          .from('notes')
          .update({
            ...(keepTitle ? {} : { title }),
            original_text: combinedOriginal,
            refined_text: refinedText,
            language: job.language,
            style_id: resolvedStyleId || null,
            style_name: styleName,
            ...(totalMs != null ? { processing_ms: totalMs, processing_stats: processingStats } : {}),
          })
          .eq('id', job.append_to_note_id)
        noteId = job.append_to_note_id
      }
    } else {
      const { data: newNote } = await serviceClient
        .from('notes')
        .insert({
          user_id: job.user_id,
          title,
          original_text: transcript,
          refined_text: refinedText,
          language: job.language || 'NONE',
          style_id: resolvedStyleId || null,
          style_name: styleName,
          ...(totalMs != null ? { processing_ms: totalMs, processing_stats: processingStats } : {}),
        })
        .select('id')
        .single()
      noteId = newNote?.id ?? null
    }

    // Link this job's transcribe/refine usage rows to the note now that it
    // exists. New-note jobs logged those rows with note_id null (the note is
    // created only here), tagging them with jobId in metadata instead; this
    // backfill gives per-note cost rollups the transcription cost. Safe by the
    // time we get here: the awaited refine (+ optional title) Gemini calls give
    // the fire-and-forget inserts ample time to land. No-op for append jobs.
    if (noteId) {
      const { error: linkErr } = await serviceClient
        .from('ai_usage_logs')
        .update({ note_id: noteId })
        .eq('metadata->>jobId', jobId)
        .is('note_id', null)
      if (linkErr) console.error('[transcribe-long] usage note_id backfill failed:', linkErr)
    }

    // Embed (fire-and-forget)
    if (noteId) {
      inlineEmbed(ai, serviceClient, refinedText || transcript, noteId, job.user_id as string, (job.source as string) || 'recording')
    }

    // Overview is now OPT-IN (Simple-mode default): a freshly transcribed note
    // stays 'simple' (plain transcript). The user generates the cheap overview on
    // demand via the `overview` function ("Summarize"), which flips the note to
    // 'summary'. Auto-overview-on-transcription removed 2026-06-07.

    // Mark completed
    await updateJob(serviceClient, jobId, {
      status: 'completed',
      note_id: noteId,
      transcript,
      completed_at: new Date().toISOString(),
    })

    // Cleanup Storage chunks
    serviceClient.storage
      .from('audio-recordings')
      .remove(storageChunks.filter(Boolean))
      .catch(console.error)

    return new Response(
      JSON.stringify({ status: 'completed', noteId }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    )
  } catch (err) {
    console.error('[transcribe-long] Unexpected error:', err)
    await updateJob(serviceClient, jobId, {
      status: 'error',
      error_message: err instanceof Error ? err.message : 'Unexpected error',
      completed_at: new Date().toISOString(),
    })
    return new Response(
      JSON.stringify({ error: 'Processing failed' }),
      {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      },
    )
  }
})
