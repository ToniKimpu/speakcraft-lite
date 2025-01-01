import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_themes.dart';
import 'package:pmp_english/main_providers.dart';

import 'l10n/generated/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PmpApp extends StatefulWidget {
  const PmpApp({super.key});

  @override
  State<PmpApp> createState() => _PmpAppState();
}

class _PmpAppState extends State<PmpApp> {
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
