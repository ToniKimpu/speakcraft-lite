import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';

class VocabularyBottomSheet extends StatelessWidget {
  const VocabularyBottomSheet({
    super.key,
    required this.word,
  });

  final VocabularyWord word;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                  // Word
                  Text(
                    word.word,
                    style: PmpTextStyles.h1.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'ArchivoBlack Regular',
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // IPA + POS row
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
                  // Definitions
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
                          child:
                              Divider(color: colorScheme.outlineVariant, height: 1),
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
                          child:
                              Divider(color: colorScheme.outlineVariant, height: 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(word.examples.length, (i) {
                      final ex = word.examples[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ],
                        ),
                      );
                    }),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _onSavePressed(context),
                      icon: const Icon(Icons.bookmark_add_outlined),
                      label: const Text('Save word'),
                    ),
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

  void _onSavePressed(BuildContext context) {
    AppLogger.instance.debug('_saveVocabWord: ${word.word}');
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text("'${word.word}' saved (coming soon)"),
        duration: const Duration(seconds: 2),
      ));
  }
}
