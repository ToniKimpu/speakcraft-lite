import 'package:flutter/material.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

class GlobalAppState {
  static final GlobalAppState _instance = GlobalAppState._internal();
  factory GlobalAppState() => _instance;
  GlobalAppState._internal();

  String? deviceID;
  static const int maxTotalTokens = 500000;
  final ValueNotifier<AppUser> _currentUser =
      ValueNotifier<AppUser>(AppUser.empty());
  AppUser get currentUser => _currentUser.value;
  ValueNotifier<AppUser> get currentUserNotifier => _currentUser;
  set currentUser(AppUser user) => _currentUser.value = user;
  bool tokenAvailable() => _currentUser.value.totalTokenUsed < maxTotalTokens;
  bool isOnline = true;
}
