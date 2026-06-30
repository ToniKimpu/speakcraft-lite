import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:speakcraft/config/env.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/services/supabase_service.dart';

/// Resolved YouTube metadata from the `yt-meta` edge function.
class YtMeta {
  const YtMeta({
    required this.youtubeId,
    required this.title,
    required this.channelTitle,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.sourceUrl,
  });

  final String youtubeId;
  final String title;
  final String channelTitle;
  final String thumbnailUrl;
  final int durationSeconds;
  final String sourceUrl;

  factory YtMeta.fromJson(Map<String, dynamic> j) => YtMeta(
        youtubeId: (j['youtubeId'] ?? '') as String,
        title: (j['title'] ?? '') as String,
        channelTitle: (j['channelTitle'] ?? '') as String,
        thumbnailUrl: (j['thumbnailUrl'] ?? '') as String,
        durationSeconds: (j['durationSeconds'] as num?)?.toInt() ?? 0,
        sourceUrl: (j['sourceUrl'] ?? '') as String,
      );
}

/// One row of `public.user_imports` — a user-imported video turned into a
/// Listening & Shadowing lesson. Plain class (no codegen): only used here.
class UserImport {
  const UserImport({
    required this.id,
    required this.youtubeId,
    required this.title,
    required this.thumbnailUrl,
    required this.durationSec,
    required this.sourceUrl,
    required this.subtitlePath,
    required this.shadowingPath,
    required this.recordPath,
    this.keyTakeawaysPath = '',
    this.sentenceExplanationPath = '',
    this.multipleChoicePath = '',
  });

  final String id; // uuid
  final String youtubeId;
  final String title;
  final String thumbnailUrl;
  final int durationSec;
  final String sourceUrl;
  final String subtitlePath;
  final String shadowingPath;
  final String recordPath;
  final String keyTakeawaysPath;
  final String sentenceExplanationPath;
  final String multipleChoicePath;

  factory UserImport.fromRow(Map<String, dynamic> r) => UserImport(
        id: (r['id'] ?? '') as String,
        youtubeId: (r['youtube_id'] ?? '') as String,
        title: (r['title'] ?? '') as String,
        thumbnailUrl: (r['thumbnail_url'] ?? '') as String,
        durationSec: (r['duration_sec'] as num?)?.toInt() ?? 0,
        sourceUrl: (r['source_url'] ?? '') as String,
        subtitlePath: (r['subtitle_path'] ?? '') as String,
        shadowingPath: (r['shadowing_path'] ?? '') as String,
        recordPath: (r['record_path'] ?? '') as String,
        keyTakeawaysPath: (r['key_takeaways_path'] ?? '') as String,
        sentenceExplanationPath:
            (r['sentence_explanation_path'] ?? '') as String,
        multipleChoicePath: (r['multiple_choice_path'] ?? '') as String,
      );

  /// Adapt to the shared [Listening] model so the imported video flows through
  /// the existing lesson hub. `id` is synthesized (stable per video) — progress
  /// is keyed by [youtubeId], not this int, so the value only needs to be stable.
  /// The storage paths are already absolute Supabase URLs, which the watch /
  /// shadowing / record loaders fetch as-is.
  Listening toListening() => Listening(
        id: youtubeId.hashCode & 0x7fffffff,
        title: title.isEmpty ? 'YouTube import' : title,
        thumbnail: thumbnailUrl,
        start: 0,
        end: durationSec,
        hasMMSubtitle: true,
        hasVocabularies: false,
        youtubeId: youtubeId,
        subtitlePath: subtitlePath,
        shadowingPath: shadowingPath,
        recordSubtitlePath: recordPath,
        keyTakeawaysPath: keyTakeawaysPath,
        sentenceExplanationPath: sentenceExplanationPath,
        multipleChoicePath: multipleChoicePath,
        // Imports gate like non-free curated content: free users get Watch + MM
        // translation; the rest is premium. importId marks this as an import so
        // the generatable steps show (and generate lazily) for premium users.
        isFree: false,
        importId: id,
      );
}

/// Typed failures from the import backend, so the UI can show the right copy
/// (quota wall → upgrade prompt; too-long / too-large → guidance).
class YoutubeImportException implements Exception {
  const YoutubeImportException(
    this.code, {
    this.message,
    this.limit = 0,
    this.used = 0,
    this.maxDurationSec = 0,
    this.usedSec = 0,
    this.thisSec = 0,
    this.budgetSec = 0,
    this.remainingSec = 0,
    this.isPremium = false,
  });

  final String code;
  final String? message;
  final int limit;
  final int used;
  final int maxDurationSec;
  // Minutes-budget quota (seconds).
  final int usedSec;
  final int thisSec;
  final int budgetSec;
  final int remainingSec;
  final bool isPremium;

  bool get isQuota => code == 'import_quota_exceeded';
  bool get isTooLong => code == 'video_too_long';
  bool get isTooLarge => code == 'audio_too_large';
  bool get needsPremium => code == 'needs_premium';

  @override
  String toString() => 'YoutubeImportException($code)';
}

/// The user's import minutes budget — what's configured and how much they've
/// already used — so the UI can warn before an over-budget import.
class ImportQuota {
  const ImportQuota({
    required this.freeUsedSec,
    required this.premiumUsedSec,
    required this.freeTotalSec,
    required this.premiumTotalSec,
  });

  // Usage is tracked in two independent pools (free vs premium imports), so an
  // upgrade gives a full premium budget regardless of free-trial usage.
  final int freeUsedSec;
  final int premiumUsedSec;
  final int freeTotalSec;
  final int premiumTotalSec;

  int budgetSec(bool isPremium) => isPremium ? premiumTotalSec : freeTotalSec;
  int usedSec(bool isPremium) => isPremium ? premiumUsedSec : freeUsedSec;
  int remainingSec(bool isPremium) {
    final r = budgetSec(isPremium) - usedSec(isPremium);
    return r < 0 ? 0 : r;
  }
}

/// Result of a lazy enrichment call (yt-enrich). Whole-transcript steps
/// (record / key_takeaways) return [path]; the per-sentence explanation step
/// returns [url] + the generated [data] so the UI can render without a refetch.
class EnrichResult {
  const EnrichResult({this.path, this.url, this.data});

  final String? path;
  final String? url;
  final Map<String, dynamic>? data;
}

/// Calls the `yt-meta` and `yt-transcribe` edge functions. The client supplies
/// the audio (downloaded on the user's own device/IP); the server transcribes,
/// translates, stores the lesson JSON, and records the import against quota.
class YoutubeImportRepository {
  String get _base => Env.supabaseURL;
  String get _anon => Env.supabaseAnonKey;
  String get _token =>
      supabase.auth.currentSession?.accessToken ?? Env.supabaseAnonKey;

  Map<String, String> get _authHeaders => {
        'Authorization': 'Bearer $_token',
        'apikey': _anon,
      };

  Never _throwFromBody(int status, Map<String, dynamic> body) {
    final code = (body['error'] ?? 'unknown') as String;
    throw YoutubeImportException(
      code,
      message: body['message'] as String?,
      limit: (body['limit'] as num?)?.toInt() ?? 0,
      used: (body['used'] as num?)?.toInt() ?? 0,
      maxDurationSec: (body['max_duration_sec'] as num?)?.toInt() ?? 0,
      usedSec: (body['used_sec'] as num?)?.toInt() ?? 0,
      thisSec: (body['this_sec'] as num?)?.toInt() ?? 0,
      budgetSec: (body['budget_sec'] as num?)?.toInt() ?? 0,
      remainingSec: (body['remaining_sec'] as num?)?.toInt() ?? 0,
      isPremium: body['is_premium'] as bool? ?? false,
    );
  }

  /// Resolve a YouTube URL (or bare id) to title / thumbnail / duration.
  Future<YtMeta> fetchMeta(String url) async {
    final resp = await http
        .post(
          Uri.parse('$_base/functions/v1/yt-meta'),
          headers: {..._authHeaders, 'Content-Type': 'application/json'},
          body: jsonEncode({'url': url}),
        )
        .timeout(const Duration(seconds: 20));

    final body = _decode(utf8.decode(resp.bodyBytes));
    if (resp.statusCode != 200) _throwFromBody(resp.statusCode, body);
    return YtMeta.fromJson(body);
  }

  /// Upload the audio file and create the lesson. [audioBytes] is the picked
  /// file's bytes; [filename] keeps the extension so Whisper detects the format.
  Future<UserImport> transcribe({
    required List<int> audioBytes,
    required String filename,
    required YtMeta meta,
    int audioDurationSec = 0,
  }) async {
    final req = http.MultipartRequest(
      'POST',
      Uri.parse('$_base/functions/v1/yt-transcribe'),
    )
      ..headers.addAll(_authHeaders)
      ..fields['youtube_id'] = meta.youtubeId
      ..fields['title'] = meta.title
      ..fields['thumbnail_url'] = meta.thumbnailUrl
      ..fields['duration_sec'] = meta.durationSeconds.toString()
      ..fields['audio_duration_sec'] = audioDurationSec.toString()
      ..fields['source_url'] = meta.sourceUrl
      ..files.add(http.MultipartFile.fromBytes('audio', audioBytes,
          filename: filename));

    // Transcription + translation can take a while; give it room.
    final streamed = await req.send().timeout(const Duration(minutes: 5));
    final resp = await http.Response.fromStream(streamed);

    final body = _decode(utf8.decode(resp.bodyBytes));
    if (resp.statusCode != 200) _throwFromBody(resp.statusCode, body);
    return UserImport.fromRow((body['import'] as Map).cast<String, dynamic>());
  }

  /// Generate one premium lesson step on demand (yt-enrich). [step] is one of
  /// `record`, `key_takeaways`, or `explanation`; the explanation step also
  /// needs [lineId] (the subtitle line to explain). Idempotent server-side —
  /// re-calling a generated step returns the cached result.
  Future<EnrichResult> enrich({
    required String importId,
    required String step,
    int? lineId,
  }) async {
    final resp = await http
        .post(
          Uri.parse('$_base/functions/v1/yt-enrich'),
          headers: {..._authHeaders, 'Content-Type': 'application/json'},
          body: jsonEncode({
            'import_id': importId,
            'step': step,
            if (lineId != null) 'line_id': lineId,
          }),
        )
        .timeout(const Duration(minutes: 3));

    final body = _decode(utf8.decode(resp.bodyBytes));
    if (resp.statusCode != 200) _throwFromBody(resp.statusCode, body);
    return EnrichResult(
      path: body['path'] as String?,
      url: body['url'] as String?,
      data: (body['data'] as Map?)?.cast<String, dynamic>(),
    );
  }

  /// The current user's imports, newest first (drives the My Videos tab).
  /// Soft-deleted rows are hidden but still count toward the minutes budget.
  Future<List<UserImport>> listImports() async {
    final rows = await supabase
        .from('user_imports_listening')
        .select()
        .eq('is_deleted', false)
        .order('created_at', ascending: false);
    return (rows as List)
        .map((e) => UserImport.fromRow((e as Map).cast<String, dynamic>()))
        .toList();
  }

  /// Reads the minutes budget (config) and minutes already used (SUM of
  /// duration_sec over ALL the user's rows, including soft-deleted — same as the
  /// server gate). Lets the UI pre-check a video's duration before importing.
  Future<ImportQuota> fetchQuota() async {
    final cfg = await supabase
        .from('youtube_import_config')
        .select('free_total_sec, premium_total_sec')
        .eq('id', 1)
        .maybeSingle();
    final rows = await supabase
        .from('user_imports_listening')
        .select('duration_sec, imported_free');
    var freeUsed = 0;
    var premiumUsed = 0;
    for (final r in (rows as List)) {
      final m = r as Map;
      final sec = (m['duration_sec'] as num?)?.toInt() ?? 0;
      if (m['imported_free'] == false) {
        premiumUsed += sec;
      } else {
        freeUsed += sec;
      }
    }
    return ImportQuota(
      freeUsedSec: freeUsed,
      premiumUsedSec: premiumUsed,
      freeTotalSec: (cfg?['free_total_sec'] as num?)?.toInt() ?? 600,
      premiumTotalSec: (cfg?['premium_total_sec'] as num?)?.toInt() ?? 18000,
    );
  }

  /// Soft-delete an import (remove it from My Videos). The row is kept so the
  /// minutes already used can't be reclaimed by deleting. RLS + a column-scoped
  /// update grant let the owner flip only `is_deleted`.
  Future<void> deleteImport(String importId) async {
    await supabase
        .from('user_imports_listening')
        .update({'is_deleted': true})
        .eq('id', importId);
  }

  Map<String, dynamic> _decode(String body) {
    if (body.isEmpty) return {};
    try {
      final v = jsonDecode(body);
      return v is Map ? v.cast<String, dynamic>() : {};
    } catch (_) {
      return {};
    }
  }
}
