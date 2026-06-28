/// Vocabulary data access — the **only** place the module reads content.
///
/// Content lives in the Supabase `vocab_groups` table (one row per group: index
/// columns + a `data` JSONB + a `has_audio` flag). The whole module talks to
/// vocabulary solely through [loadVocabIndex] and [loadVocabGroup], so the
/// storage backend is confined to this file. (Authoring source for the table is
/// `assets/vocabulary/`, seeded via the admin `seed-vocab.mjs` — not bundled.)
library;

import '../../services/supabase_service.dart';
import 'vocab_models.dart';

// Session cache — the manifest rarely changes mid-session.
List<VocabIndexEntry>? _indexCache;

/// Loads the group manifest, sorted by level then authored order.
Future<List<VocabIndexEntry>> loadVocabIndex() async {
  if (_indexCache != null) return _indexCache!;
  final entries = await _indexFromSupabase();
  entries.sort((a, b) =>
      a.level != b.level ? a.level.compareTo(b.level) : a.order.compareTo(b.order));
  return _indexCache = entries;
}

/// Loads one full group by id.
Future<VocabGroup> loadVocabGroup(String id) => _groupFromSupabase(id);

// ── Supabase ────────────────────────────────────────────────────────────────

Future<List<VocabIndexEntry>> _indexFromSupabase() async {
  // RLS returns only published, non-deleted rows (like writing_lessons), so the
  // query needn't filter. NB: .order() defaults to DESCENDING in postgrest-dart
  // — pass ascending:true so the curriculum runs in authored order.
  final rows = await supabase
      .from('vocab_groups')
      .select('id,level,section,order_in_level,title,theme,unit,word_count')
      .order('level', ascending: true)
      .order('order_in_level', ascending: true);
  return (rows as List).map((r) {
    final m = (r as Map).cast<String, dynamic>();
    return VocabIndexEntry.fromJson({
      'id': m['id'],
      'level': m['level'],
      'order': m['order_in_level'],
      'section': m['section'],
      'title': m['title'],
      'theme': m['theme'],
      'unit': m['unit'],
      'word_count': m['word_count'],
    });
  }).toList();
}

Future<VocabGroup> _groupFromSupabase(String id) async {
  final row = await supabase
      .from('vocab_groups')
      .select('data,has_audio')
      .eq('id', id)
      .maybeSingle();
  if (row == null) throw Exception('Vocab group "$id" not found');
  final m = row.cast<String, dynamic>();
  // `data` JSONB is the full group; `has_audio` is a separate column → merge it
  // in so the model sees one map.
  final data = (m['data'] as Map).cast<String, dynamic>();
  data['has_audio'] = m['has_audio'] ?? false;
  return VocabGroup.fromJson(data);
}
