import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/repositories/listening/listening_repository.dart';

import '../../model/pattern_vocabulary/pattern_vocabulary.dart';

import 'package:json_annotation/json_annotation.dart';

part 'listening_bloc.freezed.dart';

@freezed
abstract class ListeningEvent with _$ListeningEvent {
  const factory ListeningEvent.loadListenings() = _LoadListenings;
  const factory ListeningEvent.loadVocabulariesByListening(int listeningId) =
      _LoadVocabulariesByListening;
  const factory ListeningEvent.toggleBurmeseSub(bool value) = _ToggleBurmeseSub;
}

@freezed
abstract class ListeningState with _$ListeningState {
  const factory ListeningState.initial() = _Initial;
  const factory ListeningState.loading() = _Loading;
  const factory ListeningState.loaded(List<Listening> listenings) = _Loaded;
  const factory ListeningState.vocabularyLoaded(
      List<PatternVocabulary> vocabularies) = _VocabularyLoaded;
  const factory ListeningState.onToggleBurmeseSubtitle(bool value) =
      _OnToggleBurmeseSubtitle;
  const factory ListeningState.error(String message) = _Error;
}

class ListeningBloc extends Bloc<ListeningEvent, ListeningState> {
  final ListeningRepository _repository;

  ListeningBloc({ListeningRepository? repository})
      : _repository = repository ?? sl<ListeningRepository>(),
        super(const ListeningState.initial()) {
    on<ListeningEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadListenings: () => _mapLoadListeningsToState(emit),
            toggleBurmeseSub: (value) async =>
                emit(ListeningState.onToggleBurmeseSubtitle(value)),
            loadVocabulariesByListening: (listeningId) =>
                _mapLoadVocabulariesByListening(listeningId, emit),
          );
        } catch (e) {
          AppLogger.instance.error('ListeningBloc error: ${e.toString()}', error: e);
          emit(ListeningState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadListeningsToState(Emitter<ListeningState> emit) async {
    emit(const ListeningState.loading());
    try {
      final listenings = await _repository.loadListenings();
      emit(ListeningState.loaded(listenings));
    } catch (e) {
      AppLogger.instance.error(e.toString(), error: e);
      emit(ListeningState.error(e.toString()));
    }
  }

  Future<void> _mapLoadVocabulariesByListening(
      int listeningId, Emitter<ListeningState> emit) async {
    emit(const ListeningState.loading());
    try {
      final vocabularies =
          await _repository.loadVocabulariesByListening(listeningId);
      emit(ListeningState.vocabularyLoaded(vocabularies));
    } catch (e) {
      AppLogger.instance.error('_loadVocabulariesError: ${e.toString()}', error: e);
      emit(ListeningState.error(e.toString()));
    }
  }
}
