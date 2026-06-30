/// Speak Your Mind — content access.
///
/// Online-first (Supabase `sym_topics`), with the bundled JSON as a fallback so
/// the app keeps working offline and before the table is seeded. The whole
/// module reads content only through here, so the backend is confined to this
/// file (mirrors how Vocabulary productionised).
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../services/supabase_service.dart';
import 'sym_models.dart';

const _dir = 'assets/speak_your_mind';

/// Bundled topic ids, in curriculum order. Also the fallback list + the seed's
/// canonical order. Keep in sync with `scripts/seed-sym.mjs` in the admin repo.
const symTopicIds = <String>[
  // Level 1 — Me & my everyday life (introduce yourself → everyday life)
  'about_me',
  'my_family',
  'my_friends',
  'where_i_live',
  'my_hometown',
  'my_daily_routine',
  'my_weekend',
  'my_work_and_studies',
  'food_i_eat',
  'my_free_time',

  // Level 2 — Tell stories & give your opinions
  'a_memorable_trip',
  'an_unforgettable_day',
  'my_first_day',
  'a_problem_i_solved',
  'a_festival_i_celebrated',
  'phones_and_social_media',
  'city_vs_countryside',
  'online_vs_classroom',
  'money_and_happiness',
  'keeping_traditions',

  // Level 3 — Discuss issues & current topics
  'climate_and_environment',
  'technology_and_ai',
  'education_today',
  'health_and_modern_life',
  'the_future_of_work',
  'news_and_misinformation',
  'rich_and_poor',
  'english_in_our_lives',
  'young_people_today',
  'life_in_the_future',
];

/// A lightweight topic entry for the home list — enough to render a card and
/// gate it, without loading the heavy toolbox/produce/guide blocks.
class SymTopicIndex {
  const SymTopicIndex({
    required this.id,
    required this.level,
    required this.domainEn,
    required this.titleEn,
    required this.moveCount,
    required this.phraseCount,
    required this.isFree,
  });

  final String id;
  final int level;
  final String domainEn;
  final String titleEn;
  final int moveCount;
  final int phraseCount;

  /// Freemium gate — Level 1 is free; Level 2/3 are premium.
  final bool isFree;

  factory SymTopicIndex.fromRow(Map<String, dynamic> r) => SymTopicIndex(
        id: r['id'] as String? ?? '',
        level: (r['level'] as num?)?.toInt() ?? 1,
        domainEn: r['domain_en'] as String? ?? '',
        titleEn: r['title_en'] as String? ?? '',
        moveCount: (r['move_count'] as num?)?.toInt() ?? 0,
        phraseCount: (r['phrase_count'] as num?)?.toInt() ?? 0,
        isFree: r['is_free'] as bool? ?? false,
      );

  factory SymTopicIndex.fromTopic(SymTopic t) => SymTopicIndex(
        id: t.id,
        level: t.level,
        domainEn: t.domainEn,
        titleEn: t.titleEn,
        moveCount: t.toolbox.length,
        phraseCount: t.chunkCount,
        isFree: t.level == 1,
      );
}

// Session cache — the index rarely changes mid-session.
List<SymTopicIndex>? _indexCache;

/// The home list: Supabase index, sorted by level then authored order. Falls
/// back to the bundled topics (offline / before seeding).
Future<List<SymTopicIndex>> loadSymIndex() async {
  if (_indexCache != null) return _indexCache!;
  try {
    final rows = await supabase
        .from('sym_topics')
        .select(
            'id,level,domain_en,title_en,order_in_level,move_count,phrase_count,is_free')
        .order('level', ascending: true)
        .order('order_in_level', ascending: true);
    final list = (rows as List)
        .map((r) => SymTopicIndex.fromRow((r as Map).cast<String, dynamic>()))
        .toList();
    if (list.isNotEmpty) return _indexCache = list;
  } catch (_) {
    // fall through to bundled
  }
  final topics = await _loadBundledTopics();
  return _indexCache =
      topics.map((t) => SymTopicIndex.fromTopic(t)).toList(growable: false);
}

/// One full topic: Supabase `data` jsonb, else the bundled JSON.
Future<SymTopic> loadSymTopic(String id) async {
  try {
    final row = await supabase
        .from('sym_topics')
        .select('data')
        .eq('id', id)
        .maybeSingle();
    final data = row?['data'];
    if (data is Map) {
      return SymTopic.fromJson(data.cast<String, dynamic>());
    }
  } catch (_) {
    // fall through to bundled
  }
  return _loadBundledTopic(id);
}

// ── Bundled fallback ─────────────────────────────────────────────────────────

Future<SymTopic> _loadBundledTopic(String id) async {
  final raw = await rootBundle.loadString('$_dir/$id.json');
  return SymTopic.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}

Future<List<SymTopic>> _loadBundledTopics() async {
  final out = <SymTopic>[];
  for (final id in symTopicIds) {
    out.add(await _loadBundledTopic(id));
  }
  return out;
}

/// Full topics (bundled) — used where the whole content is needed offline (e.g.
/// the history screen's id→title map). Prefer [loadSymIndex] for the home list.
Future<List<SymTopic>> loadSymTopics() => _loadBundledTopics();
