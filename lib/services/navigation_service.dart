import 'package:flutter/material.dart';

/// App-wide navigator key, shared by [MaterialApp] and out-of-context callers
/// (e.g. the notification-tap handler in main.dart that routes to a screen
/// without a [BuildContext]).
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
