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
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsGuided)),
      body: SafeArea(
        child: BlocBuilder<GuidedLessonBloc, GuidedLessonState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
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
              loaded: (lessons) => _LoadedList(lessons: lessons),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}

class _LoadedList extends StatelessWidget {
  const _LoadedList({required this.lessons});
  final List<GuidedLesson> lessons;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final levels = lessons.map((l) => l.level).toSet().toList()..sort();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Text(
          l10n.txtDsGuidedIntro,
          style: PmpTextStyles.body2Regular.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        for (final level in levels) ...[
          _LevelHeader(level: level),
          const SizedBox(height: 10),
          for (final lesson in lessons.where((l) => l.level == level))
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _LessonCard(lesson: lesson),
            ),
          const SizedBox(height: 12),
        ],
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

class _LevelHeader extends StatelessWidget {
  const _LevelHeader({required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final accent = _accentForLevel(level);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          child: Text(
            AppLocalizations.of(context).txtDsGuidedLevel(level),
            style: PmpTextStyles.subBold.copyWith(color: accent),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Divider(color: colorScheme.outlineVariant, height: 1),
        ),
      ],
    );
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
