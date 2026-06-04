// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'daily_speaking_feedback.dart';

part 'daily_speaking_session.freezed.dart';
part 'daily_speaking_session.g.dart';

/// Which on-ramp the user took to start this session. Stored as a plain string
/// in Drift so adding a new on-ramp later doesn't require a schema migration.
class DailySpeakingOnRamp {
  static const String justTalk = 'just_talk';
  static const String ownTopic = 'own_topic';
  static const String suggested = 'suggested';
}

class DailySpeakingInputMode {
  static const String voice = 'voice';
  static const String text = 'text';
}

@freezed
class DailySpeakingSession with _$DailySpeakingSession {
  const factory DailySpeakingSession({
    required int id,
    String? topicId,
    required String onRamp,
    required String inputMode,
    String? inputText,
    required DailySpeakingFeedback feedback,
    DateTime? createdAt,
    /// Groups every version (v1, v2, …) of one topic attempt together. Minted
    /// on the first attempt; carried forward by "Polish & retry". Null for
    /// legacy rows and one-off (just-talk) sessions. See the version loop in
    /// `daily_speaking_feature.md`.
    String? topicAttemptId,

    /// 1 for the first attempt, 2 for the first retry, etc. Rendered as "v{n}".
    @Default(1) int revisionNumber,
  }) = _DailySpeakingSession;

  factory DailySpeakingSession.fromJson(Map<String, dynamic> json) =>
      _$DailySpeakingSessionFromJson(json);
}
