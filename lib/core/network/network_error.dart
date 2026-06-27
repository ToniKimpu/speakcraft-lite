import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' show ClientException;

/// Single source of truth for "is this failure a connectivity problem?".
///
/// Returns true when [error] looks like a network-transport fault (no internet,
/// DNS failure, dropped connection, timeout) rather than a server/logic error.
/// Accepts either a raw exception object or an error *string* (BLoCs in this app
/// often surface `error.toString()`), so the string fallbacks matter.
bool isOfflineError(Object? error) {
  if (error == null) return false;
  if (error is SocketException) return true;
  if (error is TimeoutException) return true;
  if (error is HttpException) return true;
  if (error is ClientException) return true;

  final s = error.toString().toLowerCase();
  return s.contains('socketexception') ||
      s.contains('clientexception') ||
      s.contains('failed host lookup') ||
      s.contains('connection closed') ||
      s.contains('connection reset') ||
      s.contains('connection refused') ||
      s.contains('connection terminated') ||
      s.contains('network is unreachable') ||
      s.contains('software caused connection abort') ||
      s.contains('timed out') ||
      s.contains('timeout');
}
