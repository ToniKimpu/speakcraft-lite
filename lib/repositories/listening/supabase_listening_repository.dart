import 'package:pmp_english/config/env.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/services/supabase_service.dart';

import 'listening_repository.dart';

class SupabaseListeningRepository implements ListeningRepository {
  @override
  Future<List<Listening>> loadListenings() async {
    final dataRes = await supabase
        .from('listenings')
        .select('*')
        .eq('is_deleted', false)
        .order('order_number', ascending: true);

    return dataRes.map((e) {
      final listening = Listening.fromJson(e);
      return listening.copyWith(
        thumbnail: SupabaseService().getPublicUrl(
          bucketFolder: SupabaseBucketFolders.listeningAndShadowingImages,
          fileName: listening.thumbnail,
        ),
        subtitlePath: _normalizePath(listening.subtitlePath),
        multipleChoicePath: _normalizePath(listening.multipleChoicePath),
        shadowingPath: _normalizePath(listening.shadowingPath),
        recordSubtitlePath: _normalizePath(listening.recordSubtitlePath),
        sentenceExplanationPath:
            _normalizePath(listening.sentenceExplanationPath),
        vocabularyPath: _normalizePath(listening.vocabularyPath),
      );
    }).toList();
  }

  @override
  Future<List<PatternVocabulary>> loadVocabulariesByListening(
      int listeningId) async {
    final dataRes = await supabase
        .from('pattern_vocabularies')
        .select('*,listening_vocabularies_relation!inner()')
        .eq('listening_vocabularies_relation.listening_id', listeningId)
        .eq('is_deleted', false);

    if (dataRes.isEmpty) return [];
    return PatternVocabulary.fromJsonList(dataRes);
  }

  String _normalizePath(String path) {
    if (path.isEmpty) return '';
    return Env.bunnyListeningAPIKey + path.replaceFirst('bunny/', '');
  }
}
