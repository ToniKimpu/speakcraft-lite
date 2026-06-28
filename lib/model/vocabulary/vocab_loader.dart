/// Vocabulary data access — the **only** place the module reads content.
///
/// PROTOTYPE: loads bundled sample JSON from `assets/vocabulary/`. Because the
/// whole module talks to vocabulary solely through [loadVocabIndex] and
/// [loadVocabGroup], swapping to Supabase later (a `vocab_groups` table) is a
/// change to just these two functions — no screen touches storage directly.
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'vocab_models.dart';

const _kIndexAsset = 'assets/vocabulary/index.json';

// Session cache — the manifest rarely changes mid-session.
List<VocabIndexEntry>? _indexCache;

/// Loads the group manifest, sorted by level then authored order.
Future<List<VocabIndexEntry>> loadVocabIndex() async {
  if (_indexCache != null) return _indexCache!;
  final raw = await rootBundle.loadString(_kIndexAsset);
  final map = jsonDecode(raw) as Map<String, dynamic>;
  final entries = ((map['groups'] as List?) ?? const [])
      .map((e) => VocabIndexEntry.fromJson((e as Map).cast<String, dynamic>()))
      .toList();
  entries.sort((a, b) =>
      a.level != b.level ? a.level.compareTo(b.level) : a.order.compareTo(b.order));
  return _indexCache = entries;
}

/// Loads one full group by id.
Future<VocabGroup> loadVocabGroup(String id) async {
  final raw = await rootBundle.loadString('assets/vocabulary/groups/$id.json');
  return VocabGroup.fromJson(jsonDecode(raw) as Map<String, dynamic>);
}
