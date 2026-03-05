import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:pmp_english/firebase_options.dart';
import 'package:pmp_english/firebase_options_dev.dart';
import 'package:pmp_english/pmp_english_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/env.dart';
import 'core/di/service_locator.dart';
import 'services/share_preference_utils.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/core/logger/dev_logger.dart';
import 'package:pmp_english/core/logger/crashlytics_logger.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  const env = String.fromEnvironment('flavor', defaultValue: 'dev');
  final firebaseOption = getOption(env);
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: firebaseOption ?? DefaultFirebaseOptionsDev.currentPlatform,
    );
  }
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    debugPrint('about to abord noti init, already initialized.');
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (details) {},
  );

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final response = await get(Uri.parse(url));
  return response.bodyBytes;
}

Future<void> showFlutterNotification(RemoteMessage message) async {
  if (kIsWeb) return;
  RemoteNotification? notification = message.notification;
  final data = message.data;
  ByteArrayAndroidBitmap? bigPicture;
  if (data['poster_image'] != null) {
    final imageResponse = await _getByteArrayFromUrl(data['poster_image']);
    bigPicture = ByteArrayAndroidBitmap(imageResponse);
  }
  flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    data['title'],
    data['message'],
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        priority: Priority.max,
        importance: Importance.max,
        icon: 'ic_notification',
        playSound: true,
        largeIcon: bigPicture,
        styleInformation: bigPicture == null
            ? null
            : BigPictureStyleInformation(
                bigPicture,
              ),
      ),
    ),
    payload: jsonEncode(message.data),
  );
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

getOption(String env) => env == 'dev'
    ? DefaultFirebaseOptionsDev.currentPlatform
    : env == 'prod'
        ? DefaultFirebaseOptions.currentPlatform
        : null;

void main() {
  runZonedGuarded(() async {
    const env = String.fromEnvironment('flavor', defaultValue: 'dev');
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.envs/.env.$env');
    Env.validate();
    await Supabase.initialize(
      url: Env.supabaseURL,
      anonKey: Env.supabaseAnonKey,
    );
    AppLogger.init(env == 'prod' ? CrashlyticsLogger() : DevLogger());

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: getOption(env),
      );
    }

    // Only collect crash reports in production
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(env == 'prod');

    // Catch Flutter framework errors (e.g. widget build errors)
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Catch platform/async errors outside the Flutter framework
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await setupServiceLocator();
    await SharedPreferenceUtils.init();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _populateDeviceInfo();
    await setupFlutterNotifications();
    runApp(const PmpEnglishApp());
  }, (error, stack) {
    // Catch any errors that escape the async zone
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

Future<void> _populateDeviceInfo() async {
  final di = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidDeviceInfo = await di.androidInfo;
    sl<ValueNotifier<String?>>(instanceName: 'deviceId').value = androidDeviceInfo.id;
  } else {
    final iosDeviceInfo = await di.iosInfo;
    sl<ValueNotifier<String?>>(instanceName: 'deviceId').value = iosDeviceInfo.identifierForVendor;
  }
}
