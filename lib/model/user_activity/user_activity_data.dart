class UserActivityData {
  const UserActivityData({
    required this.totalLearningDays,
    required this.currentStreak,
    required this.lastActiveDate,
    required this.isFirstTimeUser,
  });

  final int totalLearningDays;
  final int currentStreak;
  final DateTime? lastActiveDate;
  final bool isFirstTimeUser;

  /// Whole calendar days since the last qualifying session, or null if never active.
  int? get daysSinceLastActive {
    if (lastActiveDate == null) return null;
    final today = _todayNormalized();
    return today.difference(lastActiveDate!).inDays;
  }

  static DateTime _todayNormalized() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
