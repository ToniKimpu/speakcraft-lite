import 'package:speakcraft/model/user_activity/user_activity_data.dart';

enum UserActivityMessageType {
  firstTime,
  activeToday,
  streakActive,
  missedOneTwoDay,
  missedThreeSevenDay,
  missedSevenPlusDay,
}

UserActivityMessageType resolveMessageType(UserActivityData data) {
  if (data.isFirstTimeUser) return UserActivityMessageType.firstTime;
  final gap = data.daysSinceLastActive;
  if (gap == null) return UserActivityMessageType.firstTime;
  if (gap == 0) return UserActivityMessageType.activeToday;
  if (gap == 1 && data.currentStreak > 1) return UserActivityMessageType.streakActive;
  if (gap <= 2) return UserActivityMessageType.missedOneTwoDay;
  if (gap <= 7) return UserActivityMessageType.missedThreeSevenDay;
  return UserActivityMessageType.missedSevenPlusDay;
}

class UserActivityMessages {
  UserActivityMessages._();

  static const Map<UserActivityMessageType, List<String>> _pool = {
    UserActivityMessageType.firstTime: [
      'Welcome! Your English journey starts today. 🌟',
      'Great to have you! Every expert was once a beginner. 😊',
      "Hello! Let's take the very first step together. 🚀",
    ],
    UserActivityMessageType.activeToday: [
      "You're on a roll today! Keep it up 💪",
      "You've already practiced today — fantastic!",
      'Consistency is your superpower. You are doing it! ⚡',
    ],
    UserActivityMessageType.streakActive: [
      '{streak} day streak! Don\'t break the chain 🔥',
      "You've been consistent for {streak} days. Amazing! 🌟",
      '{streak} days strong — keep the momentum going! 💪',
    ],
    UserActivityMessageType.missedOneTwoDay: [
      'Welcome back! A short break is okay. Let\'s go! 😊',
      'You were missed! Ready to pick up where you left off?',
      'Back again! Every day forward counts. 📈',
    ],
    UserActivityMessageType.missedThreeSevenDay: [
      "It's been a few days — no worries, a new streak starts now! 🔄",
      "Every day is a fresh start. Let's learn something today 🌱",
      "You're back! Progress is progress, no matter the gap.",
    ],
    UserActivityMessageType.missedSevenPlusDay: [
      'Long time no see! Ready to get back on track? 💡',
      "Your English is waiting — let's dive back in! 📚",
      'A fresh start is all you need. Welcome back! 🎉',
    ],
  };

  /// Returns a message deterministically rotated by day-of-year so it
  /// changes daily but never flickers mid-session on widget rebuilds.
  static String get(UserActivityMessageType type, {int streak = 0}) {
    final messages = _pool[type]!;
    final index = _dayOfYear() % messages.length;
    return messages[index].replaceAll('{streak}', streak.toString());
  }

  static String getDayTitle(int totalDays) {
    if (totalDays == 0) return 'Day 1';
    if (totalDays == 1) return 'Day 1 🚀';
    if (totalDays <= 7) return 'Day $totalDays 💪';
    if (totalDays <= 30) return 'Day $totalDays 🔥';
    if (totalDays <= 60) return 'Day $totalDays 🌟';
    if (totalDays < 100) return 'Day $totalDays 🚀';
    if (totalDays == 100) return 'Day 100 🏆';
    return 'Day $totalDays · Keep Shining! ✨';
  }

  static int _dayOfYear() {
    final now = DateTime.now();
    return now.difference(DateTime(now.year, 1, 1)).inDays + 1;
  }
}
