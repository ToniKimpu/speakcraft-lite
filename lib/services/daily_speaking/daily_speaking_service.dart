import 'dart:convert';
import 'dart:io';

import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/feedback_section.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'daily_speaking_service_stubs.dart';

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

  Future<DailySpeakingFeedback> _stubResponse(SessionInput input) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final canned = DailySpeakingServiceStubs.cannedResponses;
    // Pick a canned response based on input hash so different attempts surface
    // different UI states (high / mid / low score) during dev.
    final seed = (input.text ?? input.audioPath ?? '').hashCode;
    var response = canned[seed.abs() % canned.length];
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
      collocations:
          has(FeedbackSectionKey.collocations) ? f.collocations : const [],
      idioms: has(FeedbackSectionKey.idioms) ? f.idioms : const [],
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
