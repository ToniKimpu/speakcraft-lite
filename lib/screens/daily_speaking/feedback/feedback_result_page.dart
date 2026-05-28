import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';

/// Shared result screen for all three on-ramps.
///
/// Renders every section that the [DailySpeakingFeedback] payload may include
/// — `targetPhraseResults` only appears when the session had a topic with
/// target phrases (i.e. the P3 suggested-topic path).
class FeedbackResultPage extends StatelessWidget {
  const FeedbackResultPage({super.key, required this.session});

  final DailySpeakingSession session;

  @override
  Widget build(BuildContext context) {
    final feedback = session.feedback;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.popUntil(
              context,
              (route) => route.isFirst || route.settings.name == '/home',
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ScoreHeader(feedback: feedback),
            const SizedBox(height: 20),
            _MetricsRow(feedback: feedback),
            if (feedback.inferredTopic != null) ...[
              const SizedBox(height: 16),
              _TopicChip(label: feedback.inferredTopic!),
            ],
            if (feedback.strengths.isNotEmpty) ...[
              const SizedBox(height: 20),
              _Section(
                icon: Icons.star_outline,
                iconColor: PmpColors.success500,
                title: 'What you did well',
                child: _BulletList(items: feedback.strengths),
              ),
            ],
            if (feedback.fixes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.tune,
                iconColor: PmpColors.warning500,
                title: 'Things to fix',
                child: Column(
                  children: feedback.fixes
                      .map((f) => _FixCard(fix: f))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.nativeRewrite.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.record_voice_over,
                iconColor: colorScheme.primary,
                title: 'How a native speaker would say it',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    feedback.nativeRewrite,
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
            if (feedback.targetPhraseResults.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.flag_outlined,
                iconColor: PmpColors.info500,
                title: 'Target phrases',
                child: Column(
                  children: feedback.targetPhraseResults
                      .map((p) => _TargetPhraseRow(result: p))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.pronunciationNotes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.graphic_eq,
                iconColor: colorScheme.tertiary,
                title: 'Pronunciation notes',
                child: _BulletList(items: feedback.pronunciationNotes),
              ),
            ],
            if (feedback.explanationMm.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.translate,
                iconColor: PmpColors.accentOrange,
                title: 'အကျဉ်းချုပ်',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    feedback.explanationMm,
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'Noto Sans Myanmar',
                      height: 1.7,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.popUntil(
                context,
                (route) =>
                    route.isFirst || route.settings.name == '/home',
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreHeader extends StatelessWidget {
  const _ScoreHeader({required this.feedback});
  final DailySpeakingFeedback feedback;

  Color _scoreColor() {
    if (feedback.score >= 80) return PmpColors.success500;
    if (feedback.score >= 60) return PmpColors.warning500;
    return PmpColors.destructive500;
  }

  String _levelLabel(CefrLevel level) {
    switch (level) {
      case CefrLevel.beginner:
        return 'Beginner';
      case CefrLevel.elementary:
        return 'Elementary';
      case CefrLevel.intermediate:
        return 'Intermediate';
      case CefrLevel.upperIntermediate:
        return 'Upper-Intermediate';
      case CefrLevel.advanced:
        return 'Advanced';
      case CefrLevel.fluent:
        return 'Fluent';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scoreColor = _scoreColor();
    return Row(
      children: [
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: feedback.score.clamp(0, 100) / 100.0,
                strokeWidth: 8,
                backgroundColor: scoreColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              ),
              Center(
                child: Text(
                  '${feedback.score}',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'ArchivoBlack Regular',
                    color: scoreColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _levelLabel(feedback.level),
                style: PmpTextStyles.h2.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'out of 100',
                style: PmpTextStyles.label2Regular
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({required this.feedback});
  final DailySpeakingFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final mm = (feedback.durationSeconds ~/ 60).toString().padLeft(2, '0');
    final ss = (feedback.durationSeconds % 60).toString().padLeft(2, '0');
    return Row(
      children: [
        Expanded(child: _MetricTile(label: 'Time', value: '$mm:$ss')),
        const SizedBox(width: 10),
        Expanded(
          child:
              _MetricTile(label: 'Words', value: '${feedback.wordCount}'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MetricTile(
            label: 'Pace',
            value: '${feedback.speakingPaceWpm} wpm',
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: PmpTextStyles.body1Semi.copyWith(
              color: colorScheme.onSurface,
              fontFamily: 'ArchivoBlack Regular',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: PmpTextStyles.sub.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.label_outline, size: 14, color: colorScheme.primary),
            const SizedBox(width: 6),
            Text(
              'Topic: $label',
              style: PmpTextStyles.labelSemi.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 8),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _FixCard extends StatelessWidget {
  const _FixCard({required this.fix});
  final FeedbackFix fix;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fix.original,
            style: PmpTextStyles.body2Regular.copyWith(
              color: PmpColors.destructive400,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fix.corrected,
            style: PmpTextStyles.body1Semi.copyWith(
              color: PmpColors.success500,
            ),
          ),
          if (fix.reasonMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              fix.reasonMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TargetPhraseRow extends StatelessWidget {
  const _TargetPhraseRow({required this.result});
  final TargetPhraseResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color fg = result.used
        ? (result.usedCorrectly
            ? PmpColors.success500
            : PmpColors.warning500)
        : colorScheme.onSurfaceVariant;
    final IconData icon = result.used
        ? (result.usedCorrectly
            ? Icons.check_circle
            : Icons.error_outline)
        : Icons.radio_button_unchecked;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              result.phraseEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: result.used ? colorScheme.onSurface : fg,
                fontStyle:
                    result.used ? FontStyle.normal : FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
