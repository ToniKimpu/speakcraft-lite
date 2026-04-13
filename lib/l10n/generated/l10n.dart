// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Okay`
  String get txtOk {
    return Intl.message('Okay', name: 'txtOk', desc: '', args: []);
  }

  /// `Cancel`
  String get txtCancel {
    return Intl.message('Cancel', name: 'txtCancel', desc: '', args: []);
  }

  /// `Coming Soon`
  String get txtComingSoon {
    return Intl.message(
      'Coming Soon',
      name: 'txtComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `မကြာခင်တင်ပေးပါမည်`
  String get txtWillUploadSoon {
    return Intl.message(
      'မကြာခင်တင်ပေးပါမည်',
      name: 'txtWillUploadSoon',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get txtName {
    return Intl.message('Name', name: 'txtName', desc: '', args: []);
  }

  /// `Change Name`
  String get txtChangeName {
    return Intl.message(
      'Change Name',
      name: 'txtChangeName',
      desc: '',
      args: [],
    );
  }

  /// `Change Avatar`
  String get txtChangeAvatar {
    return Intl.message(
      'Change Avatar',
      name: 'txtChangeAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Account ID`
  String get txtAccountID {
    return Intl.message('Account ID', name: 'txtAccountID', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get txtPrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'txtPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Content Request`
  String get txtContentRequest {
    return Intl.message(
      'Content Request',
      name: 'txtContentRequest',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get txtFeedback {
    return Intl.message('Feedback', name: 'txtFeedback', desc: '', args: []);
  }

  /// `View Explanation`
  String get txtViewExplanation {
    return Intl.message(
      'View Explanation',
      name: 'txtViewExplanation',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
