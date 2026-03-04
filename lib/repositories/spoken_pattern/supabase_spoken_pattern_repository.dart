import 'package:drift/drift.dart';
import 'package:pmp_english/config/env.dart';
import 'package:pmp_english/model/pattern_example/pattern_example.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/model/spoken_pattern/spoken_pattern.dart';
import 'package:pmp_english/services/app_database/app_database.dart';
import 'package:pmp_english/services/supabase_service.dart';

import 'spoken_pattern_repository.dart';

class SupabaseSpokenPatternRepository implements SpokenPatternRepository {
  @override
  Future<List<SpokenPattern>> loadPatterns({String? keyword}) async {
    var query = supabase
        .from('patterns')
        .select('*,subject_verb_agreements(*)')
        .eq('self_practicable', true)
        .eq('is_deleted', false);

    if (keyword != null) {
      query = query.or('pattern.ilike.%$keyword%,title.ilike.%$keyword%');
    }

    final dataRes = await query.order('created_at', ascending: true);
    if (dataRes.isEmpty) return [];
    return SpokenPattern.fromJsonList(dataRes);
  }

  @override
  Future<List<SpokenPattern>> loadPatternsByLesson(int lessonId) async {
    final dataRes = await supabase
        .from('patterns')
        .select('*')
        .eq('lesson_id', lessonId)
        .eq('is_deleted', false)
        .order('order_number', ascending: true);

    if (dataRes.isEmpty) return [];

    return dataRes.map((e) {
      final p = SpokenPattern.fromJson(e);
      if (p.filePath == null || p.filePath!.isEmpty) return p;
      return p.copyWith(
        filePath:
            Env.bunnySpokenPatternAPIKey + p.filePath!.replaceFirst('bunny/', ''),
      );
    }).toList();
  }

  @override
  Future<List<PatternExample>> loadPracticeExamplesByPattern(
      int patternId) async {
    final dataRes = await supabase
        .from('pattern_examples')
        .select(
            '*,vocabularies:pattern_examples_vocabularies_relation(pattern_vocabularies(*))')
        .eq('pattern_id', patternId)
        .eq('is_deleted', false)
        .order('created_at', ascending: true);

    if (dataRes.isEmpty) return [];

    final examples = dataRes.map((e) => PatternExample.fromJson(e)).toList()
      ..sort((a, b) =>
          (a.createdAt ?? DateTime(0)).compareTo(b.createdAt ?? DateTime(0)));

    // Batch load local user answers (fixes N+1 from step 3.4)
    final ids = examples.map((e) => e.id).toList();
    final answers =
        await (AppDatabase.instance().userExampleAnswerTable.select()
              ..where((tbl) => tbl.exampleId.isIn(ids)))
            .get();

    final answerMap = {for (final a in answers) a.exampleId: a.userAnswer};
    return examples.map((e) => e.copyWith(userAnswer: answerMap[e.id])).toList();
  }

  @override
  Future<List<PatternExample>> loadExamplesByPattern(int patternId) async {
    final dataRes = await supabase
        .from('pattern_examples')
        .select()
        .eq('pattern_id', patternId)
        .eq('is_deleted', false)
        .order('created_at', ascending: true);

    if (dataRes.isEmpty) return [];
    return dataRes.map((e) => PatternExample.fromJson(e)).toList();
  }

  @override
  Future<List<PatternVocabulary>> loadVocabulariesByPattern(
      int patternId) async {
    final dataRes = await supabase
        .from('pattern_vocabularies')
        .select('*,pattern_vocabulary_relation!inner()')
        .eq('pattern_vocabulary_relation.pattern_id', patternId)
        .eq('is_deleted', false);

    if (dataRes.isEmpty) return [];
    return PatternVocabulary.fromJsonList(dataRes);
  }
}
