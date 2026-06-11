import 'dart:convert';
import 'dart:io';

import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/feedback_section.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'daily_speaking_sample_feedback.dart';
import 'daily_speaking_service_stubs.dart';

/// The constrained set of follow-up "asks" the learner can make on the prep
/// scaffold. Each is a *typed* request (not free text), so the future edge
/// function can branch on it deterministically. See `DailySpeakingPrepBloc`.
enum PrepAskKind { moreVocab, usefulPhrases, howToStart, harderWords }

/// Input bundle for a single review request — voice OR text, plus optional
/// topic context. Keeping the variants in one class avoids a dispatch fork in
/// the BLoC and matches what the edge function will accept.
class SessionInput {
  SessionInput.voice({
    required this.audioPath,
    required this.onRamp,
    required this.requestedSections,
    this.topic,
  })  : text = null,
        inputMode = 'voice';

  SessionInput.text({
    required this.text,
    required this.onRamp,
    required this.requestedSections,
    this.topic,
  })  : audioPath = null,
        inputMode = 'text';

  final String? audioPath;
  final String? text;
  final DailySpeakingTopic? topic;
  final String onRamp;
  final String inputMode;

  /// Which optional feedback sections the learner asked for. The edge function
  /// builds its prompt from these so unrequested sections cost no tokens.
  /// See `FeedbackSectionKey`.
  final List<String> requestedSections;
}

/// Single entry point the BLoC calls. Owns the stub/real switch so swapping
/// to the live edge function is a one-line change.
class DailySpeakingService {
  /// Flip to `false` the moment the Supabase edge function
  /// `daily-speaking-review` is deployed with `GEMINI_API_KEY` set.
  static const bool useStubResponse = true;

  Future<DailySpeakingFeedback> reviewSession(SessionInput input) async {
    if (useStubResponse) {
      return _stubResponse(input);
    }
    return _realResponse(input);
  }

  /// Own-topic AI prep: expand a bare typed [topicText] into a scaffolded
  /// [DailySpeakingTopic] (vocab / target phrases / warmups filled in). This is
  /// text-only and ~8× cheaper than an audio review; it does NOT consume a
  /// practice from the learner's quota. The future edge function must branch on
  /// call *kind* (prep vs practice) and decrement the right counter.
  Future<DailySpeakingTopic> expandTopic({required String topicText}) async {
    if (useStubResponse) {
      await Future<void>.delayed(const Duration(seconds: 2)); // match feedback feel
      return DailySpeakingServiceStubs.expandedTopic(topicText);
    }
    // TODO(real): supabase.functions.invoke('daily-speaking-prep', body: {
    //   'call_kind': 'prep',     // edge fn branches: prep does NOT decrement the
    //                            // practices quota (5 premium / 1 free); only the
    //                            // audio review call does.
    //   'topic_text': topicText, // NO level/CEFR param for MVP (level-agnostic).
    // }); then DailySpeakingTopic.fromJson(...). Must return id:'own', bilingual
    // fields (prompt_en/prompt_mm), vocabulary, target_phrases, warmup_questions.
    throw UnimplementedError('daily-speaking-prep edge function not deployed');
  }

  /// Follow-up "ask" on an already-expanded prep [current] topic. Returns the
  /// topic with the requested delta appended (more vocab / phrases / warmups).
  /// Anti-abuse cap (max 3 asks/topic) is enforced client-side for now and
  /// server-side later.
  Future<DailySpeakingTopic> askMore({
    required PrepAskKind kind,
    required DailySpeakingTopic current,
  }) async {
    if (useStubResponse) {
      await Future<void>.delayed(const Duration(seconds: 1));
      switch (kind) {
        case PrepAskKind.moreVocab:
          return current.copyWith(vocabulary: [
            ...current.vocabulary,
            ...DailySpeakingServiceStubs.moreVocabDelta,
          ]);
        case PrepAskKind.harderWords:
          return current.copyWith(vocabulary: [
            ...current.vocabulary,
            ...DailySpeakingServiceStubs.harderWordsDelta,
          ]);
        case PrepAskKind.usefulPhrases:
          return current.copyWith(targetPhrases: [
            ...current.targetPhrases,
            ...DailySpeakingServiceStubs.usefulPhrasesDelta,
          ]);
        case PrepAskKind.howToStart:
          return current.copyWith(warmupQuestions: [
            ...current.warmupQuestions,
            ...DailySpeakingServiceStubs.howToStartDelta,
          ]);
      }
    }
    // TODO(real): supabase.functions.invoke('daily-speaking-prep', body: {
    //   'call_kind': 'prep', 'ask_kind': kind.name,
    //   'topic': current.toJson(), // server returns the merged/expanded topic.
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

  Future<DailySpeakingFeedback> _realResponse(SessionInput input) async {
    final body = await _serializeInput(input);
    final res = await supabase.functions.invoke(
      'daily-speaking-review',
      body: body,
    );
    final data = res.data;
    if (data is! Map) {
      throw const FormatException('daily-speaking-review: bad response');
    }
    return DailySpeakingFeedback.fromJson(
      Map<String, dynamic>.from(data),
    );
  }

  // TODO: finalize audio upload format with the edge function. Gemini accepts
  // audio natively — likely base64 in the JSON body. Confirm with the first
  // real test call.
  Future<Map<String, dynamic>> _serializeInput(SessionInput input) async {
    final body = <String, dynamic>{
      'on_ramp': input.onRamp,
      'input_mode': input.inputMode,
      'requested_sections': input.requestedSections,
      if (input.topic != null) 'topic': input.topic!.toJson(),
    };
    if (input.audioPath != null) {
      final bytes = await File(input.audioPath!).readAsBytes();
      body['audio_base64'] = base64Encode(bytes);
      body['audio_format'] = 'm4a';
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
