// Deno / Edge copy. The Node / Cloud Run side keeps the same data split
// across `shared/gemini-models.ts`, `shared/languages.ts`, and
// `shared/transcription-prompts.ts`. KEEP IN SYNC manually when adding a
// language or changing the model defaults or transcription prompt.

// ── AI model defaults ────────────────────────────────────────────────────────
export const GEMINI_MODEL_AUDIO = 'gemini-2.5-flash-lite'
export const GEMINI_MODEL_AUDIO_LITE = 'gemini-2.5-flash-lite'
export const GEMINI_MODEL_TEXT = 'gemini-2.5-flash-lite'
// Per-chunk Burmese ASR repair. 3.1-flash-lite (not 2.5-flash-lite) because it
// materially outperforms on Burmese language judgment — the same reason the
// meeting summary/extract passes use it — and the diff-only design keeps output
// tiny so the higher rate barely moves per-hour cost. Keep in sync with the
// Node/Cloud-Run copy (services/transcribe-chunk/src/lib/chunk-repair.ts).
export const GEMINI_MODEL_REPAIR = 'gemini-3.1-flash-lite'

// ── Long recording constants ─────────────────────────────────────────────────
export const CHUNK_DURATION_MINUTES = 10
export const CHUNK_OVERLAP_MINUTES = 1

// ── Language system ──────────────────────────────────────────────────────────

export interface Language {
  code: string
  name: string
  nativeName: string
  flag: string
}

export const FEATURED_LANGUAGES: Language[] = [
  { code: 'NONE', name: 'Burmese', nativeName: 'မြန်မာ', flag: '🇲🇲' },
  { code: 'ENGLISH', name: 'English', nativeName: 'English', flag: '🇺🇸' },
  { code: 'JAPANESE', name: 'Japanese', nativeName: '日本語', flag: '🇯🇵' },
  { code: 'KOREAN', name: 'Korean', nativeName: '한국어', flag: '🇰🇷' },
  { code: 'THAI', name: 'Thai', nativeName: 'ไทย', flag: '🇹🇭' },
  { code: 'CHINESE', name: 'Chinese', nativeName: '中文', flag: '🇨🇳' },
  { code: 'VIETNAMESE', name: 'Vietnamese', nativeName: 'Tiếng Việt', flag: '🇻🇳' },
]

export const OTHER_LANGUAGES: Language[] = [
  { code: 'AFRIKAANS', name: 'Afrikaans', nativeName: 'Afrikaans', flag: '🇿🇦' },
  { code: 'ALBANIAN', name: 'Albanian', nativeName: 'Shqip', flag: '🇦🇱' },
  { code: 'AMHARIC', name: 'Amharic', nativeName: 'አማርኛ', flag: '🇪🇹' },
  { code: 'ARABIC', name: 'Arabic', nativeName: 'العربية', flag: '🇸🇦' },
  { code: 'ARMENIAN', name: 'Armenian', nativeName: 'Հայերեն', flag: '🇦🇲' },
  { code: 'AZERBAIJANI', name: 'Azerbaijani', nativeName: 'Azərbaycan', flag: '🇦🇿' },
  { code: 'BASQUE', name: 'Basque', nativeName: 'Euskara', flag: '🇪🇸' },
  { code: 'BELARUSIAN', name: 'Belarusian', nativeName: 'Беларуская', flag: '🇧🇾' },
  { code: 'BENGALI', name: 'Bengali', nativeName: 'বাংলা', flag: '🇧🇩' },
  { code: 'BOSNIAN', name: 'Bosnian', nativeName: 'Bosanski', flag: '🇧🇦' },
  { code: 'BULGARIAN', name: 'Bulgarian', nativeName: 'Български', flag: '🇧🇬' },
  { code: 'CATALAN', name: 'Catalan', nativeName: 'Català', flag: '🇪🇸' },
  { code: 'CROATIAN', name: 'Croatian', nativeName: 'Hrvatski', flag: '🇭🇷' },
  { code: 'CZECH', name: 'Czech', nativeName: 'Čeština', flag: '🇨🇿' },
  { code: 'DANISH', name: 'Danish', nativeName: 'Dansk', flag: '🇩🇰' },
  { code: 'DUTCH', name: 'Dutch', nativeName: 'Nederlands', flag: '🇳🇱' },
  { code: 'ESTONIAN', name: 'Estonian', nativeName: 'Eesti', flag: '🇪🇪' },
  { code: 'FILIPINO', name: 'Filipino', nativeName: 'Filipino', flag: '🇵🇭' },
  { code: 'FINNISH', name: 'Finnish', nativeName: 'Suomi', flag: '🇫🇮' },
  { code: 'FRENCH', name: 'French', nativeName: 'Français', flag: '🇫🇷' },
  { code: 'GALICIAN', name: 'Galician', nativeName: 'Galego', flag: '🇪🇸' },
  { code: 'GEORGIAN', name: 'Georgian', nativeName: 'ქართული', flag: '🇬🇪' },
  { code: 'GERMAN', name: 'German', nativeName: 'Deutsch', flag: '🇩🇪' },
  { code: 'GREEK', name: 'Greek', nativeName: 'Ελληνικά', flag: '🇬🇷' },
  { code: 'GUJARATI', name: 'Gujarati', nativeName: 'ગુજરાતી', flag: '🇮🇳' },
  { code: 'HAITIAN_CREOLE', name: 'Haitian Creole', nativeName: 'Kreyòl Ayisyen', flag: '🇭🇹' },
  { code: 'HEBREW', name: 'Hebrew', nativeName: 'עברית', flag: '🇮🇱' },
  { code: 'HINDI', name: 'Hindi', nativeName: 'हिन्दी', flag: '🇮🇳' },
  { code: 'HUNGARIAN', name: 'Hungarian', nativeName: 'Magyar', flag: '🇭🇺' },
  { code: 'ICELANDIC', name: 'Icelandic', nativeName: 'Íslenska', flag: '🇮🇸' },
  { code: 'INDONESIAN', name: 'Indonesian', nativeName: 'Bahasa Indonesia', flag: '🇮🇩' },
  { code: 'IRISH', name: 'Irish', nativeName: 'Gaeilge', flag: '🇮🇪' },
  { code: 'ITALIAN', name: 'Italian', nativeName: 'Italiano', flag: '🇮🇹' },
  { code: 'KANNADA', name: 'Kannada', nativeName: 'ಕನ್ನಡ', flag: '🇮🇳' },
  { code: 'KAZAKH', name: 'Kazakh', nativeName: 'Қазақ', flag: '🇰🇿' },
  { code: 'KHMER', name: 'Khmer', nativeName: 'ខ្មែរ', flag: '🇰🇭' },
  { code: 'LAO', name: 'Lao', nativeName: 'ລາວ', flag: '🇱🇦' },
  { code: 'LATVIAN', name: 'Latvian', nativeName: 'Latviešu', flag: '🇱🇻' },
  { code: 'LITHUANIAN', name: 'Lithuanian', nativeName: 'Lietuvių', flag: '🇱🇹' },
  { code: 'MACEDONIAN', name: 'Macedonian', nativeName: 'Македонски', flag: '🇲🇰' },
  { code: 'MALAY', name: 'Malay', nativeName: 'Bahasa Melayu', flag: '🇲🇾' },
  { code: 'MALAYALAM', name: 'Malayalam', nativeName: 'മലയാളം', flag: '🇮🇳' },
  { code: 'MALTESE', name: 'Maltese', nativeName: 'Malti', flag: '🇲🇹' },
  { code: 'MARATHI', name: 'Marathi', nativeName: 'मराठी', flag: '🇮🇳' },
  { code: 'MONGOLIAN', name: 'Mongolian', nativeName: 'Монгол', flag: '🇲🇳' },
  { code: 'NEPALI', name: 'Nepali', nativeName: 'नेपाली', flag: '🇳🇵' },
  { code: 'NORWEGIAN', name: 'Norwegian', nativeName: 'Norsk', flag: '🇳🇴' },
  { code: 'PASHTO', name: 'Pashto', nativeName: 'پښتو', flag: '🇦🇫' },
  { code: 'PERSIAN', name: 'Persian', nativeName: 'فارسی', flag: '🇮🇷' },
  { code: 'POLISH', name: 'Polish', nativeName: 'Polski', flag: '🇵🇱' },
  { code: 'PORTUGUESE', name: 'Portuguese', nativeName: 'Português', flag: '🇧🇷' },
  { code: 'PUNJABI', name: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ', flag: '🇮🇳' },
  { code: 'ROMANIAN', name: 'Romanian', nativeName: 'Română', flag: '🇷🇴' },
  { code: 'RUSSIAN', name: 'Russian', nativeName: 'Русский', flag: '🇷🇺' },
  { code: 'SERBIAN', name: 'Serbian', nativeName: 'Српски', flag: '🇷🇸' },
  { code: 'SINHALA', name: 'Sinhala', nativeName: 'සිංහල', flag: '🇱🇰' },
  { code: 'SLOVAK', name: 'Slovak', nativeName: 'Slovenčina', flag: '🇸🇰' },
  { code: 'SLOVENIAN', name: 'Slovenian', nativeName: 'Slovenščina', flag: '🇸🇮' },
  { code: 'SOMALI', name: 'Somali', nativeName: 'Soomaali', flag: '🇸🇴' },
  { code: 'SPANISH', name: 'Spanish', nativeName: 'Español', flag: '🇪🇸' },
  { code: 'SWAHILI', name: 'Swahili', nativeName: 'Kiswahili', flag: '🇰🇪' },
  { code: 'SWEDISH', name: 'Swedish', nativeName: 'Svenska', flag: '🇸🇪' },
  { code: 'TAMIL', name: 'Tamil', nativeName: 'தமிழ்', flag: '🇮🇳' },
  { code: 'TELUGU', name: 'Telugu', nativeName: 'తెలుగు', flag: '🇮🇳' },
  { code: 'TURKISH', name: 'Turkish', nativeName: 'Türkçe', flag: '🇹🇷' },
  { code: 'UKRAINIAN', name: 'Ukrainian', nativeName: 'Українська', flag: '🇺🇦' },
  { code: 'URDU', name: 'Urdu', nativeName: 'اردو', flag: '🇵🇰' },
  { code: 'UZBEK', name: 'Uzbek', nativeName: "O'zbek", flag: '🇺🇿' },
  { code: 'WELSH', name: 'Welsh', nativeName: 'Cymraeg', flag: '🏴󠁧󠁢󠁷󠁬󠁳󠁿' },
  { code: 'ZULU', name: 'Zulu', nativeName: 'isiZulu', flag: '🇿🇦' },
]

export const LANGUAGES: Language[] = [...FEATURED_LANGUAGES, ...OTHER_LANGUAGES]

const LANG_MAP = new Map(LANGUAGES.map((l) => [l.code, l]))

export function getLangByCode(code: string): Language | undefined {
  return LANG_MAP.get(code)
}

// ── Transcription instructions ───────────────────────────────────────────────

export const SYSTEM_INSTRUCTION_TRANSCRIPTION = `
Provide a Clean Verbatim transcription of the audio.

RULES:
1. Capture every spoken word accurately.
2. Remove disfluencies (ums, ahs, stutters, filler words) unless they carry emotional meaning.
3. Apply punctuation to reflect natural pauses, emphasis, and intent.
4. Code-switching: if the speaker mixes languages, transcribe each word in its original script.
5. Numbers and dates: write them as spoken (e.g., "ten thirty" → 10:30).
6. Ignore background noise and non-speech sounds.

WHAT TO TRANSCRIBE:
- Transcribe ONLY actual human SPEECH — someone talking, narrating, dictating.
- DO NOT attempt to transcribe music, songs, instrumental sections, jingles,
  ads with music beds, ambient sound, traffic, silence, or non-speech audio.
- DO NOT try to identify songs, describe music, or note "[music playing]".
  Music and non-speech sections produce NO output — just silence in the
  transcript. The system handles missing sections correctly on its own.

WHEN UNCLEAR — CRITICAL:
- If a section contains no speech (music, silence, noise, distortion, an
  unknown language), or you cannot transcribe it with reasonable
  confidence: output NOTHING for that section. Empty is correct.
- NEVER guess. NEVER fill silence with repeated phrases. NEVER fall into
  repetition loops. If you find yourself repeating the same words or
  phrases, STOP — return what you have so far.
- If the ENTIRE clip has no transcribable speech: return an empty response
  (no text at all). The system handles empty output gracefully.

OUTPUT: Only the transcribed text. No translations, no commentary, no preamble.
`

export function getTranscriptionInstruction(inputLanguage: string): string {
  if (inputLanguage === 'NONE') return SYSTEM_INSTRUCTION_TRANSCRIPTION

  const lang = getLangByCode(inputLanguage)
  const langName = lang?.name ?? inputLanguage
  return `
Provide a Clean Verbatim transcription of the audio in ${langName}.

RULES:
1. Capture every spoken word accurately in ${langName}.
2. Remove disfluencies (ums, ahs, stutters, filler words) unless they carry emotional meaning.
3. Apply punctuation to reflect natural pauses, emphasis, and intent.
4. Code-switching: if the speaker mixes in words from other languages, transcribe those words in their original script.
5. Numbers and dates: write them as spoken (e.g., "ten thirty" → 10:30).
6. Ignore background noise and non-speech sounds.

WHAT TO TRANSCRIBE:
- Transcribe ONLY actual human SPEECH — someone talking, narrating, dictating.
- DO NOT attempt to transcribe music, songs, instrumental sections, jingles,
  ads with music beds, ambient sound, traffic, silence, or non-speech audio.
- DO NOT try to identify songs, describe music, or note "[music playing]".
  Music and non-speech sections produce NO output — just silence in the
  transcript. The system handles missing sections correctly on its own.

WHEN UNCLEAR — CRITICAL:
- If a section contains no speech (music, silence, noise, distortion, an
  unknown language), or you cannot transcribe it with reasonable
  confidence: output NOTHING for that section. Empty is correct.
- NEVER guess. NEVER fill silence with repeated phrases. NEVER fall into
  repetition loops. If you find yourself repeating the same words or
  phrases, STOP — return what you have so far.
- If the ENTIRE clip has no transcribable speech: return an empty response
  (no text at all). The system handles empty output gracefully.

OUTPUT: Only the transcribed text. No translations, no commentary, no preamble.
`
}
