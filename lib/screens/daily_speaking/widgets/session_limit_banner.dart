import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

/// "N of 3 sessions today" banner.
///
/// Decorative only: the real budget enforcement lives in the edge function.
/// Once the live API is in, replace the `sessionsToday` from local Drift with
/// the server-returned `sessions_remaining`.
class SessionLimitBanner extends StatelessWidget {
  const SessionLimitBanner({super.key, this.dailyLimit = 3});

  final int dailyLimit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailySpeakingHistoryBloc, DailySpeakingHistoryState>(
      builder: (context, state) {
        final used = state.maybeWhen(
          loaded: (_, sessionsToday) => sessionsToday,
          orElse: () => 0,
        );
        final remaining = (dailyLimit - used).clamp(0, dailyLimit);
        final colorScheme = Theme.of(context).colorScheme;
        final exhausted = remaining == 0;
        final fg = exhausted ? colorScheme.error : colorScheme.primary;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: fg.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Icon(
                exhausted ? Icons.lock_clock : Icons.check_circle_outline,
                size: 18,
                color: fg,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  exhausted
                      ? AppLocalizations.of(context).txtDsDailyLimitReached
                      : AppLocalizations.of(context)
                          .txtDsSessionsToday(used, dailyLimit),
                  style: PmpTextStyles.labelSemi.copyWith(color: fg),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
