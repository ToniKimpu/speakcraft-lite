class UserActivityPrefsKeys {
  UserActivityPrefsKeys._();

  /// ISO-8601 date string of the very first app open. Null = never set.
  static const String firstOpenDate = 'ua_first_open_date';

  /// ISO-8601 date string of the last calendar day on which a qualifying
  /// session (>= 1 minute) was completed.
  static const String lastActiveDate = 'ua_last_active_date';

  /// Total count of calendar days that had at least one qualifying session.
  static const String totalLearningDays = 'ua_total_learning_days';

  /// Current consecutive-day streak count.
  static const String currentStreak = 'ua_current_streak';
}
