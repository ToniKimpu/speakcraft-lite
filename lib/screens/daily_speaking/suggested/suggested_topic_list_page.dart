import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_topic_bloc.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';

/// P3 stub. Lists topics from `assets/daily_speaking/topics/topics.json`. The
/// loader (`DailySpeakingTopicBloc`) is already wired so this screen can
/// render real topic data the moment the entry-page tile is enabled.
class SuggestedTopicListPage extends StatelessWidget {
  const SuggestedTopicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DailySpeakingTopicBloc()..add(const DailySpeakingTopicEvent.load()),
      child: const _ListView(),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Suggested topics')),
      body: BlocBuilder<DailySpeakingTopicBloc, DailySpeakingTopicState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(msg)),
            loaded: (topics) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: topics.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final t = topics[i];
                return Material(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    title: Text(t.title, style: PmpTextStyles.body2Semi),
                    subtitle: Text(t.promptEn,
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      // P3: push prep page with this topic
                    },
                  ),
                );
              },
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
