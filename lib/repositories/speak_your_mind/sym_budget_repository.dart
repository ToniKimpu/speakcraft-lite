import '../../model/speak_your_mind/sym_feedback.dart';
import '../../services/supabase_service.dart';
import '../../shared_widgets/premium_gate.dart';

/// Reads the learner's *current* daily AI-feedback budget without making a
/// feedback call — so the write screen can show "N checks left today" up front.
///
/// Mirrors the `speak-your-mind-review` edge function's limit logic, but purely
/// from rows the user may already read (RLS: own `sym_usage` + the public
/// `sym_budget_config`). The server stays authoritative; this is display-only.
class SymBudgetRepository {
  static const _avgCallTokens = 1800; // ≈ 1 feedback "check"
  // Fallback defaults (match the edge function) if the config row is missing.
  static const _dFreeTrial = 10000;
  static const _dFree = 5000;
  static const _dTrialDays = 3;
  static const _dPremium = 15000;

  /// Today's budget, or null when it can't be determined (signed out, offline,
  /// table not deployed) — callers just hide the indicator in that case.
  Future<SymBudget?> fetchToday() async {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return null;
    try {
      final cfg = await supabase
          .from('sym_budget_config')
          .select('free_trial_daily, free_daily, trial_days, premium_daily')
          .eq('id', 1)
          .maybeSingle();
      final freeTrial = (cfg?['free_trial_daily'] as num?)?.toInt() ?? _dFreeTrial;
      final free = (cfg?['free_daily'] as num?)?.toInt() ?? _dFree;
      final trialDays = (cfg?['trial_days'] as num?)?.toInt() ?? _dTrialDays;
      final premium = (cfg?['premium_daily'] as num?)?.toInt() ?? _dPremium;

      final today = _yangonDate(DateTime.now());
      final usageRow = await supabase
          .from('sym_usage')
          .select('tokens')
          .eq('user_id', uid)
          .eq('usage_date', today)
          .maybeSingle();
      final used = (usageRow?['tokens'] as num?)?.toInt() ?? 0;

      final isPremium = hasPremiumAccess();
      int limit;
      if (isPremium) {
        limit = premium;
      } else {
        final firstRow = await supabase
            .from('sym_usage')
            .select('usage_date')
            .eq('user_id', uid)
            .order('usage_date', ascending: true)
            .limit(1)
            .maybeSingle();
        final firstUse = firstRow?['usage_date'] as String? ?? today;
        final inTrial = _daysBetween(firstUse, today) < trialDays;
        limit = inTrial ? freeTrial : free;
      }

      final remaining = (limit - used).clamp(0, limit);
      return SymBudget(
        used: used,
        limit: limit,
        remaining: remaining,
        checksLeft: remaining ~/ _avgCallTokens,
        isPremium: isPremium,
        resetAt: null,
      );
    } catch (_) {
      return null;
    }
  }

  /// The Asia/Yangon (UTC+6:30) calendar date, matching the edge function.
  String _yangonDate(DateTime d) {
    final y = d.toUtc().add(const Duration(hours: 6, minutes: 30));
    String two(int n) => n.toString().padLeft(2, '0');
    return '${y.year}-${two(y.month)}-${two(y.day)}';
  }

  int _daysBetween(String aDate, String bDate) {
    final a = DateTime.parse('${aDate}T00:00:00Z');
    final b = DateTime.parse('${bDate}T00:00:00Z');
    return (b.difference(a).inHours / 24).round();
  }
}
