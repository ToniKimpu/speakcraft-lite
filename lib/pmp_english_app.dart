import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_themes.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/services/theme_controller.dart';
import 'package:pmp_english/main.dart';
import 'package:pmp_english/main_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc/internet_checker/internet_checker_bloc.dart';
import 'l10n/generated/l10n.dart';
import 'services/supabase_service.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class PmpEnglishApp extends StatefulWidget {
  const PmpEnglishApp({super.key});

  @override
  State<PmpEnglishApp> createState() => _PmpEnglishAppState();
}

class _PmpEnglishAppState extends State<PmpEnglishApp> {
  late final StreamSubscription<String> _tokenStream;
  late final StreamSubscription _onMessageStream;
  late final StreamSubscription _onAuthStateChangedStream;
  late final InternetConnectionChecker _connectionChecker;
  late final StreamSubscription<InternetConnectionStatus>
      _connectionStatusSubscription;
  User? _currentUser;

  void _setToken(String? token) {
    AppLogger.instance.debug('FCM Token: $token');
  }

  @override
  void initState() {
    super.initState();
    _connectionChecker = InternetConnectionChecker.createInstance(
      addresses: [
        AddressCheckOption(
          uri: Uri.parse(dotenv.env['SUPABASE_URL'] ?? ''),
        ),
      ],
      slowConnectionConfig: const SlowConnectionConfig(
        enableToCheckForSlowConnection: true,
        slowConnectionThreshold: Duration(seconds: 3),
      ),
    );
    FirebaseMessaging.instance.getToken().then(
      (token) {
        _setToken(token);
        _tokenStream = FirebaseMessaging.instance.onTokenRefresh.listen(
          _setToken,
          onError: (e) {
            AppLogger.instance.error('onTokenRefresh error: $e', error: e);
          },
        );
        _onMessageStream = FirebaseMessaging.onMessage.listen(
          (event) {
            showFlutterNotification(event);
          },
        );
        _onAuthStateChangedStream = supabase.auth.onAuthStateChange.listen(
          (event) async {
            if (event.event == AuthChangeEvent.signedOut) {
              await FirebaseMessaging.instance.unsubscribeFromTopic(
                'all-new-contents',
              );
              AppLogger.instance.debug('tp user unsubscribe: ${_currentUser?.id}');
              await FirebaseMessaging.instance.unsubscribeFromTopic(
                '${_currentUser?.id}',
              );
            } else if (event.session != null) {
              if (event.session?.user.id != null) {
                _currentUser = event.session!.user;
              }
              await FirebaseMessaging.instance
                  .subscribeToTopic('${_currentUser?.id}');
              await FirebaseMessaging.instance
                  .subscribeToTopic("all-new-contents");
            }
          },
        )..onError((e) {
            AppLogger.instance.error('Auth state change error: ${e.toString()}', error: e);
          });
      },
    ).onError(
      (error, stackTrace) {
        AppLogger.instance.error('getToken onError: $error', error: error);
      },
    );
    _setupConnectionListener();
  }

  @override
  void dispose() {
    super.dispose();
    _tokenStream.cancel();
    _onMessageStream.cancel();
    _onAuthStateChangedStream.cancel();
    _connectionChecker.dispose();
    _connectionStatusSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: mainBlocProviders(),
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: sl<ThemeController>(),
        builder: (context, themeMode, _) {
          return MaterialApp(
            title: 'PMP English App',
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: PmpThemes.lightTheme,
            darkTheme: PmpThemes.darkTheme,
            themeMode: themeMode,
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
          );
        },
      ),
    );
  }

  void _setupConnectionListener() {
    _connectionStatusSubscription = _connectionChecker.onStatusChange.listen(
      (InternetConnectionStatus status) {
        final navigatorState = _navigatorKey.currentState;
        final context = navigatorState?.context;
        final checkInternetBloc = context?.read<InternetCheckerBloc>();
        AppLogger.instance.debug("_hratnaengApp: ${status.toString()} connection state!");
        if (status == InternetConnectionStatus.connected ||
            status == InternetConnectionStatus.slow) {
          sl<ValueNotifier<bool>>(instanceName: 'isOnline').value = true;
          checkInternetBloc?.add(
            const InternetCheckerEvent.internetAccess(),
          );
          AppLogger.instance.debug('_connectionStatus: Connected to the internet');
        } else {
          sl<ValueNotifier<bool>>(instanceName: 'isOnline').value = false;
          checkInternetBloc?.add(
            const InternetCheckerEvent.noInternetAccess(),
          );
          AppLogger.instance.debug('_connectionStatus: Disconnected from the internet');
        }
      },
    );
  }
}
