import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_topic_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/topic_progress.dart';
import 'package:speakcraft/services/share_preference_utils.dart';

/// P3 — suggested topic list. Material 3 TabBar (Beginner / Intermediate /
/// Advanced) plus a "New this week" horizontal rail above the tabs when there
/// are topics added in the last 7 days. Last-used tab is persisted across
/// launches via SharedPreferences so a returning learner lands back on the
/// level they were practicing.
class SuggestedTopicListPage extends StatelessWidget {
  const SuggestedTopicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DailySpeakingTopicBloc()..add(const DailySpeakingTopicEvent.load()),
      child: const _ListScaffold(),
    );
  }
}

class _ListScaffold extends StatefulWidget {
  const _ListScaffold();

  @override
  State<_ListScaffold> createState() => _ListScaffoldState();
}

class _ListScaffoldState extends State<_ListScaffold>
    with SingleTickerProviderStateMixin {
  static const String _lastTabKey = 'daily_speaking.suggested_last_tab';
  static const Duration _newWindow = Duration(days: 7);

  late final TabController _tabController;

  static const List<TopicDifficulty> _difficulties = [
    TopicDifficulty.beginner,
    TopicDifficulty.intermediate,
    TopicDifficulty.advanced,
  ];

  @override
  void initState() {
    super.initState();
    final saved = SharedPreferenceUtils.getInt(_lastTabKey);
    final initial = (saved != null && saved >= 0 && saved < _difficulties.length)
        ? saved
        : 0;
    _tabController = TabController(
      length: _difficulties.length,
      vsync: this,
      initialIndex: initial,
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    SharedPreferenceUtils.saveInt(_lastTabKey, _tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  bool _isNew(DailySpeakingTopic t) {
    final created = t.createdAt;
    if (created == null) return false;
    return DateTime.now().difference(created) < _newWindow;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsSuggestedTopics)),
      body: BlocBuilder<DailySpeakingTopicBloc, DailySpeakingTopicState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  msg,
                  style: PmpTextStyles.body2Regular,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            loaded: (topics, progress) {
              // The rail is a discovery surface — only ever-fresh, not-yet-
              // practiced topics belong there.
              final recent = topics
                  .where((t) => _isNew(t) && !progress.containsKey(t.id))
                  .toList()
                ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
              return Column(
                children: [
                  if (recent.isNotEmpty)
                    _NewThisWeekRail(topics: recent, isNew: _isNew),
                  // Pill selector (replaces the flat TabBar) — rebuilds as the
                  // controller moves, whether by tap or swipe.
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                    child: ListenableBuilder(
                      listenable: _tabController,
                      builder: (context, _) => _LevelPills(
                        selectedIndex: _tabController.index,
                        onSelected: (i) => _tabController.animateTo(i),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        for (final d in _difficulties)
                          _DifficultyList(
                            topics:
                                topics.where((t) => t.difficulty == d).toList(),
                            progress: progress,
                            accent: _accentFor(d),
                            isNew: _isNew,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

Color _accentFor(TopicDifficulty d) {
  switch (d) {
    case TopicDifficulty.beginner:
      return PmpColors.success500;
    case TopicDifficulty.intermediate:
      return PmpColors.warning500;
    case TopicDifficulty.advanced:
      return PmpColors.destructive400;
  }
}

String _difficultyLabel(BuildContext context, TopicDifficulty d) {
  final l10n = AppLocalizations.of(context);
  switch (d) {
    case TopicDifficulty.beginner:
      return l10n.txtDsLevelBeginner;
    case TopicDifficulty.intermediate:
      return l10n.txtDsLevelIntermediate;
    case TopicDifficulty.advanced:
      return l10n.txtDsLevelAdvanced;
  }
}

/// A pill/segmented level selector — replaces the flat underline TabBar. The
/// selected pill fills with that difficulty's accent (green → amber → red),
/// matching the guided list and reinforcing the difficulty ramp with color.
class _LevelPills extends StatelessWidget {
  const _LevelPills({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const List<TopicDifficulty> _levels = [
    TopicDifficulty.beginner,
    TopicDifficulty.intermediate,
    TopicDifficulty.advanced,
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < _levels.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _LevelPill(
              label: _difficultyLabel(context, _levels[i]),
              accent: _accentFor(_levels[i]),
              selected: i == selectedIndex,
              onTap: () => onSelected(i),
              colorScheme: colorScheme,
            ),
          ),
        ],
      ],
    );
  }
}

class _LevelPill extends StatelessWidget {
  const _LevelPill({
    required this.label,
    required this.accent,
    required this.selected,
    required this.onTap,
    required this.colorScheme,
  });

  final String label;
  final Color accent;
  final bool selected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 9),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? accent : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? accent : colorScheme.outlineVariant,
            ),
          ),
          child: Text(
            label,
            style: PmpTextStyles.labelSemi.copyWith(
              color: selected ? Colors.white : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _NewThisWeekRail extends StatelessWidget {
  const _NewThisWeekRail({required this.topics, required this.isNew});
  final List<DailySpeakingTopic> topics;
  final bool Function(DailySpeakingTopic) isNew;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Horizontal padding lives INSIDE the list (and on the header) rather than
    // on an outer wrapper — otherwise the outer inset shrinks the horizontal
    // ListView's viewport and cards get clipped at the edges while swiping.
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.auto_awesome,
                    size: 16, color: colorScheme.primary),
                const SizedBox(width: 6),
                Text(
                  AppLocalizations.of(context).txtDsNewThisWeek,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 132,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              clipBehavior: Clip.none,
              itemCount: topics.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final t = topics[index];
                return _RailCard(topic: t);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RailCard extends StatelessWidget {
  const _RailCard({required this.topic});
  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = _accentFor(topic.difficulty);
    return SizedBox(
      width: 230,
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              PmpRoutes.dailySpeakingSuggestedPrep,
              arguments: {'topic': topic},
            );
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: accent.withValues(alpha: 0.4)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent.withValues(alpha: 0.10),
                  colorScheme.surfaceContainerHighest,
                ],
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const _NewBadge(),
                    const SizedBox(width: 6),
                    _DifficultyChip(difficulty: topic.difficulty),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  topic.title,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: colorScheme.onSurface),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    topic.promptEn,
                    style: PmpTextStyles.label2Regular.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DifficultyList extends StatelessWidget {
  const _DifficultyList({
    required this.topics,
    required this.progress,
    required this.accent,
    required this.isNew,
  });
  final List<DailySpeakingTopic> topics;
  final Map<String, TopicProgress> progress;
  final Color accent;
  final bool Function(DailySpeakingTopic) isNew;

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            AppLocalizations.of(context).txtDsNoTopicsHere,
            style: PmpTextStyles.body2Regular.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Fresh topics float to the top (newest first); already-practiced topics
    // sink to the bottom under a "Practice again" header, most-recently-
    // practiced first. Practiced topics are never hidden — re-speaking is good
    // practice, and the list keeps feeling full.
    final unpracticed = topics
        .where((t) => !progress.containsKey(t.id))
        .toList()
      ..sort(_freshFirst);
    final practiced = topics
        .where((t) => progress.containsKey(t.id))
        .toList()
      ..sort((a, b) => progress[b.id]!
          .lastPracticedAt
          .compareTo(progress[a.id]!.lastPracticedAt));

    final children = <Widget>[
      for (final t in unpracticed)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _TopicCard(
            topic: t,
            accent: accent,
            showNewBadge: isNew(t),
            progress: progress[t.id],
          ),
        ),
      if (practiced.isNotEmpty) ...[
        const SizedBox(height: 4),
        _PracticeAgainHeader(count: practiced.length),
        const SizedBox(height: 8),
        for (final t in practiced)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _TopicCard(
              topic: t,
              accent: accent,
              showNewBadge: false,
              progress: progress[t.id],
            ),
          ),
      ],
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: children,
    );
  }

  int _freshFirst(DailySpeakingTopic a, DailySpeakingTopic b) {
    final aNew = isNew(a);
    final bNew = isNew(b);
    if (aNew != bNew) return aNew ? -1 : 1;
    final aDate = a.createdAt;
    final bDate = b.createdAt;
    if (aDate != null && bDate != null) return bDate.compareTo(aDate);
    if (aDate != null) return -1;
    if (bDate != null) return 1;
    return 0;
  }
}

class _PracticeAgainHeader extends StatelessWidget {
  const _PracticeAgainHeader({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.refresh, size: 16, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          AppLocalizations.of(context).txtDsPracticeAgain(count),
          style: PmpTextStyles.body2Semi
              .copyWith(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Divider(color: colorScheme.outlineVariant, height: 1),
        ),
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.topic,
    required this.accent,
    required this.showNewBadge,
    this.progress,
  });
  final DailySpeakingTopic topic;
  final Color accent;
  final bool showNewBadge;
  final TopicProgress? progress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mins = (topic.durationTargetSeconds / 60).round();
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PmpRoutes.dailySpeakingSuggestedPrep,
            arguments: {'topic': topic},
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.menu_book, size: 18, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            topic.title,
                            style: PmpTextStyles.body1Semi
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                        if (progress != null) ...[
                          const SizedBox(width: 8),
                          const _PracticedBadge(),
                        ] else if (showNewBadge) ...[
                          const SizedBox(width: 8),
                          const _NewBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.promptEn,
                      style: PmpTextStyles.label2Regular.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 14, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          AppLocalizations.of(context).txtDsApproxMin(mins),
                          style: PmpTextStyles.sub.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (topic.targetPhrases.isNotEmpty) ...[
                          const SizedBox(width: 12),
                          Icon(Icons.flag_outlined,
                              size: 14,
                              color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context).txtDsTargetPhraseCount(
                                topic.targetPhrases.length),
                            style: PmpTextStyles.sub.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        if (progress != null) ...[
                          const SizedBox(width: 12),
                          const Icon(Icons.star_rounded,
                              size: 14, color: PmpColors.success500),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)
                                .txtDsBestScore(progress!.bestScore),
                            style: PmpTextStyles.sub
                                .copyWith(color: PmpColors.success500),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        AppLocalizations.of(context).txtDsNew,
        style: PmpTextStyles.subBold.copyWith(
          color: colorScheme.onPrimary,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _PracticedBadge extends StatelessWidget {
  const _PracticedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: PmpColors.success500.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: PmpColors.success500.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, size: 12, color: PmpColors.success500),
          const SizedBox(width: 3),
          Text(
            AppLocalizations.of(context).txtDsPracticed,
            style: PmpTextStyles.subBold.copyWith(
              color: PmpColors.success500,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty});
  final TopicDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    final accent = _accentFor(difficulty);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Text(
        _difficultyLabel(context, difficulty),
        style: PmpTextStyles.subBold.copyWith(color: accent),
      ),
    );
  }
}
