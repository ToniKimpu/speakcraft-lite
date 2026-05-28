import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// P3 stub. Will show: prompt, warmup questions, vocabulary chips, target
/// phrase chips. CTA → `SuggestedTopicRecordPage` with the topic carried
/// through.
class SuggestedTopicPrepPage extends StatelessWidget {
  const SuggestedTopicPrepPage({super.key, required this.topic});

  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Suggested-topic prep — P3.',
            style:
                PmpTextStyles.body1Regular.copyWith(color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
