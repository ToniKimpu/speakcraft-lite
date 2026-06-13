import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// P2 — own-topic prep. User types what they want to talk about, then either
/// asks the AI to build a prep scaffold ("Help me prepare") or jumps straight
/// into the recorder ("Record now"). This is speaking practice — you say it,
/// you don't write it.
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

  /// Shuffled index order into the starter pool; the first [_visibleCount] are
  /// shown. Reshuffled on the shuffle button so the chips feel fresh.
  late List<int> _order;
  static const int _visibleCount = 5;

  /// A random placeholder hint shown in the empty field; re-rolled on shuffle
  /// (alongside the chips) so the example stays fresh.
  late int _hintIndex;

  @override
  void initState() {
    super.initState();
    _hintIndex = Random().nextInt(_kHintCount);
    _order = List<int>.generate(_kStarterCount, (i) => i)..shuffle();
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

  void _shuffle() => setState(() {
        _order.shuffle();
        _hintIndex = Random().nextInt(_kHintCount);
      });

  void _useStarter(String text) {
    _controller.text = text;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: text.length));
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

  void _goPrepare() {
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingOwnTopicChoosePrep,
      arguments: {'topicText': _controller.text.trim()},
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    final pool = _starterPool(l10n);
    final starters =
        _order.take(_visibleCount).map((i) => pool[i]).toList(growable: false);
    final hint = _hintPool(l10n)[_hintIndex];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsOwnTopic)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
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
              const SizedBox(height: 6),
              Text(
                l10n.txtDsTopicHint,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 3,
                maxLength: 120,
                textInputAction: TextInputAction.done,
                style: PmpTextStyles.body1Regular
                    .copyWith(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: hint,
                  prefixIcon: Icon(Icons.edit_outlined,
                      color: colorScheme.primary, size: 20),
                  // Clear-all button, shown only once there's text to clear.
                  // (_canContinue tracks empty/non-empty, so it toggles here.)
                  // Wrapped as a plain tappable Icon — NOT a default IconButton —
                  // so its 48px tap target doesn't grow the field's height.
                  suffixIcon: _canContinue
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _controller.clear,
                          child: Icon(Icons.cancel,
                              size: 20, color: colorScheme.onSurfaceVariant),
                        )
                      : null,
                  suffixIconConstraints: const BoxConstraints(
                      minWidth: 44, minHeight: 0, maxHeight: 24),
                  // Built-in counter hidden — rendered below the field instead,
                  // next to the "Use this" action.
                  counterText: '',
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: colorScheme.primary, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Caption row under the field: a one-tap "Use this" (drops the
              // shown example into the box, only while empty) on the left, the
              // live character count on the right.
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _controller,
                builder: (context, value, _) {
                  final isEmpty = value.text.trim().isEmpty;
                  return Row(
                    children: [
                      if (isEmpty)
                        InkWell(
                          onTap: () => _useStarter(hint),
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  l10n.txtDsUseThisHint,
                                  style: PmpTextStyles.labelSemi
                                      .copyWith(color: colorScheme.primary),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.arrow_upward,
                                    size: 15, color: colorScheme.primary),
                              ],
                            ),
                          ),
                        ),
                      const Spacer(),
                      Text(
                        '${value.text.characters.length}/120',
                        style: PmpTextStyles.sub
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 16, color: colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    l10n.txtDsTryOneOfThese,
                    style: PmpTextStyles.labelSemi.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _shuffle,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      minimumSize: const Size(0, 32),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.shuffle, size: 16),
                    label:
                        Text(l10n.txtDsShuffle, style: PmpTextStyles.labelSemi),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: starters
                    .map((s) =>
                        _StarterChip(label: s, onTap: () => _useStarter(s)))
                    .toList(growable: false),
              ),
              const SizedBox(height: 28),
              _ActionButton(
                primary: false,
                enabled: _canContinue,
                onTap: _goPrepare,
                icon: Icons.auto_awesome,
                title: l10n.txtDsHelpMePrepare,
                caption: l10n.txtDsHelpMePrepareCaption,
              ),
              const SizedBox(height: 12),
              _ActionButton(
                primary: true,
                enabled: _canContinue,
                onTap: _goRecord,
                icon: Icons.mic,
                title: l10n.txtDsRecordNow,
                caption: l10n.txtDsRecordNowCaption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The full pool of static topic starters. A random [_visibleCount] are shown
/// at a time (reshuffled via the shuffle button) so the page never feels stale.
/// Keep [_kStarterCount] in sync with this list's length.
const int _kStarterCount = 12;

List<String> _starterPool(AppLocalizations l10n) => [
      l10n.txtDsSuggestionFamily,
      l10n.txtDsSuggestionTrip,
      l10n.txtDsSuggestionJob,
      l10n.txtDsSuggestionGoal,
      l10n.txtDsSuggestionWorried,
      l10n.txtDsSuggestionWeekend,
      l10n.txtDsSuggestionHobby,
      l10n.txtDsSuggestionFood,
      l10n.txtDsSuggestionShow,
      l10n.txtDsSuggestionHometown,
      l10n.txtDsSuggestionDream,
      l10n.txtDsSuggestionFriend,
    ];

/// Pool of placeholder hints shown in the empty topic field — one is picked at
/// random per visit. Keep [_kHintCount] in sync with this list's length.
const int _kHintCount = 25;

List<String> _hintPool(AppLocalizations l10n) => [
      l10n.txtDsFieldHint1,
      l10n.txtDsFieldHint2,
      l10n.txtDsFieldHint3,
      l10n.txtDsFieldHint4,
      l10n.txtDsFieldHint5,
      l10n.txtDsFieldHint6,
      l10n.txtDsFieldHint7,
      l10n.txtDsFieldHint8,
      l10n.txtDsFieldHint9,
      l10n.txtDsFieldHint10,
      l10n.txtDsFieldHint11,
      l10n.txtDsFieldHint12,
      l10n.txtDsFieldHint13,
      l10n.txtDsFieldHint14,
      l10n.txtDsFieldHint15,
      l10n.txtDsFieldHint16,
      l10n.txtDsFieldHint17,
      l10n.txtDsFieldHint18,
      l10n.txtDsFieldHint19,
      l10n.txtDsFieldHint20,
      l10n.txtDsFieldHint21,
      l10n.txtDsFieldHint22,
      l10n.txtDsFieldHint23,
      l10n.txtDsFieldHint24,
      l10n.txtDsFieldHint25,
    ];

/// Tonal, tappable starter chip — softer and more inviting than a plain
/// outlined chip, and brand-tinted so it reads as a primary action.
class _StarterChip extends StatelessWidget {
  const _StarterChip({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: colorScheme.primary.withValues(alpha: 0.25)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, size: 15, color: colorScheme.primary),
              const SizedBox(width: 5),
              Text(
                label,
                style: PmpTextStyles.body2Semi
                    .copyWith(color: colorScheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rich two-line CTA: an icon tile + title + caption. The primary variant is a
/// gradient with a soft shadow (so it doesn't read flat); the secondary is a
/// tonal/outlined card. Both grey out cleanly when [enabled] is false.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.primary,
    required this.enabled,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.caption,
  });

  final bool primary;
  final bool enabled;
  final VoidCallback onTap;
  final IconData icon;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final disabled = !enabled;

    final Color titleColor;
    final Color captionColor;
    final Color iconColor;
    final Color iconBg;
    BoxDecoration decoration;

    if (primary) {
      // Disabled = a dimmed, on-brand "inactive" state (NOT flat grey) so the
      // button still reads as the colorful primary. The moment the field has
      // text it brightens to the full gradient + shadow — that "lighting up"
      // pulls the eye to Help-me-prepare before Record-now.
      titleColor = disabled
          ? colorScheme.primary.withValues(alpha: 0.55)
          : colorScheme.onPrimary;
      captionColor = disabled
          ? colorScheme.primary.withValues(alpha: 0.45)
          : colorScheme.onPrimary.withValues(alpha: 0.85);
      iconColor = titleColor;
      iconBg = disabled
          ? colorScheme.primary.withValues(alpha: 0.12)
          : colorScheme.onPrimary.withValues(alpha: 0.2);
      decoration = disabled
          ? BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.25)),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary,
                  Color.lerp(colorScheme.primary, PmpColors.info500, 0.55)!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            );
    } else {
      titleColor =
          disabled ? colorScheme.onSurfaceVariant : colorScheme.onSurface;
      captionColor = colorScheme.onSurfaceVariant;
      iconColor = disabled ? colorScheme.onSurfaceVariant : colorScheme.primary;
      iconBg = (disabled ? colorScheme.onSurfaceVariant : colorScheme.primary)
          .withValues(alpha: 0.12);
      decoration = BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      );
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled ? null : onTap,
        child: Ink(
          decoration: decoration,
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style:
                          PmpTextStyles.body1Semi.copyWith(color: titleColor),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      caption,
                      style: PmpTextStyles.sub.copyWith(color: captionColor),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 14, color: titleColor.withValues(alpha: 0.7)),
            ],
          ),
        ),
      ),
    );
  }
}
