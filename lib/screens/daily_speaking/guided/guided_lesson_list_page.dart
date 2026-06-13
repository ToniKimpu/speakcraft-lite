import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/guided_lesson_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/guided_lesson.dart';

/// The guided on-ramp's lesson list ("Start here"). Lessons are grouped by
/// level (1 → 3) under section headers; the scaffold fades as the level rises,
/// so beginners naturally climb. Tapping a lesson opens the I-do/We-do/You-do
/// wizard (`guided_lesson_page.dart`).
class GuidedLessonListPage extends StatelessWidget {
  const GuidedLessonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuidedLessonBloc()..add(const GuidedLessonEvent.load()),
      child: const _ListScaffold(),
    );
  }
}

class _ListScaffold extends StatelessWidget {
  const _ListScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocBuilder<GuidedLessonBloc, GuidedLessonState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (lessons) => _GuidedTabs(lessons: lessons),
          error: (msg) => Scaffold(
            appBar: AppBar(title: Text(l10n.txtDsGuided)),
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    msg,
                    style: PmpTextStyles.body2Regular,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          orElse: () => Scaffold(
            appBar: AppBar(title: Text(l10n.txtDsGuided)),
            body: const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

/// Lessons grouped under one tab per level (1 → 3), mirroring the Suggested
/// Topics list. Each tab is a short scroll of that level's cards instead of one
/// long stack — and the tabs make the L1 → L3 climb explicit. Defaults to the
/// first (lowest) level so beginners land on "Start here".
class _GuidedTabs extends StatefulWidget {
  const _GuidedTabs({required this.lessons});
  final List<GuidedLesson> lessons;

  @override
  State<_GuidedTabs> createState() => _GuidedTabsState();
}

class _GuidedTabsState extends State<_GuidedTabs>
    with SingleTickerProviderStateMixin {
  late final List<int> _levels;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _levels = widget.lessons.map((l) => l.level).toSet().toList()..sort();
    _tabController = TabController(length: _levels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsGuided)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                l10n.txtDsGuidedIntro,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              // Rebuilds as the selection (tap) or a swipe moves the controller.
              child: ListenableBuilder(
                listenable: _tabController,
                builder: (context, _) => _LevelSegments(
                  levels: _levels,
                  selectedIndex: _tabController.index,
                  onSelected: (i) => _tabController.animateTo(i),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  for (final level in _levels)
                    _LevelLessonList(
                      lessons: widget.lessons
                          .where((l) => l.level == level)
                          .toList(growable: false),
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

/// A pill/segmented selector for the levels — replaces the flat underline
/// TabBar. The selected pill fills with that level's accent (green → amber →
/// red), making the active level obvious and reinforcing the L1 → L3 climb.
class _LevelSegments extends StatelessWidget {
  const _LevelSegments({
    required this.levels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<int> levels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < levels.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _LevelSegment(
              label: l10n.txtDsGuidedLevel(levels[i]),
              accent: _accentForLevel(levels[i]),
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

class _LevelSegment extends StatelessWidget {
  const _LevelSegment({
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
          decoration: BoxDecoration(
            color: selected ? accent : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: selected ? accent : colorScheme.outlineVariant,
            ),
          ),
          alignment: Alignment.center,
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

class _LevelLessonList extends StatelessWidget {
  const _LevelLessonList({required this.lessons});
  final List<GuidedLesson> lessons;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        for (final lesson in lessons)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _LessonCard(lesson: lesson),
          ),
      ],
    );
  }
}

Color _accentForLevel(int level) {
  switch (level) {
    case 1:
      return PmpColors.success500;
    case 2:
      return PmpColors.warning500;
    default:
      return PmpColors.destructive400;
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({required this.lesson});
  final GuidedLesson lesson;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = _accentForLevel(lesson.level);
    final mins = (lesson.durationTargetSeconds / 60).round().clamp(1, 99);
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PmpRoutes.dailySpeakingGuidedLesson,
            arguments: {'lesson': lesson},
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
                child: Icon(Icons.school_outlined, size: 18, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.objectiveEn,
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
