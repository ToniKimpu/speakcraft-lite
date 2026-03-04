import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/repositories/spoken_pattern/spoken_pattern_repository.dart';

import '../../model/pattern_example/pattern_example.dart';
import '../../model/spoken_pattern/spoken_pattern.dart';

part 'spoken_pattern_bloc.freezed.dart';

@freezed
abstract class SpokenPatternEvent with _$SpokenPatternEvent {
  const factory SpokenPatternEvent.loadPatternsByLesson(int lessonId) =
      _LoadLessonPatterns;
  const factory SpokenPatternEvent.loadPatterns({
    String? keyword,
    bool? examples,
    bool? vocabularies,
    bool? userComments,
  }) = _Loadpatterns;
  const factory SpokenPatternEvent.loadVocabulariesByPattern(int patternId) =
      _LoadVocabulariesByPattern;
  const factory SpokenPatternEvent.loadExamplesByPattern(int patternId) =
      _LoadExamplesByPattern;
  const factory SpokenPatternEvent.loadPracticeExamplesByPattern(
      {required bool withLoading,
      required int patternId}) = _LoadPracticeExamplesByPattern;
}

@freezed
abstract class SpokenPatternState with _$SpokenPatternState {
  const factory SpokenPatternState.initial() = _Initial;
  const factory SpokenPatternState.loading() = _Loading;
  const factory SpokenPatternState.loaded(List<SpokenPattern> patterns) =
      _Loaded;
  const factory SpokenPatternState.vocabularyLoaded(
      List<PatternVocabulary> vocabularies) = _VocabularyLoaded;
  const factory SpokenPatternState.examplesLoaded(
      List<PatternExample> examples) = _ExampleLoaded;
  const factory SpokenPatternState.error(String message) = _Error;
}

class SpokenPatternBloc extends Bloc<SpokenPatternEvent, SpokenPatternState> {
  final SpokenPatternRepository _repository;

  SpokenPatternBloc({SpokenPatternRepository? repository})
      : _repository = repository ?? sl<SpokenPatternRepository>(),
        super(const SpokenPatternState.initial()) {
    on<SpokenPatternEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadPatterns: (keyword, examples, vocabularies, userComments) =>
                _mapLoadPatterns(keyword: keyword, emit: emit),
            loadPatternsByLesson: (lessonId) =>
                _mapLoadPatternsByLessonToState(lessonId, emit),
            loadVocabulariesByPattern: (patternId) =>
                _mapLoadVocabulariesByPattern(patternId, emit),
            loadExamplesByPattern: (patternId) =>
                _mapLoadExamplesByPattern(patternId, emit),
            loadPracticeExamplesByPattern: (withLoading, patternId) =>
                _mapLoadPracticeExamplesToState(withLoading, patternId, emit),
          );
        } catch (e) {
          AppLogger.instance.error('SpokenPatternBloc error: ${e.toString()}', error: e);
          emit(SpokenPatternState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadPatterns({
    String? keyword,
    required Emitter<SpokenPatternState> emit,
  }) async {
    emit(const SpokenPatternState.loading());
    try {
      final patterns = await _repository.loadPatterns(keyword: keyword);
      emit(SpokenPatternState.loaded(patterns));
    } catch (e) {
      AppLogger.instance.error('_loadPatternError: ${e.toString()}', error: e);
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  Future<void> _mapLoadPatternsByLessonToState(
      int lessonId, Emitter<SpokenPatternState> emit) async {
    emit(const SpokenPatternState.loading());
    try {
      final patterns = await _repository.loadPatternsByLesson(lessonId);
      emit(SpokenPatternState.loaded(patterns));
    } catch (e) {
      AppLogger.instance.error('_loadPatternError: ${e.toString()}', error: e);
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  Future<void> _mapLoadPracticeExamplesToState(bool withLoading,
      int spokenPatternId, Emitter<SpokenPatternState> emit) async {
    if (withLoading) emit(const SpokenPatternState.loading());
    try {
      final examples =
          await _repository.loadPracticeExamplesByPattern(spokenPatternId);
      emit(SpokenPatternState.examplesLoaded(examples));
    } catch (e) {
      AppLogger.instance.error('_loadPracticeExamplesError: ${e.toString()}', error: e);
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  Future<void> _mapLoadVocabulariesByPattern(
      int patternId, Emitter<SpokenPatternState> emit) async {
    emit(const SpokenPatternState.loading());
    try {
      final vocabularies =
          await _repository.loadVocabulariesByPattern(patternId);
      emit(SpokenPatternState.vocabularyLoaded(vocabularies));
    } catch (e) {
      AppLogger.instance.error('_loadVocabulariesError: ${e.toString()}', error: e);
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  Future<void> _mapLoadExamplesByPattern(
      int patternId, Emitter<SpokenPatternState> emit) async {
    emit(const SpokenPatternState.loading());
    try {
      final examples = await _repository.loadExamplesByPattern(patternId);
      emit(SpokenPatternState.examplesLoaded(examples));
    } catch (e) {
      AppLogger.instance.error('_loadExamplesError: ${e.toString()}', error: e);
      emit(SpokenPatternState.error(e.toString()));
    }
  }
}
