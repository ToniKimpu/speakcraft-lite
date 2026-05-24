import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_step_progress.freezed.dart';
part 'video_step_progress.g.dart';

enum StepState {
  notStarted,
  inProgress,
  done,
}

enum VideoLessonStep {
  watch,
  explanation,
  shadowing,
  record,
}

@freezed
class VideoStepProgress with _$VideoStepProgress {
  const factory VideoStepProgress({
    required String youtubeId,
    required String stepKey,
    @Default(0) int state,
    DateTime? lastOpenedAt,
    @Default(0) int openCount,
  }) = _VideoStepProgress;

  factory VideoStepProgress.fromJson(Map<String, dynamic> json) =>
      _$VideoStepProgressFromJson(json);
}
