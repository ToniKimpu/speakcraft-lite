import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/services/supabase_service.dart';

import '../../config/env.dart';
import '../../model/pattern_example/pattern_example.dart';
import '../../model/spoken_pattern/spoken_pattern.dart';
import '../../services/app_database/app_database.dart';

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
  SpokenPatternBloc() : super(const SpokenPatternState.initial()) {
    on<SpokenPatternEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadPatterns: (keyword, examples, vocabularies, userComments) =>
                _mapLoadPatterns(
              keyword: keyword,
              examples: examples,
              vocabularies: vocabularies,
              userComments: userComments,
              emit: emit,
            ),
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
          debugPrint('Load Patterns error ${e.toString()}');
          emit(SpokenPatternState.error(e.toString()));
        }
      },
    );
  }

  _mapLoadPatterns({
    String? keyword,
    bool? examples,
    bool? vocabularies,
    bool? userComments,
    required Emitter<SpokenPatternState> emit,
  }) async {
    emit(const SpokenPatternState.loading());
    try {
      var query = supabase
          .from('patterns')
          .select('*,subject_verb_agreements(*)')
          .eq('self_practicable', true)
          .eq('is_deleted', false);

      if (keyword != null) {
        query = query.or('pattern.ilike.%$keyword%,title.ilike.%$keyword%');
      }
      final dataRes = await query.order('created_at', ascending: true);
      if (dataRes.isEmpty) {
        emit(const SpokenPatternState.loaded(<SpokenPattern>[]));
        return;
      }
      final spokenPatterns = SpokenPattern.fromJsonList(dataRes);
      emit(SpokenPatternState.loaded(spokenPatterns));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  _mapLoadPatternsByLessonToState(
      int lessonId, Emitter<SpokenPatternState> emit) async {
    emit(const SpokenPatternState.loading());
    try {
      final dataRes = await supabase
          .from('patterns')
          .select('*')
          .eq('lesson_id', lessonId)
          .eq('is_deleted', false)
          .order('order_number', ascending: true);
      if (dataRes.isEmpty) {
        emit(const SpokenPatternState.loaded(<SpokenPattern>[]));
        return;
      }
      final spokenPatterns = dataRes.map((e) {
        final p = SpokenPattern.fromJson(e);
        if (p.filePath == null || p.filePath!.isEmpty) return p;
        return p.copyWith(
          filePath: Env.bunnySpokenPatternAPIKey +
              p.filePath!.replaceFirst('bunny/', ''),
        );
      }).toList();
      emit(SpokenPatternState.loaded(spokenPatterns));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  _mapLoadPracticeExamplesToState(bool withLoading, int spokenPatternId,
      Emitter<SpokenPatternState> emit) async {
    if (withLoading) {
      emit(const SpokenPatternState.loading());
    }
    try {
      final dataRes = await supabase
          .from('pattern_examples')
          .select(
              '*,vocabularies:pattern_examples_vocabularies_relation(pattern_vocabularies(*))')
          .eq('pattern_id', spokenPatternId)
          .eq("is_deleted", false)
          .order('created_at', ascending: true);
      if (dataRes.isEmpty) {
        emit(const SpokenPatternState.loaded(<SpokenPattern>[]));
        return;
      }
      final examples = dataRes.map((e) => PatternExample.fromJson(e)).toList()
        ..sort(
          (a, b) => (a.createdAt ?? DateTime(0))
              .compareTo(b.createdAt ?? DateTime(0)),
        );

      final updatedExamples = await Future.wait(
        examples.map((example) async {
          final data =
              await (AppDatabase.instance().userExampleAnswerTable.select()
                    ..where((tbl) => tbl.exampleId.equals(example.id)))
                  .getSingleOrNull();

          return example.copyWith(userAnswer: data?.userAnswer);
        }),
      );

      emit(SpokenPatternState.examplesLoaded(updatedExamples));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  _mapLoadVocabulariesByPattern(
      int patternId, Emitter<SpokenPatternState> emit) async {
    emit(const SpokenPatternState.loading());
    try {
      final dataRes = await supabase
          .from('pattern_vocabularies')
          .select('*,pattern_vocabulary_relation!inner()')
          .eq('pattern_vocabulary_relation.pattern_id', patternId)
          .eq('is_deleted', false);
      if (dataRes.isEmpty) {
        emit(const SpokenPatternState.vocabularyLoaded(<PatternVocabulary>[]));
        return;
      }
      final vocabularies = PatternVocabulary.fromJsonList(dataRes);
      emit(SpokenPatternState.vocabularyLoaded(vocabularies));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(SpokenPatternState.error(e.toString()));
    }
  }

  _mapLoadExamplesByPattern(
      int patternId, Emitter<SpokenPatternState> emit) async {
    emit(const SpokenPatternState.loading());
    try {
      final dataRes = await supabase
          .from('pattern_examples')
          .select()
          .eq('pattern_id', patternId)
          .eq('is_deleted', false)
          .order(
            "created_at",
            ascending: true,
          );

      if (dataRes.isEmpty) {
        emit(const SpokenPatternState.examplesLoaded(<PatternExample>[]));
        return;
      }
      final examples = dataRes.map((e) => PatternExample.fromJson(e)).toList();
      emit(SpokenPatternState.examplesLoaded(examples));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(SpokenPatternState.error(e.toString()));
    }
  }
}
