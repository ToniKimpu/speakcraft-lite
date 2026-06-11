import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

import 'widgets/session_limit_banner.dart';

// DEBUG: bumped from 3 → 100 so the client-side cap doesn't block testing.
// The real budget is enforced server-side anyway (this is decorative). Restore
// to 3 before release.
const int kDailySessionLimit = 100;

/// Daily Speaking landing page. Three on-ramps, all leading to the same
/// voice-feedback flow: Just talk, Own topic, and Suggested topic. Each on-ramp
/// can capture via the live mic OR by importing an existing recording (the
/// "Import a recording instead" option on each record page) — import is a
/// capture method, not a separate on-ramp. It's speaking practice — no text path.
class DailySpeakingEntryPage extends StatefulWidget {
  const DailySpeakingEntryPage({super.key});

  @override
  State<DailySpeakingEntryPage> createState() => _DailySpeakingEntryPageState();
}

class _DailySpeakingEntryPageState extends State<DailySpeakingEntryPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<DailySpeakingHistoryBloc>()
        .add(const DailySpeakingHistoryEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.txtDailySpeaking),
        actions: [
          IconButton(
            tooltip: l10n.txtDsHistory,
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, PmpRoutes.dailySpeakingHistory);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DailySpeakingHistoryBloc, DailySpeakingHistoryState>(
          builder: (context, state) {
            final used = state.maybeWhen(
              loaded: (_, sessionsToday) => sessionsToday,
              orElse: () => 0,
            );
            final exhausted = used >= kDailySessionLimit;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.txtDsHeadline,
                    style: PmpTextStyles.h1.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'ArchivoBlack Regular',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.txtDsSubhead,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SessionLimitBanner(dailyLimit: kDailySessionLimit),
                  const SizedBox(height: 24),
                  _OnRampCard(
                    title: l10n.txtDsJustTalk,
                    subtitle: l10n.txtDsJustTalkDesc,
                    icon: Icons.mic,
                    accentColor: colorScheme.primary,
                    enabled: !exhausted,
                    badge: exhausted ? l10n.txtDsLimitReached : null,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PmpRoutes.dailySpeakingJustRecord,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _OnRampCard(
                    title: l10n.txtDsOwnTopic,
                    subtitle: l10n.txtDsOwnTopicDesc,
                    icon: Icons.edit_note,
                    accentColor: colorScheme.secondary,
                    enabled: !exhausted,
                    badge: exhausted ? l10n.txtDsLimitReached : null,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PmpRoutes.dailySpeakingOwnTopicPrep,
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _OnRampCard(
                    title: l10n.txtDsSuggestedTopic,
                    subtitle: l10n.txtDsSuggestedTopicDesc,
                    icon: Icons.menu_book,
                    accentColor: colorScheme.tertiary,
                    enabled: !exhausted,
                    badge: exhausted ? l10n.txtDsLimitReached : null,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PmpRoutes.dailySpeakingSuggestedList,
                      );
                    },
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

class _OnRampCard extends StatelessWidget {
  const _OnRampCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.enabled,
    required this.onTap,
    this.badge,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final bool enabled;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final disabledOpacity = enabled ? 1.0 : 0.5;
    return Opacity(
      opacity: disabledOpacity,
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: enabled ? accentColor : colorScheme.outlineVariant,
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: accentColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: PmpTextStyles.body1Semi.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (badge != null) _Badge(text: badge!),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: PmpTextStyles.label2Regular.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: enabled
                      ? accentColor
                      : colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: PmpTextStyles.sub.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
