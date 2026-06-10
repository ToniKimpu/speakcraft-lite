import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// P2 — own-topic prep. User types what they want to talk about, then continues
/// into the voice recorder. (This is speaking practice — there's no text input
/// path; you say it, you don't write it.)
///
/// The synthetic [DailySpeakingTopic] built here only fills the fields the
/// edge function actually needs (`title`, `promptEn`) — everything else is
/// default. `id == 'own'` is a sentinel so the result screen and history
/// view can tell own-topic apart from a real curated topic.
class OwnTopicPrepPage extends StatefulWidget {
  const OwnTopicPrepPage({super.key});

  @override
  State<OwnTopicPrepPage> createState() => _OwnTopicPrepPageState();
}

class _OwnTopicPrepPageState extends State<OwnTopicPrepPage> {
  final _controller = TextEditingController();
  bool _canContinue = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final ok = _controller.text.trim().isNotEmpty;
      if (ok != _canContinue) setState(() => _canContinue = ok);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DailySpeakingTopic _buildTopic() {
    final text = _controller.text.trim();
    return DailySpeakingTopic(
      id: 'own',
      title: text,
      promptEn: text,
      promptMm: '',
    );
  }

  void _goRecord() {
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingOwnTopicRecord,
      arguments: {'topic': _buildTopic()},
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final suggestions = [
      l10n.txtDsSuggestionFamily,
      l10n.txtDsSuggestionTrip,
      l10n.txtDsSuggestionJob,
      l10n.txtDsSuggestionGoal,
      l10n.txtDsSuggestionWorried,
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsOwnTopic)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.txtDsWhatToTalkAbout,
                style: PmpTextStyles.h2.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.txtDsTopicHint,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 3,
                maxLength: 120,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l10n.txtDsTopicFieldHint,
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.txtDsTryOneOfThese,
                style: PmpTextStyles.labelSemi.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: suggestions
                    .map(
                      (s) => ActionChip(
                        label: Text(s),
                        onPressed: () {
                          _controller.text = s;
                          _controller.selection = TextSelection.fromPosition(
                            TextPosition(offset: s.length),
                          );
                        },
                      ),
                    )
                    .toList(growable: false),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _canContinue ? _goRecord : null,
                icon: const Icon(Icons.mic),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(l10n.txtDsRecordThis),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
