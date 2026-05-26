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
