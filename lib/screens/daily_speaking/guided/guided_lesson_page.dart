import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/guided_lesson.dart';

import 'guided_paragraph_actions.dart';

/// The guided wizard — gradual release in four steps:
///   0. Objective  — the payoff up front ("by the end you'll be able to…")
///   1. Model      — the worked example + line-by-line breakdown (I do)
///   2. Build      — fill the slots with your own life; **record is gated** here
///                   (Next stays disabled until every blank is filled) (We do)
///   3. Yours      — your assembled paragraph; the model is now hidden →
///                   hand off to the recorder (You do)
///
/// Slot answers live in local state (no bloc — they only matter inside this
/// screen, like the own-topic scaffold). The assembled paragraph + the lesson's
/// level travel to `guided_record_page.dart`.
/// Asset folder holding a lesson's pre-generated audio (see tools/guided_tts.py).
/// Files: `paragraph.mp3`, `s{index}.mp3`, `v_{vocabId}.mp3`. For the POC these
/// are bundled; production would stream them from Bunny with the same layout.
String _audioBase(String lessonId) =>
    'assets/daily_speaking/guided/audio/$lessonId';

/// One shared audio player for the whole lesson page. Tapping a new clip stops
/// the previous one, so only a single line/word ever plays at a time. Speaker
/// buttons read [currentAsset]/[isPlaying] to render their play/stop state.
class _GuidedAudio extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  String? _currentAsset;

  String? get currentAsset => _currentAsset;
  bool get isPlaying => _player.playing;

  _GuidedAudio() {
    _player.playerStateStream.listen((s) {
      if (s.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
      notifyListeners();
    });
  }

  Future<void> toggle(String assetPath) async {
    try {
      if (_currentAsset == assetPath) {
        if (_player.playing) {
          await _player.pause();
        } else {
          await _player.seek(Duration.zero);
          await _player.play();
        }
        return;
      }
      _currentAsset = assetPath;
      notifyListeners();
      await _player.setAsset(assetPath);
      await _player.play();
    } catch (_) {
      // Missing asset / decode error — stay silent (button already hidden if
      // the asset doesn't exist; see _SpeakerButton).
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

class GuidedLessonPage extends StatefulWidget {
  const GuidedLessonPage({super.key, required this.lesson});

  final GuidedLesson lesson;

  @override
  State<GuidedLessonPage> createState() => _GuidedLessonPageState();
}

class _GuidedLessonPageState extends State<GuidedLessonPage> {
  static const int _stepCount = 4;

  final PageController _pageController = PageController();
  int _step = 0;

  /// slotId → the learner's answer.
  final Map<String, String> _answers = {};

  /// Controllers for free-text slots (those without preset options).
  final Map<String, TextEditingController> _controllers = {};

  /// Shared player for the model audio (paragraph / sentences / vocab).
  final _GuidedAudio _audio = _GuidedAudio();

  @override
  void initState() {
    super.initState();
    for (final slot in widget.lesson.slots) {
      if (slot.options.isEmpty) {
        _controllers[slot.id] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audio.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _allSlotsFilled => widget.lesson.slots
      .every((s) => (_answers[s.id] ?? '').trim().isNotEmpty);

  /// The learner's paragraph: the template with each `{slotId}` replaced by
  /// their answer. Unfilled tokens fall back to the slot hint so the live
  /// preview stays readable (the record gate still requires every slot filled).
  String get _userParagraph {
    final lesson = widget.lesson;
    if (lesson.template.isEmpty) return lesson.modelParagraphEn;
    var out = lesson.template;
    for (final slot in lesson.slots) {
      final answer = (_answers[slot.id] ?? '').trim();
      final value = answer.isNotEmpty
          ? answer
          : (slot.hint.isNotEmpty ? slot.hint : slot.labelEn);
      out = out.replaceAll('{${slot.id}}', value);
    }
    return out;
  }

  /// A manual edit made on the "This is yours" step, or null to use the derived
  /// paragraph. Cleared whenever an answer changes, so going back to tweak a
  /// slot regenerates the paragraph instead of keeping a stale edit.
  String? _paragraphOverride;

  String get _effectiveParagraph => _paragraphOverride ?? _userParagraph;

  void _copyParagraph() =>
      copyParagraphToClipboard(context, _effectiveParagraph);

  Future<void> _editParagraph() async {
    final edited = await showEditParagraphSheet(context, _effectiveParagraph);
    if (edited != null && edited.isNotEmpty && edited != _effectiveParagraph) {
      setState(() => _paragraphOverride = edited);
    }
  }

  void _goTo(int step) {
    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (_step < _stepCount - 1) _goTo(_step + 1);
  }

  void _back() {
    if (_step > 0) _goTo(_step - 1);
  }

  void _startRecording() {
    final lesson = widget.lesson;
    final topic = DailySpeakingTopic(
      id: 'guided',
      title: lesson.title,
      promptEn: lesson.objectiveEn,
      promptMm: lesson.objectiveMm,
      difficulty: _difficultyForLevel(lesson.level),
      durationTargetSeconds: lesson.durationTargetSeconds,
      // Map the richer GuidedVocab down to the shared TopicVocabItem shape the
      // recorder/checklist expects — related/opposite/group are prep-only.
      vocabulary: lesson.vocabulary
          .map((v) => TopicVocabItem(
                term: v.term,
                definitionMm: v.definitionMm,
                exampleEn: v.exampleEn,
              ))
          .toList(growable: false),
      targetPhrases: lesson.targetPhrases,
      warmupQuestions: lesson.warmupQuestions,
      tags: const ['guided'],
    );
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingGuidedRecord,
      arguments: {
        'topic': topic,
        'userParagraph': _effectiveParagraph,
        'level': lesson.level,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      // Keep the Back/Next bar pinned at the bottom (under the keyboard) instead
      // of floating it up and squeezing the form. The form pads itself by the
      // keyboard height so focused fields still scroll above the keyboard.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.lesson.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_step + 1) / _stepCount,
            minHeight: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _ObjectiveStep(lesson: widget.lesson),
                  _ModelStep(lesson: widget.lesson, audio: _audio),
                  _BuildStep(
                    lesson: widget.lesson,
                    answers: _answers,
                    controllers: _controllers,
                    // Clear any manual edit when an answer changes so the
                    // paragraph regenerates from the new slots.
                    onChanged: () => setState(() => _paragraphOverride = null),
                  ),
                  _YoursStep(
                    userParagraph: _effectiveParagraph,
                    onEdit: _editParagraph,
                    onCopy: _copyParagraph,
                  ),
                ],
              ),
            ),
            _BottomBar(
              step: _step,
              l10n: l10n,
              canAdvanceFromBuild: _allSlotsFilled,
              onBack: _back,
              onNext: _next,
              onRecord: _startRecording,
            ),
          ],
        ),
      ),
    );
  }
}

TopicDifficulty _difficultyForLevel(int level) {
  switch (level) {
    case 1:
      return TopicDifficulty.beginner;
    case 2:
      return TopicDifficulty.intermediate;
    default:
      return TopicDifficulty.advanced;
  }
}

// ─────────────────────────────────────── Step 0: Objective ──────────────────

class _ObjectiveStep extends StatelessWidget {
  const _ObjectiveStep({required this.lesson});
  final GuidedLesson lesson;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.flag_rounded, size: 40, color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            l10n.txtDsGuidedObjectiveHeading,
            style: PmpTextStyles.labelSemi.copyWith(color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(
            lesson.objectiveEn,
            style: PmpTextStyles.h2.copyWith(
              color: colorScheme.onSurface,
              height: 1.4,
            ),
          ),
          if (lesson.objectiveMm.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              lesson.objectiveMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: PmpColors.myanmarGloss(Theme.of(context).brightness),
                fontFamily: 'Noto Sans Myanmar',
                height: 1.7,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Step 1: Model (I do) ───────────────

class _ModelStep extends StatelessWidget {
  const _ModelStep({required this.lesson, required this.audio});
  final GuidedLesson lesson;
  final _GuidedAudio audio;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GuidedSectionHeader(
            icon: Icons.menu_book_outlined,
            iconColor: colorScheme.primary,
            title: l10n.txtDsGuidedModelHeading,
            trailing: _SpeakerButton(
              audio: audio,
              assetPath: '${_audioBase(lesson.id)}/paragraph.mp3',
              size: 26,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
            ),
            child: Text(
              lesson.modelParagraphEn,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                height: 1.6,
              ),
            ),
          ),
          if (lesson.sentences.isNotEmpty) ...[
            const SizedBox(height: 20),
            _GuidedSectionHeader(
              icon: Icons.segment,
              iconColor: PmpColors.info500,
              title: l10n.txtDsGuidedBreakdownHeading,
            ),
            const SizedBox(height: 10),
            ...lesson.sentences.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SentenceCard(
                      sentence: e.value,
                      vocab: lesson.vocabulary,
                      audio: audio,
                      lessonId: lesson.id,
                      index: e.key,
                    ),
                  ),
                ),
          ],
          if (lesson.vocabulary.isNotEmpty) ...[
            const SizedBox(height: 10),
            _GuidedSectionHeader(
              icon: Icons.menu_book_outlined,
              iconColor: colorScheme.primary,
              title: l10n.txtDsWordsYouMightUse,
            ),
            const SizedBox(height: 8),
            _TapHint(text: l10n.txtDsTapWordHint),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: lesson.vocabulary
                  .map((v) => _VocabChip(
                        item: v,
                        audio: audio,
                        lessonId: lesson.id,
                      ))
                  .toList(growable: false),
            ),
          ],
          if (lesson.targetPhrases.isNotEmpty) ...[
            const SizedBox(height: 20),
            _GuidedSectionHeader(
              icon: Icons.flag_outlined,
              iconColor: PmpColors.warning500,
              title: l10n.txtDsTryUseThesePhrases,
            ),
            const SizedBox(height: 10),
            ...lesson.targetPhrases.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _TargetPhraseCard(phrase: p),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SentenceCard extends StatefulWidget {
  const _SentenceCard({
    required this.sentence,
    required this.vocab,
    required this.audio,
    required this.lessonId,
    required this.index,
  });
  final GuidedSentence sentence;
  final List<GuidedVocab> vocab;
  final _GuidedAudio audio;
  final String lessonId;
  final int index;

  @override
  State<_SentenceCard> createState() => _SentenceCardState();
}

class _SentenceCardState extends State<_SentenceCard> {
  // Tap handlers for the underlined spans; rebuilt each build, disposed here.
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  GuidedVocab? _vocabById(String id) {
    for (final v in widget.vocab) {
      if (v.id == id) return v;
    }
    return null;
  }

  /// Splits [textEn] into plain + underlined-tappable spans. Each highlight's
  /// phrase is matched at its first occurrence; overlaps are skipped. Swap
  /// words (linked to a build slot) get a solid underline, plain content words
  /// a dotted one — so the two kinds read differently at a glance.
  List<InlineSpan> _buildSpans(BuildContext context) {
    final text = widget.sentence.textEn;
    final colorScheme = Theme.of(context).colorScheme;

    final matches = <({int start, int end, GuidedVocab vocab})>[];
    for (final h in widget.sentence.highlights) {
      final vocab = _vocabById(h.vocabId);
      if (vocab == null || h.phrase.isEmpty) continue;
      final idx = text.indexOf(h.phrase);
      if (idx < 0) continue;
      matches.add((start: idx, end: idx + h.phrase.length, vocab: vocab));
    }
    matches.sort((a, b) => a.start.compareTo(b.start));

    final spans = <InlineSpan>[];
    var cursor = 0;
    for (final m in matches) {
      if (m.start < cursor) continue; // overlapping highlight → skip
      if (m.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, m.start)));
      }
      final isSwap = m.vocab.slot.isNotEmpty;
      final accent = isSwap ? colorScheme.primary : PmpColors.info500;
      final recognizer = TapGestureRecognizer()
        ..onTap = () => _showGuidedVocabSheet(
              context,
              m.vocab,
              audio: widget.audio,
              lessonId: widget.lessonId,
            );
      _recognizers.add(recognizer);
      spans.add(TextSpan(
        text: text.substring(m.start, m.end),
        style: TextStyle(
          color: accent,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationColor: accent,
          decorationStyle:
              isSwap ? TextDecorationStyle.solid : TextDecorationStyle.dotted,
        ),
        recognizer: recognizer,
      ));
      cursor = m.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sentence = widget.sentence;
    _disposeRecognizers();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: PmpTextStyles.body2Semi
                        .copyWith(color: colorScheme.onSurface),
                    children: _buildSpans(context),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              _SpeakerButton(
                audio: widget.audio,
                assetPath:
                    '${_audioBase(widget.lessonId)}/s${widget.index}.mp3',
              ),
            ],
          ),
          if (sentence.textMm.isNotEmpty) ...[
            const SizedBox(height: 10),
            Divider(height: 1, color: colorScheme.outlineVariant),
            const SizedBox(height: 10),
            Text(
              sentence.textMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: PmpColors.myanmarGloss(Theme.of(context).brightness),
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
          if (sentence.explanationMm.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              sentence.explanationMm,
              style: PmpTextStyles.label2Regular.copyWith(
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

// ─────────────────────────────────────── Step 2: Build (We do) ──────────────

class _BuildStep extends StatelessWidget {
  const _BuildStep({
    required this.lesson,
    required this.answers,
    required this.controllers,
    required this.onChanged,
  });

  final GuidedLesson lesson;
  final Map<String, String> answers;
  final Map<String, TextEditingController> controllers;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Preview is capped to a slice of the page so it can't swallow the
        // form. The Scaffold doesn't resize for the keyboard (see
        // resizeToAvoidBottomInset above), so the form pads itself by the
        // keyboard height instead, letting focused fields scroll above it.
        final previewMax =
            (constraints.maxHeight * 0.26).clamp(72.0, 220.0);
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Pinned live preview: the learner watches each blank become their own
        // word inside the real sentence as they fill the slots below.
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: _LivePreviewCard(
            lesson: lesson,
            answers: answers,
            maxPreviewHeight: previewMax,
          ),
        ),
        Expanded(
          child: _ScrollbarBox(
            builder: (controller) => ListView(
            controller: controller,
            padding: EdgeInsets.fromLTRB(20, 8, 20, 16 + bottomInset),
            children: [
              Text(
                l10n.txtDsGuidedBuildSubhead,
                style: PmpTextStyles.label2Regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              ...lesson.slots.map(
                (slot) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SlotCard(
                    slot: slot,
                    value: answers[slot.id] ?? '',
                    controller: controllers[slot.id],
                    filled: (answers[slot.id] ?? '').trim().isNotEmpty,
                    onChanged: (v) {
                      answers[slot.id] = v;
                      onChanged();
                    },
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ],
        );
      },
    );
  }
}

/// The pinned "Your paragraph so far" header. Filled slots show as bold accent
/// words; unfilled slots show as blanks (____) — so the learner sees their
/// answers land inside a real, grammatical sentence in real time.
class _LivePreviewCard extends StatelessWidget {
  const _LivePreviewCard({
    required this.lesson,
    required this.answers,
    required this.maxPreviewHeight,
  });
  final GuidedLesson lesson;
  final Map<String, String> answers;
  final double maxPreviewHeight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PmpColors.success500.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PmpColors.success500.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  size: 14, color: PmpColors.success500),
              const SizedBox(width: 6),
              Text(
                l10n.txtDsGuidedPreviewHeading,
                style: PmpTextStyles.labelSemi
                    .copyWith(color: PmpColors.success500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Cap the paragraph height so a long lesson can't swallow the form
          // below; it scrolls inside while the header stays pinned. The cap is
          // computed against the space available right now (shrinks with the
          // keyboard) — see _BuildStep's LayoutBuilder.
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxPreviewHeight),
            child: _ScrollbarBox(
              builder: (controller) => SingleChildScrollView(
                controller: controller,
                child: _ParagraphPreview(lesson: lesson, answers: answers),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParagraphPreview extends StatelessWidget {
  const _ParagraphPreview({required this.lesson, required this.answers});
  final GuidedLesson lesson;
  final Map<String, String> answers;

  static final _tokenRegex = RegExp(r'\{(\w+)\}');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final base = PmpTextStyles.body1Regular.copyWith(
      color: colorScheme.onSurface,
      height: 1.7,
    );
    final filledStyle = base.copyWith(
      fontWeight: FontWeight.w700,
      color: PmpColors.success500,
    );
    final blankStyle = base.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
    );

    final template = lesson.template;
    if (template.isEmpty) {
      return Text(lesson.modelParagraphEn, style: base);
    }

    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _tokenRegex.allMatches(template)) {
      if (m.start > last) {
        spans.add(TextSpan(text: template.substring(last, m.start)));
      }
      final answer = (answers[m.group(1)] ?? '').trim();
      spans.add(answer.isNotEmpty
          ? TextSpan(text: answer, style: filledStyle)
          : TextSpan(text: '____', style: blankStyle));
      last = m.end;
    }
    if (last < template.length) {
      spans.add(TextSpan(text: template.substring(last)));
    }
    return Text.rich(TextSpan(style: base, children: spans));
  }
}

/// One slot as a card. Turns green with a check once filled — reinforcing
/// progress toward the record gate.
class _SlotCard extends StatelessWidget {
  const _SlotCard({
    required this.slot,
    required this.value,
    required this.controller,
    required this.filled,
    required this.onChanged,
  });

  final GuidedSlot slot;
  final String value;
  final TextEditingController? controller;
  final bool filled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: filled
              ? PmpColors.success500.withValues(alpha: 0.4)
              : colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (filled) ...[
                const Icon(Icons.check_circle,
                    size: 16, color: PmpColors.success500),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  slot.labelEn,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
              if (slot.labelMm.isNotEmpty) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    slot.labelMm,
                    style: PmpTextStyles.sub.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontFamily: 'Noto Sans Myanmar',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          if (slot.options.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: slot.options
                  .map(
                    (opt) => ChoiceChip(
                      label: Text(opt),
                      selected: value == opt,
                      onSelected: (_) => onChanged(opt),
                    ),
                  )
                  .toList(growable: false),
            )
          else
            TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              // A slot is a word or short phrase — cap it so it can't be
              // spammed with a wall of text. Counter hidden (keeps it clean).
              maxLength: 40,
              decoration: InputDecoration(
                hintText: slot.hint,
                isDense: true,
                counterText: '',
                border: const OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Step 3: Yours ──────────────────────

class _YoursStep extends StatelessWidget {
  const _YoursStep({
    required this.userParagraph,
    this.onEdit,
    this.onCopy,
  });
  final String userParagraph;
  final VoidCallback? onEdit;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              size: 40, color: PmpColors.success500),
          const SizedBox(height: 16),
          Text(
            l10n.txtDsGuidedYoursHeading,
            style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.txtDsGuidedYoursSubhead,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                l10n.txtDsGuidedYourParagraph,
                style: PmpTextStyles.labelSemi
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              if (onCopy != null)
                IconButton(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  visualDensity: VisualDensity.compact,
                  tooltip: l10n.txtDsGuidedCopy,
                  color: colorScheme.onSurfaceVariant,
                ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  visualDensity: VisualDensity.compact,
                  tooltip: l10n.txtDsGuidedEdit,
                  color: colorScheme.onSurfaceVariant,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: PmpColors.success500.withValues(alpha: 0.4)),
            ),
            child: Text(
              userParagraph,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Bottom bar ─────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.step,
    required this.l10n,
    required this.canAdvanceFromBuild,
    required this.onBack,
    required this.onNext,
    required this.onRecord,
  });

  final int step;
  final AppLocalizations l10n;
  final bool canAdvanceFromBuild;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    final isBuildStep = step == 2;
    final isLastStep = step == 3;
    final nextEnabled = !isBuildStep || canAdvanceFromBuild;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The record gate: tell the learner what's missing before they can move on.
          if (isBuildStep && !canAdvanceFromBuild)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                l10n.txtDsGuidedFillToContinue,
                style: PmpTextStyles.sub.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Row(
            children: [
              if (step > 0)
                OutlinedButton(
                  onPressed: onBack,
                  child: Text(l10n.txtDsGuidedBack),
                ),
              if (step > 0) const SizedBox(width: 12),
              Expanded(
                child: isLastStep
                    ? FilledButton.icon(
                        onPressed: onRecord,
                        icon: const Icon(Icons.mic),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(l10n.txtDsGuidedReadyRecord),
                        ),
                      )
                    : FilledButton(
                        onPressed: nextEnabled ? onNext : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            step == 0
                                ? l10n.txtDsGuidedStart
                                : l10n.txtDsGuidedNext,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Shared small widgets ───────────────

/// Wraps a scrollable with an always-visible scrollbar so learners notice the
/// content scrolls (the capped preview and the form can both overflow). Owns
/// the [ScrollController] the always-on thumb requires.
class _ScrollbarBox extends StatefulWidget {
  const _ScrollbarBox({required this.builder});
  final Widget Function(ScrollController controller) builder;

  @override
  State<_ScrollbarBox> createState() => _ScrollbarBoxState();
}

class _ScrollbarBoxState extends State<_ScrollbarBox> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      child: widget.builder(_controller),
    );
  }
}

class _GuidedSectionHeader extends StatelessWidget {
  const _GuidedSectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style:
                PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// A small speaker icon that plays a pre-generated audio asset through the
/// page's shared [_GuidedAudio]. It probes the bundle first and renders nothing
/// if the asset is missing — so the button only appears for lessons that
/// actually have audio (during the rollout only `guided_self_intro` does).
class _SpeakerButton extends StatefulWidget {
  const _SpeakerButton({
    required this.audio,
    required this.assetPath,
    this.size = 20,
  });
  final _GuidedAudio audio;
  final String assetPath;
  final double size;

  @override
  State<_SpeakerButton> createState() => _SpeakerButtonState();
}

class _SpeakerButtonState extends State<_SpeakerButton> {
  bool _exists = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    var ok = false;
    try {
      await rootBundle.load(widget.assetPath);
      ok = true;
    } catch (_) {
      ok = false;
    }
    if (mounted) setState(() => _exists = ok);
  }

  @override
  Widget build(BuildContext context) {
    if (!_exists) return const SizedBox.shrink();
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: widget.audio,
      builder: (context, _) {
        final isThis = widget.audio.currentAsset == widget.assetPath;
        final isPlaying = isThis && widget.audio.isPlaying;
        return IconButton(
          onPressed: () => widget.audio.toggle(widget.assetPath),
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(),
          iconSize: widget.size,
          color: colorScheme.primary,
          icon: Icon(
            isPlaying ? Icons.stop_circle_outlined : Icons.volume_up_rounded,
          ),
        );
      },
    );
  }
}

/// A subtle "tap a chip" affordance, since the vocab chips don't otherwise
/// signal they open a detail sheet. Mirrors the suggested-topic prep page.
class _TapHint extends StatelessWidget {
  const _TapHint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.touch_app_outlined,
            size: 14, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: PmpTextStyles.sub.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class _VocabChip extends StatelessWidget {
  const _VocabChip({
    required this.item,
    required this.audio,
    required this.lessonId,
  });
  final GuidedVocab item;
  final _GuidedAudio audio;
  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.book_outlined, size: 16),
      label: Text(item.term),
      onPressed: () =>
          _showGuidedVocabSheet(context, item, audio: audio, lessonId: lessonId),
    );
  }
}

/// Shared detail sheet for a [GuidedVocab] — opened from both the vocab chips
/// and the underlined spans in the line-by-line breakdown. Shows the gloss,
/// the semantic group, "use instead" / "similar" words, opposites, an example,
/// and (for swap words) a nudge that they'll pick it in the build step.
void _showGuidedVocabSheet(
  BuildContext context,
  GuidedVocab vocab, {
  _GuidedAudio? audio,
  String? lessonId,
}) {
  final l10n = AppLocalizations.of(context);
  final colorScheme = Theme.of(context).colorScheme;
  final isSwap = vocab.slot.isNotEmpty;

  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    vocab.term,
                    style:
                        PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
                  ),
                ),
                if (audio != null && lessonId != null) ...[
                  const SizedBox(width: 6),
                  _SpeakerButton(
                    audio: audio,
                    assetPath: '${_audioBase(lessonId)}/v_${vocab.id}.mp3',
                    size: 26,
                  ),
                ],
                if (vocab.group.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  _GroupBadge(label: vocab.group),
                ],
              ],
            ),
            if (vocab.definitionMm.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                vocab.definitionMm,
                style: PmpTextStyles.body1Regular.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'Noto Sans Myanmar',
                  height: 1.6,
                ),
              ),
            ],
            if (vocab.related.isNotEmpty) ...[
              const SizedBox(height: 18),
              _SheetLabel(
                text: isSwap
                    ? l10n.txtDsVocabSwapTitle
                    : l10n.txtDsVocabRelatedTitle,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: vocab.related
                    .map((w) => _WordChip(label: w))
                    .toList(growable: false),
              ),
            ],
            if (vocab.opposite.isNotEmpty) ...[
              const SizedBox(height: 18),
              _SheetLabel(text: l10n.txtDsVocabOppositeTitle),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: vocab.opposite
                    .map((w) => _WordChip(label: w, muted: true))
                    .toList(growable: false),
              ),
            ],
            if (vocab.exampleEn.isNotEmpty) ...[
              const SizedBox(height: 18),
              _SheetLabel(text: l10n.txtDsExample),
              const SizedBox(height: 6),
              Text(
                vocab.exampleEn,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: colorScheme.onSurface,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            if (isSwap) ...[
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 16, color: colorScheme.primary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n.txtDsVocabPickNext,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

class _GroupBadge extends StatelessWidget {
  const _GroupBadge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: PmpTextStyles.sub.copyWith(color: colorScheme.primary),
      ),
    );
  }
}

class _SheetLabel extends StatelessWidget {
  const _SheetLabel({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: PmpTextStyles.labelSemi
          .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
  }
}

class _WordChip extends StatelessWidget {
  const _WordChip({required this.label, this.muted = false});
  final String label;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fg = muted ? colorScheme.onSurfaceVariant : colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Text(label, style: PmpTextStyles.body2Regular.copyWith(color: fg)),
    );
  }
}

class _TargetPhraseCard extends StatelessWidget {
  const _TargetPhraseCard({required this.phrase});
  final TopicTargetPhrase phrase;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phrase.phraseEn,
            style:
                PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 4),
          Text(
            phrase.translationMm,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontFamily: 'Noto Sans Myanmar',
            ),
          ),
        ],
      ),
    );
  }
}
