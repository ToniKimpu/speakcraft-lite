// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'daily_speaking_feedback.dart';
import 'daily_speaking_topic.dart';

part 'daily_speaking_session.freezed.dart';
part 'daily_speaking_session.g.dart';

/// Which on-ramp the user took to start this session. Stored as a plain string
/// in Drift so adding a new on-ramp later doesn't require a schema migration.
class DailySpeakingOnRamp {
  static const String justTalk = 'just_talk';
  static const String ownTopic = 'own_topic';
  static const String suggested = 'suggested';
  static const String guided = 'guided';
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

    /// Local path to the saved recording (voice sessions only). Audio is kept
    /// only for the active attempt chain and pruned when a new chain starts, so
    /// this is null for older / pruned sessions and for the text path. Powers
    /// the result-page player and the A/B "hear your progress" comparison across
    /// the version loop. See `daily_speaking_feature.md`.
    String? audioPath,
    /// Groups every version (v1, v2, …) of one topic attempt together. Minted
    /// on the first attempt; carried forward by "Polish & retry". Null for
    /// legacy rows and one-off (just-talk) sessions. See the version loop in
    /// `daily_speaking_feature.md`.
    String? topicAttemptId,

    /// 1 for the first attempt, 2 for the first retry, etc. Rendered as "v{n}".
    @Default(1) int revisionNumber,

    /// Serialized [DailySpeakingTopic] for loop-capable on-ramps, so the topic
    /// can be resumed from history. Null for just-talk and legacy rows. See
    /// [decodedTopic].
    String? topicJson,
  }) = _DailySpeakingSession;

  factory DailySpeakingSession.fromJson(Map<String, dynamic> json) =>
      _$DailySpeakingSessionFromJson(json);
}

extension DailySpeakingSessionX on DailySpeakingSession {
  /// The stored topic rebuilt from [topicJson], or null if none was saved
  /// (just-talk, or a pre-v8 row). Used to offer "Polish & retry" on a session
  /// reopened from history, and to label history with the real topic.
  DailySpeakingTopic? get decodedTopic {
    final raw = topicJson;
    if (raw == null || raw.isEmpty) return null;
    try {
      return DailySpeakingTopic.fromJson(
        Map<String, dynamic>.from(jsonDecode(raw) as Map),
      );
    } catch (_) {
      return null;
    }
  }
}
