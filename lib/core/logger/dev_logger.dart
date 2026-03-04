 import 'package:flutter/foundation.dart';
  import 'app_logger.dart';

  class DevLogger extends AppLogger {
    @override
    void debug(String message, {String? tag}) =>
        debugPrint('[DEBUG][${tag ?? ''}] $message');

    @override
    void info(String message, {String? tag}) =>
        debugPrint('[INFO][${tag ?? ''}] $message');

    @override
    void warning(String message, {String? tag}) =>
        debugPrint('[WARN][${tag ?? ''}] $message');

    @override
    void error(String message, {Object? error, StackTrace? stackTrace,
  String? tag}) =>
        debugPrint('[ERROR][${tag ?? ''}] $message — $error\n$stackTrace');
  }