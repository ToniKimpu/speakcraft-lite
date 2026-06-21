import 'dart:io';

import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/feedback_section.dart';
import 'package:speakcraft/model/daily_speaking/prep_section.dart';
import 'package:speakcraft/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show FunctionException, FileOptions;

import 'daily_speaking_sample_feedback.dart';
import 'daily_speaking_service_stubs.dart';

/// Thrown when the learner has hit their daily AI-feedback quota (free 1/day, or
/// premium daily token grant). The BLoC catches this to prompt an upgrade
/// instead of showing a generic error. [reason] is `free_daily` or
/// `premium_tokens`.
class DailySpeakingLimitException implements Exception {
  DailySpeakingLimitException(this.reason);
  final String reason;
  @override
  String toString() => 'DailySpeakingLimitException($reason)';
}

/// Thrown when the AI is temporarily overloaded (Gemini "high demand" / 503)
/// and the edge function's retries + model fallback were all exhausted. Distinct
/// from a generic error: the learner's audio/text is intact and a retry is FREE
/// (no session was recorded server-side, so no quota was spent), so the UI
/// offers an immediate "tap to retry" instead of a dead-end. The edge function
/// signals this with HTTP 503 + `{reason: 'overloaded'}`; a 502 (older upstream
/// gemini failure) is treated the same way since it's almost always transient.
class DailySpeakingBusyException implements Exception {
  @override
  String toString() => 'DailySpeakingBusyException';
}

/// Thrown when the async job is still running after the client give-up window.
/// The job row lives on (the server keeps it; a sweep can finish it), so this is
/// "taking longer than usual — try again", not a hard failure. [sessionId] is
/// the row that's still processing.
class DailySpeakingProcessingException implements Exception {
  DailySpeakingProcessingException(this.sessionId);
  final int sessionId;
  @override
  String toString() => 'DailySpeakingProcessingException($sessionId)';
}

/// Input bundle for a single review request — voice OR text, plus optional
/// topic context. Keeping the variants in one class avoids a dispatch fork in
/// the BLoC and matches what the edge function will accept.
class SessionInput {
  SessionInput.voice({
    required this.audioPath,
    required this.onRamp,
    required this.requestedSections,
    this.topic,
    this.durationSeconds = 0,
    this.topicAttemptId,
    this.revisionNumber = 1,
  })  : text = null,
        inputMode = 'voice';

  SessionInput.text({
    required this.text,
    required this.onRamp,
    required this.requestedSections,
    this.topic,
    this.topicAttemptId,
    this.revisionNumber = 1,
  })  : audioPath = null,
        durationSeconds = 0,
        inputMode = 'text';

  final String? audioPath;
  final String? text;
  final DailySpeakingTopic? topic;
  final String onRamp;
  final String inputMode;

  /// Version-loop chain id (minted before the call) + position, so the edge
  /// function can write a complete session row for history's v1/v2 grouping.
  final String? topicAttemptId;
  final int revisionNumber;

  /// Actual recording length (seconds), measured client-side. Gemini can't read
  /// wall-clock duration reliably, so the edge function trusts this when > 0.
  final int durationSeconds;

  /// Which optional feedback sections the learner asked for. The edge function
  /// builds its prompt from these so unrequested sections cost no tokens.
  /// See `FeedbackSectionKey`.
  final List<String> requestedSections;
}

/// Single entry point the BLoC calls. Owns the stub/real switch so swapping
/// to the live edge function is a one-line change.
class DailySpeakingService {
  /// Prep (expandTopic / askMore) still uses the stub — the
  /// `daily-speaking-prep` edge function isn't deployed yet.
  static const bool useStubResponse = true;

  /// The `daily-speaking-review` edge function IS deployed, so the feedback path
  /// runs for real. Flip to `true` to fall back to the canned stub.
  static const bool useStubReview = false;

  Future<DailySpeakingFeedback> reviewSession(SessionInput input) async {
    if (useStubReview) {
      return _stubResponse(input);
    }
    return _realResponse(input);
  }

  /// Own-topic AI prep: expand a bare typed [topicText] into a scaffolded
  /// [DailySpeakingTopic], filling **only the [sections] the learner chose** on
  /// the choose-prep screen (the rest stay empty, so unrequested sections cost
  /// no tokens). This is text-only and does NOT consume a practice from the
  /// learner's quota. The future edge function must branch on call *kind* (prep
  /// vs practice) and decrement the right counter.
  Future<DailySpeakingTopic> expandTopic({
    required String topicText,
    required Set<PrepSection> sections,
  }) async {
    if (useStubResponse) {
      await Future<void>.delayed(const Duration(seconds: 2)); // match feedback feel
      return DailySpeakingServiceStubs.expandedTopic(topicText, sections);
    }
    // TODO(real): supabase.functions.invoke('daily-speaking-prep', body: {
    //   'call_kind': 'prep',     // edge fn branches: prep does NOT decrement the
    //                            // practices quota (5 premium / 1 free).
    //   'topic_text': topicText,
    //   'sections': sections.map((s) => s.name).toList(), // only generate these
    // }); then DailySpeakingTopic.fromJson(...). Must return id:'own', bilingual
    // prompt + the rich guide fields for the requested sections only.
    throw UnimplementedError('daily-speaking-prep edge function not deployed');
  }

  /// "Add more help" on an already-expanded prep [current]: generate one
  /// [section] the learner didn't pick up front and merge it in. Bounded by the
  /// set of sections not yet present (the UI only offers missing ones).
  Future<DailySpeakingTopic> askMore({
    required PrepSection section,
    required DailySpeakingTopic current,
  }) async {
    if (useStubResponse) {
      await Future<void>.delayed(const Duration(seconds: 1));
      return DailySpeakingServiceStubs.addSection(current, section);
    }
    // TODO(real): supabase.functions.invoke('daily-speaking-prep', body: {
    //   'call_kind': 'prep', 'sections': [section.name],
    //   'topic': current.toJson(), // server returns the topic with that section
    // }); same budget branch as expandTopic (prep, not a practice).
    throw UnimplementedError('daily-speaking-prep edge function not deployed');
  }

  Future<DailySpeakingFeedback> _stubResponse(SessionInput input) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    // TEMP: always return the v2 annotated-transcript sample so the Review &
    // highlights screen and the new schema can be exercised end-to-end before
    // the Gemini edge function is live. Restore the hash-based rotation over
    // `DailySpeakingServiceStubs.cannedResponses` (high/mid/low variety) when
    // done previewing.
    var response = kSampleFiveMinFeedback;
    // If the on-ramp doesn't carry a topic, drop any target-phrase results from
    // the canned response so the result screen renders correctly.
    if (input.topic == null) {
      response = response.copyWith(targetPhraseResults: const []);
    }
    // Honor the learner's selection: blank out any optional section they didn't
    // request, mirroring what the real edge function will omit. Core fields
    // (score, level, strengths, explanation_mm, metrics) are always kept.
    return _applyRequestedSections(response, input.requestedSections.toSet());
  }

  DailySpeakingFeedback _applyRequestedSections(
    DailySpeakingFeedback f,
    Set<String> requested,
  ) {
    bool has(String key) => requested.contains(key);
    return f.copyWith(
      fixes: has(FeedbackSectionKey.sentenceFixes) ? f.fixes : const [],
      grammarPatterns:
          has(FeedbackSectionKey.grammarPatterns) ? f.grammarPatterns : const [],
      interferenceNotes: has(FeedbackSectionKey.burmeseInterference)
          ? f.interferenceNotes
          : const [],
      vocabUpgrades:
          has(FeedbackSectionKey.betterVocab) ? f.vocabUpgrades : const [],
      // Collocations and idioms share one `phrases` list; honor each toggle
      // independently by filtering on the phrase kind.
      phrases: f.phrases.where((p) {
        switch (p.kind) {
          case PhraseKind.collocation:
            return has(FeedbackSectionKey.collocations);
          case PhraseKind.idiom:
            return has(FeedbackSectionKey.idioms);
          case PhraseKind.phrasalVerb:
            return has(FeedbackSectionKey.phrasalVerbs);
        }
      }).toList(growable: false),
      nativeRewrite:
          has(FeedbackSectionKey.wholeRewrite) ? f.nativeRewrite : '',
      sentenceRewrites:
          has(FeedbackSectionKey.sentenceRewrite) ? f.sentenceRewrites : const [],
      pronunciationNotes: has(FeedbackSectionKey.pronunciation)
          ? f.pronunciationNotes
          : const [],
      fillerWords:
          has(FeedbackSectionKey.fillerWords) ? f.fillerWords : const [],
      subScores: has(FeedbackSectionKey.subScores) ? f.subScores : null,
    );
  }

  /// Async pipeline: upload audio + SUBMIT (returns a session id in ~1s) → the
  /// edge function processes Gemini in the background → we POLL the session row
  /// until it's `completed`/`error`. A worker that dies mid-call (the old 5-min
  /// wall-clock failure) leaves the row stuck `processing`; we re-KICK it so a
  /// fresh worker takes over. See DAILY_SPEAKING_ASYNC_PLAN.md.
  Future<DailySpeakingFeedback> _realResponse(SessionInput input) async {
    final body = await _serializeInput(input);
    final sessionId = await _submit(body);
    return _pollUntilDone(sessionId);
  }

  /// Submit the job; returns the session id. Throws limit/busy as today.
  Future<int> _submit(Map<String, dynamic> body) async {
    try {
      final res = await supabase.functions.invoke(
        'daily-speaking-review',
        body: body,
      );
      final data = res.data;
      if (res.status == 429 ||
          (data is Map && data['limit_reached'] == true)) {
        throw DailySpeakingLimitException(
          (data is Map ? data['reason']?.toString() : null) ?? 'limit',
        );
      }
      if (data is Map && data['session_id'] != null) {
        return (data['session_id'] as num).toInt();
      }
      if (res.status == 503 || res.status == 502 || res.status == 546) {
        throw DailySpeakingBusyException();
      }
      throw FormatException('daily-speaking submit: status ${res.status}');
    } on FunctionException catch (e) {
      final details = e.details;
      if (e.status == 429 ||
          (details is Map && details['limit_reached'] == true)) {
        throw DailySpeakingLimitException(
          (details is Map ? details['reason']?.toString() : null) ?? 'limit',
        );
      }
      if (e.status == 503 || e.status == 502 || e.status == 546) {
        throw DailySpeakingBusyException();
      }
      rethrow;
    }
  }

  /// Poll the session row until terminal. Re-kicks a stuck `processing` row (the
  /// app drives retries while open). Throws [DailySpeakingBusyException] on a
  /// transient `overloaded` error, [DailySpeakingProcessingException] if it's
  /// still going after the give-up window (the row lives on for history/sweep).
  Future<DailySpeakingFeedback> _pollUntilDone(int sessionId) async {
    const pollEvery = Duration(seconds: 2);
    const kickAfter = Duration(seconds: 160); // > server STALE_SECONDS (150)
    const giveUpAfter = Duration(minutes: 6);
    final startedAt = DateTime.now();
    var lastKick = DateTime.now();

    while (true) {
      await Future<void>.delayed(pollEvery);
      final row = await supabase
          .from('daily_speaking_sessions')
          .select('status, error_message, feedback')
          .eq('id', sessionId)
          .maybeSingle();
      final status = row?['status'] as String?;
      if (status == 'completed') {
        final fb = row?['feedback'];
        if (fb is Map) {
          return DailySpeakingFeedback.fromJson(Map<String, dynamic>.from(fb));
        }
        throw const FormatException('completed session missing feedback');
      }
      if (status == 'error') {
        final reason = row?['error_message'] as String?;
        if (reason == 'overloaded') throw DailySpeakingBusyException();
        throw Exception('daily-speaking failed: ${reason ?? 'unknown'}');
      }
      // queued / processing → re-kick a stuck job so a fresh worker takes over.
      if (DateTime.now().difference(lastKick) > kickAfter) {
        lastKick = DateTime.now();
        try {
          await supabase.functions.invoke(
            'daily-speaking-review',
            body: {'kick': sessionId},
          );
        } catch (_) {/* best-effort re-dispatch */}
      }
      if (DateTime.now().difference(startedAt) > giveUpAfter) {
        throw DailySpeakingProcessingException(sessionId);
      }
    }
  }

  /// Builds the edge-function request. Audio is UPLOADED to Storage first (the
  /// `user-recordings` bucket, under `{uid}/daily-speaking/…`) and only the
  /// storage PATH is sent — never the base64 bytes. Keeping the audio out of the
  /// request body keeps the worker from holding a multi-MB clip in memory (which
  /// blew the resource limit on 5-min recordings), and lets the edge function
  /// reuse the uploaded file as the replayable session recording. The `{uid}`
  /// prefix matches the bucket's "own user audio" RLS policy.
  Future<Map<String, dynamic>> _serializeInput(SessionInput input) async {
    final body = <String, dynamic>{
      'on_ramp': input.onRamp,
      'input_mode': input.inputMode,
      'requested_sections': input.requestedSections,
      if (input.topic != null) 'topic': input.topic!.toJson(),
    };
    if (input.audioPath != null) {
      final uid = supabase.auth.currentUser?.id;
      if (uid == null) {
        throw StateError('Not signed in — cannot upload audio.');
      }
      final ts = DateTime.now().microsecondsSinceEpoch;
      final attempt = input.topicAttemptId ?? 'x';
      final storagePath =
          '$uid/daily-speaking/${ts}_${attempt}_v${input.revisionNumber}.m4a';
      await supabase.storage.from('user-recordings').upload(
            storagePath,
            File(input.audioPath!),
            fileOptions: const FileOptions(contentType: 'audio/mp4', upsert: true),
          );
      body['audio_path'] = storagePath;
      body['audio_format'] = 'm4a';
    }
    if (input.durationSeconds > 0) {
      body['duration_seconds'] = input.durationSeconds;
    }
    if (input.topicAttemptId != null) {
      body['topic_attempt_id'] = input.topicAttemptId;
      body['revision_number'] = input.revisionNumber;
    }
    if (input.text != null) {
      body['text'] = input.text;
    }
    AppLogger.instance.debug(
      'DailySpeakingService: posting on_ramp=${input.onRamp} mode=${input.inputMode}',
    );
    return body;
  }
}
