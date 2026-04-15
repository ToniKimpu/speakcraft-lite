import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/saved_vocabulary_word/saved_vocabulary_word.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/vocabulary_bottom_sheet.dart';
import 'package:pmp_english/services/app_database/app_database.dart';

class SavedWordsPage extends StatefulWidget {
  const SavedWordsPage({super.key});

  @override
  State<SavedWordsPage> createState() => _SavedWordsPageState();
}

class _SavedWordsPageState extends State<SavedWordsPage> {
  late final Stream<List<SavedVocabularyWord>> _stream;

  @override
  void initState() {
    super.initState();
    final db = AppDatabase.instance();
    _stream = (db.select(db.savedVocabularyWordTable)
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .watch();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Words'),
      ),
      body: StreamBuilder<List<SavedVocabularyWord>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(),
              ),
            );
          }
          final words = snapshot.data ?? const <SavedVocabularyWord>[];
          if (words.isEmpty) return _buildEmptyState(context, colorScheme);
          return _buildList(words, colorScheme);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmarks_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No saved words yet',
              style: PmpTextStyles.h1.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'ArchivoBlack Regular',
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Open any video, tap a highlighted word, and tap 'Save word' to keep it here.",
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.pushNamed(
                context,
                PmpRoutes.listeningListPage,
              ),
              icon: const Icon(Icons.video_library_outlined),
              label: const Text('Browse videos'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
    List<SavedVocabularyWord> words,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
          child: Text(
            'Total — ${words.length}',
            style: PmpTextStyles.body2Regular.copyWith(
              fontFamily: 'ArchivoBlack Regular',
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: words.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final saved = words[index];
              return _SavedWordTile(
                saved: saved,
                onTap: () => _openDetail(saved),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openDetail(SavedVocabularyWord saved) {
    final vocab = VocabularyWord(
      word: saved.word,
      pos: saved.pos,
      ipa: saved.ipa,
      definitionEn: saved.definitionEn,
      definitionMy: saved.definitionMy,
      examples: saved.examples,
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VocabularyBottomSheet(
        word: vocab,
        sourceYoutubeId: saved.sourceYoutubeId,
        sourceSentence: saved.sourceSentence,
      ),
    );
  }
}

class _SavedWordTile extends StatelessWidget {
  const _SavedWordTile({required this.saved, required this.onTap});

  final SavedVocabularyWord saved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                saved.word,
                style: PmpTextStyles.h1.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'ArchivoBlack Regular',
                  fontSize: 22,
                ),
              ),
              if (saved.ipa.isNotEmpty || saved.pos.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (saved.ipa.isNotEmpty)
                      Text(
                        saved.ipa,
                        style: PmpTextStyles.body2Regular.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    if (saved.ipa.isNotEmpty && saved.pos.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text('·', style: TextStyle(color: colorScheme.onSurfaceVariant)),
                      const SizedBox(width: 8),
                    ],
                    if (saved.pos.isNotEmpty)
                      Text(
                        saved.pos,
                        style: PmpTextStyles.body2Regular.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
              if (saved.definitionEn.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  saved.definitionEn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
