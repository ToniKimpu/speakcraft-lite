import '../../model/listening/listening.dart';
import '../../model/pattern_vocabulary/pattern_vocabulary.dart';

abstract class ListeningRepository {
  Future<List<Listening>> loadListenings();
  Future<List<PatternVocabulary>> loadVocabulariesByListening(int listeningId);
}
