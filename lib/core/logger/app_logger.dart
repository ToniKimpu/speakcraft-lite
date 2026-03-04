abstract class AppLogger {
  static AppLogger? _instance;
  static AppLogger get instance => _instance!;

  static void init(AppLogger logger) => _instance = logger;

  void debug(String message, {String? tag});
  void info(String message, {String? tag});
  void warning(String message, {String? tag});
  void error(String message,
      {Object? error, StackTrace? stackTrace, String? tag});
}
