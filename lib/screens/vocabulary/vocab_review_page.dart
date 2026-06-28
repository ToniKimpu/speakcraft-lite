import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_loader.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../repositories/vocabulary/vocab_review_repository.dart';
import '../../shared_widgets/glass.dart';
import 'vocab_practice_page.dart';

/// Spaced-review session: pulls the words that are due, matches each to one of
/// its group's exercises, and runs them through the practice flow.
class VocabReviewPage extends StatefulWidget {
  const VocabReviewPage({super.key});

  @override
  State<VocabReviewPage> createState() => _VocabReviewPageState();
}

class _VocabReviewPageState extends State<VocabReviewPage> {
  final _repo = VocabReviewRepository();
  late final Future<List<VocabQuestion>> _future = _load();

  Future<List<VocabQuestion>> _load() async {
    final due = await _repo.dueItems(limit: 20);
    if (due.isEmpty) return const [];
    final groups = <String, VocabGroup>{};
    for (final gid in {for (final d in due) d.groupId}) {
      try {
        groups[gid] = await loadVocabGroup(gid);
      } catch (_) {/* skip a group that won't load */}
    }
    final items = <VocabQuestion>[];
    for (final d in due) {
      final g = groups[d.groupId];
      if (g == null) continue;
      for (final e in g.exercises) {
        final runnable =
            (e.type == 'which_word' && e.options.isNotEmpty) ||
                e.type == 'gap_fill';
        if (runnable && e.answer.trim().toLowerCase() == d.word) {
          items.add((exercise: e, groupId: d.groupId));
          break;
        }
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VocabQuestion>>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const GlassScaffold(
            title: Text('Review'),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final items = snap.data ?? const <VocabQuestion>[];
        if (items.isEmpty) {
          return const GlassScaffold(
            title: Text('Review'),
            body: _AllCaughtUp(),
          );
        }
        return VocabPracticePage.review(items);
      },
    );
  }
}

class _AllCaughtUp extends StatelessWidget {
  const _AllCaughtUp();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.task_alt_rounded,
                size: 64, color: PmpColors.success500),
            const SizedBox(height: 16),
            Text("You're all caught up!",
                style:
                    PmpTextStyles.title1SemiBold.copyWith(color: cs.onSurface)),
            const SizedBox(height: 6),
            Text(
              'No words are due for review right now. Practise a set, then come '
              'back later to lock the words in.',
              textAlign: TextAlign.center,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurfaceVariant, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
