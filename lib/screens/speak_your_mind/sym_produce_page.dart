import 'dart:convert';

import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/speak_your_mind/sym_feedback.dart';
import '../../model/speak_your_mind/sym_loader.dart';
import '../../model/speak_your_mind/sym_models.dart';
import '../../model/speak_your_mind/sym_version.dart';
import '../../repositories/speak_your_mind/sym_budget_repository.dart';
import '../../repositories/speak_your_mind/sym_reviewer.dart';
import '../../repositories/speak_your_mind/sym_session_repository.dart';
import '../../services/analytics_service.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';
import '../../shared_widgets/guest_gate.dart';
import '../vocabulary/widgets/bilingual_text.dart';
import 'widgets/sym_feedback_view.dart';
import 'widgets/sym_recorder.dart';
import 'widgets/sym_toolbox.dart';

/// The produce step: the learner writes about their own life using the toolbox,
/// gets AI feedback (gemini-2.5-flash-lite), revises (v1 → v2 → …), then reads
/// the natural version aloud. The AI call lives behind [SymReviewer] so it can
/// move to an edge function later without touching this screen.
class SymProducePage extends StatefulWidget {
  const SymProducePage({
    super.key,
    required this.topicId,
    this.resumeSessionId,
    this.resumeVersions,
    this.resumeRecordingPath,
    this.initialText,
  });
  final String topicId;

  /// Seed text for the writing box — the assembled draft handed over from the
  /// guided on-ramp, so the learner expands it instead of starting blank.
  final String? initialText;

  /// When set, this is a "Polish & retry" of a saved session: the new version(s)
  /// append to that row's chain (continue v1 → v2 → v3) instead of starting a
  /// fresh entry. [resumeVersions] seeds the prior chain; [resumeRecordingPath]
  /// is kept if the learner doesn't re-record.
  final int? resumeSessionId;
  final List<SymVersion>? resumeVersions;
  final String? resumeRecordingPath;

  @override
  State<SymProducePage> createState() => _SymProducePageState();
}

enum _Stage { writing, loading, feedback, speakAloud }

class _SymProducePageState extends State<SymProducePage> {
  final TextEditingController _controller = TextEditingController();
  final SymReviewer _reviewer = defaultSymReviewer();
  final SymSessionRepository _sessions = SymSessionRepository();

  SymTopic? _topic;
  Object? _error;

  _Stage _stage = _Stage.writing;
  int _version = 1;
  String _submittedText = '';
  SymFeedback? _feedback;
  Object? _feedbackError;

  /// Every version produced this attempt (one per successful feedback pass).
  final List<SymVersion> _versions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    // Resuming a saved attempt: seed the prior chain, continue the version
    // counter, and prefill the last text so the learner can polish it.
    final resume = widget.resumeVersions;
    if (resume != null && resume.isNotEmpty) {
      _versions.addAll(resume);
      final lastVersion =
          resume.map((v) => v.version).reduce((a, b) => a > b ? a : b);
      _version = lastVersion + 1;
      _controller.text = resume.last.text;
    } else if ((widget.initialText ?? '').trim().isNotEmpty) {
      // Came from the guided on-ramp with an assembled draft to expand.
      _controller.text = widget.initialText!.trim();
    }
    _load();
  }

  Future<void> _load() async {
    try {
      final t = await loadSymTopic(widget.topicId);
      if (mounted) setState(() => _topic = t);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get _wordCount {
    final t = _controller.text.trim();
    if (t.isEmpty) return 0;
    return t.split(RegExp(r'\s+')).length;
  }

  Future<void> _submit() async {
    final topic = _topic;
    if (topic == null) return;
    FocusScope.of(context).unfocus();
    // Guests can read the topic but AI feedback needs a real account.
    if (await blockAiForGuest(context, featureName: 'AI feedback')) return;
    if (!mounted) return;
    AnalyticsService.instance.symProduceSubmit(widget.topicId, _version);
    setState(() {
      _submittedText = _controller.text.trim();
      _feedback = null;
      _feedbackError = null;
      _stage = _Stage.loading;
    });
    try {
      final fb = await _reviewer.review(topic: topic, text: _submittedText);
      if (mounted) {
        AnalyticsService.instance
            .symFeedbackReceived(widget.topicId, fb.score);
        setState(() {
          _feedback = fb;
          _versions.add(SymVersion(
            version: _version,
            text: _submittedText,
            score: fb.score,
            band: fb.band,
            naturalVersion: fb.naturalVersionEn,
            tokens: fb.totalTokens,
            feedback: fb,
          ));
          _stage = _Stage.feedback;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _feedbackError = e;
          _stage = _Stage.feedback;
        });
      }
    }
  }

  void _improve() {
    setState(() {
      _version += 1;
      _feedback = null;
      _feedbackError = null;
      _stage = _Stage.writing;
    });
  }

  void _finish() {
    FocusScope.of(context).unfocus();
    setState(() => _stage = _Stage.speakAloud);
  }

  /// Persist the finished session (text + feedback + optional recording path),
  /// then leave. Saving never blocks exit.
  Future<void> _saveAndExit(String? recordingPath) async {
    AnalyticsService.instance.symSpeakAloudDone(widget.topicId);
    try {
      final versionsJson = _versions.isEmpty
          ? null
          : jsonEncode([for (final v in _versions) v.toJson()]);
      final totalTokens = _versions.fold<int>(0, (s, v) => s + v.tokens);
      final last = _versions.isEmpty ? null : _versions.last;
      final resumeId = widget.resumeSessionId;
      if (resumeId != null) {
        // Continue the chain: update the existing history entry in place. Keep
        // the prior recording if the learner didn't record a new one.
        await _sessions.updateSession(
          id: resumeId,
          finalText: last?.text ?? _submittedText,
          naturalVersion: last?.naturalVersion ?? _feedback?.naturalVersionEn,
          score: last?.score ?? _feedback?.score,
          band: last?.band ?? _feedback?.band,
          versions: _versions.isEmpty ? 1 : _versions.length,
          recordingPath: recordingPath ?? widget.resumeRecordingPath,
          tokens: totalTokens > 0 ? totalTokens : (_feedback?.totalTokens ?? 0),
          versionsJson: versionsJson,
        );
      } else {
        await _sessions.save(
          topicId: widget.topicId,
          finalText: _submittedText,
          naturalVersion: _feedback?.naturalVersionEn,
          score: _feedback?.score,
          band: _feedback?.band,
          versions: _versions.isEmpty ? 1 : _versions.length,
          recordingPath: recordingPath,
          tokens: totalTokens > 0 ? totalTokens : (_feedback?.totalTokens ?? 0),
          versionsJson: versionsJson,
        );
      }
    } catch (_) {}
    if (mounted) Navigator.of(context).pop(true);
  }

  /// What the learner rehearses aloud — the AI's natural rewrite if we have one,
  /// else their own words.
  String get _speakText {
    final natural = _feedback?.naturalVersionEn.trim() ?? '';
    return natural.isNotEmpty ? natural : _submittedText;
  }

  @override
  Widget build(BuildContext context) {
    final topic = _topic;
    return GlassScaffold(
      title: Text(topic == null ? 'Write' : 'Write — ${topic.titleEn}'),
      actions: [
        // Peek at the toolbox while writing — no need to leave the screen.
        if (topic != null && _stage == _Stage.writing)
          IconButton(
            tooltip: 'Toolbox',
            onPressed: () => SymToolboxSheet.show(context, topic),
            icon: const Icon(Icons.handyman_outlined),
          ),
      ],
      body: _error != null
          ? ErrorRetryView(
              error: _error,
              onRetry: () {
                setState(() => _error = null);
                _load();
              },
            )
          : topic == null
              ? const Center(child: CircularProgressIndicator())
              : _buildStage(topic),
    );
  }

  Widget _buildStage(SymTopic topic) {
    switch (_stage) {
      case _Stage.writing:
        final min = topic.produce.minWords;
        final max = topic.produce.maxWords;
        final inRange =
            (min <= 0 || _wordCount >= min) && (max <= 0 || _wordCount <= max);
        return _WritingView(
          topic: topic,
          controller: _controller,
          wordCount: _wordCount,
          version: _version,
          onSubmit: inRange ? _submit : null,
        );
      case _Stage.loading:
        return const _LoadingView();
      case _Stage.feedback:
        if (_feedbackError is SymBudgetException) {
          return _BudgetBlockedView(
            ex: _feedbackError as SymBudgetException,
            onBack: () => Navigator.of(context).pop(),
          );
        }
        if (_feedbackError != null) {
          return _FeedbackErrorView(
            error: _feedbackError!,
            onRetry: _submit,
            onContinue: _finish,
          );
        }
        return _FeedbackView(
          feedback: _feedback!,
          text: _submittedText,
          version: _version,
          onImprove: _improve,
          onFinish: _finish,
        );
      case _Stage.speakAloud:
        return _SpeakAloudView(
            topic: topic, text: _speakText, onDone: _saveAndExit);
    }
  }
}

// ── Writing ──────────────────────────────────────────────────────────────────

class _WritingView extends StatelessWidget {
  const _WritingView({
    required this.topic,
    required this.controller,
    required this.wordCount,
    required this.version,
    required this.onSubmit,
  });
  final SymTopic topic;
  final TextEditingController controller;
  final int wordCount;
  final int version;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final min = topic.produce.minWords;
    final max = topic.produce.maxWords;
    final tooShort = min > 0 && wordCount < min;
    final tooLong = max > 0 && wordCount > max;

    // Three-state counter — always shows the min–max target so the bounds are
    // clear (not a bare "12 / 40").
    final range = (min > 0 && max > 0) ? '$min–$max words' : null;
    final String counterText;
    final Color counterColor;
    if (tooShort) {
      counterText =
          range == null ? '$wordCount words' : '$wordCount words · aim for $range';
      counterColor = cs.onSurfaceVariant;
    } else if (tooLong) {
      counterText = '$wordCount words · over $max, trim a little';
      counterColor = cs.error;
    } else {
      counterText =
          range == null ? '$wordCount words ✓' : '$wordCount words ✓  ($range)';
      counterColor = PmpColors.success500;
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        const _ChecksLeftChip(),
        if (version > 1) _VersionBadge(version: version),
        GlassCard(
          blur: false,
          highlight: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit_note_rounded, size: 18, color: cs.primary),
                  const SizedBox(width: 6),
                  Text(version > 1 ? 'Improve your answer' : 'Your task',
                      style:
                          PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
                ],
              ),
              const SizedBox(height: 8),
              BilingualText(
                mm: topic.produce.promptMm,
                en: topic.produce.promptEn,
                style: PmpTextStyles.body2Semi,
                long: true,
              ),
            ],
          ),
        ),
        if (topic.produce.coverageHints.isNotEmpty) ...[
          const SizedBox(height: 14),
          Text('Try to mention',
              style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final h in topic.produce.coverageHints) _HintChip(label: h),
            ],
          ),
        ],
        const SizedBox(height: 16),
        GlassCard(
          blur: false,
          padding: const EdgeInsets.fromLTRB(14, 6, 14, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: controller,
                maxLines: null,
                minLines: 7,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.5),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write about your family here…',
                  hintStyle: PmpTextStyles.body2Regular
                      .copyWith(color: cs.onSurfaceVariant),
                ),
              ),
              Text(
                counterText,
                style: PmpTextStyles.label2Regular.copyWith(
                  color: counterColor,
                  fontWeight: tooShort ? FontWeight.w400 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: onSubmit,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            textStyle: PmpTextStyles.body1Semi,
          ),
          icon: const Icon(Icons.auto_awesome_outlined),
          label: const Text('Get feedback'),
        ),
        if (onSubmit == null) ...[
          const SizedBox(height: 8),
          Center(
            child: Text(
              tooLong
                  ? 'Trim to $max words or fewer to continue'
                  : 'Write at least $min words to get feedback',
              style: PmpTextStyles.label2Regular
                  .copyWith(color: tooLong ? cs.error : cs.onSurfaceVariant),
            ),
          ),
        ],
      ],
    );
  }
}

/// "N AI feedback checks left today" — fetched up front so the learner can plan
/// (and, for free users running low, a gentle upgrade nudge). Hidden when the
/// budget can't be read (offline / signed out).
class _ChecksLeftChip extends StatefulWidget {
  const _ChecksLeftChip();

  @override
  State<_ChecksLeftChip> createState() => _ChecksLeftChipState();
}

class _ChecksLeftChipState extends State<_ChecksLeftChip> {
  final SymBudgetRepository _repo = SymBudgetRepository();
  SymBudget? _budget;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final b = await _repo.fetchToday();
    if (mounted) {
      setState(() {
        _budget = b;
        _loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final b = _budget;
    if (!_loaded || b == null) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    final left = b.checksLeft;
    // Free users at/near the wall get the orange + upgrade nudge.
    final low = !b.isPremium && left <= 1;
    final color = low ? PmpColors.brandOrange : cs.primary;
    final text = left > 0
        ? '$left AI feedback check${left == 1 ? '' : 's'} left today'
        : 'No AI checks left today';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 14, color: color),
              const SizedBox(width: 6),
              Text(text,
                  style: PmpTextStyles.label2Regular.copyWith(color: color)),
              if (!b.isPremium && left <= 1) ...[
                Text(' · ',
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: cs.onSurfaceVariant)),
                GestureDetector(
                  onTap: () {
                    AnalyticsService.instance
                        .premiumUpgradeTapped('sym_checks_chip');
                    Navigator.pushNamed(
                        context, PmpRoutes.premiumPaymentPage);
                  },
                  child: Text('Get Premium',
                      style: PmpTextStyles.labelSemi
                          .copyWith(color: PmpColors.premiumGoldDeep)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  const _HintChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(label,
          style: PmpTextStyles.label2Regular.copyWith(color: cs.onSurface)),
    );
  }
}

// ── Loading ──────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 18),
          Text('Reading your writing…',
              style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
          const SizedBox(height: 6),
          Text('AI နှင့်စစ်ပေးနေပါတယ်...',
              style: PmpTextStyles.label2Regular.copyWith(color: mm)),
        ],
      ),
    );
  }
}

// ── Feedback (real) ──────────────────────────────────────────────────────────

class _FeedbackView extends StatelessWidget {
  const _FeedbackView({
    required this.feedback,
    required this.text,
    required this.version,
    required this.onImprove,
    required this.onFinish,
  });
  final SymFeedback feedback;
  final String text;
  final int version;
  final VoidCallback onImprove;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        _VersionBadge(version: version),
        SymFeedbackContent(feedback: feedback),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: onImprove,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            textStyle: PmpTextStyles.body1Semi,
          ),
          icon: const Icon(Icons.edit_outlined),
          label: Text('Improve (write v${version + 1})'),
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: onFinish,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            textStyle: PmpTextStyles.body1Semi,
          ),
          icon: const Icon(Icons.mic_none_rounded),
          label: const Text('I\'m happy — say it aloud'),
        ),
        if (feedback.budget != null || feedback.totalTokens > 0) ...[
          const SizedBox(height: 12),
          Center(
            child: Text(
              feedback.budget != null
                  ? '${feedback.budget!.checksLeft} feedback checks left today'
                  : '${feedback.totalTokens} tokens',
              style: PmpTextStyles.label2Regular
                  .copyWith(color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Feedback error (graceful fallback) ───────────────────────────────────────

class _FeedbackErrorView extends StatelessWidget {
  const _FeedbackErrorView({
    required this.error,
    required this.onRetry,
    required this.onContinue,
  });
  final Object error;
  final VoidCallback onRetry;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 28),
      children: [
        Icon(Icons.cloud_off_rounded, size: 40, color: cs.onSurfaceVariant),
        const SizedBox(height: 14),
        Text('Couldn\'t get feedback',
            textAlign: TextAlign.center,
            style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
        const SizedBox(height: 8),
        Text(
          'အင်တာနက် (သို့) AI ဆက်သွယ်မှု အဆင်မပြေပါ။ ပြန်ကြိုးစားကြည့်ပါ — '
          'ဒါမှမဟုတ် ဆက်သွားပြီး ကိုယ်ရေးထားတာကို အသံထွက် ဖတ်ကြည့်ပါ။',
          textAlign: TextAlign.center,
          style: PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.5),
        ),
        const SizedBox(height: 14),
        // Surface the real reason so failures are diagnosable (network block,
        // HTTP code, parse error). Kept small + muted.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: SelectableText(
            error.toString(),
            style: PmpTextStyles.label2Regular
                .copyWith(color: cs.onSurfaceVariant, height: 1.4),
          ),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: onRetry,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            textStyle: PmpTextStyles.body1Semi,
          ),
          icon: const Icon(Icons.refresh_rounded),
          label: const Text('Try again'),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: onContinue,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            textStyle: PmpTextStyles.body1Semi,
          ),
          child: const Text('Continue anyway'),
        ),
      ],
    );
  }
}

// ── Budget blocked (daily limit hit / free trial over) ───────────────────────

class _BudgetBlockedView extends StatelessWidget {
  const _BudgetBlockedView({required this.ex, required this.onBack});
  final SymBudgetException ex;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final trial = ex.isTrialExpired;
    final canUpgrade = !ex.isPremium;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 28),
      children: [
        Icon(
            trial ? Icons.lock_outline_rounded : Icons.hourglass_bottom_rounded,
            size: 44,
            color: cs.primary),
        const SizedBox(height: 14),
        Text(trial ? 'Your free trial is over' : 'That\'s today\'s practice',
            textAlign: TextAlign.center,
            style: PmpTextStyles.title1SemiBold.copyWith(color: cs.onSurface)),
        const SizedBox(height: 8),
        Text(
          trial
              ? 'အခမဲ့ ၃ ရက် စမ်းသပ်ချိန် ပြီးဆုံးသွားပါပြီ။ ဆက်လေ့ကျင့်ဖို့ '
                  'Premium ယူလိုက်ပါ — နေ့စဉ် ပိုများများ လေ့ကျင့်လို့ရပါမယ်။'
              : (canUpgrade
                  ? 'ဒီနေ့အတွက် အခမဲ့ feedback ကုန်သွားပါပြီ။ မနက်ဖြန် '
                      'ပြန်စလို့ရပါတယ် — ဒါမှမဟုတ် Premium နဲ့ နေ့စဉ် ပိုလေ့ကျင့်ပါ။'
                  : 'ဒီနေ့အတွက် feedback အကန့်အသတ် ပြည့်သွားပါပြီ။ '
                      'မနက်ဖြန် ပြန်စလို့ရပါတယ်။'),
          textAlign: TextAlign.center,
          style: PmpTextStyles.body2Regular.copyWith(color: mm, height: 1.6),
        ),
        const SizedBox(height: 22),
        if (canUpgrade)
          FilledButton.icon(
            onPressed: () {
              AnalyticsService.instance
                  .premiumUpgradeTapped('sym_budget_blocked');
              Navigator.pushNamed(context, PmpRoutes.premiumPaymentPage);
            },
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              textStyle: PmpTextStyles.body1Semi,
            ),
            icon: const Icon(Icons.workspace_premium_outlined),
            label: const Text('Upgrade to Premium'),
          ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: onBack,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            textStyle: PmpTextStyles.body1Semi,
          ),
          child: const Text('Back'),
        ),
      ],
    );
  }
}

// ── Speak aloud + record (free, no AI, no TTS — they read it themselves) ──────

class _SpeakAloudView extends StatefulWidget {
  const _SpeakAloudView({
    required this.topic,
    required this.text,
    required this.onDone,
  });
  final SymTopic topic;
  final String text;

  /// Called on Done with the recording path (null if they didn't record).
  final Future<void> Function(String?) onDone;

  @override
  State<_SpeakAloudView> createState() => _SpeakAloudViewState();
}

class _SpeakAloudViewState extends State<_SpeakAloudView> {
  String? _recordingPath;
  bool _saving = false;

  Future<void> _done() async {
    if (_saving) return;
    setState(() => _saving = true);
    await widget.onDone(_recordingPath);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        Row(
          children: [
            Icon(Icons.record_voice_over_rounded, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Now say it aloud',
                  style: PmpTextStyles.title1SemiBold
                      .copyWith(color: cs.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        BilingualText(
          mm: widget.topic.produce.speakAloudMm,
          en: widget.topic.produce.speakAloudEn,
          style: PmpTextStyles.body2Regular,
          long: true,
        ),
        const SizedBox(height: 16),
        // Read this yourself — no robotic TTS. Record + relisten to compare.
        GlassCard(
          blur: false,
          highlight: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Read this aloud',
                  style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
              const SizedBox(height: 6),
              Text(widget.text,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: cs.onSurface, height: 1.6)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text('Record yourself (optional)',
            style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
        const SizedBox(height: 4),
        Text(
          'ကိုယ့်အသံကို သွင်းပြီး ပြန်နားထောင်ကြည့်ပါ — ဘယ်လို နားဝင်လဲ '
          'သိရအောင်။ (device ထဲမှာပဲ သိမ်းတာ၊ ဘယ်ကိုမှ မပို့ပါဘူး။)',
          style: PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.5),
        ),
        const SizedBox(height: 12),
        SymRecorder(
          onChanged: (path) => setState(() => _recordingPath = path),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Text(
            'Tip: read it slowly first to get every word right, then again at a '
            'natural speed. Don\'t worry about mistakes — saying it out loud is '
            'what builds the habit.',
            style:
                PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.55),
          ),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: _saving ? null : _done,
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            textStyle: PmpTextStyles.body1Semi,
          ),
          icon: const Icon(Icons.check_rounded),
          label: Text(_saving ? 'Saving…' : 'Done'),
        ),
      ],
    );
  }
}

class _VersionBadge extends StatelessWidget {
  const _VersionBadge({required this.version});
  final int version;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Version $version',
                style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
          ),
        ],
      ),
    );
  }
}
