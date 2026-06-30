import 'package:firebase_analytics/firebase_analytics.dart';

/// Thin wrapper over Firebase Analytics for the app's deliberate event set.
///
/// Logs feature usage + the premium conversion funnel — **never content or PII**
/// (only feature names, ids, and counts). All calls are fire-and-forget and
/// swallow errors, so analytics can never break a user flow.
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();

  final FirebaseAnalytics _fa = FirebaseAnalytics.instance;

  /// Auto-logs a `screen_view` for every named route — wire into
  /// `MaterialApp.navigatorObservers` so screen usage is tracked for free.
  late final FirebaseAnalyticsObserver navigatorObserver =
      FirebaseAnalyticsObserver(analytics: _fa);

  Future<void> _log(String name, [Map<String, Object>? params]) async {
    try {
      await _fa.logEvent(name: name, parameters: params);
    } catch (_) {
      // analytics must never surface to the user
    }
  }

  // ── Feature usage — "what's used most" ─────────────────────────────────────
  /// [feature] = sym | vocabulary | listening | grammar | saved_words …
  void featureOpen(String feature) => _log('feature_open', {'feature': feature});

  // ── Speak Your Mind depth — "does the loop complete?" ──────────────────────
  void symProduceSubmit(String topicId, int version) =>
      _log('sym_produce_submit', {'topic_id': topicId, 'version': version});
  void symFeedbackReceived(String topicId, int score) =>
      _log('sym_feedback_received', {'topic_id': topicId, 'score': score});
  void symGuideUsed(String topicId) =>
      _log('sym_guide_used', {'topic_id': topicId});
  void symSpeakAloudDone(String topicId) =>
      _log('sym_speak_aloud_done', {'topic_id': topicId});

  // ── Premium conversion funnel — "which wall sells premium?" ────────────────
  /// Shown when a free user taps a locked feature. [feature] names the lock.
  void premiumSheetShown(String feature) =>
      _log('premium_sheet_shown', {'feature': feature});

  /// An upgrade CTA was tapped → premium payment page. [source] = where from.
  void premiumUpgradeTapped(String source) =>
      _log('premium_upgrade_tapped', {'source': source});

  void paymentSubmitted(String method) =>
      _log('payment_submitted', {'method': method});
}
