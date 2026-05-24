import 'package:drift/drift.dart' show OrderingTerm;
import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/saved_term/saved_term.dart';
import 'package:speakcraft/screens/saved_words/widgets/saved_term_detail_sheet.dart';
import 'package:speakcraft/services/app_database/app_database.dart';

class SavedTermsPage extends StatefulWidget {
  const SavedTermsPage({super.key});

  @override
  State<SavedTermsPage> createState() => _SavedTermsPageState();
}

class _SavedTermsPageState extends State<SavedTermsPage> {
  final _db = AppDatabase.instance();
  late final Stream<List<SavedTerm>> _stream;

  @override
  void initState() {
    super.initState();
    _stream = (_db.select(_db.savedTermTable)
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .watch();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: StreamBuilder<List<SavedTerm>>(
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
          final terms = snapshot.data ?? const <SavedTerm>[];
          if (terms.isEmpty) return _buildEmptyState(context, colorScheme);
          return _buildList(terms, colorScheme);
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
              'No bookmarks yet',
              style: PmpTextStyles.h1.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'ArchivoBlack Regular',
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Open any sentence explanation and tap the bookmark icon to keep it here.",
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

  Widget _buildList(List<SavedTerm> terms, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
          child: Text(
            'Total â€” ${terms.length}',
            style: PmpTextStyles.body2Regular.copyWith(
              fontFamily: 'ArchivoBlack Regular',
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: terms.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final saved = terms[index];
              return _SavedTermTile(
                saved: saved,
                onTap: () => _openDetail(saved),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openDetail(SavedTerm saved) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SavedTermDetailSheet(
        saved: saved,
        onRemove: () async {
          await (_db.delete(_db.savedTermTable)
                ..where((t) => t.id.equals(saved.id!)))
              .go();
        },
      ),
    );
  }
}

class _SavedTermTile extends StatelessWidget {
  const _SavedTermTile({required this.saved, required this.onTap});

  final SavedTerm saved;
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      saved.term,
                      style: PmpTextStyles.h1.copyWith(
                        color: colorScheme.onSurface,
                        fontFamily: 'ArchivoBlack Regular',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  if (saved.kind.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(left: 8, top: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: PmpColors.success400.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        saved.kind,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: PmpColors.success400,
                        ),
                      ),
                    ),
                ],
              ),
              if ((saved.translationMy ?? '').isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  saved.translationMy!,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: PmpColors.warning600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if ((saved.definitionMy ?? '').isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  saved.definitionMy!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
