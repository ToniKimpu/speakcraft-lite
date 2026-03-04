import 'package:firebase_crashlytics/firebase_crashlytics.dart';
  import 'app_logger.dart';

  class CrashlyticsLogger extends AppLogger {
    @override
    void debug(String message, {String? tag}) {}

    @override
    void info(String message, {String? tag}) {}

    @override
    void warning(String message, {String? tag}) {
      FirebaseCrashlytics.instance.log('[WARN][${tag ?? ''}] $message');
    }

    @override
    void error(String message, {Object? error, StackTrace? stackTrace,
  String? tag}) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: '[${tag ?? ''}] $message',
        fatal: false,
      );
    }
  }