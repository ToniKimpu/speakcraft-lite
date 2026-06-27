import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_loader.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';

/// Vocabulary home — groups laid out under their level (Beginner / Intermediate
/// / Upper), mirroring the Grammar path's leveled shape.
class VocabularyListPage extends StatefulWidget {
  const VocabularyListPage({super.key});

  @override
  State<VocabularyListPage> createState() => _VocabularyListPageState();
}

class _VocabularyListPageState extends State<VocabularyListPage> {
  late Future<List<VocabIndexEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = loadVocabIndex();
  }

  void _reload() => setState(() => _future = loadVocabIndex());

  static String _levelLabel(int level) => switch (level) {
        1 => 'Beginner',
        2 => 'Intermediate',
        _ => 'Upper',
      };

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: const Text('Vocabulary'),
      body: FutureBuilder<List<VocabIndexEntry>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return ErrorRetryView(error: snap.error, onRetry: _reload);
          }
          final groups = snap.data ?? const [];
          if (groups.isEmpty) {
            return const ErrorRetryView(
              isOffline: false,
              title: 'No word sets yet',
              message: 'Check back soon.',
            );
          }

          // Group entries by level, preserving order.
          final levels = <int, List<VocabIndexEntry>>{};
          for (final g in groups) {
            levels.putIfAbsent(g.level, () => []).add(g);
          }
          final sortedLevels = levels.keys.toList()..sort();

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              for (final level in sortedLevels) ...[
                _LevelHeader(label: _levelLabel(level)),
                const SizedBox(height: 10),
                for (final entry in levels[level]!) ...[
                  _GroupCard(entry: entry),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 8),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _LevelHeader extends StatelessWidget {
  const _LevelHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(width: 4, height: 18, color: cs.primary),
        const SizedBox(width: 8),
        Text(label,
            style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
      ],
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.entry});
  final VocabIndexEntry entry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      borderRadius: 16,
      blur: false,
      padding: const EdgeInsets.all(14),
      onTap: () => Navigator.pushNamed(
        context,
        PmpRoutes.vocabularyGroup,
        arguments: {'id': entry.id, 'title': entry.title},
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: PmpColors.brandCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.style_outlined, color: cs.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title,
                    style: PmpTextStyles.body1Semi
                        .copyWith(color: cs.onSurface)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(entry.theme,
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                    Text('  ·  ${entry.wordCount} words',
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
        ],
      ),
    );
  }
}
