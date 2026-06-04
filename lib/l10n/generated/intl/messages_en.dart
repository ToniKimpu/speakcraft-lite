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

  static String m1(minutes) => "~${minutes} min";

  static String m2(count) => "At least ${count} characters";

  static String m3(duration) => "max ${duration}";

  static String m4(wpm) => "${wpm} wpm";

  static String m5(onRamp, seconds, words) =>
      "${onRamp} • ${seconds}s • ${words} words";

  static String m6(used, total) => "${used} of ${total} sessions today";

  static String m7(count) => "${count} target phrases";

  static String m8(label) => "Topic: ${label}";

  static String m9(count) => "Write at least ${count} characters.";

  static String m10(total) => "out of ${total}";

  static String m11(done, total) => "${done} of ${total}";

  static String m12(count) => "${count}-step lesson";

  static String m13(done, total) => "${done} of ${total} steps";

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
    "txtDailySpeaking": MessageLookupByLibrary.simpleMessage("Daily Speaking"),
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
    "txtDone": MessageLookupByLibrary.simpleMessage("Done"),
    "txtDsApproxMin": m1,
    "txtDsAtLeastChars": m2,
    "txtDsDailyLimitReached": MessageLookupByLibrary.simpleMessage(
      "Daily limit reached — comes back tomorrow.",
    ),
    "txtDsDailyLimitReachedShort": MessageLookupByLibrary.simpleMessage(
      "Daily limit reached",
    ),
    "txtDsExample": MessageLookupByLibrary.simpleMessage("Example"),
    "txtDsFeedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "txtDsGetFeedback": MessageLookupByLibrary.simpleMessage("Get feedback"),
    "txtDsHeadline": MessageLookupByLibrary.simpleMessage(
      "Three minutes a day.",
    ),
    "txtDsHistory": MessageLookupByLibrary.simpleMessage("History"),
    "txtDsHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Daily Speaking History",
    ),
    "txtDsHowItWorks": MessageLookupByLibrary.simpleMessage("How it works"),
    "txtDsHowItWorksBody": MessageLookupByLibrary.simpleMessage(
      "• Tap the mic and just talk for up to 5 minutes.\n• When you stop, the AI gives you a score, strengths, fixes, and a Burmese explanation.\n• Don\'t worry about being perfect — the goal is to keep speaking.",
    ),
    "txtDsJustTalk": MessageLookupByLibrary.simpleMessage("Just talk"),
    "txtDsJustTalkDesc": MessageLookupByLibrary.simpleMessage(
      "No topic, no pressure. Speak freely — the AI will identify what you talked about and give you feedback.",
    ),
    "txtDsLevelAdvanced": MessageLookupByLibrary.simpleMessage("Advanced"),
    "txtDsLevelBeginner": MessageLookupByLibrary.simpleMessage("Beginner"),
    "txtDsLevelElementary": MessageLookupByLibrary.simpleMessage("Elementary"),
    "txtDsLevelFluent": MessageLookupByLibrary.simpleMessage("Fluent"),
    "txtDsLevelIntermediate": MessageLookupByLibrary.simpleMessage(
      "Intermediate",
    ),
    "txtDsLevelUpperIntermediate": MessageLookupByLibrary.simpleMessage(
      "Upper-Intermediate",
    ),
    "txtDsLimitReached": MessageLookupByLibrary.simpleMessage("Limit reached"),
    "txtDsMaxDuration": m3,
    "txtDsNativeRewrite": MessageLookupByLibrary.simpleMessage(
      "How a native speaker would say it",
    ),
    "txtDsNew": MessageLookupByLibrary.simpleMessage("NEW"),
    "txtDsNewThisWeek": MessageLookupByLibrary.simpleMessage("New this week"),
    "txtDsNoSessionsBody": MessageLookupByLibrary.simpleMessage(
      "Your past Daily Speaking sessions will show up here.",
    ),
    "txtDsNoSessionsYet": MessageLookupByLibrary.simpleMessage(
      "No sessions yet",
    ),
    "txtDsNoTopicsHere": MessageLookupByLibrary.simpleMessage(
      "No topics here yet — check back soon.",
    ),
    "txtDsOwnTopic": MessageLookupByLibrary.simpleMessage("Own topic"),
    "txtDsOwnTopicDesc": MessageLookupByLibrary.simpleMessage(
      "Tell us what you want to talk about, then speak or type.",
    ),
    "txtDsPace": MessageLookupByLibrary.simpleMessage("Pace"),
    "txtDsPaceWpm": m4,
    "txtDsPronunciationNotes": MessageLookupByLibrary.simpleMessage(
      "Pronunciation notes",
    ),
    "txtDsRecordThis": MessageLookupByLibrary.simpleMessage("Record this"),
    "txtDsRecordingUnavailable": MessageLookupByLibrary.simpleMessage(
      "Recording is unavailable.",
    ),
    "txtDsReviewingRecording": MessageLookupByLibrary.simpleMessage(
      "Reviewing your recording…",
    ),
    "txtDsReviewingTakesSeconds": MessageLookupByLibrary.simpleMessage(
      "This usually takes a few seconds.",
    ),
    "txtDsReviewingWriting": MessageLookupByLibrary.simpleMessage(
      "Reviewing your writing…",
    ),
    "txtDsSessionMeta": m5,
    "txtDsSessionsToday": m6,
    "txtDsStartRecording": MessageLookupByLibrary.simpleMessage(
      "Start recording",
    ),
    "txtDsSubhead": MessageLookupByLibrary.simpleMessage(
      "Pick how you want to start. Speak or write, then get instant feedback.",
    ),
    "txtDsSuggested": MessageLookupByLibrary.simpleMessage("Suggested"),
    "txtDsSuggestedTopic": MessageLookupByLibrary.simpleMessage(
      "Suggested topic",
    ),
    "txtDsSuggestedTopicDesc": MessageLookupByLibrary.simpleMessage(
      "Pick from curated prompts with vocabulary and target phrases.",
    ),
    "txtDsSuggestedTopics": MessageLookupByLibrary.simpleMessage(
      "Suggested topics",
    ),
    "txtDsSuggestionFamily": MessageLookupByLibrary.simpleMessage("My family"),
    "txtDsSuggestionGoal": MessageLookupByLibrary.simpleMessage(
      "A goal I have",
    ),
    "txtDsSuggestionJob": MessageLookupByLibrary.simpleMessage("My job"),
    "txtDsSuggestionTrip": MessageLookupByLibrary.simpleMessage(
      "A recent trip",
    ),
    "txtDsSuggestionWorried": MessageLookupByLibrary.simpleMessage(
      "Something I\'m worried about",
    ),
    "txtDsSummaryMm": MessageLookupByLibrary.simpleMessage("အကျဉ်းချုပ်"),
    "txtDsTapToStart": MessageLookupByLibrary.simpleMessage(
      "Tap and start talking",
    ),
    "txtDsTapToStop": MessageLookupByLibrary.simpleMessage("Tap to stop"),
    "txtDsTargetPhraseCount": m7,
    "txtDsTargetPhrases": MessageLookupByLibrary.simpleMessage(
      "Target phrases",
    ),
    "txtDsThingsToFix": MessageLookupByLibrary.simpleMessage("Things to fix"),
    "txtDsThingsYouCanMention": MessageLookupByLibrary.simpleMessage(
      "Things you can mention",
    ),
    "txtDsTime": MessageLookupByLibrary.simpleMessage("Time"),
    "txtDsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "txtDsTopicColon": m8,
    "txtDsTopicFieldHint": MessageLookupByLibrary.simpleMessage(
      "e.g. The most stressful week I had",
    ),
    "txtDsTopicHint": MessageLookupByLibrary.simpleMessage(
      "A topic, a question, or just a vibe — keep it short.",
    ),
    "txtDsTryOneOfThese": MessageLookupByLibrary.simpleMessage(
      "Try one of these",
    ),
    "txtDsTryToUse": MessageLookupByLibrary.simpleMessage("Try to use"),
    "txtDsTryTopicAgain": MessageLookupByLibrary.simpleMessage(
      "Try this topic again",
    ),
    "txtDsTryUseThesePhrases": MessageLookupByLibrary.simpleMessage(
      "Try to use these phrases",
    ),
    "txtDsWhatToTalkAbout": MessageLookupByLibrary.simpleMessage(
      "What do you want to talk about?",
    ),
    "txtDsWhatYouDidWell": MessageLookupByLibrary.simpleMessage(
      "What you did well",
    ),
    "txtDsWords": MessageLookupByLibrary.simpleMessage("Words"),
    "txtDsWordsYouMightUse": MessageLookupByLibrary.simpleMessage(
      "Words you might use",
    ),
    "txtDsWriteAtLeastChars": m9,
    "txtDsWriteInstead": MessageLookupByLibrary.simpleMessage("Write instead"),
    "txtDsWritePathHint": MessageLookupByLibrary.simpleMessage(
      "Write a paragraph about your topic. Aim for 5-10 sentences.",
    ),
    "txtDsYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "txtDsYourPrompt": MessageLookupByLibrary.simpleMessage("Your prompt"),
    "txtDsYourTopic": MessageLookupByLibrary.simpleMessage("Your topic"),
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
    "txtNoInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection.",
    ),
    "txtNoRecordForSentence": MessageLookupByLibrary.simpleMessage(
      "No Record Found For This Sentence",
    ),
    "txtNotAnswer": MessageLookupByLibrary.simpleMessage("Not Answer"),
    "txtNotStarted": MessageLookupByLibrary.simpleMessage("Not started"),
    "txtOk": MessageLookupByLibrary.simpleMessage("Okay"),
    "txtOutOf": m10,
    "txtPlaybackDisabledWhileRecording": MessageLookupByLibrary.simpleMessage(
      "Playback is disabled while recording. Please stop the recording to continue.",
    ),
    "txtPlaybackSpeed": MessageLookupByLibrary.simpleMessage("Playback speed"),
    "txtPressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Press back again to exit",
    ),
    "txtPrivacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "txtProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "txtProgressXofY": m11,
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
    "txtStepLesson": m12,
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
    "txtStepsProgress": m13,
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
