import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';

/// P2 stub — write-path alternative to speaking. User types a paragraph,
/// submits, gets the same `DailySpeakingFeedback` back (without speaking-pace
/// or pronunciation notes). Reuses the same edge function under the hood.
class WritePathPage extends StatelessWidget {
  const WritePathPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Write instead')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Write-path — P2. Type a paragraph, get the same feedback.',
            textAlign: TextAlign.center,
            style: PmpTextStyles.body1Regular
                .copyWith(color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
