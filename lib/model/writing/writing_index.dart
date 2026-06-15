/// Writing module — the **units index** (manifest) that backs the path screen.
///
/// A lightweight list of unit summaries so the path page can draw section/unit
/// cards without parsing every full unit file. Keys mirror the future Supabase
/// `writing_lessons` row (minus the heavy `teach`/`exercises` JSONB), so the
/// path query is a copy at Phase 2.
///
/// Phase-0: bundled at `assets/writing/units/index.json`. Only `published`
/// units carry an `asset` and are tappable; the rest render as "coming soon".
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

const _kIndexAsset = 'assets/writing/units/index.json';

/// Loads the units manifest, preserving authored order (curriculum sequence).
Future<List<WritingUnitSummary>> loadWritingUnitsIndex() async {
  final raw = await rootBundle.loadString(_kIndexAsset);
  final list = jsonDecode(raw) as List;
  return list
      .map((e) =>
          WritingUnitSummary.fromJson((e as Map).cast<String, dynamic>()))
      .toList(growable: false);
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

  /// A published unit with a loadable asset is the only tappable card.
  bool get isOpen => published && asset.isNotEmpty;

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
