import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';
import 'package:speakcraft/repositories/listening/video_step_progress_repository.dart';

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

  VideoStepState stepStateFor(String youtubeId, VideoLessonStep step) {
    final row = byVideo[youtubeId]?[step.name];
    if (row == null) return VideoStepState.notStarted;
    final idx = row.state;
    if (idx < 0 || idx >= VideoStepState.values.length) return VideoStepState.notStarted;
    return VideoStepState.values[idx];
  }

  Map<VideoLessonStep, VideoStepState> progressFor(String youtubeId) {
    return {
      for (final s in VideoLessonStep.values) s: stepStateFor(youtubeId, s),
    };
  }
}

class VideoStepProgressBloc
    extends Bloc<VideoStepProgressEvent, VideoStepProgressState> {
  VideoStepProgressBloc({VideoStepProgressRepository? repository})
      : _repo = repository ?? VideoStepProgressRepository(),
        super(const VideoStepProgressState()) {
    on<VideoStepProgressEvent>((event, emit) async {
      await event.when(
        loadAll: () => _loadAll(emit),
        loadVideo: (youtubeId) => _loadVideo(youtubeId, emit),
        markInProgress: (youtubeId, step) =>
            _upsert(youtubeId, step, VideoStepState.inProgress, emit),
        markDone: (youtubeId, step) =>
            _upsert(youtubeId, step, VideoStepState.done, emit),
      );
    });
  }

  final VideoStepProgressRepository _repo;

  Future<void> _loadAll(Emitter<VideoStepProgressState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final rows = await _repo.loadAll();
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
      final rows = await _repo.loadVideo(youtubeId);
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
    VideoStepState target,
    Emitter<VideoStepProgressState> emit,
  ) async {
    try {
      final current = state.byVideo[youtubeId]?[step.name];
      final currentState = current == null
          ? VideoStepState.notStarted
          : (current.state >= 0 && current.state < VideoStepState.values.length
              ? VideoStepState.values[current.state]
              : VideoStepState.notStarted);

      // Don't downgrade: once done, stay done.
      if (currentState == VideoStepState.done && target == VideoStepState.inProgress) {
        return;
      }

      final next = VideoStepProgress(
        youtubeId: youtubeId,
        stepKey: step.name,
        state: target.index,
        lastOpenedAt: DateTime.now(),
        openCount: (current?.openCount ?? 0) +
            (target == VideoStepState.inProgress ? 1 : 0),
      );

      await _repo.upsert(
        youtubeId: next.youtubeId,
        stepKey: next.stepKey,
        state: next.state,
        openCount: next.openCount,
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
