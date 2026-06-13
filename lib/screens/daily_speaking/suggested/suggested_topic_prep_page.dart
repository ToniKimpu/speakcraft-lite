import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/screens/daily_speaking/widgets/prep_sections.dart';

/// P3 — the "prep kit" shown before recording a suggested topic. The prompt sits
/// at the top; the rest is the shared collapsible guide ([PrepGuideSections]):
/// a talk structure, words, phrases, grammar patterns, common mistakes, things
/// to mention, and a gated example answer. CTA hands the topic to the recorder.
class SuggestedTopicPrepPage extends StatelessWidget {
  const SuggestedTopicPrepPage({super.key, required this.topic});

  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mins = (topic.durationTargetSeconds / 60).round();
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                children: [
                  PrepPromptCard(topic: topic, mins: mins),
                  PrepGuideSections(topic: topic),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      PmpRoutes.dailySpeakingSuggestedRecord,
                      arguments: {'topic': topic},
                    );
                  },
                  icon: const Icon(Icons.mic, size: 20),
                  label: Text(l10n.txtDsStartRecording),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
