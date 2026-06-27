/// Writing module — the **units index** (manifest) that backs the path screen.
///
/// A lightweight list of unit summaries so the path page can draw section/unit
/// cards. **Online-only**: loaded from the Supabase `writing_lessons` table
/// (RLS returns published units). There is no bundled fallback — the Grammar
/// module needs a connection.
library;

import '../../services/supabase_service.dart';

// Session cache — the manifest rarely changes mid-session.
List<WritingUnitSummary>? _indexCache;

/// Loads the units manifest, preserving authored order (curriculum sequence).
/// Online-only: queries Supabase `writing_lessons` (published units).
Future<List<WritingUnitSummary>> loadWritingUnitsIndex() async {
  if (_indexCache != null) return _indexCache!;
  final rows = await supabase
      .from('writing_lessons')
      .select('id,level,section_id,section,order_in_level,title,subtitle_mm')
      .order('level')
      .order('section_id')
      .order('order_in_level');
  final units = (rows as List).map((r) {
    final m = (r as Map).cast<String, dynamic>();
    return WritingUnitSummary.fromJson({
      'id': m['id'],
      'level': m['level'],
      'section_id': m['section_id'],
      'section': m['section'],
      'order': m['order_in_level'],
      'title': m['title'],
      'subtitle_mm': m['subtitle_mm'],
      'published': true,
    });
  }).toList(growable: false);
  return _indexCache = units;
}

/// Loads one full unit as the raw JSON map the teach/practice screens parse.
/// Online-only: fetches the `writing_lessons` row by id.
Future<Map<String, dynamic>> loadWritingUnitMap(String id) async {
  final row = await supabase
      .from('writing_lessons')
      .select('id,level,section,order_in_level,type,title,subtitle_mm,'
          'teach,toolkit,exercises,practice_recap_en,practice_recap_mm')
      .eq('id', id)
      .maybeSingle();
  if (row == null) throw Exception('Grammar unit "$id" not found');
  final m = row.cast<String, dynamic>();
  // Reassemble the unit-JSON shape (order_in_level -> order); JSONB columns
  // arrive already decoded as Map/List.
  return {
    'id': m['id'],
    'level': m['level'],
    'section': m['section'],
    'order': m['order_in_level'],
    'type': m['type'],
    'title': m['title'],
    'subtitle_mm': m['subtitle_mm'],
    'teach': m['teach'] ?? const <String, dynamic>{},
    'toolkit': m['toolkit'] ?? const <String, dynamic>{},
    'exercises': m['exercises'] ?? const [],
    'practice_recap_en': m['practice_recap_en'] ?? '',
    'practice_recap_mm': m['practice_recap_mm'] ?? '',
  };
}

/// One row of the path screen — a unit card's metadata.
class WritingUnitSummary {
  const WritingUnitSummary({
    required this.id,
    required this.level,
    required this.sectionId,
    required this.section,
    required this.order,
    required this.title,
    required this.subtitleMm,
    required this.asset,
    required this.published,
  });

  final String id;
  final int level;

  /// e.g. `1.2` — used only to order/label sections.
  final String sectionId;

  /// Section display name, e.g. `Present`.
  final String section;
  final int order;
  final String title;
  final String subtitleMm;

  /// The full unit asset path — present only for [published] units.
  final String asset;
  final bool published;

  /// A published unit is tappable (its content is fetched online by id).
  bool get isOpen => published;

  factory WritingUnitSummary.fromJson(Map<String, dynamic> json) =>
      WritingUnitSummary(
        id: json['id'] as String,
        level: (json['level'] as num?)?.toInt() ?? 1,
        sectionId: json['section_id'] as String? ?? '',
        section: json['section'] as String? ?? '',
        order: (json['order'] as num?)?.toInt() ?? 0,
        title: json['title'] as String? ?? '',
        subtitleMm: json['subtitle_mm'] as String? ?? '',
        asset: json['asset'] as String? ?? '',
        published: json['published'] as bool? ?? false,
      );
}
