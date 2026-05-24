import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:speakcraft/services/app_database/app_database.dart';

import '../../../../config/pmp_colors.dart';
import 'sej_example_row.dart';

class SejTermCard extends StatefulWidget {
  const SejTermCard({
    super.key,
    required this.term,
    this.sourceTitle,
    this.sourceSentence,
  });

  final Map<String, dynamic> term;
  final String? sourceTitle;
  final String? sourceSentence;

  @override
  State<SejTermCard> createState() => _SejTermCardState();
}

class _SejTermCardState extends State<SejTermCard> {
  final _db = AppDatabase.instance();
  int? _savedRowId;
  bool _busy = false;

  String get _termText => widget.term['term'] as String? ?? '';
  String get _kind => widget.term['kind'] as String? ?? '';

  @override
  void initState() {
    super.initState();
    _loadSavedState();
  }

  Future<void> _loadSavedState() async {
    if (_termText.isEmpty) return;
    final row = await (_db.select(_db.savedTermTable)
          ..where((t) => t.term.equals(_termText))
          ..where((t) => t.kind.equals(_kind))
          ..limit(1))
        .getSingleOrNull();
    if (!mounted) return;
    setState(() => _savedRowId = row?.id);
  }

  Future<void> _toggleSaved() async {
    if (_busy || _termText.isEmpty) return;
    setState(() => _busy = true);
    try {
      if (_savedRowId != null) {
        await (_db.delete(_db.savedTermTable)
              ..where((t) => t.id.equals(_savedRowId!)))
            .go();
        if (!mounted) return;
        setState(() => _savedRowId = null);
        _showSnackBar('Removed');
      } else {
        final examples = (widget.term['examples'] as List<dynamic>?) ?? const [];
        final translationMy = widget.term['translation_my'] as String? ?? '';
        final definitionMy = widget.term['definition_my'] as String? ?? '';
        final id = await _db.into(_db.savedTermTable).insert(
              SavedTermTableCompanion(
                term: Value(_termText),
                kind: Value(_kind),
                translationMy: translationMy.isEmpty
                    ? const Value.absent()
                    : Value(translationMy),
                definitionMy: definitionMy.isEmpty
                    ? const Value.absent()
                    : Value(definitionMy),
                examplesJson: Value(jsonEncode(examples)),
                sourceTitle: widget.sourceTitle == null
                    ? const Value.absent()
                    : Value(widget.sourceTitle),
                sourceSentence: widget.sourceSentence == null
                    ? const Value.absent()
                    : Value(widget.sourceSentence),
              ),
            );
        if (!mounted) return;
        setState(() => _savedRowId = id);
        _showSnackBar('Saved');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
      ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final number = widget.term['number'] as int? ?? 0;
    final translationMy = widget.term['translation_my'] as String? ?? '';
    final definitionMy = widget.term['definition_my'] as String? ?? '';
    final examples = (widget.term['examples'] as List<dynamic>?) ?? [];
    final items = (widget.term['items'] as List<dynamic>?) ?? [];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(colorScheme, number, _termText, _kind),
          _buildBody(colorScheme, translationMy, definitionMy, items, examples),
        ],
      ),
    );
  }

  Widget _buildHeader(
    ColorScheme cs,
    int number,
    String termText,
    String kind,
  ) {
    final isSaved = _savedRowId != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 6, 6, 6),
      decoration: BoxDecoration(
        color: PmpColors.info400.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PmpColors.info400.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: PmpColors.info400,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              termText,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
          ),
          if (kind.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: PmpColors.success400.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                kind,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: PmpColors.success400,
                ),
              ),
            ),
          IconButton(
            tooltip: isSaved ? 'Remove' : 'Save',
            visualDensity: VisualDensity.compact,
            onPressed: _busy ? null : _toggleSaved,
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              size: 22,
              color: isSaved ? PmpColors.warning600 : cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    ColorScheme cs,
    String translationMy,
    String definitionMy,
    List<dynamic> items,
    List<dynamic> examples,
  ) {
    return Container(
      color: cs.surface,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (translationMy.isNotEmpty || definitionMy.isNotEmpty)
            Text.rich(
              TextSpan(children: [
                if (translationMy.isNotEmpty)
                  TextSpan(
                    text: definitionMy.isNotEmpty
                        ? '$translationMy '
                        : translationMy,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PmpColors.warning600,
                    ),
                  ),
                if (definitionMy.isNotEmpty)
                  TextSpan(
                    text: definitionMy,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
              ]),
            ),
          if (items.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SejExampleRow(
                  english:
                      (item as Map<String, dynamic>)['english'] as String? ??
                          '',
                  burmese: item['burmese'] as String? ?? '',
                ),
              ),
          ],
          if (examples.isNotEmpty) ...[
            const SizedBox(height: 10),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 8),
            for (int i = 0; i < examples.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SejExampleRow(
                  english: (examples[i] as Map<String, dynamic>)['english']
                          as String? ??
                      '',
                  burmese: (examples[i] as Map<String, dynamic>)['burmese']
                          as String? ??
                      '',
                  index: i,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
