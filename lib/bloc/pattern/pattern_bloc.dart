import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/config/env.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/services/supabase_service.dart';

import '../../model/pattern/pattern.dart';
import '../../model/pattern_example/pattern_example.dart';

part 'pattern_bloc.freezed.dart';

@freezed
abstract class PatternEvent with _$PatternEvent {
  const factory PatternEvent.loadPatternsByLesson(int lessonId) =
      _LoadLessonPatterns;
  const factory PatternEvent.loadPatterns({
    String? keyword,
    bool? examples,
    bool? vocabularies,
    bool? userComments,
  }) = _Loadpatterns;
  const factory PatternEvent.loadVocabulariesByPattern(int patternId) =
      _LoadVocabulariesByPattern;
  const factory PatternEvent.loadExamplesByPattern(int patternId) =
      _LoadExamplesByPattern;
}

@freezed
abstract class PatternState with _$PatternState {
  const factory PatternState.initial() = _Initial;
  const factory PatternState.loading() = _Loading;
  const factory PatternState.loaded(List<Pattern> patterns) = _Loaded;
  const factory PatternState.vocabularyLoaded(
      List<PatternVocabulary> vocabularies) = _VocabularyLoaded;
  const factory PatternState.examplesLoaded(List<PatternExample> examples) =
      _ExampleLoaded;
  const factory PatternState.error(String message) = _Error;
}

class PatternBloc extends Bloc<PatternEvent, PatternState> {
  PatternBloc() : super(const PatternState.initial()) {
    on<PatternEvent>(
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
          );
        } catch (e) {
          debugPrint('Load Patterns error ${e.toString()}');
          emit(PatternState.error(e.toString()));
        }
      },
    );
  }

  _mapLoadPatterns({
    String? keyword,
    bool? examples,
    bool? vocabularies,
    bool? userComments,
    required Emitter<PatternState> emit,
  }) async {
    emit(const PatternState.loading());
    try {
      var query = supabase
          .from('patterns')
          .select('*,pattern_user_comments(id)')
          .eq('pattern_user_comments.user_id', GlobalAppState().currentUser.id!)
          .eq('self_practicable', true)
          .eq('is_deleted', false);

      if (keyword != null) {
        query = query.or('pattern.ilike.%$keyword%,title.ilike.%$keyword%');
      }
      final dataRes = await query.order('created_at', ascending: true);
      if (dataRes.isEmpty) {
        emit(const PatternState.loaded(<Pattern>[]));
        return;
      }
      final patterns = Pattern.fromJsonList(dataRes);
      emit(PatternState.loaded(patterns));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(PatternState.error(e.toString()));
    }
  }

  _mapLoadPatternsByLessonToState(
      int lessonId, Emitter<PatternState> emit) async {
    emit(const PatternState.loading());
    try {
      final dataRes = await supabase
          .from('patterns')
          .select('*,pattern_examples(*)')
          .eq('lesson_id', lessonId)
          .order('created_at', ascending: true);
      if (dataRes.isEmpty) {
        emit(const PatternState.loaded(<Pattern>[]));
        return;
      }
      final patterns = dataRes.map((e) => Pattern.fromJson(e)).toList();
      final newPatterns = patterns.map((p) {
        if (p.audioPath == null || p.audioPath!.isEmpty) return p;
        return p.copyWith(
          audioPath: "${Env.bunnyAudioAPIKey}${p.audioPath}",
        );
      }).toList();
      emit(PatternState.loaded(newPatterns));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(PatternState.error(e.toString()));
    }
  }

  _mapLoadVocabulariesByPattern(
      int patternId, Emitter<PatternState> emit) async {
    emit(const PatternState.loading());
    try {
      final dataRes = await supabase
          .from('pattern_vocabularies')
          .select('*,pattern_vocabulary_relation!inner()')
          .eq('pattern_vocabulary_relation.pattern_id', patternId)
          .eq('is_deleted', false);

      if (dataRes.isEmpty) {
        emit(const PatternState.vocabularyLoaded(<PatternVocabulary>[]));
        return;
      }
      final vocabularies = PatternVocabulary.fromJsonList(dataRes);
      emit(PatternState.vocabularyLoaded(vocabularies));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(PatternState.error(e.toString()));
    }
  }

  _mapLoadExamplesByPattern(int patternId, Emitter<PatternState> emit) async {
    emit(const PatternState.loading());
    try {
      final dataRes = await supabase
          .from('pattern_examples')
          .select()
          .eq('pattern_id', patternId)
          .eq('is_deleted', false);

      if (dataRes.isEmpty) {
        emit(const PatternState.examplesLoaded(<PatternExample>[]));
        return;
      }
      final examples = PatternExample.fromJsonList(dataRes);
      emit(PatternState.examplesLoaded(examples));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(PatternState.error(e.toString()));
    }
  }
}
