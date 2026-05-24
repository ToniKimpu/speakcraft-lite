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
      'Welcome! Your English journey starts today. ðŸŒŸ',
      'Great to have you! Every expert was once a beginner. ðŸ˜Š',
      "Hello! Let's take the very first step together. ðŸš€",
    ],
    UserActivityMessageType.activeToday: [
      "You're on a roll today! Keep it up ðŸ’ª",
      "You've already practiced today â€” fantastic!",
      'Consistency is your superpower. You are doing it! âš¡',
    ],
    UserActivityMessageType.streakActive: [
      '{streak} day streak! Don\'t break the chain ðŸ”¥',
      "You've been consistent for {streak} days. Amazing! ðŸŒŸ",
      '{streak} days strong â€” keep the momentum going! ðŸ’ª',
    ],
    UserActivityMessageType.missedOneTwoDay: [
      'Welcome back! A short break is okay. Let\'s go! ðŸ˜Š',
      'You were missed! Ready to pick up where you left off?',
      'Back again! Every day forward counts. ðŸ“ˆ',
    ],
    UserActivityMessageType.missedThreeSevenDay: [
      "It's been a few days â€” no worries, a new streak starts now! ðŸ”„",
      "Every day is a fresh start. Let's learn something today ðŸŒ±",
      "You're back! Progress is progress, no matter the gap.",
    ],
    UserActivityMessageType.missedSevenPlusDay: [
      'Long time no see! Ready to get back on track? ðŸ’¡',
      "Your English is waiting â€” let's dive back in! ðŸ“š",
      'A fresh start is all you need. Welcome back! ðŸŽ‰',
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
    if (totalDays == 0) return '" Day 1 "';
    if (totalDays == 1) return '" Day 1 â€“ ðŸš€"';
    if (totalDays <= 7) return '" Day $totalDays â€“ ðŸ’ª"';
    if (totalDays <= 30) return '" Day $totalDays â€“ ðŸ”¥"';
    if (totalDays <= 60) return '" Day $totalDays â€“ ðŸŒŸ"';
    if (totalDays < 100) return '" Day $totalDays â€“ ðŸš€"';
    if (totalDays == 100) return '" Day 100 â€“ ðŸ†"';
    return '" Day $totalDays â€“ Keep Shining! âœ¨"';
  }

  static int _dayOfYear() {
    final now = DateTime.now();
    return now.difference(DateTime(now.year, 1, 1)).inDays + 1;
  }
}
