import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/services/supabase_service.dart';

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
          .select('*,pattern_user_comments(id)')
          .eq('pattern_user_comments.user_id', GlobalAppState().currentUser.id!)
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
          .select(
              '*,pattern_examples(*,vocabularies:pattern_examples_vocabularies_relation(pattern_vocabularies(*)))')
          .eq('lesson_id', lessonId)
          .eq("is_deleted", false)
          .eq("pattern_examples.is_deleted", false)
          .order('created_at', ascending: true);
      if (dataRes.isEmpty) {
        emit(const SpokenPatternState.loaded(<SpokenPattern>[]));
        return;
      }
      debugPrint("_mapLoadPatternByLessonToState: ${dataRes.first.toString()}");
      final spokenPatterns =
          dataRes.map((e) => SpokenPattern.fromJson(e)).toList();
      final newSpokenPatterns = spokenPatterns.map((p) {
        if (p.audioPath == null || p.audioPath!.isEmpty) return p;
        // return p.copyWith(
        //   audioPath: AudioUrlService.resolveAudioUrl(p.audioPath!),
        // );
        return p.copyWith(
          audioPath: SupabaseService().getPublicUrl(
            bucketFolder: SupabaseBucketFolders.spokenPatternAudios,
            fileName: p.audioPath!,
          ),
        );
      }).toList();
      emit(SpokenPatternState.loaded(newSpokenPatterns));
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
      // final examples = PatternExample.fromJsonList(dataRes);
      final examples = dataRes.map((e) => PatternExample.fromJson(e)).toList();
      emit(SpokenPatternState.examplesLoaded(examples));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(SpokenPatternState.error(e.toString()));
    }
  }
}
