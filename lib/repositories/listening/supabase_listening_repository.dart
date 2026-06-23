import 'package:speakcraft/config/env.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'listening_repository.dart';

class SupabaseListeningRepository implements ListeningRepository {
  @override
  Future<List<Listening>> loadListenings() async {
    final dataRes = await supabase
        .from('listenings')
        .select('*')
        .eq('is_deleted', false)
        .eq("is_published", true)
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
        keyTakeawaysPath: _normalizePath(listening.keyTakeawaysPath),
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
    // Tolerate a full URL being stored (admin paste) — use it as-is. Otherwise
    // it's the relative `bunny/...` form: strip the prefix and prepend the base.
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    return Env.bunnyListeningAPIKey + path.replaceFirst('bunny/', '');
  }
}
