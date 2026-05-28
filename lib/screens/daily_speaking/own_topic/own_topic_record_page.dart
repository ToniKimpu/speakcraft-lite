import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';

/// P2 stub. Will host the recorder with the user-typed topic pinned at the
/// top of the screen. Same `SessionRecorder` widget as the just-record page;
/// onComplete dispatches `submitVoice` with `onRamp = ownTopic` and the topic
/// payload.
class OwnTopicRecordPage extends StatelessWidget {
  const OwnTopicRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Own topic')),
      body: Center(
        child: Text(
          'Own-topic recorder — P2.',
          style:
              PmpTextStyles.body1Regular.copyWith(color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
