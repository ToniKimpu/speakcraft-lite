import '../../model/pattern_example/pattern_example.dart';
import '../../model/pattern_vocabulary/pattern_vocabulary.dart';
import '../../model/spoken_pattern/spoken_pattern.dart';

abstract class SpokenPatternRepository {
  Future<List<SpokenPattern>> loadPatterns({String? keyword});
  Future<List<SpokenPattern>> loadPatternsByLesson(int lessonId);
  Future<List<PatternExample>> loadPracticeExamplesByPattern(int patternId);
  Future<List<PatternExample>> loadExamplesByPattern(int patternId);
  Future<List<PatternVocabulary>> loadVocabulariesByPattern(int patternId);
}
