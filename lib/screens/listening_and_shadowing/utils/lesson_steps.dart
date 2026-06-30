import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';

/// The ordered set of lesson steps that exist for a given [listening].
///
/// Single source of truth shared by the lesson hub, the listening list, and
/// the home "Continue" card so every surface agrees on the step count and on
/// which steps count toward completion. The "explanation" (Study the patterns)
/// step is always present; the others appear only when their content path is
/// provided.
List<VideoLessonStep> visibleLessonSteps(Listening listening) {
  // Imported videos generate Key Takeaways and "Speak on your own" lazily, so
  // those steps must be visible even before their content exists (a premium tap
  // triggers generation). For curated content they appear only when their path
  // is set.
  final isImport = listening.importId.isNotEmpty;
  return <VideoLessonStep>[
    if (listening.subtitlePath.trim().isNotEmpty) VideoLessonStep.watch,
    if (listening.keyTakeawaysPath.trim().isNotEmpty || isImport)
      VideoLessonStep.keyTakeaways,
    VideoLessonStep.explanation,
    if (listening.shadowingPath.trim().isNotEmpty) VideoLessonStep.shadowing,
    if (listening.recordSubtitlePath.trim().isNotEmpty || isImport)
      VideoLessonStep.record,
    // The "graduation" step — listen with no subtitles and mark what you miss.
    // Needs the subtitle data to map marks back to sentences.
    if (listening.subtitlePath.trim().isNotEmpty) VideoLessonStep.challenge,
  ];
}

/// Progress summary for one listening, derived from [VideoStepProgressState].
class LessonProgress {
  const LessonProgress({
    required this.doneCount,
    required this.totalCount,
    required this.hasStarted,
    required this.lastOpenedAt,
  });

  final int doneCount;
  final int totalCount;
  final bool hasStarted;
  final DateTime? lastOpenedAt;

  bool get isComplete => totalCount > 0 && doneCount >= totalCount;
  bool get isInProgress => hasStarted && !isComplete;
  double get fraction => totalCount == 0 ? 0 : doneCount / totalCount;
}

/// Computes the [LessonProgress] for [listening] from the global step-progress
/// state. `lastOpenedAt` is the most recent open time across the lesson's steps,
/// used to surface the most recently touched lesson for "Continue learning".
LessonProgress lessonProgressFor(
  VideoStepProgressState state,
  Listening listening,
) {
  final steps = visibleLessonSteps(listening);
  var done = 0;
  var started = false;
  for (final step in steps) {
    final s = state.stepStateFor(listening.youtubeId, step);
    if (s == VideoStepState.done) done++;
    if (s != VideoStepState.notStarted) started = true;
  }

  DateTime? latest;
  final rows = state.byVideo[listening.youtubeId];
  if (rows != null) {
    for (final r in rows.values) {
      final t = r.lastOpenedAt;
      if (t == null) continue;
      if (latest == null || t.isAfter(latest)) latest = t;
    }
  }

  return LessonProgress(
    doneCount: done,
    totalCount: steps.length,
    hasStarted: started,
    lastOpenedAt: latest,
  );
}
