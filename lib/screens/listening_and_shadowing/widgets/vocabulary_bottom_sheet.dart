import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';
import 'package:pmp_english/services/app_database/app_database.dart';

class VocabularyBottomSheet extends StatefulWidget {
  const VocabularyBottomSheet({
    super.key,
    required this.word,
    this.sourceYoutubeId,
    this.sourceSentence,
  });

  final VocabularyWord word;
  final String? sourceYoutubeId;
  final String? sourceSentence;

  @override
  State<VocabularyBottomSheet> createState() => _VocabularyBottomSheetState();
}

class _VocabularyBottomSheetState extends State<VocabularyBottomSheet> {
  /// `null` = checking, `true` = already saved, `false` = not saved yet.
  bool? _isSaved;
  bool _busy = false;

  String get _normalized => widget.word.word.trim().toLowerCase();

  @override
  void initState() {
    super.initState();
    _checkSaved();
  }

  Future<void> _checkSaved() async {
    if (_normalized.isEmpty) {
      if (mounted) setState(() => _isSaved = false);
      return;
    }
    try {
      final db = AppDatabase.instance();
      final existing = await (db.select(db.savedVocabularyWordTable)
            ..where((t) => t.word.equals(_normalized)))
          .getSingleOrNull();
      if (!mounted) return;
      setState(() => _isSaved = existing != null);
    } catch (e, st) {
      AppLogger.instance
          .error('_checkSaved: $e', error: e, stackTrace: st);
      if (!mounted) return;
      setState(() => _isSaved = false);
    }
  }

  SavedVocabularyWordTableCompanion _buildCompanion() {
    final examplesJson = jsonEncode(
      widget.word.examples.map((e) => e.toJson()).toList(),
    );
    return SavedVocabularyWordTableCompanion.insert(
      word: _normalized,
      pos: drift.Value(widget.word.pos),
      ipa: drift.Value(widget.word.ipa),
      definitionEn: drift.Value(widget.word.definitionEn),
      definitionMy: drift.Value(widget.word.definitionMy),
      examplesJson: drift.Value(examplesJson),
      sourceYoutubeId: drift.Value(widget.sourceYoutubeId),
      sourceSentence: drift.Value(widget.sourceSentence),
    );
  }

  Future<void> _onSavePressed() async {
    if (_busy || _isSaved == true || _normalized.isEmpty) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);

    try {
      final db = AppDatabase.instance();
      await db.into(db.savedVocabularyWordTable).insert(_buildCompanion());
      if (!mounted) return;
      setState(() {
        _isSaved = true;
        _busy = false;
      });
      Navigator.of(context).pop();
      messenger
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text("'${widget.word.word}' saved"),
          duration: const Duration(seconds: 2),
        ));
    } catch (e, st) {
      AppLogger.instance
          .error('_saveVocabWord: $e', error: e, stackTrace: st);
      if (!mounted) return;
      setState(() => _busy = false);
      messenger
        ..clearSnackBars()
        ..showSnackBar(const SnackBar(
          content: Text("Couldn't save. Try again."),
          duration: Duration(seconds: 2),
        ));
    }
  }

  Future<void> _onUnsavePressed() async {
    if (_busy || _isSaved != true || _normalized.isEmpty) return;
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);

    try {
      final db = AppDatabase.instance();
      await (db.delete(db.savedVocabularyWordTable)
            ..where((t) => t.word.equals(_normalized)))
          .go();
      if (!mounted) return;
      setState(() {
        _isSaved = false;
        _busy = false;
      });
      Navigator.of(context).pop();
      messenger
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text("'${widget.word.word}' removed"),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: _undoUnsave,
          ),
        ));
    } catch (e, st) {
      AppLogger.instance
          .error('_unsaveVocabWord: $e', error: e, stackTrace: st);
      if (!mounted) return;
      setState(() => _busy = false);
      messenger
        ..clearSnackBars()
        ..showSnackBar(const SnackBar(
          content: Text("Couldn't remove. Try again."),
          duration: Duration(seconds: 2),
        ));
    }
  }

  Future<void> _undoUnsave() async {
    // Re-insert the same row. Fire-and-forget from snackbar action; any error
    // is logged but we don't surface a second snackbar on top of the first.
    try {
      final db = AppDatabase.instance();
      await db.into(db.savedVocabularyWordTable).insert(_buildCompanion());
      if (!mounted) return;
      setState(() => _isSaved = true);
    } catch (e, st) {
      AppLogger.instance
          .error('_undoUnsave: $e', error: e, stackTrace: st);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final word = widget.word;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                height: 4,
                width: 32,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word.word,
                    style: PmpTextStyles.h1.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'ArchivoBlack Regular',
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (word.ipa.isNotEmpty)
                        Text(
                          word.ipa,
                          style: PmpTextStyles.body2Regular.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      if (word.ipa.isNotEmpty && word.pos.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          '·',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (word.pos.isNotEmpty)
                        Text(
                          word.pos,
                          style: PmpTextStyles.body2Regular.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: colorScheme.outlineVariant, height: 1),
                  const SizedBox(height: 16),
                  if (word.definitionEn.isNotEmpty) ...[
                    Text(
                      word.definitionEn,
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: colorScheme.onSurface,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (word.definitionMy.isNotEmpty)
                    Text(
                      word.definitionMy,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.85),
                        height: 1.6,
                        fontFamily: 'MM Lyrics Bold',
                      ),
                    ),
                  if (word.examples.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                              color: colorScheme.outlineVariant, height: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Examples',
                            style: PmpTextStyles.labelSemi.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                              color: colorScheme.outlineVariant, height: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(word.examples.length, (i) {
                      final ex = word.examples[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              margin: const EdgeInsets.only(top: 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.surfaceContainerHighest,
                              ),
                              child: Text(
                                '${i + 1}',
                                style: PmpTextStyles.label2Regular.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (ex.english.isNotEmpty)
                                    Text(
                                      ex.english,
                                      style: PmpTextStyles.body2Regular
                                          .copyWith(
                                        color: colorScheme.onSurface,
                                        height: 1.5,
                                      ),
                                    ),
                                  if (ex.burmese.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      ex.burmese,
                                      style: PmpTextStyles.body2Regular
                                          .copyWith(
                                        color: colorScheme.onSurface
                                            .withValues(alpha: 0.75),
                                        height: 1.6,
                                        fontFamily: 'MM Lyrics Bold',
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _buildSaveButton(colorScheme),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton(ColorScheme colorScheme) {
    // Unknown (initial DB check): show disabled placeholder so layout doesn't
    // jump when the check resolves a frame later.
    if (_isSaved == null) {
      return FilledButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        label: const Text('Save word'),
      );
    }

    // Saved — show an outlined "Remove" button. Less visual weight than the
    // primary Save button, so the eye doesn't naturally reach for it, and
    // the snackbar Undo action catches accidental taps.
    if (_isSaved == true) {
      return OutlinedButton.icon(
        onPressed: _busy ? null : _onUnsavePressed,
        icon: _busy
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.bookmark_remove_outlined),
        label: Text(_busy ? 'Removing…' : 'Saved · tap to remove'),
      );
    }

    return FilledButton.icon(
      onPressed: _busy ? null : _onSavePressed,
      icon: _busy
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.bookmark_add_outlined),
      label: Text(_busy ? 'Saving…' : 'Save word'),
    );
  }
}
