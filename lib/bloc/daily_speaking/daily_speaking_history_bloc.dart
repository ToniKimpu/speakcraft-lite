import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/repositories/daily_speaking/daily_speaking_session_repository.dart';

part 'daily_speaking_history_bloc.freezed.dart';

@freezed
class DailySpeakingHistoryEvent with _$DailySpeakingHistoryEvent {
  const factory DailySpeakingHistoryEvent.load() = _Load;
  const factory DailySpeakingHistoryEvent.delete(int id) = _Delete;
}

@freezed
class DailySpeakingHistoryState with _$DailySpeakingHistoryState {
  const factory DailySpeakingHistoryState.initial() = _Initial;
  const factory DailySpeakingHistoryState.loading() = _Loading;
  const factory DailySpeakingHistoryState.loaded({
    required Map<DateTime, List<DailySpeakingSession>> grouped,
    required int sessionsToday,
  }) = _Loaded;
  const factory DailySpeakingHistoryState.error(String message) = _Error;
}

class DailySpeakingHistoryBloc
    extends Bloc<DailySpeakingHistoryEvent, DailySpeakingHistoryState> {
  DailySpeakingHistoryBloc({DailySpeakingSessionRepository? repository})
      : _repo = repository ?? DailySpeakingSessionRepository(),
        super(const DailySpeakingHistoryState.initial()) {
    on<DailySpeakingHistoryEvent>((event, emit) async {
      await event.when(
        load: () => _load(emit),
        delete: (id) => _delete(id, emit),
      );
    });
  }

  final DailySpeakingSessionRepository _repo;

  Future<void> _load(Emitter<DailySpeakingHistoryState> emit) async {
    try {
      emit(const DailySpeakingHistoryState.loading());
      final sessions = await _repo.list();
      final grouped = <DateTime, List<DailySpeakingSession>>{};
      final today = _dayKey(DateTime.now());
      var sessionsToday = 0;
      for (final s in sessions) {
        final createdAt = s.createdAt;
        if (createdAt == null) continue;
        final day = _dayKey(createdAt);
        grouped.putIfAbsent(day, () => []).add(s);
        if (day == today) sessionsToday++;
      }
      emit(DailySpeakingHistoryState.loaded(
        grouped: grouped,
        sessionsToday: sessionsToday,
      ));
    } catch (e) {
      AppLogger.instance.error('DailySpeakingHistoryBloc load error: $e', error: e);
      emit(DailySpeakingHistoryState.error(e.toString()));
    }
  }

  Future<void> _delete(
    int id,
    Emitter<DailySpeakingHistoryState> emit,
  ) async {
    try {
      // Find the session in the loaded list so its audio file is cleaned up too.
      final target = state.maybeWhen(
        loaded: (grouped, _) {
          for (final list in grouped.values) {
            for (final s in list) {
              if (s.id == id) return s;
            }
          }
          return null;
        },
        orElse: () => null,
      );
      if (target != null) {
        await _repo.delete(target);
      }
      await _load(emit);
    } catch (e) {
      emit(DailySpeakingHistoryState.error(e.toString()));
    }
  }

  DateTime _dayKey(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
