import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pmp_english/firebase_options_dev.dart';
import 'package:pmp_english/pmp_english_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/env.dart';
import 'firebase_options_prod.dart';
import 'global_app_state.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  const env = String.fromEnvironment('flavor', defaultValue: 'dev');
  final firebaseOption = getOption(env);
  await Firebase.initializeApp(
    options: firebaseOption ?? DefaultFirebaseOptionsDev.currentPlatform,
  );
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
    onDidReceiveNotificationResponse: (details) {
      // _onNotificationTapEnter(
      //   navigatorKey.currentState!.context,
      //   details.payload,
      // );
    },
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

void showFlutterNotification(RemoteMessage message) {
  if (kIsWeb) return;
  RemoteNotification? notification = message.notification;
  // final data = message.data;
  final data = {
    'title': notification?.title,
    'body': notification?.body,
  };

  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          priority: Priority.max,
          importance: Importance.max,
          // icon: 'ic_notification',
          playSound: true,
        ),
      ),
      payload: jsonEncode(data));
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

getOption(String env) => env == 'dev'
    ? DefaultFirebaseOptionsDev.currentPlatform
    : env == 'prod'
        ? DefaultFirebaseOptions.currentPlatform
        : null;

void main() async {
  const env = String.fromEnvironment('flavor', defaultValue: 'dev');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.envs/.env.$env');
  await Supabase.initialize(
    url: Env.supabaseURL,
    anonKey: Env.supabaseAnonKey,
  );

  await Firebase.initializeApp(
    options: getOption(env),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await _populateDeviceInfo();
  await setupFlutterNotifications();
  runApp(const PmpEnglishApp());
}

Future<void> _populateDeviceInfo() async {
  final di = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidDeviceInfo = await di.androidInfo;
    GlobalAppState().deviceID = androidDeviceInfo.id;
  } else {
    final iosDeviceInfo = await di.iosInfo;
    GlobalAppState().deviceID = iosDeviceInfo.identifierForVendor;
  }
}
