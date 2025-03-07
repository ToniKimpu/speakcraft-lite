import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_themes.dart';
import 'package:pmp_english/main.dart';
import 'package:pmp_english/main_providers.dart';

import 'l10n/generated/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PmpEnglishApp extends StatefulWidget {
  const PmpEnglishApp({super.key});

  @override
  State<PmpEnglishApp> createState() => _PmpEnglishAppState();
}

class _PmpEnglishAppState extends State<PmpEnglishApp> {
  late final StreamSubscription<String> _tokenStream;
  late final StreamSubscription _onMessageStream;

  void _setToken(String? token) {
    debugPrint('FCM Token: $token');
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getToken().then(
      (token) {
        _setToken(token);
        _tokenStream = FirebaseMessaging.instance.onTokenRefresh.listen(
          _setToken,
          onError: (e) {
            debugPrint('onTokenRefresh error: $e');
          },
        );
        _onMessageStream = FirebaseMessaging.onMessage.listen(
          (event) {
            showFlutterNotification(event);
          },
        );
      },
    ).onError(
      (error, stackTrace) {
        debugPrint('getToken onError: $error');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tokenStream.cancel();
    _onMessageStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: mainBlocProviders(),
      child: MaterialApp(
        title: 'PMP English App',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: PmpThemes.lightTechLearnTheme,
        darkTheme: PmpThemes.darkTechLearnTheme,
        themeMode: ThemeMode.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        onGenerateRoute: PmpRoutes.generateRoutes,
        initialRoute: PmpRoutes.splash,
        supportedLocales: const [
          Locale('en'),
        ],
        locale: const Locale('en'),
      ),
    );
  }
}
