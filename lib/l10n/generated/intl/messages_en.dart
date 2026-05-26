// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(step) => "Continue · ${step}";

  static String m1(total) => "out of ${total}";

  static String m2(done, total) => "${done} of ${total}";

  static String m3(count) => "${count}-step lesson";

  static String m4(done, total) => "${done} of ${total} steps";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "txtAccountID": MessageLookupByLibrary.simpleMessage("Account ID"),
    "txtAllStepsComplete": MessageLookupByLibrary.simpleMessage(
      "All steps complete — great work!",
    ),
    "txtAnswerLabel": MessageLookupByLibrary.simpleMessage("Answer: "),
    "txtAppearance": MessageLookupByLibrary.simpleMessage("Appearance"),
    "txtCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "txtChangeAvatar": MessageLookupByLibrary.simpleMessage("Change Avatar"),
    "txtChangeName": MessageLookupByLibrary.simpleMessage("Change Name"),
    "txtCheck": MessageLookupByLibrary.simpleMessage("Check"),
    "txtCheckYourself": MessageLookupByLibrary.simpleMessage("Check yourself"),
    "txtCheckingAnswers": MessageLookupByLibrary.simpleMessage(
      "Checking your answers",
    ),
    "txtChooseHighlightType": MessageLookupByLibrary.simpleMessage(
      "Choose Highlight Type",
    ),
    "txtComingSoon": MessageLookupByLibrary.simpleMessage("Coming Soon"),
    "txtComingSoonDots": MessageLookupByLibrary.simpleMessage(
      "Coming soon....",
    ),
    "txtCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "txtConnectionTimedOut": MessageLookupByLibrary.simpleMessage(
      "Connection timed out. Please try again.",
    ),
    "txtContentRequest": MessageLookupByLibrary.simpleMessage(
      "Content Request",
    ),
    "txtContinueLearning": MessageLookupByLibrary.simpleMessage(
      "Continue learning",
    ),
    "txtContinueStep": m0,
    "txtCorrect": MessageLookupByLibrary.simpleMessage("Correct"),
    "txtDayStreak": MessageLookupByLibrary.simpleMessage("Day Streak"),
    "txtDaysLearned": MessageLookupByLibrary.simpleMessage("Days Learned"),
    "txtDelete": MessageLookupByLibrary.simpleMessage("Delete"),
    "txtDeleteRecordingBody": MessageLookupByLibrary.simpleMessage(
      "This will permanently remove your recorded audio:",
    ),
    "txtDeleteRecordingTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Recording?",
    ),
    "txtDiscard": MessageLookupByLibrary.simpleMessage("Discard"),
    "txtExplanation": MessageLookupByLibrary.simpleMessage("Explanation"),
    "txtExplanationGenericError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong while loading this explanation.",
    ),
    "txtExplanationLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load explanation",
    ),
    "txtExplanationLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to load explanation. Please try again later.",
    ),
    "txtExplanationNotFound": MessageLookupByLibrary.simpleMessage(
      "Explanation not found.",
    ),
    "txtFailedToOpenBrowser": MessageLookupByLibrary.simpleMessage(
      "Failed to open browser!",
    ),
    "txtFeedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "txtFillTheBlank": MessageLookupByLibrary.simpleMessage("Fill the blank"),
    "txtHighlightLine": MessageLookupByLibrary.simpleMessage("Line"),
    "txtHighlightNone": MessageLookupByLibrary.simpleMessage("None"),
    "txtHighlightReadAlong": MessageLookupByLibrary.simpleMessage("Read Along"),
    "txtInProgress": MessageLookupByLibrary.simpleMessage("In progress"),
    "txtIncorrect": MessageLookupByLibrary.simpleMessage("Incorrect"),
    "txtKeepIt": MessageLookupByLibrary.simpleMessage("Keep It"),
    "txtLesson": MessageLookupByLibrary.simpleMessage("Lesson"),
    "txtListeningListTitle": MessageLookupByLibrary.simpleMessage(
      "Listening And Shadowing",
    ),
    "txtModuleBookmarksLabel1": MessageLookupByLibrary.simpleMessage(
      "ကိုယ်တိုင် save ထားသော bookmarks များ",
    ),
    "txtModuleBookmarksLabel2": MessageLookupByLibrary.simpleMessage(
      "Vocabulary, phrase, grammar ကို ပြန်လေ့လာမယ်",
    ),
    "txtModuleBookmarksTitle": MessageLookupByLibrary.simpleMessage(
      "Bookmarks",
    ),
    "txtModuleListeningLabel1": MessageLookupByLibrary.simpleMessage(
      "Listening လုပ်မယ်။",
    ),
    "txtModuleListeningLabel2": MessageLookupByLibrary.simpleMessage(
      "Shadowing လိုက်လုပ်မယ်။",
    ),
    "txtModuleListeningTitle": MessageLookupByLibrary.simpleMessage(
      "Listening & Shadowing",
    ),
    "txtName": MessageLookupByLibrary.simpleMessage("Name"),
    "txtNetworkError": MessageLookupByLibrary.simpleMessage(
      "Network error. Please check your internet connection.",
    ),
    "txtNoRecordForSentence": MessageLookupByLibrary.simpleMessage(
      "No Record Found For This Sentence",
    ),
    "txtNotAnswer": MessageLookupByLibrary.simpleMessage("Not Answer"),
    "txtNotStarted": MessageLookupByLibrary.simpleMessage("Not started"),
    "txtOk": MessageLookupByLibrary.simpleMessage("Okay"),
    "txtOutOf": m1,
    "txtPlaybackDisabledWhileRecording": MessageLookupByLibrary.simpleMessage(
      "Playback is disabled while recording. Please stop the recording to continue.",
    ),
    "txtPlaybackSpeed": MessageLookupByLibrary.simpleMessage("Playback speed"),
    "txtPressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Press back again to exit",
    ),
    "txtPrivacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "txtProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "txtProgressXofY": m2,
    "txtRecommendedNext": MessageLookupByLibrary.simpleMessage(
      "Recommended next",
    ),
    "txtRecordComingSoonBody": MessageLookupByLibrary.simpleMessage(
      "We’re polishing the record subtitles to give you the best shadowing experience.\nCheck back soon and get ready to practice!",
    ),
    "txtRecordingName": MessageLookupByLibrary.simpleMessage("Recording name"),
    "txtRecords": MessageLookupByLibrary.simpleMessage("Records"),
    "txtRemove": MessageLookupByLibrary.simpleMessage("Remove"),
    "txtRemoved": MessageLookupByLibrary.simpleMessage("Removed"),
    "txtSave": MessageLookupByLibrary.simpleMessage("Save"),
    "txtSaveRecordingTitle": MessageLookupByLibrary.simpleMessage(
      "Save your recording?",
    ),
    "txtSaved": MessageLookupByLibrary.simpleMessage("Saved"),
    "txtSentenceExplanationComing": MessageLookupByLibrary.simpleMessage(
      "Sentence explanation is on the way.\nStay tuned!",
    ),
    "txtSentenceExplanations": MessageLookupByLibrary.simpleMessage(
      "Sentence Explanations",
    ),
    "txtShadowing": MessageLookupByLibrary.simpleMessage("Shadowing"),
    "txtShowHint": MessageLookupByLibrary.simpleMessage("Show hint"),
    "txtSpeechPracticeSession": MessageLookupByLibrary.simpleMessage(
      "Speech Practice Session",
    ),
    "txtStartHere": MessageLookupByLibrary.simpleMessage("Start here"),
    "txtStepLesson": m3,
    "txtStepRecordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Record yourself and compare to the original",
    ),
    "txtStepRecordTitle": MessageLookupByLibrary.simpleMessage(
      "Speak on your own",
    ),
    "txtStepShadowSubtitle": MessageLookupByLibrary.simpleMessage(
      "Speak in sync with the audio",
    ),
    "txtStepShadowTitle": MessageLookupByLibrary.simpleMessage(
      "Practice along (shadowing)",
    ),
    "txtStepStudySubtitle": MessageLookupByLibrary.simpleMessage(
      "Review grammar and vocabulary used in this video",
    ),
    "txtStepStudyTitle": MessageLookupByLibrary.simpleMessage(
      "Study the patterns",
    ),
    "txtStepWatchSubtitle": MessageLookupByLibrary.simpleMessage(
      "Listen with subtitles to understand the content",
    ),
    "txtStepWatchTitle": MessageLookupByLibrary.simpleMessage("Watch"),
    "txtStepsProgress": m4,
    "txtStream": MessageLookupByLibrary.simpleMessage("Stream"),
    "txtTapToRecord": MessageLookupByLibrary.simpleMessage("Tap to record"),
    "txtThemeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "txtThemeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "txtThemeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "txtTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "txtTypeMissingWords": MessageLookupByLibrary.simpleMessage(
      "Type the missing word(s)",
    ),
    "txtViewExplanation": MessageLookupByLibrary.simpleMessage(
      "View Explanation",
    ),
    "txtVocabComingSoon": MessageLookupByLibrary.simpleMessage(
      "သည်ဗီဒီယိုအတွက် vocabularyများ\n မကြာခင်တင်ပေးပါမည်။",
    ),
    "txtVocabularies": MessageLookupByLibrary.simpleMessage("Vocabularies"),
    "txtWillUploadSoon": MessageLookupByLibrary.simpleMessage(
      "မကြာခင်တင်ပေးပါမည်",
    ),
    "txtYourLevel": MessageLookupByLibrary.simpleMessage("Your Level"),
  };
}
