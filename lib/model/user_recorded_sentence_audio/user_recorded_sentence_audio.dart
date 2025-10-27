import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_recorded_sentence_audio.freezed.dart';
part 'user_recorded_sentence_audio.g.dart';

@freezed
class UserRecordedSentenceAudio with _$UserRecordedSentenceAudio {
  const factory UserRecordedSentenceAudio({
    int? id,
    required String sentenceId,
    required String youtubeId,
    required String audioPath,
    required String audioName,
    @JsonKey(name: "created_at") DateTime? createdAt,
  }) = _UserRecordedSentenceAudio;

  factory UserRecordedSentenceAudio.fromJson(Map<String, dynamic> json) =>
      _$UserRecordedSentenceAudioFromJson(json);
}
