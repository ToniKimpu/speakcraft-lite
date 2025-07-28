import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/services/app_database/app_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/ai_sentence_practice/ai_sentence_practice.dart';
import '../../services/supabase_service.dart';

part 'ai_sentence_practice_bloc.freezed.dart';

@freezed
sealed class AiSentencePracticeEvent with _$AiSentencePracticeEvent {
  const factory AiSentencePracticeEvent.load() = _Load;
  const factory AiSentencePracticeEvent.delete(AiSentencePractice data) =
      _Delete;
  const factory AiSentencePracticeEvent.loadGroupData(bool correctData) =
      _LoadGroupData;
  const factory AiSentencePracticeEvent.reviewSentence(String input) =
      _ReviewSentence;
}

@freezed
sealed class AiSentencePracticeState with _$AiSentencePracticeState {
  const factory AiSentencePracticeState.initial() = _Initial;
  const factory AiSentencePracticeState.loading({String? message}) = _Loading;
  const factory AiSentencePracticeState.loaded(List<AiSentencePractice> data) =
      _Loaded;
  const factory AiSentencePracticeState.loadedGroupData(
    Map<DateTime, List<AiSentencePractice>> aiResponses,
  ) = _LoadedGroupData;
  const factory AiSentencePracticeState.success(AiSentencePractice data) =
      _Success;
  const factory AiSentencePracticeState.socketError() = _SocketErro;
  const factory AiSentencePracticeState.error(String message) = _Error;
}

class AiSentencePracticeBloc
    extends Bloc<AiSentencePracticeEvent, AiSentencePracticeState> {
  AiSentencePracticeBloc() : super(const AiSentencePracticeState.initial()) {
    on<AiSentencePracticeEvent>((event, emit) async {
      await event.when(
        load: () async {},
        delete: (data) => _mapDeleteToState(data, emit),
        loadGroupData: (correctData) async =>
            _loadGroupDataToState(correctData, emit),
        reviewSentence: (input) async => _reviewSentenceToState(input, emit),
      );
    });
  }
  Future<void> _loadGroupDataToState(
      bool correctData, Emitter<AiSentencePracticeState> emit) async {
    try {
      emit(const AiSentencePracticeState.loading());
      debugPrint("_loadGroupDataToState: starting....");
      final data =
          await ((AppDatabase.instance().aiSentencePracticeTable.select()
                ..where(
                  (tbl) => correctData
                      ? tbl.correctedSentence.isNull()
                      : tbl.correctedSentence.isNotNull(),
                ))
                ..orderBy([
                  (tbl) => OrderingTerm(
                      expression: tbl.createdAt, mode: OrderingMode.desc)
                ]))
              .get();
      debugPrint("_loadGroupDataToState: has fetched....");
      final Map<DateTime, List<AiSentencePractice>> aiResponseGroupByDate = {};

      for (final item in data) {
        if (item.createdAt == null) continue;

        final dateOnly = DateTime(
          item.createdAt!.year,
          item.createdAt!.month,
          item.createdAt!.day,
        );
        aiResponseGroupByDate.putIfAbsent(dateOnly, () => []).add(item);
      }
      emit(
        AiSentencePracticeState.loadedGroupData(
          aiResponseGroupByDate,
        ),
      );
    } catch (e) {
      emit(AiSentencePracticeState.error(e.toString()));
    }
  }

  Future<void> _reviewSentenceToState(
      String input, Emitter<AiSentencePracticeState> emit) async {
    try {
      if (input.isEmpty) {
        emit(const AiSentencePracticeState.error("Please enter a sentence"));
        return;
      }
      emit(const AiSentencePracticeState.loading());
      final resData = await supabase.functions.invoke(
        "sentence-review",
        body: {
          "sentence": input,
        },
      );

      final data = resData.data;
      if (data is! Map) {
        emit(const AiSentencePracticeState.error(
            "Invalid response from server"));
        return;
      }
      final aiSentencePractice =
          await AppDatabase.instance().aiSentencePracticeTable.insertReturning(
                AiSentencePracticeTableCompanion(
                  inputSentence: Value(input),
                  correctedSentence: Value(data['corrected']),
                  explanation: Value(data['explanation_mm']),
                  totalTokensUsed: Value(data['total_tokens'] ?? 0),
                ),
              );
      emit(AiSentencePracticeState.success(aiSentencePractice));
    } catch (e) {
      if (e is SocketException) {
        emit(const AiSentencePracticeState.socketError());
      } else if (e is FunctionException) {
        emit(const AiSentencePracticeState.error('Sorry, the server is busy.'));
      } else {
        emit(const AiSentencePracticeState.error('There are something wrong.'));
      }
      debugPrint("_reviewSentenceToState: error: ${e.toString()}");
    }
  }

  Future<void> _mapDeleteToState(
    AiSentencePractice data,
    Emitter<AiSentencePracticeState> emit,
  ) async {
    emit(const AiSentencePracticeState.loading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      await AppDatabase.instance().aiSentencePracticeTable.deleteWhere(
            (tbl) => tbl.id.equals(data.id),
          );
      emit(AiSentencePracticeState.success(data));
    } catch (e) {
      emit(AiSentencePracticeState.error(e.toString()));
    }
  }
}
