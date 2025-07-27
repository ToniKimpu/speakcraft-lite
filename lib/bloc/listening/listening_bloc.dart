import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/listening/listening.dart';

import '../../model/pattern_vocabulary/pattern_vocabulary.dart';
import '../../services/supabase_service.dart';

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
  const factory ListeningState.onToggelBurmeseSub(bool value) =
      _OnToggelBurmeseSub;
  const factory ListeningState.error(String message) = _Error;
}

class ListeningBloc extends Bloc<ListeningEvent, ListeningState> {
  ListeningBloc() : super(const ListeningState.initial()) {
    on<ListeningEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadListenings: () => _mapLoadListeningsToState(emit),
            toggleBurmeseSub: (value) async =>
                emit(ListeningState.onToggelBurmeseSub(value)),
            loadVocabulariesByListening: (listeningId) =>
                _mapLoadVocabulariesByListening(listeningId, emit),
          );
        } catch (e) {
          debugPrint('Load Days error ${e.toString()}');
          emit(ListeningState.error(e.toString()));
        }
      },
    );
  }
  _mapLoadListeningsToState(Emitter<ListeningState> emit) async {
    emit(const ListeningState.loading());
    try {
      final dataRes = await supabase
          .from('listenings')
          .select('*')
          .eq("is_deleted", false)
          .order('created_at', ascending: true);
      final listenings = dataRes.map((e) {
        final listening = Listening.fromJson(e);
        return listening.copyWith(
          thumbnail: SupabaseService().getPublicUrl(
            bucketFolder: SupabaseBucketFolders.listeningAndShadowingImages,
            fileName: listening.thumbnail,
          ),
          subtitlePath: SupabaseService().getPublicUrl(
            bucketFolder: SupabaseBucketFolders.listeningAndShadowingSubtitles,
            fileName: listening.subtitlePath,
          ),
        );
      }).toList();

      emit(ListeningState.loaded(listenings));
    } catch (e) {
      debugPrint(e.toString());
      emit(ListeningState.error(e.toString()));
    }
  }

  _mapLoadVocabulariesByListening(
      int listeningId, Emitter<ListeningState> emit) async {
    emit(const ListeningState.loading());
    try {
      final dataRes = await supabase
          .from('pattern_vocabularies')
          .select('*,listening_vocabularies_relation!inner()')
          .eq('listening_vocabularies_relation.listening_id', listeningId)
          .eq('is_deleted', false);

      if (dataRes.isEmpty) {
        emit(const ListeningState.vocabularyLoaded(<PatternVocabulary>[]));
        return;
      }
      final vocabularies = PatternVocabulary.fromJsonList(dataRes);
      emit(ListeningState.vocabularyLoaded(vocabularies));
    } catch (e) {
      debugPrint('_loadPatternError: ${e.toString()}');
      emit(ListeningState.error(e.toString()));
    }
  }
}
