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

  /// `Log out`
  String get txtLogout {
    return Intl.message('Log out', name: 'txtLogout', desc: '', args: []);
  }

  /// `Log out?`
  String get txtLogoutConfirmTitle {
    return Intl.message(
      'Log out?',
      name: 'txtLogoutConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `You'll need to sign in again to continue learning.`
  String get txtLogoutConfirmMessage {
    return Intl.message(
      'You\'ll need to sign in again to continue learning.',
      name: 'txtLogoutConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't log out. Please try again.`
  String get txtLogoutFailed {
    return Intl.message(
      'Couldn\'t log out. Please try again.',
      name: 'txtLogoutFailed',
      desc: '',
      args: [],
    );
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

  /// `Verify your email`
  String get txtVerifyEmailTitle {
    return Intl.message(
      'Verify your email',
      name: 'txtVerifyEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit code we sent to {email}`
  String txtOtpSentTo(String email) {
    return Intl.message(
      'Enter the 6-digit code we sent to $email',
      name: 'txtOtpSentTo',
      desc: '',
      args: [email],
    );
  }

  /// `6-digit code`
  String get txtOtpFieldLabel {
    return Intl.message(
      '6-digit code',
      name: 'txtOtpFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get txtVerify {
    return Intl.message('Verify', name: 'txtVerify', desc: '', args: []);
  }

  /// `Didn't get the code?`
  String get txtDidntGetCode {
    return Intl.message(
      'Didn\'t get the code?',
      name: 'txtDidntGetCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get txtResendCode {
    return Intl.message(
      'Resend code',
      name: 'txtResendCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend in {seconds}s`
  String txtResendInSeconds(int seconds) {
    return Intl.message(
      'Resend in ${seconds}s',
      name: 'txtResendInSeconds',
      desc: '',
      args: [seconds],
    );
  }

  /// `A new code has been sent`
  String get txtCodeResent {
    return Intl.message(
      'A new code has been sent',
      name: 'txtCodeResent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the 6-digit code`
  String get txtEnterValidCode {
    return Intl.message(
      'Please enter the 6-digit code',
      name: 'txtEnterValidCode',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get txtContinueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'txtContinueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get txtOr {
    return Intl.message('or', name: 'txtOr', desc: '', args: []);
  }

  /// `Forgot password?`
  String get txtForgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'txtForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get txtForgotPasswordTitle {
    return Intl.message(
      'Reset password',
      name: 'txtForgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your account email and we'll send you a 6-digit code.`
  String get txtForgotPasswordSubtitle {
    return Intl.message(
      'Enter your account email and we\'ll send you a 6-digit code.',
      name: 'txtForgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get txtSendCode {
    return Intl.message('Send code', name: 'txtSendCode', desc: '', args: []);
  }

  /// `New password`
  String get txtNewPassword {
    return Intl.message(
      'New password',
      name: 'txtNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get txtConfirmNewPassword {
    return Intl.message(
      'Confirm new password',
      name: 'txtConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get txtResetPasswordButton {
    return Intl.message(
      'Reset password',
      name: 'txtResetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get txtPasswordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'txtPasswordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get txtPasswordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'txtPasswordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get txtDontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'txtDontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get txtSignUp {
    return Intl.message('Sign Up', name: 'txtSignUp', desc: '', args: []);
  }

  /// `Create an account`
  String get txtCreateAccount {
    return Intl.message(
      'Create an account',
      name: 'txtCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get txtNext {
    return Intl.message('Next', name: 'txtNext', desc: '', args: []);
  }

  /// `Already have an account?`
  String get txtAlreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'txtAlreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get txtLogin {
    return Intl.message('Login', name: 'txtLogin', desc: '', args: []);
  }

  /// `Completed`
  String get txtCompleted {
    return Intl.message('Completed', name: 'txtCompleted', desc: '', args: []);
  }

  /// `Try again`
  String get txtTryAgain {
    return Intl.message('Try again', name: 'txtTryAgain', desc: '', args: []);
  }

  /// `Read Along`
  String get txtHighlightReadAlong {
    return Intl.message(
      'Read Along',
      name: 'txtHighlightReadAlong',
      desc: '',
      args: [],
    );
  }

  /// `Line`
  String get txtHighlightLine {
    return Intl.message('Line', name: 'txtHighlightLine', desc: '', args: []);
  }

  /// `None`
  String get txtHighlightNone {
    return Intl.message('None', name: 'txtHighlightNone', desc: '', args: []);
  }

  /// `Press back again to exit`
  String get txtPressBackToExit {
    return Intl.message(
      'Press back again to exit',
      name: 'txtPressBackToExit',
      desc: '',
      args: [],
    );
  }

  /// `Listening & Shadowing`
  String get txtModuleListeningTitle {
    return Intl.message(
      'Listening & Shadowing',
      name: 'txtModuleListeningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Listening လုပ်မယ်။`
  String get txtModuleListeningLabel1 {
    return Intl.message(
      'Listening လုပ်မယ်။',
      name: 'txtModuleListeningLabel1',
      desc: '',
      args: [],
    );
  }

  /// `Shadowing လိုက်လုပ်မယ်။`
  String get txtModuleListeningLabel2 {
    return Intl.message(
      'Shadowing လိုက်လုပ်မယ်။',
      name: 'txtModuleListeningLabel2',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarks`
  String get txtModuleBookmarksTitle {
    return Intl.message(
      'Bookmarks',
      name: 'txtModuleBookmarksTitle',
      desc: '',
      args: [],
    );
  }

  /// `ကိုယ်တိုင် save ထားသော bookmarks များ`
  String get txtModuleBookmarksLabel1 {
    return Intl.message(
      'ကိုယ်တိုင် save ထားသော bookmarks များ',
      name: 'txtModuleBookmarksLabel1',
      desc: '',
      args: [],
    );
  }

  /// `Vocabulary, phrase, grammar ကို ပြန်လေ့လာမယ်`
  String get txtModuleBookmarksLabel2 {
    return Intl.message(
      'Vocabulary, phrase, grammar ကို ပြန်လေ့လာမယ်',
      name: 'txtModuleBookmarksLabel2',
      desc: '',
      args: [],
    );
  }

  /// `Continue learning`
  String get txtContinueLearning {
    return Intl.message(
      'Continue learning',
      name: 'txtContinueLearning',
      desc: '',
      args: [],
    );
  }

  /// `{done} of {total}`
  String txtProgressXofY(Object done, Object total) {
    return Intl.message(
      '$done of $total',
      name: 'txtProgressXofY',
      desc: '',
      args: [done, total],
    );
  }

  /// `{done} of {total} steps`
  String txtStepsProgress(Object done, Object total) {
    return Intl.message(
      '$done of $total steps',
      name: 'txtStepsProgress',
      desc: '',
      args: [done, total],
    );
  }

  /// `{count}-step lesson`
  String txtStepLesson(Object count) {
    return Intl.message(
      '$count-step lesson',
      name: 'txtStepLesson',
      desc: '',
      args: [count],
    );
  }

  /// `out of {total}`
  String txtOutOf(Object total) {
    return Intl.message(
      'out of $total',
      name: 'txtOutOf',
      desc: '',
      args: [total],
    );
  }

  /// `Profile`
  String get txtProfile {
    return Intl.message('Profile', name: 'txtProfile', desc: '', args: []);
  }

  /// `Days Learned`
  String get txtDaysLearned {
    return Intl.message(
      'Days Learned',
      name: 'txtDaysLearned',
      desc: '',
      args: [],
    );
  }

  /// `Day Streak`
  String get txtDayStreak {
    return Intl.message('Day Streak', name: 'txtDayStreak', desc: '', args: []);
  }

  /// `Appearance`
  String get txtAppearance {
    return Intl.message(
      'Appearance',
      name: 'txtAppearance',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get txtThemeLight {
    return Intl.message('Light', name: 'txtThemeLight', desc: '', args: []);
  }

  /// `Dark`
  String get txtThemeDark {
    return Intl.message('Dark', name: 'txtThemeDark', desc: '', args: []);
  }

  /// `System`
  String get txtThemeSystem {
    return Intl.message('System', name: 'txtThemeSystem', desc: '', args: []);
  }

  /// `Failed to open browser!`
  String get txtFailedToOpenBrowser {
    return Intl.message(
      'Failed to open browser!',
      name: 'txtFailedToOpenBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon....`
  String get txtComingSoonDots {
    return Intl.message(
      'Coming soon....',
      name: 'txtComingSoonDots',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get txtLesson {
    return Intl.message('Lesson', name: 'txtLesson', desc: '', args: []);
  }

  /// `All steps complete — great work!`
  String get txtAllStepsComplete {
    return Intl.message(
      'All steps complete — great work!',
      name: 'txtAllStepsComplete',
      desc: '',
      args: [],
    );
  }

  /// `Continue · {step}`
  String txtContinueStep(Object step) {
    return Intl.message(
      'Continue · $step',
      name: 'txtContinueStep',
      desc: '',
      args: [step],
    );
  }

  /// `In progress`
  String get txtInProgress {
    return Intl.message(
      'In progress',
      name: 'txtInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Recommended next`
  String get txtRecommendedNext {
    return Intl.message(
      'Recommended next',
      name: 'txtRecommendedNext',
      desc: '',
      args: [],
    );
  }

  /// `Not started`
  String get txtNotStarted {
    return Intl.message(
      'Not started',
      name: 'txtNotStarted',
      desc: '',
      args: [],
    );
  }

  /// `Watch`
  String get txtStepWatchTitle {
    return Intl.message('Watch', name: 'txtStepWatchTitle', desc: '', args: []);
  }

  /// `Listen with subtitles to understand the content`
  String get txtStepWatchSubtitle {
    return Intl.message(
      'Listen with subtitles to understand the content',
      name: 'txtStepWatchSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Study the patterns`
  String get txtStepStudyTitle {
    return Intl.message(
      'Study the patterns',
      name: 'txtStepStudyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review grammar and vocabulary used in this video`
  String get txtStepStudySubtitle {
    return Intl.message(
      'Review grammar and vocabulary used in this video',
      name: 'txtStepStudySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Practice along (shadowing)`
  String get txtStepShadowTitle {
    return Intl.message(
      'Practice along (shadowing)',
      name: 'txtStepShadowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Speak in sync with the audio`
  String get txtStepShadowSubtitle {
    return Intl.message(
      'Speak in sync with the audio',
      name: 'txtStepShadowSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Speak on your own`
  String get txtStepRecordTitle {
    return Intl.message(
      'Speak on your own',
      name: 'txtStepRecordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Record yourself and compare to the original`
  String get txtStepRecordSubtitle {
    return Intl.message(
      'Record yourself and compare to the original',
      name: 'txtStepRecordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `What you'll get from this lesson`
  String get txtOutcomeBannerTitle {
    return Intl.message(
      'What you\'ll get from this lesson',
      name: 'txtOutcomeBannerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Follow this talk at full native speed — without rewinding`
  String get txtOutcomeBullet1 {
    return Intl.message(
      'Follow this talk at full native speed — without rewinding',
      name: 'txtOutcomeBullet1',
      desc: '',
      args: [],
    );
  }

  /// `Pick up real phrases you can use yourself when you speak`
  String get txtOutcomeBullet2 {
    return Intl.message(
      'Pick up real phrases you can use yourself when you speak',
      name: 'txtOutcomeBullet2',
      desc: '',
      args: [],
    );
  }

  /// `Train your pronunciation until it feels natural`
  String get txtOutcomeBullet3 {
    return Intl.message(
      'Train your pronunciation until it feels natural',
      name: 'txtOutcomeBullet3',
      desc: '',
      args: [],
    );
  }

  /// `Do the 4 steps in order — each one makes the next easier.`
  String get txtOutcomeStepLadder {
    return Intl.message(
      'Do the 4 steps in order — each one makes the next easier.',
      name: 'txtOutcomeStepLadder',
      desc: '',
      args: [],
    );
  }

  /// `Follow this {minutes}-min talk at full native speed`
  String txtOutcomeCountMinutes(Object minutes) {
    return Intl.message(
      'Follow this $minutes-min talk at full native speed',
      name: 'txtOutcomeCountMinutes',
      desc: '',
      args: [minutes],
    );
  }

  /// `Learn {count} new words with correct pronunciation`
  String txtOutcomeCountVocab(Object count) {
    return Intl.message(
      'Learn $count new words with correct pronunciation',
      name: 'txtOutcomeCountVocab',
      desc: '',
      args: [count],
    );
  }

  /// `Master {count} speaking patterns natives use`
  String txtOutcomeCountPatterns(Object count) {
    return Intl.message(
      'Master $count speaking patterns natives use',
      name: 'txtOutcomeCountPatterns',
      desc: '',
      args: [count],
    );
  }

  /// `Shadow {count} sentences at native speed`
  String txtOutcomeCountSentences(Object count) {
    return Intl.message(
      'Shadow $count sentences at native speed',
      name: 'txtOutcomeCountSentences',
      desc: '',
      args: [count],
    );
  }

  /// `Understand real English — and speak it`
  String get txtListeningIntroTitle {
    return Intl.message(
      'Understand real English — and speak it',
      name: 'txtListeningIntroTitle',
      desc: '',
      args: [],
    );
  }

  /// `Right now, native talks can sound like one fast, blurry word.`
  String get txtListeningIntroBefore {
    return Intl.message(
      'Right now, native talks can sound like one fast, blurry word.',
      name: 'txtListeningIntroBefore',
      desc: '',
      args: [],
    );
  }

  /// `Work through these lessons and you'll follow real podcasts, YouTube & TED talks — and speak with their rhythm.`
  String get txtListeningIntroAfter {
    return Intl.message(
      'Work through these lessons and you\'ll follow real podcasts, YouTube & TED talks — and speak with their rhythm.',
      name: 'txtListeningIntroAfter',
      desc: '',
      args: [],
    );
  }

  /// `Every lesson is a 4-step path: Watch → Study → Shadow → Record.`
  String get txtListeningIntroPath {
    return Intl.message(
      'Every lesson is a 4-step path: Watch → Study → Shadow → Record.',
      name: 'txtListeningIntroPath',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get txtGotIt {
    return Intl.message('Got it', name: 'txtGotIt', desc: '', args: []);
  }

  /// `Listening And Shadowing`
  String get txtListeningListTitle {
    return Intl.message(
      'Listening And Shadowing',
      name: 'txtListeningListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start here`
  String get txtStartHere {
    return Intl.message('Start here', name: 'txtStartHere', desc: '', args: []);
  }

  /// `Explanation`
  String get txtExplanation {
    return Intl.message(
      'Explanation',
      name: 'txtExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Explanation not found.`
  String get txtExplanationNotFound {
    return Intl.message(
      'Explanation not found.',
      name: 'txtExplanationNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load explanation. Please try again later.`
  String get txtExplanationLoadFailed {
    return Intl.message(
      'Failed to load explanation. Please try again later.',
      name: 'txtExplanationLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Connection timed out. Please try again.`
  String get txtConnectionTimedOut {
    return Intl.message(
      'Connection timed out. Please try again.',
      name: 'txtConnectionTimedOut',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your internet connection.`
  String get txtNetworkError {
    return Intl.message(
      'Network error. Please check your internet connection.',
      name: 'txtNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while loading this explanation.`
  String get txtExplanationGenericError {
    return Intl.message(
      'Something went wrong while loading this explanation.',
      name: 'txtExplanationGenericError',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't load explanation`
  String get txtExplanationLoadError {
    return Intl.message(
      'Couldn\'t load explanation',
      name: 'txtExplanationLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Save your recording?`
  String get txtSaveRecordingTitle {
    return Intl.message(
      'Save your recording?',
      name: 'txtSaveRecordingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recording name`
  String get txtRecordingName {
    return Intl.message(
      'Recording name',
      name: 'txtRecordingName',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get txtDiscard {
    return Intl.message('Discard', name: 'txtDiscard', desc: '', args: []);
  }

  /// `Save`
  String get txtSave {
    return Intl.message('Save', name: 'txtSave', desc: '', args: []);
  }

  /// `Delete Recording?`
  String get txtDeleteRecordingTitle {
    return Intl.message(
      'Delete Recording?',
      name: 'txtDeleteRecordingTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will permanently remove your recorded audio:`
  String get txtDeleteRecordingBody {
    return Intl.message(
      'This will permanently remove your recorded audio:',
      name: 'txtDeleteRecordingBody',
      desc: '',
      args: [],
    );
  }

  /// `Keep It`
  String get txtKeepIt {
    return Intl.message('Keep It', name: 'txtKeepIt', desc: '', args: []);
  }

  /// `Delete`
  String get txtDelete {
    return Intl.message('Delete', name: 'txtDelete', desc: '', args: []);
  }

  /// `Checking your answers`
  String get txtCheckingAnswers {
    return Intl.message(
      'Checking your answers',
      name: 'txtCheckingAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Speech Practice Session`
  String get txtSpeechPracticeSession {
    return Intl.message(
      'Speech Practice Session',
      name: 'txtSpeechPracticeSession',
      desc: '',
      args: [],
    );
  }

  /// `Records`
  String get txtRecords {
    return Intl.message('Records', name: 'txtRecords', desc: '', args: []);
  }

  /// `Playback is disabled while recording. Please stop the recording to continue.`
  String get txtPlaybackDisabledWhileRecording {
    return Intl.message(
      'Playback is disabled while recording. Please stop the recording to continue.',
      name: 'txtPlaybackDisabledWhileRecording',
      desc: '',
      args: [],
    );
  }

  /// `We’re polishing the record subtitles to give you the best shadowing experience.\nCheck back soon and get ready to practice!`
  String get txtRecordComingSoonBody {
    return Intl.message(
      'We’re polishing the record subtitles to give you the best shadowing experience.\nCheck back soon and get ready to practice!',
      name: 'txtRecordComingSoonBody',
      desc: '',
      args: [],
    );
  }

  /// `Tap to record`
  String get txtTapToRecord {
    return Intl.message(
      'Tap to record',
      name: 'txtTapToRecord',
      desc: '',
      args: [],
    );
  }

  /// `No Record Found For This Sentence`
  String get txtNoRecordForSentence {
    return Intl.message(
      'No Record Found For This Sentence',
      name: 'txtNoRecordForSentence',
      desc: '',
      args: [],
    );
  }

  /// `Sentence Explanations`
  String get txtSentenceExplanations {
    return Intl.message(
      'Sentence Explanations',
      name: 'txtSentenceExplanations',
      desc: '',
      args: [],
    );
  }

  /// `Sentence explanation is on the way.\nStay tuned!`
  String get txtSentenceExplanationComing {
    return Intl.message(
      'Sentence explanation is on the way.\nStay tuned!',
      name: 'txtSentenceExplanationComing',
      desc: '',
      args: [],
    );
  }

  /// `Choose Highlight Type`
  String get txtChooseHighlightType {
    return Intl.message(
      'Choose Highlight Type',
      name: 'txtChooseHighlightType',
      desc: '',
      args: [],
    );
  }

  /// `Playback speed`
  String get txtPlaybackSpeed {
    return Intl.message(
      'Playback speed',
      name: 'txtPlaybackSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Shadowing`
  String get txtShadowing {
    return Intl.message('Shadowing', name: 'txtShadowing', desc: '', args: []);
  }

  /// `Your Level`
  String get txtYourLevel {
    return Intl.message('Your Level', name: 'txtYourLevel', desc: '', args: []);
  }

  /// `Correct`
  String get txtCorrect {
    return Intl.message('Correct', name: 'txtCorrect', desc: '', args: []);
  }

  /// `Incorrect`
  String get txtIncorrect {
    return Intl.message('Incorrect', name: 'txtIncorrect', desc: '', args: []);
  }

  /// `Not Answer`
  String get txtNotAnswer {
    return Intl.message('Not Answer', name: 'txtNotAnswer', desc: '', args: []);
  }

  /// `Stream`
  String get txtStream {
    return Intl.message('Stream', name: 'txtStream', desc: '', args: []);
  }

  /// `Saved`
  String get txtSaved {
    return Intl.message('Saved', name: 'txtSaved', desc: '', args: []);
  }

  /// `Removed`
  String get txtRemoved {
    return Intl.message('Removed', name: 'txtRemoved', desc: '', args: []);
  }

  /// `Remove`
  String get txtRemove {
    return Intl.message('Remove', name: 'txtRemove', desc: '', args: []);
  }

  /// `Vocabularies`
  String get txtVocabularies {
    return Intl.message(
      'Vocabularies',
      name: 'txtVocabularies',
      desc: '',
      args: [],
    );
  }

  /// `သည်ဗီဒီယိုအတွက် vocabularyများ\n မကြာခင်တင်ပေးပါမည်။`
  String get txtVocabComingSoon {
    return Intl.message(
      'သည်ဗီဒီယိုအတွက် vocabularyများ\n မကြာခင်တင်ပေးပါမည်။',
      name: 'txtVocabComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Check yourself`
  String get txtCheckYourself {
    return Intl.message(
      'Check yourself',
      name: 'txtCheckYourself',
      desc: '',
      args: [],
    );
  }

  /// `Fill the blank`
  String get txtFillTheBlank {
    return Intl.message(
      'Fill the blank',
      name: 'txtFillTheBlank',
      desc: '',
      args: [],
    );
  }

  /// `Type the missing word(s)`
  String get txtTypeMissingWords {
    return Intl.message(
      'Type the missing word(s)',
      name: 'txtTypeMissingWords',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get txtCheck {
    return Intl.message('Check', name: 'txtCheck', desc: '', args: []);
  }

  /// `Answer: `
  String get txtAnswerLabel {
    return Intl.message('Answer: ', name: 'txtAnswerLabel', desc: '', args: []);
  }

  /// `Show hint`
  String get txtShowHint {
    return Intl.message('Show hint', name: 'txtShowHint', desc: '', args: []);
  }

  /// `Done`
  String get txtDone {
    return Intl.message('Done', name: 'txtDone', desc: '', args: []);
  }

  /// `No internet connection.`
  String get txtNoInternetConnection {
    return Intl.message(
      'No internet connection.',
      name: 'txtNoInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Daily Speaking`
  String get txtDailySpeaking {
    return Intl.message(
      'Daily Speaking',
      name: 'txtDailySpeaking',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get txtDsHistory {
    return Intl.message('History', name: 'txtDsHistory', desc: '', args: []);
  }

  /// `Three minutes a day.`
  String get txtDsHeadline {
    return Intl.message(
      'Three minutes a day.',
      name: 'txtDsHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Pick how you want to start. Speak or write, then get instant feedback.`
  String get txtDsSubhead {
    return Intl.message(
      'Pick how you want to start. Speak or write, then get instant feedback.',
      name: 'txtDsSubhead',
      desc: '',
      args: [],
    );
  }

  /// `Just talk`
  String get txtDsJustTalk {
    return Intl.message('Just talk', name: 'txtDsJustTalk', desc: '', args: []);
  }

  /// `No topic, no pressure. Speak freely — the AI will identify what you talked about and give you feedback.`
  String get txtDsJustTalkDesc {
    return Intl.message(
      'No topic, no pressure. Speak freely — the AI will identify what you talked about and give you feedback.',
      name: 'txtDsJustTalkDesc',
      desc: '',
      args: [],
    );
  }

  /// `Own topic`
  String get txtDsOwnTopic {
    return Intl.message('Own topic', name: 'txtDsOwnTopic', desc: '', args: []);
  }

  /// `Tell us what you want to talk about, then speak or type.`
  String get txtDsOwnTopicDesc {
    return Intl.message(
      'Tell us what you want to talk about, then speak or type.',
      name: 'txtDsOwnTopicDesc',
      desc: '',
      args: [],
    );
  }

  /// `Suggested topic`
  String get txtDsSuggestedTopic {
    return Intl.message(
      'Suggested topic',
      name: 'txtDsSuggestedTopic',
      desc: '',
      args: [],
    );
  }

  /// `Pick from curated prompts with vocabulary and target phrases.`
  String get txtDsSuggestedTopicDesc {
    return Intl.message(
      'Pick from curated prompts with vocabulary and target phrases.',
      name: 'txtDsSuggestedTopicDesc',
      desc: '',
      args: [],
    );
  }

  /// `More ways to practice`
  String get txtDsMoreWays {
    return Intl.message(
      'More ways to practice',
      name: 'txtDsMoreWays',
      desc: '',
      args: [],
    );
  }

  /// `Start here`
  String get txtDsGuided {
    return Intl.message('Start here', name: 'txtDsGuided', desc: '', args: []);
  }

  /// `New to speaking? We'll walk you through it — study a model, make it your own, then say it.`
  String get txtDsGuidedDesc {
    return Intl.message(
      'New to speaking? We\'ll walk you through it — study a model, make it your own, then say it.',
      name: 'txtDsGuidedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Pick a lesson. We'll show you a model, help you make your own version, then you record it and get feedback. Higher levels give you less to lean on.`
  String get txtDsGuidedIntro {
    return Intl.message(
      'Pick a lesson. We\'ll show you a model, help you make your own version, then you record it and get feedback. Higher levels give you less to lean on.',
      name: 'txtDsGuidedIntro',
      desc: '',
      args: [],
    );
  }

  /// `Level {level}`
  String txtDsGuidedLevel(Object level) {
    return Intl.message(
      'Level $level',
      name: 'txtDsGuidedLevel',
      desc: '',
      args: [level],
    );
  }

  /// `What you'll be able to do`
  String get txtDsGuidedObjectiveHeading {
    return Intl.message(
      'What you\'ll be able to do',
      name: 'txtDsGuidedObjectiveHeading',
      desc: '',
      args: [],
    );
  }

  /// `A model to learn from`
  String get txtDsGuidedModelHeading {
    return Intl.message(
      'A model to learn from',
      name: 'txtDsGuidedModelHeading',
      desc: '',
      args: [],
    );
  }

  /// `Line by line`
  String get txtDsGuidedBreakdownHeading {
    return Intl.message(
      'Line by line',
      name: 'txtDsGuidedBreakdownHeading',
      desc: '',
      args: [],
    );
  }

  /// `Now make it your own`
  String get txtDsGuidedBuildHeading {
    return Intl.message(
      'Now make it your own',
      name: 'txtDsGuidedBuildHeading',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the blanks with your own answers.`
  String get txtDsGuidedBuildSubhead {
    return Intl.message(
      'Fill in the blanks with your own answers.',
      name: 'txtDsGuidedBuildSubhead',
      desc: '',
      args: [],
    );
  }

  /// `Your paragraph so far`
  String get txtDsGuidedPreviewHeading {
    return Intl.message(
      'Your paragraph so far',
      name: 'txtDsGuidedPreviewHeading',
      desc: '',
      args: [],
    );
  }

  /// `This is yours now`
  String get txtDsGuidedYoursHeading {
    return Intl.message(
      'This is yours now',
      name: 'txtDsGuidedYoursHeading',
      desc: '',
      args: [],
    );
  }

  /// `You built this yourself. Next, say it out loud and get feedback — just like the other practices.`
  String get txtDsGuidedYoursSubhead {
    return Intl.message(
      'You built this yourself. Next, say it out loud and get feedback — just like the other practices.',
      name: 'txtDsGuidedYoursSubhead',
      desc: '',
      args: [],
    );
  }

  /// `I'm ready — record`
  String get txtDsGuidedReadyRecord {
    return Intl.message(
      'I\'m ready — record',
      name: 'txtDsGuidedReadyRecord',
      desc: '',
      args: [],
    );
  }

  /// `Fill in every blank to continue`
  String get txtDsGuidedFillToContinue {
    return Intl.message(
      'Fill in every blank to continue',
      name: 'txtDsGuidedFillToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get txtDsGuidedBack {
    return Intl.message('Back', name: 'txtDsGuidedBack', desc: '', args: []);
  }

  /// `Next`
  String get txtDsGuidedNext {
    return Intl.message('Next', name: 'txtDsGuidedNext', desc: '', args: []);
  }

  /// `Let's start`
  String get txtDsGuidedStart {
    return Intl.message(
      'Let\'s start',
      name: 'txtDsGuidedStart',
      desc: '',
      args: [],
    );
  }

  /// `Your paragraph`
  String get txtDsGuidedYourParagraph {
    return Intl.message(
      'Your paragraph',
      name: 'txtDsGuidedYourParagraph',
      desc: '',
      args: [],
    );
  }

  /// `Your keywords — say the rest in your own words`
  String get txtDsGuidedYourKeywords {
    return Intl.message(
      'Your keywords — say the rest in your own words',
      name: 'txtDsGuidedYourKeywords',
      desc: '',
      args: [],
    );
  }

  /// `Try saying it in your own words — you've got this.`
  String get txtDsGuidedSpeakFromMemory {
    return Intl.message(
      'Try saying it in your own words — you\'ve got this.',
      name: 'txtDsGuidedSpeakFromMemory',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get txtDsGuidedCopy {
    return Intl.message('Copy', name: 'txtDsGuidedCopy', desc: '', args: []);
  }

  /// `Edit`
  String get txtDsGuidedEdit {
    return Intl.message('Edit', name: 'txtDsGuidedEdit', desc: '', args: []);
  }

  /// `Copied to clipboard`
  String get txtDsGuidedCopied {
    return Intl.message(
      'Copied to clipboard',
      name: 'txtDsGuidedCopied',
      desc: '',
      args: [],
    );
  }

  /// `Edit your paragraph`
  String get txtDsGuidedEditTitle {
    return Intl.message(
      'Edit your paragraph',
      name: 'txtDsGuidedEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get txtDsGuidedEditSave {
    return Intl.message(
      'Save',
      name: 'txtDsGuidedEditSave',
      desc: '',
      args: [],
    );
  }

  /// `Limit reached`
  String get txtDsLimitReached {
    return Intl.message(
      'Limit reached',
      name: 'txtDsLimitReached',
      desc: '',
      args: [],
    );
  }

  /// `Daily limit reached — comes back tomorrow.`
  String get txtDsDailyLimitReached {
    return Intl.message(
      'Daily limit reached — comes back tomorrow.',
      name: 'txtDsDailyLimitReached',
      desc: '',
      args: [],
    );
  }

  /// `Daily limit reached`
  String get txtDsDailyLimitReachedShort {
    return Intl.message(
      'Daily limit reached',
      name: 'txtDsDailyLimitReachedShort',
      desc: '',
      args: [],
    );
  }

  /// `How it works`
  String get txtDsHowItWorks {
    return Intl.message(
      'How it works',
      name: 'txtDsHowItWorks',
      desc: '',
      args: [],
    );
  }

  /// `• Tap the mic and just talk for up to 5 minutes.\n• When you stop, the AI gives you a score, strengths, fixes, and a Burmese explanation.\n• Don't worry about being perfect — the goal is to keep speaking.`
  String get txtDsHowItWorksBody {
    return Intl.message(
      '• Tap the mic and just talk for up to 5 minutes.\n• When you stop, the AI gives you a score, strengths, fixes, and a Burmese explanation.\n• Don\'t worry about being perfect — the goal is to keep speaking.',
      name: 'txtDsHowItWorksBody',
      desc: '',
      args: [],
    );
  }

  /// `Reviewing your recording…`
  String get txtDsReviewingRecording {
    return Intl.message(
      'Reviewing your recording…',
      name: 'txtDsReviewingRecording',
      desc: '',
      args: [],
    );
  }

  /// `Reviewing your writing…`
  String get txtDsReviewingWriting {
    return Intl.message(
      'Reviewing your writing…',
      name: 'txtDsReviewingWriting',
      desc: '',
      args: [],
    );
  }

  /// `This usually takes a few seconds.`
  String get txtDsReviewingTakesSeconds {
    return Intl.message(
      'This usually takes a few seconds.',
      name: 'txtDsReviewingTakesSeconds',
      desc: '',
      args: [],
    );
  }

  /// `Daily Speaking History`
  String get txtDsHistoryTitle {
    return Intl.message(
      'Daily Speaking History',
      name: 'txtDsHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get txtDsToday {
    return Intl.message('Today', name: 'txtDsToday', desc: '', args: []);
  }

  /// `Yesterday`
  String get txtDsYesterday {
    return Intl.message(
      'Yesterday',
      name: 'txtDsYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Suggested`
  String get txtDsSuggested {
    return Intl.message(
      'Suggested',
      name: 'txtDsSuggested',
      desc: '',
      args: [],
    );
  }

  /// `{onRamp} • {seconds}s • {words} words`
  String txtDsSessionMeta(Object onRamp, Object seconds, Object words) {
    return Intl.message(
      '$onRamp • ${seconds}s • $words words',
      name: 'txtDsSessionMeta',
      desc: '',
      args: [onRamp, seconds, words],
    );
  }

  /// `No sessions yet`
  String get txtDsNoSessionsYet {
    return Intl.message(
      'No sessions yet',
      name: 'txtDsNoSessionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Your past Daily Speaking sessions will show up here.`
  String get txtDsNoSessionsBody {
    return Intl.message(
      'Your past Daily Speaking sessions will show up here.',
      name: 'txtDsNoSessionsBody',
      desc: '',
      args: [],
    );
  }

  /// `{used} of {total} sessions today`
  String txtDsSessionsToday(Object used, Object total) {
    return Intl.message(
      '$used of $total sessions today',
      name: 'txtDsSessionsToday',
      desc: '',
      args: [used, total],
    );
  }

  /// `max {duration}`
  String txtDsMaxDuration(Object duration) {
    return Intl.message(
      'max $duration',
      name: 'txtDsMaxDuration',
      desc: '',
      args: [duration],
    );
  }

  /// `Recording is unavailable.`
  String get txtDsRecordingUnavailable {
    return Intl.message(
      'Recording is unavailable.',
      name: 'txtDsRecordingUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Tap to stop`
  String get txtDsTapToStop {
    return Intl.message(
      'Tap to stop',
      name: 'txtDsTapToStop',
      desc: '',
      args: [],
    );
  }

  /// `Tap and start talking`
  String get txtDsTapToStart {
    return Intl.message(
      'Tap and start talking',
      name: 'txtDsTapToStart',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to talk about?`
  String get txtDsWhatToTalkAbout {
    return Intl.message(
      'What do you want to talk about?',
      name: 'txtDsWhatToTalkAbout',
      desc: '',
      args: [],
    );
  }

  /// `A topic, a question, or just a vibe — keep it short.`
  String get txtDsTopicHint {
    return Intl.message(
      'A topic, a question, or just a vibe — keep it short.',
      name: 'txtDsTopicHint',
      desc: '',
      args: [],
    );
  }

  /// `e.g. The most stressful week I had`
  String get txtDsTopicFieldHint {
    return Intl.message(
      'e.g. The most stressful week I had',
      name: 'txtDsTopicFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Try one of these`
  String get txtDsTryOneOfThese {
    return Intl.message(
      'Try one of these',
      name: 'txtDsTryOneOfThese',
      desc: '',
      args: [],
    );
  }

  /// `Record this`
  String get txtDsRecordThis {
    return Intl.message(
      'Record this',
      name: 'txtDsRecordThis',
      desc: '',
      args: [],
    );
  }

  /// `Help me prepare`
  String get txtDsHelpMePrepare {
    return Intl.message(
      'Help me prepare',
      name: 'txtDsHelpMePrepare',
      desc: '',
      args: [],
    );
  }

  /// `Record now`
  String get txtDsRecordNow {
    return Intl.message(
      'Record now',
      name: 'txtDsRecordNow',
      desc: '',
      args: [],
    );
  }

  /// `Building your prep…`
  String get txtDsBuildingPrep {
    return Intl.message(
      'Building your prep…',
      name: 'txtDsBuildingPrep',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't build prep. Try again.`
  String get txtDsPrepFailed {
    return Intl.message(
      'Couldn\'t build prep. Try again.',
      name: 'txtDsPrepFailed',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get txtDsRetry {
    return Intl.message('Retry', name: 'txtDsRetry', desc: '', args: []);
  }

  /// `Record without prep`
  String get txtDsRecordWithoutPrep {
    return Intl.message(
      'Record without prep',
      name: 'txtDsRecordWithoutPrep',
      desc: '',
      args: [],
    );
  }

  /// `Ask for more`
  String get txtDsAskForMore {
    return Intl.message(
      'Ask for more',
      name: 'txtDsAskForMore',
      desc: '',
      args: [],
    );
  }

  /// `More vocabulary`
  String get txtDsAskMoreVocab {
    return Intl.message(
      'More vocabulary',
      name: 'txtDsAskMoreVocab',
      desc: '',
      args: [],
    );
  }

  /// `Useful phrases`
  String get txtDsAskUsefulPhrases {
    return Intl.message(
      'Useful phrases',
      name: 'txtDsAskUsefulPhrases',
      desc: '',
      args: [],
    );
  }

  /// `How do I start?`
  String get txtDsAskHowToStart {
    return Intl.message(
      'How do I start?',
      name: 'txtDsAskHowToStart',
      desc: '',
      args: [],
    );
  }

  /// `Harder words`
  String get txtDsAskHarderWords {
    return Intl.message(
      'Harder words',
      name: 'txtDsAskHarderWords',
      desc: '',
      args: [],
    );
  }

  /// `That's all the prep help for this topic.`
  String get txtDsAsksUsedUp {
    return Intl.message(
      'That\'s all the prep help for this topic.',
      name: 'txtDsAsksUsedUp',
      desc: '',
      args: [],
    );
  }

  /// `Write instead`
  String get txtDsWriteInstead {
    return Intl.message(
      'Write instead',
      name: 'txtDsWriteInstead',
      desc: '',
      args: [],
    );
  }

  /// `My family`
  String get txtDsSuggestionFamily {
    return Intl.message(
      'My family',
      name: 'txtDsSuggestionFamily',
      desc: '',
      args: [],
    );
  }

  /// `A recent trip`
  String get txtDsSuggestionTrip {
    return Intl.message(
      'A recent trip',
      name: 'txtDsSuggestionTrip',
      desc: '',
      args: [],
    );
  }

  /// `My job`
  String get txtDsSuggestionJob {
    return Intl.message(
      'My job',
      name: 'txtDsSuggestionJob',
      desc: '',
      args: [],
    );
  }

  /// `A goal I have`
  String get txtDsSuggestionGoal {
    return Intl.message(
      'A goal I have',
      name: 'txtDsSuggestionGoal',
      desc: '',
      args: [],
    );
  }

  /// `Something I'm worried about`
  String get txtDsSuggestionWorried {
    return Intl.message(
      'Something I\'m worried about',
      name: 'txtDsSuggestionWorried',
      desc: '',
      args: [],
    );
  }

  /// `My weekend`
  String get txtDsSuggestionWeekend {
    return Intl.message(
      'My weekend',
      name: 'txtDsSuggestionWeekend',
      desc: '',
      args: [],
    );
  }

  /// `A hobby I enjoy`
  String get txtDsSuggestionHobby {
    return Intl.message(
      'A hobby I enjoy',
      name: 'txtDsSuggestionHobby',
      desc: '',
      args: [],
    );
  }

  /// `Food I love`
  String get txtDsSuggestionFood {
    return Intl.message(
      'Food I love',
      name: 'txtDsSuggestionFood',
      desc: '',
      args: [],
    );
  }

  /// `A movie or show`
  String get txtDsSuggestionShow {
    return Intl.message(
      'A movie or show',
      name: 'txtDsSuggestionShow',
      desc: '',
      args: [],
    );
  }

  /// `My hometown`
  String get txtDsSuggestionHometown {
    return Intl.message(
      'My hometown',
      name: 'txtDsSuggestionHometown',
      desc: '',
      args: [],
    );
  }

  /// `A dream I have`
  String get txtDsSuggestionDream {
    return Intl.message(
      'A dream I have',
      name: 'txtDsSuggestionDream',
      desc: '',
      args: [],
    );
  }

  /// `A close friend`
  String get txtDsSuggestionFriend {
    return Intl.message(
      'A close friend',
      name: 'txtDsSuggestionFriend',
      desc: '',
      args: [],
    );
  }

  /// `Shuffle`
  String get txtDsShuffle {
    return Intl.message('Shuffle', name: 'txtDsShuffle', desc: '', args: []);
  }

  /// `Use this`
  String get txtDsUseThisHint {
    return Intl.message(
      'Use this',
      name: 'txtDsUseThisHint',
      desc: '',
      args: [],
    );
  }

  /// `Get vocabulary, phrases & ideas`
  String get txtDsHelpMePrepareCaption {
    return Intl.message(
      'Get vocabulary, phrases & ideas',
      name: 'txtDsHelpMePrepareCaption',
      desc: '',
      args: [],
    );
  }

  /// `Skip prep — just start talking`
  String get txtDsRecordNowCaption {
    return Intl.message(
      'Skip prep — just start talking',
      name: 'txtDsRecordNowCaption',
      desc: '',
      args: [],
    );
  }

  /// `e.g. The most stressful week I had`
  String get txtDsFieldHint1 {
    return Intl.message(
      'e.g. The most stressful week I had',
      name: 'txtDsFieldHint1',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A small win I'm proud of`
  String get txtDsFieldHint2 {
    return Intl.message(
      'e.g. A small win I\'m proud of',
      name: 'txtDsFieldHint2',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Why I started learning English`
  String get txtDsFieldHint3 {
    return Intl.message(
      'e.g. Why I started learning English',
      name: 'txtDsFieldHint3',
      desc: '',
      args: [],
    );
  }

  /// `e.g. My favorite way to relax`
  String get txtDsFieldHint4 {
    return Intl.message(
      'e.g. My favorite way to relax',
      name: 'txtDsFieldHint4',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A person who inspires me`
  String get txtDsFieldHint5 {
    return Intl.message(
      'e.g. A person who inspires me',
      name: 'txtDsFieldHint5',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Something I changed my mind about`
  String get txtDsFieldHint6 {
    return Intl.message(
      'e.g. Something I changed my mind about',
      name: 'txtDsFieldHint6',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A habit I want to build`
  String get txtDsFieldHint7 {
    return Intl.message(
      'e.g. A habit I want to build',
      name: 'txtDsFieldHint7',
      desc: '',
      args: [],
    );
  }

  /// `e.g. The best meal I've ever had`
  String get txtDsFieldHint8 {
    return Intl.message(
      'e.g. The best meal I\'ve ever had',
      name: 'txtDsFieldHint8',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A place I'd love to visit`
  String get txtDsFieldHint9 {
    return Intl.message(
      'e.g. A place I\'d love to visit',
      name: 'txtDsFieldHint9',
      desc: '',
      args: [],
    );
  }

  /// `e.g. What I did last weekend`
  String get txtDsFieldHint10 {
    return Intl.message(
      'e.g. What I did last weekend',
      name: 'txtDsFieldHint10',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A skill I wish I had`
  String get txtDsFieldHint11 {
    return Intl.message(
      'e.g. A skill I wish I had',
      name: 'txtDsFieldHint11',
      desc: '',
      args: [],
    );
  }

  /// `e.g. My morning routine`
  String get txtDsFieldHint12 {
    return Intl.message(
      'e.g. My morning routine',
      name: 'txtDsFieldHint12',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A video that stuck with me`
  String get txtDsFieldHint13 {
    return Intl.message(
      'e.g. A video that stuck with me',
      name: 'txtDsFieldHint13',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Something that made me laugh recently`
  String get txtDsFieldHint14 {
    return Intl.message(
      'e.g. Something that made me laugh recently',
      name: 'txtDsFieldHint14',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A decision I'm trying to make`
  String get txtDsFieldHint15 {
    return Intl.message(
      'e.g. A decision I\'m trying to make',
      name: 'txtDsFieldHint15',
      desc: '',
      args: [],
    );
  }

  /// `e.g. What my ideal day looks like`
  String get txtDsFieldHint16 {
    return Intl.message(
      'e.g. What my ideal day looks like',
      name: 'txtDsFieldHint16',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A challenge at work or school`
  String get txtDsFieldHint17 {
    return Intl.message(
      'e.g. A challenge at work or school',
      name: 'txtDsFieldHint17',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Advice I'd give my younger self`
  String get txtDsFieldHint18 {
    return Intl.message(
      'e.g. Advice I\'d give my younger self',
      name: 'txtDsFieldHint18',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A tradition in my family`
  String get txtDsFieldHint19 {
    return Intl.message(
      'e.g. A tradition in my family',
      name: 'txtDsFieldHint19',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Something I'm grateful for today`
  String get txtDsFieldHint20 {
    return Intl.message(
      'e.g. Something I\'m grateful for today',
      name: 'txtDsFieldHint20',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A goal for this year`
  String get txtDsFieldHint21 {
    return Intl.message(
      'e.g. A goal for this year',
      name: 'txtDsFieldHint21',
      desc: '',
      args: [],
    );
  }

  /// `e.g. The last time I felt nervous`
  String get txtDsFieldHint22 {
    return Intl.message(
      'e.g. The last time I felt nervous',
      name: 'txtDsFieldHint22',
      desc: '',
      args: [],
    );
  }

  /// `e.g. A song I can't stop playing`
  String get txtDsFieldHint23 {
    return Intl.message(
      'e.g. A song I can\'t stop playing',
      name: 'txtDsFieldHint23',
      desc: '',
      args: [],
    );
  }

  /// `e.g. How I spend my free time`
  String get txtDsFieldHint24 {
    return Intl.message(
      'e.g. How I spend my free time',
      name: 'txtDsFieldHint24',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Something new I tried recently`
  String get txtDsFieldHint25 {
    return Intl.message(
      'e.g. Something new I tried recently',
      name: 'txtDsFieldHint25',
      desc: '',
      args: [],
    );
  }

  /// `Your topic`
  String get txtDsYourTopic {
    return Intl.message(
      'Your topic',
      name: 'txtDsYourTopic',
      desc: '',
      args: [],
    );
  }

  /// `Write at least {count} characters.`
  String txtDsWriteAtLeastChars(Object count) {
    return Intl.message(
      'Write at least $count characters.',
      name: 'txtDsWriteAtLeastChars',
      desc: '',
      args: [count],
    );
  }

  /// `At least {count} characters`
  String txtDsAtLeastChars(Object count) {
    return Intl.message(
      'At least $count characters',
      name: 'txtDsAtLeastChars',
      desc: '',
      args: [count],
    );
  }

  /// `Write a paragraph about your topic. Aim for 5-10 sentences.`
  String get txtDsWritePathHint {
    return Intl.message(
      'Write a paragraph about your topic. Aim for 5-10 sentences.',
      name: 'txtDsWritePathHint',
      desc: '',
      args: [],
    );
  }

  /// `Get feedback`
  String get txtDsGetFeedback {
    return Intl.message(
      'Get feedback',
      name: 'txtDsGetFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get txtDsFeedback {
    return Intl.message('Feedback', name: 'txtDsFeedback', desc: '', args: []);
  }

  /// `Yours`
  String get txtDsTabYours {
    return Intl.message('Yours', name: 'txtDsTabYours', desc: '', args: []);
  }

  /// `Native`
  String get txtDsTabNative {
    return Intl.message('Native', name: 'txtDsTabNative', desc: '', args: []);
  }

  /// `What you did well`
  String get txtDsWhatYouDidWell {
    return Intl.message(
      'What you did well',
      name: 'txtDsWhatYouDidWell',
      desc: '',
      args: [],
    );
  }

  /// `Things to fix`
  String get txtDsThingsToFix {
    return Intl.message(
      'Things to fix',
      name: 'txtDsThingsToFix',
      desc: '',
      args: [],
    );
  }

  /// `How a native speaker would say it`
  String get txtDsNativeRewrite {
    return Intl.message(
      'How a native speaker would say it',
      name: 'txtDsNativeRewrite',
      desc: '',
      args: [],
    );
  }

  /// `Target phrases`
  String get txtDsTargetPhrases {
    return Intl.message(
      'Target phrases',
      name: 'txtDsTargetPhrases',
      desc: '',
      args: [],
    );
  }

  /// `Pronunciation notes`
  String get txtDsPronunciationNotes {
    return Intl.message(
      'Pronunciation notes',
      name: 'txtDsPronunciationNotes',
      desc: '',
      args: [],
    );
  }

  /// `အကျဉ်းချုပ်`
  String get txtDsSummaryMm {
    return Intl.message(
      'အကျဉ်းချုပ်',
      name: 'txtDsSummaryMm',
      desc: '',
      args: [],
    );
  }

  /// `Try this topic again`
  String get txtDsTryTopicAgain {
    return Intl.message(
      'Try this topic again',
      name: 'txtDsTryTopicAgain',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get txtDsTime {
    return Intl.message('Time', name: 'txtDsTime', desc: '', args: []);
  }

  /// `Words`
  String get txtDsWords {
    return Intl.message('Words', name: 'txtDsWords', desc: '', args: []);
  }

  /// `Pace`
  String get txtDsPace {
    return Intl.message('Pace', name: 'txtDsPace', desc: '', args: []);
  }

  /// `{wpm} wpm`
  String txtDsPaceWpm(Object wpm) {
    return Intl.message(
      '$wpm wpm',
      name: 'txtDsPaceWpm',
      desc: '',
      args: [wpm],
    );
  }

  /// `Topic: {label}`
  String txtDsTopicColon(Object label) {
    return Intl.message(
      'Topic: $label',
      name: 'txtDsTopicColon',
      desc: '',
      args: [label],
    );
  }

  /// `Beginner`
  String get txtDsLevelBeginner {
    return Intl.message(
      'Beginner',
      name: 'txtDsLevelBeginner',
      desc: '',
      args: [],
    );
  }

  /// `Elementary`
  String get txtDsLevelElementary {
    return Intl.message(
      'Elementary',
      name: 'txtDsLevelElementary',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate`
  String get txtDsLevelIntermediate {
    return Intl.message(
      'Intermediate',
      name: 'txtDsLevelIntermediate',
      desc: '',
      args: [],
    );
  }

  /// `Upper-Intermediate`
  String get txtDsLevelUpperIntermediate {
    return Intl.message(
      'Upper-Intermediate',
      name: 'txtDsLevelUpperIntermediate',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get txtDsLevelAdvanced {
    return Intl.message(
      'Advanced',
      name: 'txtDsLevelAdvanced',
      desc: '',
      args: [],
    );
  }

  /// `Fluent`
  String get txtDsLevelFluent {
    return Intl.message('Fluent', name: 'txtDsLevelFluent', desc: '', args: []);
  }

  /// `Suggested topics`
  String get txtDsSuggestedTopics {
    return Intl.message(
      'Suggested topics',
      name: 'txtDsSuggestedTopics',
      desc: '',
      args: [],
    );
  }

  /// `New this week`
  String get txtDsNewThisWeek {
    return Intl.message(
      'New this week',
      name: 'txtDsNewThisWeek',
      desc: '',
      args: [],
    );
  }

  /// `No topics here yet — check back soon.`
  String get txtDsNoTopicsHere {
    return Intl.message(
      'No topics here yet — check back soon.',
      name: 'txtDsNoTopicsHere',
      desc: '',
      args: [],
    );
  }

  /// `NEW`
  String get txtDsNew {
    return Intl.message('NEW', name: 'txtDsNew', desc: '', args: []);
  }

  /// `~{minutes} min`
  String txtDsApproxMin(Object minutes) {
    return Intl.message(
      '~$minutes min',
      name: 'txtDsApproxMin',
      desc: '',
      args: [minutes],
    );
  }

  /// `{count} target phrases`
  String txtDsTargetPhraseCount(Object count) {
    return Intl.message(
      '$count target phrases',
      name: 'txtDsTargetPhraseCount',
      desc: '',
      args: [count],
    );
  }

  /// `Practiced`
  String get txtDsPracticed {
    return Intl.message(
      'Practiced',
      name: 'txtDsPracticed',
      desc: '',
      args: [],
    );
  }

  /// `Best {score}`
  String txtDsBestScore(Object score) {
    return Intl.message(
      'Best $score',
      name: 'txtDsBestScore',
      desc: '',
      args: [score],
    );
  }

  /// `Practice again ({count})`
  String txtDsPracticeAgain(Object count) {
    return Intl.message(
      'Practice again ($count)',
      name: 'txtDsPracticeAgain',
      desc: '',
      args: [count],
    );
  }

  /// `Words you might use`
  String get txtDsWordsYouMightUse {
    return Intl.message(
      'Words you might use',
      name: 'txtDsWordsYouMightUse',
      desc: '',
      args: [],
    );
  }

  /// `Try to use these phrases`
  String get txtDsTryUseThesePhrases {
    return Intl.message(
      'Try to use these phrases',
      name: 'txtDsTryUseThesePhrases',
      desc: '',
      args: [],
    );
  }

  /// `Things you can mention`
  String get txtDsThingsYouCanMention {
    return Intl.message(
      'Things you can mention',
      name: 'txtDsThingsYouCanMention',
      desc: '',
      args: [],
    );
  }

  /// `Start recording`
  String get txtDsStartRecording {
    return Intl.message(
      'Start recording',
      name: 'txtDsStartRecording',
      desc: '',
      args: [],
    );
  }

  /// `Your prompt`
  String get txtDsYourPrompt {
    return Intl.message(
      'Your prompt',
      name: 'txtDsYourPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get txtDsExample {
    return Intl.message('Example', name: 'txtDsExample', desc: '', args: []);
  }

  /// `Examples`
  String get txtDsExamples {
    return Intl.message('Examples', name: 'txtDsExamples', desc: '', args: []);
  }

  /// `Tap a word to see its meaning`
  String get txtDsTapWordHint {
    return Intl.message(
      'Tap a word to see its meaning',
      name: 'txtDsTapWordHint',
      desc: '',
      args: [],
    );
  }

  /// `How to structure it`
  String get txtDsHowToStructure {
    return Intl.message(
      'How to structure it',
      name: 'txtDsHowToStructure',
      desc: '',
      args: [],
    );
  }

  /// `Grammar patterns`
  String get txtDsGrammarPatterns {
    return Intl.message(
      'Grammar patterns',
      name: 'txtDsGrammarPatterns',
      desc: '',
      args: [],
    );
  }

  /// `Watch out for these`
  String get txtDsWatchOutFor {
    return Intl.message(
      'Watch out for these',
      name: 'txtDsWatchOutFor',
      desc: '',
      args: [],
    );
  }

  /// `Avoid`
  String get txtDsAvoid {
    return Intl.message('Avoid', name: 'txtDsAvoid', desc: '', args: []);
  }

  /// `Say`
  String get txtDsSayInstead {
    return Intl.message('Say', name: 'txtDsSayInstead', desc: '', args: []);
  }

  /// `Example answer`
  String get txtDsExampleAnswer {
    return Intl.message(
      'Example answer',
      name: 'txtDsExampleAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Peek at an example answer`
  String get txtDsPeekExample {
    return Intl.message(
      'Peek at an example answer',
      name: 'txtDsPeekExample',
      desc: '',
      args: [],
    );
  }

  /// `Hide example`
  String get txtDsHideExample {
    return Intl.message(
      'Hide example',
      name: 'txtDsHideExample',
      desc: '',
      args: [],
    );
  }

  /// `What help do you want?`
  String get txtDsChoosePrepTitle {
    return Intl.message(
      'What help do you want?',
      name: 'txtDsChoosePrepTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick what you'd like us to prepare for your topic. You can add more later.`
  String get txtDsChoosePrepSubtitle {
    return Intl.message(
      'Pick what you\'d like us to prepare for your topic. You can add more later.',
      name: 'txtDsChoosePrepSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Build my prep`
  String get txtDsBuildMyPrep {
    return Intl.message(
      'Build my prep',
      name: 'txtDsBuildMyPrep',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get txtDsRecommended {
    return Intl.message(
      'Recommended',
      name: 'txtDsRecommended',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get txtDsSelectAll {
    return Intl.message(
      'Select all',
      name: 'txtDsSelectAll',
      desc: '',
      args: [],
    );
  }

  /// `Pick at least one to continue`
  String get txtDsPrepPickOne {
    return Intl.message(
      'Pick at least one to continue',
      name: 'txtDsPrepPickOne',
      desc: '',
      args: [],
    );
  }

  /// `Add more help`
  String get txtDsAddMoreHelp {
    return Intl.message(
      'Add more help',
      name: 'txtDsAddMoreHelp',
      desc: '',
      args: [],
    );
  }

  /// `A step-by-step outline for your talk`
  String get txtDsPrepDescStructure {
    return Intl.message(
      'A step-by-step outline for your talk',
      name: 'txtDsPrepDescStructure',
      desc: '',
      args: [],
    );
  }

  /// `Useful words with meanings and examples`
  String get txtDsPrepDescVocab {
    return Intl.message(
      'Useful words with meanings and examples',
      name: 'txtDsPrepDescVocab',
      desc: '',
      args: [],
    );
  }

  /// `Handy phrases you can try`
  String get txtDsPrepDescPhrases {
    return Intl.message(
      'Handy phrases you can try',
      name: 'txtDsPrepDescPhrases',
      desc: '',
      args: [],
    );
  }

  /// `Sentence patterns to build on`
  String get txtDsPrepDescGrammar {
    return Intl.message(
      'Sentence patterns to build on',
      name: 'txtDsPrepDescGrammar',
      desc: '',
      args: [],
    );
  }

  /// `Common mistakes to avoid`
  String get txtDsPrepDescMistakes {
    return Intl.message(
      'Common mistakes to avoid',
      name: 'txtDsPrepDescMistakes',
      desc: '',
      args: [],
    );
  }

  /// `A full sample answer (hidden until you tap)`
  String get txtDsPrepDescExample {
    return Intl.message(
      'A full sample answer (hidden until you tap)',
      name: 'txtDsPrepDescExample',
      desc: '',
      args: [],
    );
  }

  /// `Words you can use instead`
  String get txtDsVocabSwapTitle {
    return Intl.message(
      'Words you can use instead',
      name: 'txtDsVocabSwapTitle',
      desc: '',
      args: [],
    );
  }

  /// `Similar words`
  String get txtDsVocabRelatedTitle {
    return Intl.message(
      'Similar words',
      name: 'txtDsVocabRelatedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Opposite`
  String get txtDsVocabOppositeTitle {
    return Intl.message(
      'Opposite',
      name: 'txtDsVocabOppositeTitle',
      desc: '',
      args: [],
    );
  }

  /// `You'll choose this in the next step.`
  String get txtDsVocabPickNext {
    return Intl.message(
      'You\'ll choose this in the next step.',
      name: 'txtDsVocabPickNext',
      desc: '',
      args: [],
    );
  }

  /// `Tap a phrase to see what it means and how to use it.`
  String get txtDsTapPhraseHint {
    return Intl.message(
      'Tap a phrase to see what it means and how to use it.',
      name: 'txtDsTapPhraseHint',
      desc: '',
      args: [],
    );
  }

  /// `Excellent — you sound really fluent!`
  String get txtDsScoreCheerHigh {
    return Intl.message(
      'Excellent — you sound really fluent!',
      name: 'txtDsScoreCheerHigh',
      desc: '',
      args: [],
    );
  }

  /// `Good effort — a few tweaks and you'll shine.`
  String get txtDsScoreCheerMid {
    return Intl.message(
      'Good effort — a few tweaks and you\'ll shine.',
      name: 'txtDsScoreCheerMid',
      desc: '',
      args: [],
    );
  }

  /// `Nice start — keep practicing, you've got this!`
  String get txtDsScoreCheerLow {
    return Intl.message(
      'Nice start — keep practicing, you\'ve got this!',
      name: 'txtDsScoreCheerLow',
      desc: '',
      args: [],
    );
  }

  /// `Show all {count}`
  String txtDsShowAll(Object count) {
    return Intl.message(
      'Show all $count',
      name: 'txtDsShowAll',
      desc: '',
      args: [count],
    );
  }

  /// `Show less`
  String get txtDsShowLess {
    return Intl.message('Show less', name: 'txtDsShowLess', desc: '', args: []);
  }

  /// `Quick picks`
  String get txtDsQuickPicks {
    return Intl.message(
      'Quick picks',
      name: 'txtDsQuickPicks',
      desc: '',
      args: [],
    );
  }

  /// `Try to use`
  String get txtDsTryToUse {
    return Intl.message(
      'Try to use',
      name: 'txtDsTryToUse',
      desc: '',
      args: [],
    );
  }

  /// `Choose your feedback`
  String get txtDsChooseFeedbackTitle {
    return Intl.message(
      'Choose your feedback',
      name: 'txtDsChooseFeedbackTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick what you want the AI to focus on. You can change this anytime — only what you choose is analyzed.`
  String get txtDsChooseFeedbackIntro {
    return Intl.message(
      'Pick what you want the AI to focus on. You can change this anytime — only what you choose is analyzed.',
      name: 'txtDsChooseFeedbackIntro',
      desc: '',
      args: [],
    );
  }

  /// `You'll get a full native rewrite to compare against when you finish this topic.`
  String get txtDsChooseRewriteNote {
    return Intl.message(
      'You\'ll get a full native rewrite to compare against when you finish this topic.',
      name: 'txtDsChooseRewriteNote',
      desc: '',
      args: [],
    );
  }

  /// `Version {revision} — polish your answer and see how much you improve.`
  String txtDsVersionBanner(Object revision) {
    return Intl.message(
      'Version $revision — polish your answer and see how much you improve.',
      name: 'txtDsVersionBanner',
      desc: '',
      args: [revision],
    );
  }

  /// `Select at least one`
  String get txtDsSelectAtLeastOne {
    return Intl.message(
      'Select at least one',
      name: 'txtDsSelectAtLeastOne',
      desc: '',
      args: [],
    );
  }

  /// `{count} selected`
  String txtDsNSelected(Object count) {
    return Intl.message(
      '$count selected',
      name: 'txtDsNSelected',
      desc: '',
      args: [count],
    );
  }

  /// `Accuracy`
  String get txtDsGroupAccuracy {
    return Intl.message(
      'Accuracy',
      name: 'txtDsGroupAccuracy',
      desc: '',
      args: [],
    );
  }

  /// `Style & naturalness`
  String get txtDsGroupStyle {
    return Intl.message(
      'Style & naturalness',
      name: 'txtDsGroupStyle',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get txtDsGroupDelivery {
    return Intl.message(
      'Delivery',
      name: 'txtDsGroupDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Scoring`
  String get txtDsGroupScoring {
    return Intl.message(
      'Scoring',
      name: 'txtDsGroupScoring',
      desc: '',
      args: [],
    );
  }

  /// `Vocabulary`
  String get txtDsVocabulary {
    return Intl.message(
      'Vocabulary',
      name: 'txtDsVocabulary',
      desc: '',
      args: [],
    );
  }

  /// `Grammar`
  String get txtDsGrammar {
    return Intl.message('Grammar', name: 'txtDsGrammar', desc: '', args: []);
  }

  /// `Fluency`
  String get txtDsFluency {
    return Intl.message('Fluency', name: 'txtDsFluency', desc: '', args: []);
  }

  /// `Pronunciation`
  String get txtDsPronunciation {
    return Intl.message(
      'Pronunciation',
      name: 'txtDsPronunciation',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get txtDsPresetRecommended {
    return Intl.message(
      'Recommended',
      name: 'txtDsPresetRecommended',
      desc: '',
      args: [],
    );
  }

  /// `Sound natural`
  String get txtDsPresetSoundNatural {
    return Intl.message(
      'Sound natural',
      name: 'txtDsPresetSoundNatural',
      desc: '',
      args: [],
    );
  }

  /// `Grammar focus`
  String get txtDsPresetGrammarFocus {
    return Intl.message(
      'Grammar focus',
      name: 'txtDsPresetGrammarFocus',
      desc: '',
      args: [],
    );
  }

  /// `Everything`
  String get txtDsPresetEverything {
    return Intl.message(
      'Everything',
      name: 'txtDsPresetEverything',
      desc: '',
      args: [],
    );
  }

  /// `Sentence fixes`
  String get txtDsSecSentenceFixes {
    return Intl.message(
      'Sentence fixes',
      name: 'txtDsSecSentenceFixes',
      desc: '',
      args: [],
    );
  }

  /// `Burmese-English errors`
  String get txtDsBurmeseErrors {
    return Intl.message(
      'Burmese-English errors',
      name: 'txtDsBurmeseErrors',
      desc: '',
      args: [],
    );
  }

  /// `Better word choices`
  String get txtDsBetterWordChoices {
    return Intl.message(
      'Better word choices',
      name: 'txtDsBetterWordChoices',
      desc: '',
      args: [],
    );
  }

  /// `Collocations`
  String get txtDsCollocations {
    return Intl.message(
      'Collocations',
      name: 'txtDsCollocations',
      desc: '',
      args: [],
    );
  }

  /// `Idioms`
  String get txtDsIdioms {
    return Intl.message('Idioms', name: 'txtDsIdioms', desc: '', args: []);
  }

  /// `Phrasal verbs`
  String get txtDsPhrasalVerbs {
    return Intl.message(
      'Phrasal verbs',
      name: 'txtDsPhrasalVerbs',
      desc: '',
      args: [],
    );
  }

  /// `Native rewrite`
  String get txtDsWholeRewriteLabel {
    return Intl.message(
      'Native rewrite',
      name: 'txtDsWholeRewriteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Sentence-by-sentence rewrite`
  String get txtDsSentenceRewriteLabel {
    return Intl.message(
      'Sentence-by-sentence rewrite',
      name: 'txtDsSentenceRewriteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Filler words`
  String get txtDsFillerWords {
    return Intl.message(
      'Filler words',
      name: 'txtDsFillerWords',
      desc: '',
      args: [],
    );
  }

  /// `Skill sub-scores`
  String get txtDsSkillSubScores {
    return Intl.message(
      'Skill sub-scores',
      name: 'txtDsSkillSubScores',
      desc: '',
      args: [],
    );
  }

  /// `Corrects your mistakes with a Burmese reason.`
  String get txtDsDescSentenceFixes {
    return Intl.message(
      'Corrects your mistakes with a Burmese reason.',
      name: 'txtDsDescSentenceFixes',
      desc: '',
      args: [],
    );
  }

  /// `Groups recurring grammar issues so you see the pattern.`
  String get txtDsDescGrammarPatterns {
    return Intl.message(
      'Groups recurring grammar issues so you see the pattern.',
      name: 'txtDsDescGrammarPatterns',
      desc: '',
      args: [],
    );
  }

  /// `Flags direct Burmese→English translations.`
  String get txtDsDescBurmeseErrors {
    return Intl.message(
      'Flags direct Burmese→English translations.',
      name: 'txtDsDescBurmeseErrors',
      desc: '',
      args: [],
    );
  }

  /// `Upgrades basic words to more precise ones.`
  String get txtDsDescBetterVocab {
    return Intl.message(
      'Upgrades basic words to more precise ones.',
      name: 'txtDsDescBetterVocab',
      desc: '',
      args: [],
    );
  }

  /// `Natural word pairings ("make a decision").`
  String get txtDsDescCollocations {
    return Intl.message(
      'Natural word pairings ("make a decision").',
      name: 'txtDsDescCollocations',
      desc: '',
      args: [],
    );
  }

  /// `Useful idioms and expressions you could have used.`
  String get txtDsDescIdioms {
    return Intl.message(
      'Useful idioms and expressions you could have used.',
      name: 'txtDsDescIdioms',
      desc: '',
      args: [],
    );
  }

  /// `Handy phrasal verbs for your topic ("follow through").`
  String get txtDsDescPhrasalVerbs {
    return Intl.message(
      'Handy phrasal verbs for your topic ("follow through").',
      name: 'txtDsDescPhrasalVerbs',
      desc: '',
      args: [],
    );
  }

  /// `One polished version of your whole talk.`
  String get txtDsDescWholeRewrite {
    return Intl.message(
      'One polished version of your whole talk.',
      name: 'txtDsDescWholeRewrite',
      desc: '',
      args: [],
    );
  }

  /// `Each sentence rewritten to sound native.`
  String get txtDsDescSentenceRewrite {
    return Intl.message(
      'Each sentence rewritten to sound native.',
      name: 'txtDsDescSentenceRewrite',
      desc: '',
      args: [],
    );
  }

  /// `Sounds to work on.`
  String get txtDsDescPronunciation {
    return Intl.message(
      'Sounds to work on.',
      name: 'txtDsDescPronunciation',
      desc: '',
      args: [],
    );
  }

  /// `Counts "um", "uh", "like", etc.`
  String get txtDsDescFillerWords {
    return Intl.message(
      'Counts "um", "uh", "like", etc.',
      name: 'txtDsDescFillerWords',
      desc: '',
      args: [],
    );
  }

  /// `Breaks your score into grammar / vocab / fluency / pronunciation.`
  String get txtDsDescSubScores {
    return Intl.message(
      'Breaks your score into grammar / vocab / fluency / pronunciation.',
      name: 'txtDsDescSubScores',
      desc: '',
      args: [],
    );
  }

  /// `Hear your progress`
  String get txtDsHearYourProgress {
    return Intl.message(
      'Hear your progress',
      name: 'txtDsHearYourProgress',
      desc: '',
      args: [],
    );
  }

  /// `Your recording`
  String get txtDsYourRecording {
    return Intl.message(
      'Your recording',
      name: 'txtDsYourRecording',
      desc: '',
      args: [],
    );
  }

  /// `What you said`
  String get txtDsWhatYouSaid {
    return Intl.message(
      'What you said',
      name: 'txtDsWhatYouSaid',
      desc: '',
      args: [],
    );
  }

  /// `What you wrote`
  String get txtDsWhatYouWrote {
    return Intl.message(
      'What you wrote',
      name: 'txtDsWhatYouWrote',
      desc: '',
      args: [],
    );
  }

  /// `Skill breakdown`
  String get txtDsSkillBreakdown {
    return Intl.message(
      'Skill breakdown',
      name: 'txtDsSkillBreakdown',
      desc: '',
      args: [],
    );
  }

  /// `Sentence rewrites`
  String get txtDsSentenceRewritesTitle {
    return Intl.message(
      'Sentence rewrites',
      name: 'txtDsSentenceRewritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Polish & retry`
  String get txtDsPolishRetry {
    return Intl.message(
      'Polish & retry',
      name: 'txtDsPolishRetry',
      desc: '',
      args: [],
    );
  }

  /// `I'm done — see native version`
  String get txtDsImDoneSeeNative {
    return Intl.message(
      'I\'m done — see native version',
      name: 'txtDsImDoneSeeNative',
      desc: '',
      args: [],
    );
  }

  /// `See native version`
  String get txtDsSeeNativeVersion {
    return Intl.message(
      'See native version',
      name: 'txtDsSeeNativeVersion',
      desc: '',
      args: [],
    );
  }

  /// `Your latest attempt at this topic.`
  String get txtDsLatestAttempt {
    return Intl.message(
      'Your latest attempt at this topic.',
      name: 'txtDsLatestAttempt',
      desc: '',
      args: [],
    );
  }

  /// `Up {delta} from v{revision} (was {previous}).`
  String txtDsScoreUp(Object delta, Object revision, Object previous) {
    return Intl.message(
      'Up $delta from v$revision (was $previous).',
      name: 'txtDsScoreUp',
      desc: '',
      args: [delta, revision, previous],
    );
  }

  /// `Down {delta} from v{revision} (was {previous}).`
  String txtDsScoreDown(Object delta, Object revision, Object previous) {
    return Intl.message(
      'Down $delta from v$revision (was $previous).',
      name: 'txtDsScoreDown',
      desc: '',
      args: [delta, revision, previous],
    );
  }

  /// `Same score as v{revision} ({previous}).`
  String txtDsScoreSame(Object revision, Object previous) {
    return Intl.message(
      'Same score as v$revision ($previous).',
      name: 'txtDsScoreSame',
      desc: '',
      args: [revision, previous],
    );
  }

  /// `v{revision}`
  String txtDsVersionShort(Object revision) {
    return Intl.message(
      'v$revision',
      name: 'txtDsVersionShort',
      desc: '',
      args: [revision],
    );
  }

  /// `v{revision} (this one)`
  String txtDsVersionThisOne(Object revision) {
    return Intl.message(
      'v$revision (this one)',
      name: 'txtDsVersionThisOne',
      desc: '',
      args: [revision],
    );
  }

  /// `Native version`
  String get txtDsNativeVersion {
    return Intl.message(
      'Native version',
      name: 'txtDsNativeVersion',
      desc: '',
      args: [],
    );
  }

  /// `Writing a native version of your best attempt…`
  String get txtDsWritingNativeVersion {
    return Intl.message(
      'Writing a native version of your best attempt…',
      name: 'txtDsWritingNativeVersion',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't generate the native version.`
  String get txtDsCouldntGenerateNative {
    return Intl.message(
      'Couldn\'t generate the native version.',
      name: 'txtDsCouldntGenerateNative',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get txtDsTryAgain {
    return Intl.message('Try again', name: 'txtDsTryAgain', desc: '', args: []);
  }

  /// `The AI is busy right now. Please tap to try again.`
  String get txtDsAiBusy {
    return Intl.message(
      'The AI is busy right now. Please tap to try again.',
      name: 'txtDsAiBusy',
      desc: '',
      args: [],
    );
  }

  /// `Here's how a native speaker might say it.`
  String get txtDsNativeHeaderNoScore {
    return Intl.message(
      'Here\'s how a native speaker might say it.',
      name: 'txtDsNativeHeaderNoScore',
      desc: '',
      args: [],
    );
  }

  /// `You finished at {score}. Here's a native version to compare against.`
  String txtDsNativeHeaderScore(Object score) {
    return Intl.message(
      'You finished at $score. Here\'s a native version to compare against.',
      name: 'txtDsNativeHeaderScore',
      desc: '',
      args: [score],
    );
  }

  /// `Your version`
  String get txtDsYourVersion {
    return Intl.message(
      'Your version',
      name: 'txtDsYourVersion',
      desc: '',
      args: [],
    );
  }

  /// `Sentence by sentence`
  String get txtDsSentenceBySentence {
    return Intl.message(
      'Sentence by sentence',
      name: 'txtDsSentenceBySentence',
      desc: '',
      args: [],
    );
  }

  /// `{count} versions · up {delta} from v1`
  String txtDsChainVersionsUp(Object count, Object delta) {
    return Intl.message(
      '$count versions · up $delta from v1',
      name: 'txtDsChainVersionsUp',
      desc: '',
      args: [count, delta],
    );
  }

  /// `{count} versions`
  String txtDsChainVersions(Object count) {
    return Intl.message(
      '$count versions',
      name: 'txtDsChainVersions',
      desc: '',
      args: [count],
    );
  }

  /// `Talk about`
  String get txtDsTalkAbout {
    return Intl.message(
      'Talk about',
      name: 'txtDsTalkAbout',
      desc: '',
      args: [],
    );
  }

  /// `Review & highlights`
  String get txtDsReviewHighlights {
    return Intl.message(
      'Review & highlights',
      name: 'txtDsReviewHighlights',
      desc: '',
      args: [],
    );
  }

  /// `Highlights`
  String get txtDsHighlights {
    return Intl.message(
      'Highlights',
      name: 'txtDsHighlights',
      desc: '',
      args: [],
    );
  }

  /// `Compare`
  String get txtDsCompare {
    return Intl.message('Compare', name: 'txtDsCompare', desc: '', args: []);
  }

  /// `Interference`
  String get txtDsInterference {
    return Intl.message(
      'Interference',
      name: 'txtDsInterference',
      desc: '',
      args: [],
    );
  }

  /// `Filler`
  String get txtDsFiller {
    return Intl.message('Filler', name: 'txtDsFiller', desc: '', args: []);
  }

  /// `Word choice`
  String get txtDsWordChoice {
    return Intl.message(
      'Word choice',
      name: 'txtDsWordChoice',
      desc: '',
      args: [],
    );
  }

  /// `Patterns to study`
  String get txtDsStudyPatterns {
    return Intl.message(
      'Patterns to study',
      name: 'txtDsStudyPatterns',
      desc: '',
      args: [],
    );
  }

  /// `Tap a highlighted word to see the fix.`
  String get txtDsReviewTapHint {
    return Intl.message(
      'Tap a highlighted word to see the fix.',
      name: 'txtDsReviewTapHint',
      desc: '',
      args: [],
    );
  }

  /// `Your progress`
  String get txtDsProgressTitle {
    return Intl.message(
      'Your progress',
      name: 'txtDsProgressTitle',
      desc: '',
      args: [],
    );
  }

  /// `You gained {points} points from your first try — keep it up!`
  String txtDsProgressUp(Object points) {
    return Intl.message(
      'You gained $points points from your first try — keep it up!',
      name: 'txtDsProgressUp',
      desc: '',
      args: [points],
    );
  }

  /// `Down {points} from your first try — every rep still counts.`
  String txtDsProgressDown(Object points) {
    return Intl.message(
      'Down $points from your first try — every rep still counts.',
      name: 'txtDsProgressDown',
      desc: '',
      args: [points],
    );
  }

  /// `Same score as your first try — consistency is progress too.`
  String get txtDsProgressSame {
    return Intl.message(
      'Same score as your first try — consistency is progress too.',
      name: 'txtDsProgressSame',
      desc: '',
      args: [],
    );
  }

  /// `Phrases to try next time`
  String get txtDsPhrasesToTry {
    return Intl.message(
      'Phrases to try next time',
      name: 'txtDsPhrasesToTry',
      desc: '',
      args: [],
    );
  }

  /// `Natural ways to say this on your topic — you didn't use these yet, so try working them in next time.`
  String get txtDsPhrasesToTryHint {
    return Intl.message(
      'Natural ways to say this on your topic — you didn\'t use these yet, so try working them in next time.',
      name: 'txtDsPhrasesToTryHint',
      desc: '',
      args: [],
    );
  }

  /// `Import audio`
  String get txtDsImportAudio {
    return Intl.message(
      'Import audio',
      name: 'txtDsImportAudio',
      desc: '',
      args: [],
    );
  }

  /// `Import a recording instead`
  String get txtDsImportInstead {
    return Intl.message(
      'Import a recording instead',
      name: 'txtDsImportInstead',
      desc: '',
      args: [],
    );
  }

  /// `Use this recording`
  String get txtDsImportUseRecording {
    return Intl.message(
      'Use this recording',
      name: 'txtDsImportUseRecording',
      desc: '',
      args: [],
    );
  }

  /// `Already recorded yourself speaking English? Import it and get the same feedback. One clear voice, up to 5 minutes, works best.`
  String get txtDsImportIntro {
    return Intl.message(
      'Already recorded yourself speaking English? Import it and get the same feedback. One clear voice, up to 5 minutes, works best.',
      name: 'txtDsImportIntro',
      desc: '',
      args: [],
    );
  }

  /// `Choose audio file`
  String get txtDsImportChooseFile {
    return Intl.message(
      'Choose audio file',
      name: 'txtDsImportChooseFile',
      desc: '',
      args: [],
    );
  }

  /// `Choose a different file`
  String get txtDsImportChangeFile {
    return Intl.message(
      'Choose a different file',
      name: 'txtDsImportChangeFile',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported format. Use m4a, mp3, wav, aac, ogg, or flac.`
  String get txtDsImportUnsupported {
    return Intl.message(
      'Unsupported format. Use m4a, mp3, wav, aac, ogg, or flac.',
      name: 'txtDsImportUnsupported',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't read that audio file. Try another one.`
  String get txtDsImportUnreadable {
    return Intl.message(
      'Couldn\'t read that audio file. Try another one.',
      name: 'txtDsImportUnreadable',
      desc: '',
      args: [],
    );
  }

  /// `That clip is too short — it needs at least a few seconds of speech.`
  String get txtDsImportTooShort {
    return Intl.message(
      'That clip is too short — it needs at least a few seconds of speech.',
      name: 'txtDsImportTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Audio must be {minutes} minutes or less.`
  String txtDsImportTooLong(Object minutes) {
    return Intl.message(
      'Audio must be $minutes minutes or less.',
      name: 'txtDsImportTooLong',
      desc: '',
      args: [minutes],
    );
  }

  /// `That file is too large (max {mb} MB).`
  String txtDsImportTooBig(Object mb) {
    return Intl.message(
      'That file is too large (max $mb MB).',
      name: 'txtDsImportTooBig',
      desc: '',
      args: [mb],
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
