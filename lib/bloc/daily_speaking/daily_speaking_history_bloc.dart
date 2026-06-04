import 'dart:convert';

import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/services/app_database/app_database.dart';

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
  DailySpeakingHistoryBloc()
      : super(const DailySpeakingHistoryState.initial()) {
    on<DailySpeakingHistoryEvent>((event, emit) async {
      await event.when(
        load: () => _load(emit),
        delete: (id) => _delete(id, emit),
      );
    });
  }

  Future<void> _load(Emitter<DailySpeakingHistoryState> emit) async {
    try {
      emit(const DailySpeakingHistoryState.loading());
      final rows =
          await (AppDatabase.instance().dailySpeakingSessionTable.select()
                ..orderBy([
                  (t) => OrderingTerm(
                        expression: t.createdAt,
                        mode: OrderingMode.desc,
                      ),
                ]))
              .get();
      final sessions = rows.map(_rowToSession).toList(growable: false);
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
      AppLogger.instance.error(
        'DailySpeakingHistoryBloc load error: $e',
        error: e,
      );
      emit(DailySpeakingHistoryState.error(e.toString()));
    }
  }

  Future<void> _delete(
    int id,
    Emitter<DailySpeakingHistoryState> emit,
  ) async {
    try {
      await AppDatabase.instance()
          .dailySpeakingSessionTable
          .deleteWhere((t) => t.id.equals(id));
      await _load(emit);
    } catch (e) {
      emit(DailySpeakingHistoryState.error(e.toString()));
    }
  }

  DateTime _dayKey(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  DailySpeakingSession _rowToSession(DailySpeakingSessionTableData row) {
    final feedback = DailySpeakingFeedback.fromJson(
      Map<String, dynamic>.from(jsonDecode(row.feedbackJson) as Map),
    );
    return DailySpeakingSession(
      id: row.id,
      topicId: row.topicId,
      onRamp: row.onRamp,
      inputMode: row.inputMode,
      inputText: row.inputText,
      feedback: feedback,
      createdAt: row.createdAt,
      topicAttemptId: row.topicAttemptId,
      revisionNumber: row.revisionNumber,
      audioPath: row.audioPath,
      topicJson: row.topicJson,
    );
  }
}
