import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:pmp_english/firebase_options-dev.dart';
import 'firebase_options-prod.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pmp_english/pmp_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/env.dart';
import 'global_app_state.dart';

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
  await _populateDeviceInfo();
  runApp(const PmpApp());
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
