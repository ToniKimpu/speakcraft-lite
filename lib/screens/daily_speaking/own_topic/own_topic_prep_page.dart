import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';

/// P2 stub — own topic prep. Activated alongside [_RecordPage] when the
/// "Own topic" entry-page card is enabled.
///
/// Final shape: text input asking "What do you want to talk about?", warmup
/// prompt suggestions, then either CTA to record (voice) or CTA to write
/// (text). The "Own topic" tile is currently disabled on the entry page; this
/// stub keeps the route registration honest.
class OwnTopicPrepPage extends StatelessWidget {
  const OwnTopicPrepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ComingSoonScaffold(
      title: 'Own topic',
      body:
          "Type the topic you want to practice. The AI will check whether you stuck to it and give feedback.",
    );
  }
}

class _ComingSoonScaffold extends StatelessWidget {
  const _ComingSoonScaffold({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.construction,
                  size: 56, color: colorScheme.onSurfaceVariant),
              const SizedBox(height: 16),
              Text(
                'Coming soon',
                style: PmpTextStyles.h1.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                textAlign: TextAlign.center,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
