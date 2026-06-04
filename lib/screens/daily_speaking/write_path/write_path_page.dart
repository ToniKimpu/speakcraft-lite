import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

import '../daily_speaking_entry_page.dart' show kDailySessionLimit;

/// P2 — write-path. User types a paragraph about the topic from the prep
/// page, gets the same `DailySpeakingFeedback` (without speaking-pace or
/// pronunciation notes — those branches in `feedback_result_page` already
/// handle the empty case).
class WritePathPage extends StatefulWidget {
  const WritePathPage({
    super.key,
    required this.topic,
    this.topicAttemptId,
    this.revisionNumber = 1,
  });

  final DailySpeakingTopic topic;

  /// Version-loop context — set when arriving from "Polish & retry".
  final String? topicAttemptId;
  final int revisionNumber;

  @override
  State<WritePathPage> createState() => _WritePathPageState();
}

class _WritePathPageState extends State<WritePathPage> {
  static const int _minChars = 60;
  static const int _maxChars = 1500;

  final _controller = TextEditingController();
  int _length = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final n = _controller.text.length;
      if (n != _length) setState(() => _length = n);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final text = _controller.text.trim();
    if (text.length < _minChars) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).txtDsWriteAtLeastChars(_minChars),
            ),
          ),
        );
      return;
    }
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingChooseFeedback,
      arguments: {
        'inputMode': DailySpeakingInputMode.text,
        'onRamp': DailySpeakingOnRamp.ownTopic,
        'text': text,
        'topic': widget.topic,
        'topicAttemptId': widget.topicAttemptId,
        'revisionNumber': widget.revisionNumber,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context).txtDsWriteInstead)),
      body: SafeArea(
        child: BlocBuilder<DailySpeakingHistoryBloc,
            DailySpeakingHistoryState>(
              builder: (context, historyState) {
                final used = historyState.maybeWhen(
                  loaded: (_, n) => n,
                  orElse: () => 0,
                );
                final exhausted = used >= kDailySessionLimit;
                final canSubmit = !exhausted && _length >= _minChars;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color:
                              colorScheme.secondary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.secondary
                                .withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.edit_note,
                                size: 18, color: colorScheme.secondary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.topic.title,
                                style: PmpTextStyles.body1Semi.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          maxLines: null,
                          expands: true,
                          maxLength: _maxChars,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context).txtDsWritePathHint,
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHighest,
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colorScheme.outlineVariant),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: colorScheme.outlineVariant),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _length < _minChars
                                ? AppLocalizations.of(context)
                                    .txtDsAtLeastChars(_minChars)
                                : '$_length / $_maxChars',
                            style: PmpTextStyles.label2Regular.copyWith(
                              color: _length < _minChars
                                  ? colorScheme.error
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: canSubmit ? () => _submit(context) : null,
                        icon: const Icon(Icons.send),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            exhausted
                                ? AppLocalizations.of(context)
                                    .txtDsDailyLimitReachedShort
                                : AppLocalizations.of(context).txtDsGetFeedback,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
  }
}
