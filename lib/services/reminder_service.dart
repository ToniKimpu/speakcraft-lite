import 'package:flutter/material.dart' show Color, TimeOfDay;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

import 'share_preference_utils.dart';

/// On-device daily study reminder — one repeating local notification at the
/// user's chosen time (inexact, so no exact-alarm permission needed). The
/// toggle + time are surfaced in onboarding and the profile page.
///
/// `FlutterLocalNotificationsPlugin()` is a singleton, so this reuses the same
/// instance `main.dart` initialised in `setupFlutterNotifications()`, and the
/// same Android channel (created there).
class ReminderService {
  ReminderService();

  static const int _id = 1001;
  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';
  static const String _channelDesc =
      'This channel is used for important notifications.';

  static const String kEnabled = 'reminder_enabled';
  static const String kHour = 'reminder_hour';
  static const String kMinute = 'reminder_minute';
  static const int defaultHour = 20; // 8:00 PM
  static const int defaultMinute = 0;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool get isEnabled => SharedPreferenceUtils.getBool(kEnabled) ?? false;

  TimeOfDay get time => TimeOfDay(
        hour: SharedPreferenceUtils.getInt(kHour) ?? defaultHour,
        minute: SharedPreferenceUtils.getInt(kMinute) ?? defaultMinute,
      );

  /// Persists the choice and schedules the daily reminder. Returns whether OS
  /// notification permission is granted — if false, the user must enable
  /// notifications in system settings for it to actually appear.
  Future<bool> enable(TimeOfDay t) async {
    final status = await Permission.notification.request();
    await SharedPreferenceUtils.saveInt(kHour, t.hour);
    await SharedPreferenceUtils.saveInt(kMinute, t.minute);
    await SharedPreferenceUtils.saveBool(kEnabled, true);
    await _schedule(t);
    return status.isGranted;
  }

  Future<void> disable() async {
    await SharedPreferenceUtils.saveBool(kEnabled, false);
    await _plugin.cancel(_id);
  }

  /// Re-applies the schedule on app start when enabled — covers reboots and
  /// app updates (belt-and-suspenders alongside the boot receiver).
  Future<void> reschedule() async {
    if (isEnabled) await _schedule(time);
  }

  Future<void> _schedule(TimeOfDay t) async {
    await _plugin.cancel(_id);
    final now = tz.TZDateTime.now(tz.local);
    var when = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, t.hour, t.minute);
    if (!when.isAfter(now)) {
      when = when.add(const Duration(days: 1));
    }
    await _plugin.zonedSchedule(
      _id,
      'Time to practice 🎧',
      'အင်္ဂလိပ်စာ ခဏလေး လေ့ကျင့်ရအောင် — သင့် streak ဆက်ထိန်းပါ။',
      when,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDesc,
          icon: 'ic_notification',
          color: Color(0xFF0496C7), // brand cyan
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      // Repeats every day at this time.
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily_reminder',
    );
  }
}
