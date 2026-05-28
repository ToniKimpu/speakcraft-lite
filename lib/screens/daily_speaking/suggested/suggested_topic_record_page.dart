import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// P3 stub. Recorder with topic banner + target-phrase chips pinned on
/// screen. onComplete dispatches `submitVoice` with `onRamp = suggested` and
/// the topic payload (so the edge function knows which target phrases to
/// score).
class SuggestedTopicRecordPage extends StatelessWidget {
  const SuggestedTopicRecordPage({super.key, required this.topic});

  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: Center(
        child: Text(
          'Suggested-topic recorder — P3.',
          style:
              PmpTextStyles.body1Regular.copyWith(color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
