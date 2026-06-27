import 'package:flutter/material.dart';

import '../config/pmp_text_styles.dart';
import '../core/network/network_error.dart';

/// Reusable "couldn't load — try again" view for any screen that fetches remote
/// data. Decides its own copy/icon from the failure: a connectivity fault shows
/// an offline message, anything else a generic one. Pass [error] (an exception
/// or an `error.toString()` string) and let it classify, or force [isOffline].
///
/// Use the default (centered) variant to fill a page body, or [compact] for a
/// small inline slot (e.g. a subtitle strip).
class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({
    super.key,
    this.error,
    this.isOffline,
    this.onRetry,
    this.title,
    this.message,
    this.compact = false,
  });

  /// The raw failure (exception or message string) used to classify offline vs
  /// generic when [isOffline] is not given.
  final Object? error;

  /// Force the offline/generic styling instead of deriving it from [error].
  final bool? isOffline;

  /// Called when the user taps "Try again". Hidden when null.
  final VoidCallback? onRetry;

  /// Optional copy overrides.
  final String? title;
  final String? message;

  /// Smaller inline layout for tight slots.
  final bool compact;

  bool get _offline => isOffline ?? isOfflineError(error);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final offline = _offline;
    final icon = offline ? Icons.wifi_off_rounded : Icons.error_outline_rounded;
    final headline =
        title ?? (offline ? 'No internet connection' : 'Something went wrong');
    final body = message ??
        (offline
            ? 'Check your connection and try again.'
            : 'Please try again in a moment.');

    if (compact) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28, color: cs.onSurfaceVariant),
              const SizedBox(height: 8),
              Text(
                headline,
                textAlign: TextAlign.center,
                style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 4),
                TextButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Try again'),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
              ),
              child: Icon(icon, size: 48, color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 20),
            Text(
              headline,
              textAlign: TextAlign.center,
              style: PmpTextStyles.title2SemiBold.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              body,
              textAlign: TextAlign.center,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurfaceVariant, height: 1.5),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
