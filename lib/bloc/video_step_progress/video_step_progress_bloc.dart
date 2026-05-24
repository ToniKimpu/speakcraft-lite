import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/video_step_progress/video_step_progress.dart';
import 'package:pmp_english/services/app_database/app_database.dart';

part 'video_step_progress_bloc.freezed.dart';

@freezed
class VideoStepProgressEvent with _$VideoStepProgressEvent {
  const factory VideoStepProgressEvent.loadAll() = _LoadAll;
  const factory VideoStepProgressEvent.loadVideo(String youtubeId) = _LoadVideo;
  const factory VideoStepProgressEvent.markInProgress(
    String youtubeId,
    VideoLessonStep step,
  ) = _MarkInProgress;
  const factory VideoStepProgressEvent.markDone(
    String youtubeId,
    VideoLessonStep step,
  ) = _MarkDone;
}

@freezed
class VideoStepProgressState with _$VideoStepProgressState {
  const VideoStepProgressState._();

  const factory VideoStepProgressState({
    @Default(<String, Map<String, VideoStepProgress>>{})
    Map<String, Map<String, VideoStepProgress>> byVideo,
    @Default(false) bool isLoading,
    String? error,
  }) = _VideoStepProgressState;

  StepState stepStateFor(String youtubeId, VideoLessonStep step) {
    final row = byVideo[youtubeId]?[step.name];
    if (row == null) return StepState.notStarted;
    final idx = row.state;
    if (idx < 0 || idx >= StepState.values.length) return StepState.notStarted;
    return StepState.values[idx];
  }

  Map<VideoLessonStep, StepState> progressFor(String youtubeId) {
    return {
      for (final s in VideoLessonStep.values) s: stepStateFor(youtubeId, s),
    };
  }
}

class VideoStepProgressBloc
    extends Bloc<VideoStepProgressEvent, VideoStepProgressState> {
  VideoStepProgressBloc() : super(const VideoStepProgressState()) {
    on<VideoStepProgressEvent>((event, emit) async {
      await event.when(
        loadAll: () => _loadAll(emit),
        loadVideo: (youtubeId) => _loadVideo(youtubeId, emit),
        markInProgress: (youtubeId, step) =>
            _upsert(youtubeId, step, StepState.inProgress, emit),
        markDone: (youtubeId, step) =>
            _upsert(youtubeId, step, StepState.done, emit),
      );
    });
  }

  Future<void> _loadAll(Emitter<VideoStepProgressState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final db = AppDatabase.instance();
      final rows = await db.select(db.videoStepProgressTable).get();
      final grouped = <String, Map<String, VideoStepProgress>>{};
      for (final r in rows) {
        grouped.putIfAbsent(r.youtubeId, () => {})[r.stepKey] = r;
      }
      emit(state.copyWith(byVideo: grouped, isLoading: false));
    } catch (e) {
      AppLogger.instance.error('VideoStepProgressBloc.loadAll: $e', error: e);
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _loadVideo(
    String youtubeId,
    Emitter<VideoStepProgressState> emit,
  ) async {
    try {
      final db = AppDatabase.instance();
      final rows = await (db.select(db.videoStepProgressTable)
            ..where((t) => t.youtubeId.equals(youtubeId)))
          .get();
      final forVideo = <String, VideoStepProgress>{
        for (final r in rows) r.stepKey: r,
      };
      final next = Map<String, Map<String, VideoStepProgress>>.from(
          state.byVideo)
        ..[youtubeId] = forVideo;
      emit(state.copyWith(byVideo: next, error: null));
    } catch (e) {
      AppLogger.instance.error('VideoStepProgressBloc.loadVideo: $e', error: e);
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _upsert(
    String youtubeId,
    VideoLessonStep step,
    StepState target,
    Emitter<VideoStepProgressState> emit,
  ) async {
    try {
      final db = AppDatabase.instance();
      final current = state.byVideo[youtubeId]?[step.name];
      final currentState = current == null
          ? StepState.notStarted
          : (current.state >= 0 && current.state < StepState.values.length
              ? StepState.values[current.state]
              : StepState.notStarted);

      // Don't downgrade: once done, stay done.
      if (currentState == StepState.done && target == StepState.inProgress) {
        return;
      }

      final next = VideoStepProgress(
        youtubeId: youtubeId,
        stepKey: step.name,
        state: target.index,
        lastOpenedAt: DateTime.now(),
        openCount: (current?.openCount ?? 0) +
            (target == StepState.inProgress ? 1 : 0),
      );

      await db.into(db.videoStepProgressTable).insertOnConflictUpdate(
            VideoStepProgressTableCompanion(
              youtubeId: Value(next.youtubeId),
              stepKey: Value(next.stepKey),
              state: Value(next.state),
              lastOpenedAt: Value(next.lastOpenedAt),
              openCount: Value(next.openCount),
            ),
          );

      final nextByVideo = Map<String, Map<String, VideoStepProgress>>.from(
          state.byVideo);
      final nextForVideo = Map<String, VideoStepProgress>.from(
          nextByVideo[youtubeId] ?? <String, VideoStepProgress>{});
      nextForVideo[step.name] = next;
      nextByVideo[youtubeId] = nextForVideo;

      emit(state.copyWith(byVideo: nextByVideo, error: null));
    } catch (e) {
      AppLogger.instance.error('VideoStepProgressBloc.upsert: $e', error: e);
      emit(state.copyWith(error: e.toString()));
    }
  }
}
