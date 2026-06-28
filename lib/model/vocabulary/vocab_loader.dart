/// Vocabulary data access — the **only** place the module reads content.
///
/// Productionizing: content lives in the Supabase `vocab_groups` table (one row
/// per group: index columns + a `data` JSONB + a `has_audio` flag). The whole
/// module talks to vocabulary solely through [loadVocabIndex] and
/// [loadVocabGroup], so the storage swap is confined to this file.
///
/// [_online] gates the source: it stays `false` (bundled assets) until the
/// Supabase table is populated, then flips to `true` (online-only, like Grammar).
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../services/supabase_service.dart';
import 'vocab_models.dart';

/// Flip to `true` once `vocab_groups` is populated → online-only.
const bool _online = false;

const _kIndexAsset = 'assets/vocabulary/index.json';

// Session cache — the manifest rarely changes mid-session.
List<VocabIndexEntry>? _indexCache;

/// Loads the group manifest, sorted by level then authored order.
Future<List<VocabIndexEntry>> loadVocabIndex() async {
  if (_indexCache != null) return _indexCache!;
  final entries =
      _online ? await _indexFromSupabase() : await _indexFromAssets();
  entries.sort((a, b) =>
      a.level != b.level ? a.level.compareTo(b.level) : a.order.compareTo(b.order));
  return _indexCache = entries;
}

/// Loads one full group by id.
Future<VocabGroup> loadVocabGroup(String id) =>
    _online ? _groupFromSupabase(id) : _groupFromAssets(id);

// ── Supabase (production) ───────────────────────────────────────────────────

Future<List<VocabIndexEntry>> _indexFromSupabase() async {
  final rows = await supabase
      .from('vocab_groups')
      .select('id,level,section,order_in_level,title,theme,unit,word_count')
      .eq('published', true)
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

// ── Bundled assets (until _online) ──────────────────────────────────────────

Future<List<VocabIndexEntry>> _indexFromAssets() async {
  final raw = await rootBundle.loadString(_kIndexAsset);
  final map = jsonDecode(raw) as Map<String, dynamic>;
  return ((map['groups'] as List?) ?? const [])
      .map((e) => VocabIndexEntry.fromJson((e as Map).cast<String, dynamic>()))
      .toList();
}

Future<VocabGroup> _groupFromAssets(String id) async {
  final raw = await rootBundle.loadString('assets/vocabulary/groups/$id.json');
  return VocabGroup.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}
