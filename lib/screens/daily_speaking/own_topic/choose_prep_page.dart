import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/prep_section.dart';

/// P2 — "what help do you want?" step between typing an own topic and the AI
/// scaffold. Mirrors the choose-feedback pattern: a checklist pre-ticked with
/// the [kRecommendedPrep] set, so it reads as "here's a good prep — adjust if
/// you want" rather than a blank decision. Only the chosen sections get
/// generated (own-topic prep is a paid AI call).
class ChoosePrepPage extends StatefulWidget {
  const ChoosePrepPage({super.key, required this.topicText});

  final String topicText;

  @override
  State<ChoosePrepPage> createState() => _ChoosePrepPageState();
}

class _ChoosePrepPageState extends State<ChoosePrepPage> {
  late final Set<PrepSection> _selected = {...kRecommendedPrep};

  void _toggle(PrepSection s) => setState(() {
        _selected.contains(s) ? _selected.remove(s) : _selected.add(s);
      });

  void _selectAll() => setState(() => _selected.addAll(kPrepSections));

  void _build() {
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingOwnTopicScaffold,
      arguments: {
        'topicText': widget.topicText,
        'sections': {..._selected},
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final allSelected = _selected.length == kPrepSections.length;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsOwnTopic)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                children: [
                  Text(
                    l10n.txtDsChoosePrepTitle,
                    style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.txtDsChoosePrepSubtitle,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: allSelected ? null : _selectAll,
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(Icons.done_all, size: 16),
                      label: Text(l10n.txtDsSelectAll,
                          style: PmpTextStyles.labelSemi),
                    ),
                  ),
                  const SizedBox(height: 4),
                  for (final s in kPrepSections)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _SectionTile(
                        icon: _icon(s),
                        title: _title(context, s),
                        description: _description(context, s),
                        recommended: kRecommendedPrep.contains(s),
                        selected: _selected.contains(s),
                        onTap: () => _toggle(s),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_selected.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        l10n.txtDsPrepPickOne,
                        style: PmpTextStyles.sub
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _selected.isEmpty ? null : _build,
                      icon: const Icon(Icons.auto_awesome, size: 20),
                      label: Text(l10n.txtDsBuildMyPrep),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _icon(PrepSection s) {
  switch (s) {
    case PrepSection.structure:
      return Icons.list_alt_rounded;
    case PrepSection.vocab:
      return Icons.menu_book_outlined;
    case PrepSection.phrases:
      return Icons.flag_outlined;
    case PrepSection.grammar:
      return Icons.account_tree_outlined;
    case PrepSection.mistakes:
      return Icons.error_outline;
    case PrepSection.example:
      return Icons.visibility_outlined;
  }
}

String _title(BuildContext context, PrepSection s) {
  final l10n = AppLocalizations.of(context);
  switch (s) {
    case PrepSection.structure:
      return l10n.txtDsHowToStructure;
    case PrepSection.vocab:
      return l10n.txtDsWordsYouMightUse;
    case PrepSection.phrases:
      return l10n.txtDsTryUseThesePhrases;
    case PrepSection.grammar:
      return l10n.txtDsGrammarPatterns;
    case PrepSection.mistakes:
      return l10n.txtDsWatchOutFor;
    case PrepSection.example:
      return l10n.txtDsExampleAnswer;
  }
}

String _description(BuildContext context, PrepSection s) {
  final l10n = AppLocalizations.of(context);
  switch (s) {
    case PrepSection.structure:
      return l10n.txtDsPrepDescStructure;
    case PrepSection.vocab:
      return l10n.txtDsPrepDescVocab;
    case PrepSection.phrases:
      return l10n.txtDsPrepDescPhrases;
    case PrepSection.grammar:
      return l10n.txtDsPrepDescGrammar;
    case PrepSection.mistakes:
      return l10n.txtDsPrepDescMistakes;
    case PrepSection.example:
      return l10n.txtDsPrepDescExample;
  }
}

class _SectionTile extends StatelessWidget {
  const _SectionTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.recommended,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool recommended;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? colorScheme.primary.withValues(alpha: 0.06)
          : colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.55)
              : colorScheme.outlineVariant,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon,
                  size: 22,
                  color:
                      selected ? colorScheme.primary : colorScheme.onSurfaceVariant),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: PmpTextStyles.body1Semi
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                        if (recommended) ...[
                          const SizedBox(width: 8),
                          _RecommendedBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: PmpTextStyles.sub
                          .copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // A checkbox-style indicator that reads clearly in both states.
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color:
                    selected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecommendedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        AppLocalizations.of(context).txtDsRecommended,
        style: PmpTextStyles.subBold.copyWith(color: colorScheme.primary),
      ),
    );
  }
}
