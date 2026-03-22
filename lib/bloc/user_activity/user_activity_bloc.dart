import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/user_activity/user_activity_data.dart';
import 'package:pmp_english/services/share_preference_utils.dart';
import 'package:pmp_english/services/user_activity_prefs_keys.dart';

part 'user_activity_bloc.freezed.dart';

@freezed
abstract class UserActivityEvent with _$UserActivityEvent {
  /// Dispatched in initState of HomePage — loads persisted data and
  /// computes the current state (including streak reset if needed).
  const factory UserActivityEvent.initialize() = _Initialize;

  /// Dispatched after the user has been on the home screen for >= 1 minute.
  /// Records the session if it is the first qualifying session today.
  const factory UserActivityEvent.recordSession() = _RecordSession;
}

@freezed
abstract class UserActivityState with _$UserActivityState {
  const factory UserActivityState.initial() = _Initial;
  const factory UserActivityState.loading() = _Loading;
  const factory UserActivityState.loaded(UserActivityData data) = _Loaded;

  /// Emitted after a qualifying session is recorded (or confirmed idempotent).
  const factory UserActivityState.sessionRecorded(UserActivityData data) =
      _SessionRecorded;

  const factory UserActivityState.error(String message) = _Error;
}

class UserActivityBloc extends Bloc<UserActivityEvent, UserActivityState> {
  UserActivityBloc() : super(const UserActivityState.initial()) {
    on<UserActivityEvent>((event, emit) async {
      await event.when(
        initialize: () => _initialize(emit),
        recordSession: () => _recordSession(emit),
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Handlers
  // ---------------------------------------------------------------------------

  Future<void> _initialize(Emitter<UserActivityState> emit) async {
    try {
      emit(const UserActivityState.loading());
      final today = _todayNormalized();

      // First-time detection
      final firstOpenRaw =
          SharedPreferenceUtils.getString(UserActivityPrefsKeys.firstOpenDate);
      if (firstOpenRaw == null) {
        await SharedPreferenceUtils.saveString(
          UserActivityPrefsKeys.firstOpenDate,
          today.toIso8601String(),
        );
        emit(const UserActivityState.loaded(
          UserActivityData(
            totalLearningDays: 0,
            currentStreak: 0,
            lastActiveDate: null,
            isFirstTimeUser: true,
          ),
        ));
        return;
      }

      // Returning user — load persisted values
      var data = _readFromPrefs();

      // Reset streak if the user missed more than one consecutive calendar day
      if (data.lastActiveDate != null) {
        final gap = today.difference(data.lastActiveDate!).inDays;
        if (gap > 1) {
          await SharedPreferenceUtils.saveInt(
              UserActivityPrefsKeys.currentStreak, 0);
          data = UserActivityData(
            totalLearningDays: data.totalLearningDays,
            currentStreak: 0,
            lastActiveDate: data.lastActiveDate,
            isFirstTimeUser: false,
          );
        }
      }

      emit(UserActivityState.loaded(data));
    } catch (e, st) {
      AppLogger.instance.error(
        'UserActivityBloc._initialize failed',
        error: e,
        stackTrace: st,
      );
      emit(UserActivityState.error(e.toString()));
    }
  }

  Future<void> _recordSession(Emitter<UserActivityState> emit) async {
    try {
      final today = _todayNormalized();
      final data = _readFromPrefs();

      // Idempotency guard — do not count the same calendar day twice
      if (data.lastActiveDate != null &&
          data.lastActiveDate!.isAtSameMomentAs(today)) {
        emit(UserActivityState.sessionRecorded(data));
        return;
      }

      final gap = data.lastActiveDate == null
          ? null
          : today.difference(data.lastActiveDate!).inDays;

      final int newStreak;
      if (gap == null) {
        newStreak = 1; // very first session ever
      } else if (gap == 1) {
        newStreak = data.currentStreak + 1; // consecutive day
      } else {
        newStreak = 1; // streak already reset in _initialize; start fresh
      }

      final newTotalDays = data.totalLearningDays + 1;

      await Future.wait([
        SharedPreferenceUtils.saveString(
          UserActivityPrefsKeys.lastActiveDate,
          today.toIso8601String(),
        ),
        SharedPreferenceUtils.saveInt(
            UserActivityPrefsKeys.currentStreak, newStreak),
        SharedPreferenceUtils.saveInt(
            UserActivityPrefsKeys.totalLearningDays, newTotalDays),
      ]);

      final updated = UserActivityData(
        totalLearningDays: newTotalDays,
        currentStreak: newStreak,
        lastActiveDate: today,
        isFirstTimeUser: false,
      );

      emit(UserActivityState.sessionRecorded(updated));
      AppLogger.instance.debug(
        'UserActivityBloc: session recorded — day $newTotalDays, streak $newStreak',
      );
    } catch (e, st) {
      // Silent failure — the session timer is a background action; no UI error.
      AppLogger.instance.error(
        'UserActivityBloc._recordSession failed',
        error: e,
        stackTrace: st,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  UserActivityData _readFromPrefs() {
    final lastRaw =
        SharedPreferenceUtils.getString(UserActivityPrefsKeys.lastActiveDate);
    final totalDays =
        SharedPreferenceUtils.getInt(UserActivityPrefsKeys.totalLearningDays) ??
            0;
    final streak =
        SharedPreferenceUtils.getInt(UserActivityPrefsKeys.currentStreak) ?? 0;
    final lastActiveDate =
        lastRaw != null ? DateTime.parse(lastRaw) : null;

    return UserActivityData(
      totalLearningDays: totalDays,
      currentStreak: streak,
      lastActiveDate: lastActiveDate,
      isFirstTimeUser: false,
    );
  }

  static DateTime _todayNormalized() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
