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

  static String m3(score) => "Best ${score}";

  static String m4(count) => "${count} versions";

  static String m5(count, delta) => "${count} versions · up ${delta} from v1";

  static String m6(level) => "Level ${level}";

  static String m7(mb) => "That file is too large (max ${mb} MB).";

  static String m8(minutes) => "Audio must be ${minutes} minutes or less.";

  static String m9(duration) => "max ${duration}";

  static String m10(count) => "${count} selected";

  static String m11(score) =>
      "You finished at ${score}. Here\'s a native version to compare against.";

  static String m12(wpm) => "${wpm} wpm";

  static String m13(count) => "Practice again (${count})";

  static String m14(points) =>
      "Down ${points} from your first try — every rep still counts.";

  static String m15(points) =>
      "You gained ${points} points from your first try — keep it up!";

  static String m16(delta, revision, previous) =>
      "Down ${delta} from v${revision} (was ${previous}).";

  static String m17(revision, previous) =>
      "Same score as v${revision} (${previous}).";

  static String m18(delta, revision, previous) =>
      "Up ${delta} from v${revision} (was ${previous}).";

  static String m19(onRamp, seconds, words) =>
      "${onRamp} • ${seconds}s • ${words} words";

  static String m20(used, total) => "${used} of ${total} sessions today";

  static String m21(count) => "Show all ${count}";

  static String m22(count) => "${count} target phrases";

  static String m23(label) => "Topic: ${label}";

  static String m24(revision) =>
      "Version ${revision} — polish your answer and see how much you improve.";

  static String m25(revision) => "v${revision}";

  static String m26(revision) => "v${revision} (this one)";

  static String m27(count) => "Write at least ${count} characters.";

  static String m28(email) => "Enter the 6-digit code we sent to ${email}";

  static String m29(total) => "out of ${total}";

  static String m30(minutes) =>
      "Follow this ${minutes}-min talk at full native speed";

  static String m31(count) => "Master ${count} speaking patterns natives use";

  static String m32(count) => "Shadow ${count} sentences at native speed";

  static String m33(count) =>
      "Learn ${count} new words with correct pronunciation";

  static String m34(done, total) => "${done} of ${total}";

  static String m35(seconds) => "Resend in ${seconds}s";

  static String m36(count) => "${count}-step lesson";

  static String m37(done, total) => "${done} of ${total} steps";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "txtAccountID": MessageLookupByLibrary.simpleMessage("Account ID"),
    "txtAllStepsComplete": MessageLookupByLibrary.simpleMessage(
      "All steps complete — great work!",
    ),
    "txtAlreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
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
    "txtCodeResent": MessageLookupByLibrary.simpleMessage(
      "A new code has been sent",
    ),
    "txtComingSoon": MessageLookupByLibrary.simpleMessage("Coming Soon"),
    "txtComingSoonDots": MessageLookupByLibrary.simpleMessage(
      "Coming soon....",
    ),
    "txtCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "txtConfirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm new password",
    ),
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
    "txtContinueWithGoogle": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "txtCorrect": MessageLookupByLibrary.simpleMessage("Correct"),
    "txtCreateAccount": MessageLookupByLibrary.simpleMessage(
      "Create an account",
    ),
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
    "txtDidntGetCode": MessageLookupByLibrary.simpleMessage(
      "Didn\'t get the code?",
    ),
    "txtDiscard": MessageLookupByLibrary.simpleMessage("Discard"),
    "txtDone": MessageLookupByLibrary.simpleMessage("Done"),
    "txtDontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "txtDsApproxMin": m1,
    "txtDsAskForMore": MessageLookupByLibrary.simpleMessage("Ask for more"),
    "txtDsAskHarderWords": MessageLookupByLibrary.simpleMessage("Harder words"),
    "txtDsAskHowToStart": MessageLookupByLibrary.simpleMessage(
      "How do I start?",
    ),
    "txtDsAskMoreVocab": MessageLookupByLibrary.simpleMessage(
      "More vocabulary",
    ),
    "txtDsAskUsefulPhrases": MessageLookupByLibrary.simpleMessage(
      "Useful phrases",
    ),
    "txtDsAsksUsedUp": MessageLookupByLibrary.simpleMessage(
      "That\'s all the prep help for this topic.",
    ),
    "txtDsAtLeastChars": m2,
    "txtDsBestScore": m3,
    "txtDsBetterWordChoices": MessageLookupByLibrary.simpleMessage(
      "Better word choices",
    ),
    "txtDsBuildingPrep": MessageLookupByLibrary.simpleMessage(
      "Building your prep…",
    ),
    "txtDsBurmeseErrors": MessageLookupByLibrary.simpleMessage(
      "Burmese-English errors",
    ),
    "txtDsChainVersions": m4,
    "txtDsChainVersionsUp": m5,
    "txtDsChooseFeedbackIntro": MessageLookupByLibrary.simpleMessage(
      "Pick what you want the AI to focus on. You can change this anytime — only what you choose is analyzed.",
    ),
    "txtDsChooseFeedbackTitle": MessageLookupByLibrary.simpleMessage(
      "Choose your feedback",
    ),
    "txtDsChooseRewriteNote": MessageLookupByLibrary.simpleMessage(
      "You\'ll get a full native rewrite to compare against when you finish this topic.",
    ),
    "txtDsCollocations": MessageLookupByLibrary.simpleMessage("Collocations"),
    "txtDsCompare": MessageLookupByLibrary.simpleMessage("Compare"),
    "txtDsCouldntGenerateNative": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t generate the native version.",
    ),
    "txtDsDailyLimitReached": MessageLookupByLibrary.simpleMessage(
      "Daily limit reached — comes back tomorrow.",
    ),
    "txtDsDailyLimitReachedShort": MessageLookupByLibrary.simpleMessage(
      "Daily limit reached",
    ),
    "txtDsDescBetterVocab": MessageLookupByLibrary.simpleMessage(
      "Upgrades basic words to more precise ones.",
    ),
    "txtDsDescBurmeseErrors": MessageLookupByLibrary.simpleMessage(
      "Flags direct Burmese→English translations.",
    ),
    "txtDsDescCollocations": MessageLookupByLibrary.simpleMessage(
      "Natural word pairings (\"make a decision\").",
    ),
    "txtDsDescFillerWords": MessageLookupByLibrary.simpleMessage(
      "Counts \"um\", \"uh\", \"like\", etc.",
    ),
    "txtDsDescGrammarPatterns": MessageLookupByLibrary.simpleMessage(
      "Groups recurring grammar issues so you see the pattern.",
    ),
    "txtDsDescIdioms": MessageLookupByLibrary.simpleMessage(
      "Idioms and phrasal verbs you could have used.",
    ),
    "txtDsDescPronunciation": MessageLookupByLibrary.simpleMessage(
      "Sounds to work on.",
    ),
    "txtDsDescSentenceFixes": MessageLookupByLibrary.simpleMessage(
      "Corrects your mistakes with a Burmese reason.",
    ),
    "txtDsDescSentenceRewrite": MessageLookupByLibrary.simpleMessage(
      "Each sentence rewritten to sound native.",
    ),
    "txtDsDescSubScores": MessageLookupByLibrary.simpleMessage(
      "Breaks your score into grammar / vocab / fluency / pronunciation.",
    ),
    "txtDsDescWholeRewrite": MessageLookupByLibrary.simpleMessage(
      "One polished version of your whole talk.",
    ),
    "txtDsExample": MessageLookupByLibrary.simpleMessage("Example"),
    "txtDsExamples": MessageLookupByLibrary.simpleMessage("Examples"),
    "txtDsFeedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "txtDsFieldHint1": MessageLookupByLibrary.simpleMessage(
      "e.g. The most stressful week I had",
    ),
    "txtDsFieldHint10": MessageLookupByLibrary.simpleMessage(
      "e.g. What I did last weekend",
    ),
    "txtDsFieldHint11": MessageLookupByLibrary.simpleMessage(
      "e.g. A skill I wish I had",
    ),
    "txtDsFieldHint12": MessageLookupByLibrary.simpleMessage(
      "e.g. My morning routine",
    ),
    "txtDsFieldHint13": MessageLookupByLibrary.simpleMessage(
      "e.g. A video that stuck with me",
    ),
    "txtDsFieldHint14": MessageLookupByLibrary.simpleMessage(
      "e.g. Something that made me laugh recently",
    ),
    "txtDsFieldHint15": MessageLookupByLibrary.simpleMessage(
      "e.g. A decision I\'m trying to make",
    ),
    "txtDsFieldHint16": MessageLookupByLibrary.simpleMessage(
      "e.g. What my ideal day looks like",
    ),
    "txtDsFieldHint17": MessageLookupByLibrary.simpleMessage(
      "e.g. A challenge at work or school",
    ),
    "txtDsFieldHint18": MessageLookupByLibrary.simpleMessage(
      "e.g. Advice I\'d give my younger self",
    ),
    "txtDsFieldHint19": MessageLookupByLibrary.simpleMessage(
      "e.g. A tradition in my family",
    ),
    "txtDsFieldHint2": MessageLookupByLibrary.simpleMessage(
      "e.g. A small win I\'m proud of",
    ),
    "txtDsFieldHint20": MessageLookupByLibrary.simpleMessage(
      "e.g. Something I\'m grateful for today",
    ),
    "txtDsFieldHint21": MessageLookupByLibrary.simpleMessage(
      "e.g. A goal for this year",
    ),
    "txtDsFieldHint22": MessageLookupByLibrary.simpleMessage(
      "e.g. The last time I felt nervous",
    ),
    "txtDsFieldHint23": MessageLookupByLibrary.simpleMessage(
      "e.g. A song I can\'t stop playing",
    ),
    "txtDsFieldHint24": MessageLookupByLibrary.simpleMessage(
      "e.g. How I spend my free time",
    ),
    "txtDsFieldHint25": MessageLookupByLibrary.simpleMessage(
      "e.g. Something new I tried recently",
    ),
    "txtDsFieldHint3": MessageLookupByLibrary.simpleMessage(
      "e.g. Why I started learning English",
    ),
    "txtDsFieldHint4": MessageLookupByLibrary.simpleMessage(
      "e.g. My favorite way to relax",
    ),
    "txtDsFieldHint5": MessageLookupByLibrary.simpleMessage(
      "e.g. A person who inspires me",
    ),
    "txtDsFieldHint6": MessageLookupByLibrary.simpleMessage(
      "e.g. Something I changed my mind about",
    ),
    "txtDsFieldHint7": MessageLookupByLibrary.simpleMessage(
      "e.g. A habit I want to build",
    ),
    "txtDsFieldHint8": MessageLookupByLibrary.simpleMessage(
      "e.g. The best meal I\'ve ever had",
    ),
    "txtDsFieldHint9": MessageLookupByLibrary.simpleMessage(
      "e.g. A place I\'d love to visit",
    ),
    "txtDsFiller": MessageLookupByLibrary.simpleMessage("Filler"),
    "txtDsFillerWords": MessageLookupByLibrary.simpleMessage("Filler words"),
    "txtDsFluency": MessageLookupByLibrary.simpleMessage("Fluency"),
    "txtDsGetFeedback": MessageLookupByLibrary.simpleMessage("Get feedback"),
    "txtDsGrammar": MessageLookupByLibrary.simpleMessage("Grammar"),
    "txtDsGrammarPatterns": MessageLookupByLibrary.simpleMessage(
      "Grammar patterns",
    ),
    "txtDsGroupAccuracy": MessageLookupByLibrary.simpleMessage("Accuracy"),
    "txtDsGroupDelivery": MessageLookupByLibrary.simpleMessage("Delivery"),
    "txtDsGroupScoring": MessageLookupByLibrary.simpleMessage("Scoring"),
    "txtDsGroupStyle": MessageLookupByLibrary.simpleMessage(
      "Style & naturalness",
    ),
    "txtDsGuided": MessageLookupByLibrary.simpleMessage("Start here"),
    "txtDsGuidedBack": MessageLookupByLibrary.simpleMessage("Back"),
    "txtDsGuidedBreakdownHeading": MessageLookupByLibrary.simpleMessage(
      "Line by line",
    ),
    "txtDsGuidedBuildHeading": MessageLookupByLibrary.simpleMessage(
      "Now make it your own",
    ),
    "txtDsGuidedBuildSubhead": MessageLookupByLibrary.simpleMessage(
      "Fill in the blanks with your own answers.",
    ),
    "txtDsGuidedCopied": MessageLookupByLibrary.simpleMessage(
      "Copied to clipboard",
    ),
    "txtDsGuidedCopy": MessageLookupByLibrary.simpleMessage("Copy"),
    "txtDsGuidedDesc": MessageLookupByLibrary.simpleMessage(
      "New to speaking? We\'ll walk you through it — study a model, make it your own, then say it.",
    ),
    "txtDsGuidedEdit": MessageLookupByLibrary.simpleMessage("Edit"),
    "txtDsGuidedEditSave": MessageLookupByLibrary.simpleMessage("Save"),
    "txtDsGuidedEditTitle": MessageLookupByLibrary.simpleMessage(
      "Edit your paragraph",
    ),
    "txtDsGuidedFillToContinue": MessageLookupByLibrary.simpleMessage(
      "Fill in every blank to continue",
    ),
    "txtDsGuidedIntro": MessageLookupByLibrary.simpleMessage(
      "Pick a lesson. We\'ll show you a model, help you make your own version, then you record it and get feedback. Higher levels give you less to lean on.",
    ),
    "txtDsGuidedLevel": m6,
    "txtDsGuidedModelHeading": MessageLookupByLibrary.simpleMessage(
      "A model to learn from",
    ),
    "txtDsGuidedNext": MessageLookupByLibrary.simpleMessage("Next"),
    "txtDsGuidedObjectiveHeading": MessageLookupByLibrary.simpleMessage(
      "What you\'ll be able to do",
    ),
    "txtDsGuidedPreviewHeading": MessageLookupByLibrary.simpleMessage(
      "Your paragraph so far",
    ),
    "txtDsGuidedReadyRecord": MessageLookupByLibrary.simpleMessage(
      "I\'m ready — record",
    ),
    "txtDsGuidedSpeakFromMemory": MessageLookupByLibrary.simpleMessage(
      "Try saying it in your own words — you\'ve got this.",
    ),
    "txtDsGuidedStart": MessageLookupByLibrary.simpleMessage("Let\'s start"),
    "txtDsGuidedYourKeywords": MessageLookupByLibrary.simpleMessage(
      "Your keywords — say the rest in your own words",
    ),
    "txtDsGuidedYourParagraph": MessageLookupByLibrary.simpleMessage(
      "Your paragraph",
    ),
    "txtDsGuidedYoursHeading": MessageLookupByLibrary.simpleMessage(
      "This is yours now",
    ),
    "txtDsGuidedYoursSubhead": MessageLookupByLibrary.simpleMessage(
      "You built this yourself. Next, say it out loud and get feedback — just like the other practices.",
    ),
    "txtDsHeadline": MessageLookupByLibrary.simpleMessage(
      "Three minutes a day.",
    ),
    "txtDsHearYourProgress": MessageLookupByLibrary.simpleMessage(
      "Hear your progress",
    ),
    "txtDsHelpMePrepare": MessageLookupByLibrary.simpleMessage(
      "Help me prepare",
    ),
    "txtDsHelpMePrepareCaption": MessageLookupByLibrary.simpleMessage(
      "Get vocabulary, phrases & ideas",
    ),
    "txtDsHighlights": MessageLookupByLibrary.simpleMessage("Highlights"),
    "txtDsHistory": MessageLookupByLibrary.simpleMessage("History"),
    "txtDsHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Daily Speaking History",
    ),
    "txtDsHowItWorks": MessageLookupByLibrary.simpleMessage("How it works"),
    "txtDsHowItWorksBody": MessageLookupByLibrary.simpleMessage(
      "• Tap the mic and just talk for up to 5 minutes.\n• When you stop, the AI gives you a score, strengths, fixes, and a Burmese explanation.\n• Don\'t worry about being perfect — the goal is to keep speaking.",
    ),
    "txtDsIdioms": MessageLookupByLibrary.simpleMessage(
      "Idioms & phrasal verbs",
    ),
    "txtDsImDoneSeeNative": MessageLookupByLibrary.simpleMessage(
      "I\'m done — see native version",
    ),
    "txtDsImportAudio": MessageLookupByLibrary.simpleMessage("Import audio"),
    "txtDsImportChangeFile": MessageLookupByLibrary.simpleMessage(
      "Choose a different file",
    ),
    "txtDsImportChooseFile": MessageLookupByLibrary.simpleMessage(
      "Choose audio file",
    ),
    "txtDsImportInstead": MessageLookupByLibrary.simpleMessage(
      "Import a recording instead",
    ),
    "txtDsImportIntro": MessageLookupByLibrary.simpleMessage(
      "Already recorded yourself speaking English? Import it and get the same feedback. One clear voice, up to 5 minutes, works best.",
    ),
    "txtDsImportTooBig": m7,
    "txtDsImportTooLong": m8,
    "txtDsImportTooShort": MessageLookupByLibrary.simpleMessage(
      "That clip is too short — it needs at least a few seconds of speech.",
    ),
    "txtDsImportUnreadable": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t read that audio file. Try another one.",
    ),
    "txtDsImportUnsupported": MessageLookupByLibrary.simpleMessage(
      "Unsupported format. Use m4a, mp3, wav, aac, ogg, or flac.",
    ),
    "txtDsImportUseRecording": MessageLookupByLibrary.simpleMessage(
      "Use this recording",
    ),
    "txtDsInterference": MessageLookupByLibrary.simpleMessage("Interference"),
    "txtDsJustTalk": MessageLookupByLibrary.simpleMessage("Just talk"),
    "txtDsJustTalkDesc": MessageLookupByLibrary.simpleMessage(
      "No topic, no pressure. Speak freely — the AI will identify what you talked about and give you feedback.",
    ),
    "txtDsLatestAttempt": MessageLookupByLibrary.simpleMessage(
      "Your latest attempt at this topic.",
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
    "txtDsMaxDuration": m9,
    "txtDsNSelected": m10,
    "txtDsNativeHeaderNoScore": MessageLookupByLibrary.simpleMessage(
      "Here\'s how a native speaker might say it.",
    ),
    "txtDsNativeHeaderScore": m11,
    "txtDsNativeRewrite": MessageLookupByLibrary.simpleMessage(
      "How a native speaker would say it",
    ),
    "txtDsNativeVersion": MessageLookupByLibrary.simpleMessage(
      "Native version",
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
    "txtDsPaceWpm": m12,
    "txtDsPhrasesToTry": MessageLookupByLibrary.simpleMessage(
      "Phrases to try next time",
    ),
    "txtDsPhrasesToTryHint": MessageLookupByLibrary.simpleMessage(
      "Natural ways to say this on your topic — you didn\'t use these yet, so try working them in next time.",
    ),
    "txtDsPolishRetry": MessageLookupByLibrary.simpleMessage("Polish & retry"),
    "txtDsPracticeAgain": m13,
    "txtDsPracticed": MessageLookupByLibrary.simpleMessage("Practiced"),
    "txtDsPrepFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t build prep. Try again.",
    ),
    "txtDsPresetEverything": MessageLookupByLibrary.simpleMessage("Everything"),
    "txtDsPresetGrammarFocus": MessageLookupByLibrary.simpleMessage(
      "Grammar focus",
    ),
    "txtDsPresetRecommended": MessageLookupByLibrary.simpleMessage(
      "Recommended",
    ),
    "txtDsPresetSoundNatural": MessageLookupByLibrary.simpleMessage(
      "Sound natural",
    ),
    "txtDsProgressDown": m14,
    "txtDsProgressSame": MessageLookupByLibrary.simpleMessage(
      "Same score as your first try — consistency is progress too.",
    ),
    "txtDsProgressTitle": MessageLookupByLibrary.simpleMessage("Your progress"),
    "txtDsProgressUp": m15,
    "txtDsPronunciation": MessageLookupByLibrary.simpleMessage("Pronunciation"),
    "txtDsPronunciationNotes": MessageLookupByLibrary.simpleMessage(
      "Pronunciation notes",
    ),
    "txtDsQuickPicks": MessageLookupByLibrary.simpleMessage("Quick picks"),
    "txtDsRecordNow": MessageLookupByLibrary.simpleMessage("Record now"),
    "txtDsRecordNowCaption": MessageLookupByLibrary.simpleMessage(
      "Skip prep — just start talking",
    ),
    "txtDsRecordThis": MessageLookupByLibrary.simpleMessage("Record this"),
    "txtDsRecordWithoutPrep": MessageLookupByLibrary.simpleMessage(
      "Record without prep",
    ),
    "txtDsRecordingUnavailable": MessageLookupByLibrary.simpleMessage(
      "Recording is unavailable.",
    ),
    "txtDsRetry": MessageLookupByLibrary.simpleMessage("Retry"),
    "txtDsReviewHighlights": MessageLookupByLibrary.simpleMessage(
      "Review & highlights",
    ),
    "txtDsReviewTapHint": MessageLookupByLibrary.simpleMessage(
      "Tap a highlighted word to see the fix.",
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
    "txtDsScoreCheerHigh": MessageLookupByLibrary.simpleMessage(
      "Excellent — you sound really fluent!",
    ),
    "txtDsScoreCheerLow": MessageLookupByLibrary.simpleMessage(
      "Nice start — keep practicing, you\'ve got this!",
    ),
    "txtDsScoreCheerMid": MessageLookupByLibrary.simpleMessage(
      "Good effort — a few tweaks and you\'ll shine.",
    ),
    "txtDsScoreDown": m16,
    "txtDsScoreSame": m17,
    "txtDsScoreUp": m18,
    "txtDsSecSentenceFixes": MessageLookupByLibrary.simpleMessage(
      "Sentence fixes",
    ),
    "txtDsSeeNativeVersion": MessageLookupByLibrary.simpleMessage(
      "See native version",
    ),
    "txtDsSelectAtLeastOne": MessageLookupByLibrary.simpleMessage(
      "Select at least one",
    ),
    "txtDsSentenceBySentence": MessageLookupByLibrary.simpleMessage(
      "Sentence by sentence",
    ),
    "txtDsSentenceRewriteLabel": MessageLookupByLibrary.simpleMessage(
      "Sentence-by-sentence rewrite",
    ),
    "txtDsSentenceRewritesTitle": MessageLookupByLibrary.simpleMessage(
      "Sentence rewrites",
    ),
    "txtDsSessionMeta": m19,
    "txtDsSessionsToday": m20,
    "txtDsShowAll": m21,
    "txtDsShowLess": MessageLookupByLibrary.simpleMessage("Show less"),
    "txtDsShuffle": MessageLookupByLibrary.simpleMessage("Shuffle"),
    "txtDsSkillBreakdown": MessageLookupByLibrary.simpleMessage(
      "Skill breakdown",
    ),
    "txtDsSkillSubScores": MessageLookupByLibrary.simpleMessage(
      "Skill sub-scores",
    ),
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
    "txtDsSuggestionDream": MessageLookupByLibrary.simpleMessage(
      "A dream I have",
    ),
    "txtDsSuggestionFamily": MessageLookupByLibrary.simpleMessage("My family"),
    "txtDsSuggestionFood": MessageLookupByLibrary.simpleMessage("Food I love"),
    "txtDsSuggestionFriend": MessageLookupByLibrary.simpleMessage(
      "A close friend",
    ),
    "txtDsSuggestionGoal": MessageLookupByLibrary.simpleMessage(
      "A goal I have",
    ),
    "txtDsSuggestionHobby": MessageLookupByLibrary.simpleMessage(
      "A hobby I enjoy",
    ),
    "txtDsSuggestionHometown": MessageLookupByLibrary.simpleMessage(
      "My hometown",
    ),
    "txtDsSuggestionJob": MessageLookupByLibrary.simpleMessage("My job"),
    "txtDsSuggestionShow": MessageLookupByLibrary.simpleMessage(
      "A movie or show",
    ),
    "txtDsSuggestionTrip": MessageLookupByLibrary.simpleMessage(
      "A recent trip",
    ),
    "txtDsSuggestionWeekend": MessageLookupByLibrary.simpleMessage(
      "My weekend",
    ),
    "txtDsSuggestionWorried": MessageLookupByLibrary.simpleMessage(
      "Something I\'m worried about",
    ),
    "txtDsSummaryMm": MessageLookupByLibrary.simpleMessage("အကျဉ်းချုပ်"),
    "txtDsTabNative": MessageLookupByLibrary.simpleMessage("Native"),
    "txtDsTabYours": MessageLookupByLibrary.simpleMessage("Yours"),
    "txtDsTalkAbout": MessageLookupByLibrary.simpleMessage("Talk about"),
    "txtDsTapPhraseHint": MessageLookupByLibrary.simpleMessage(
      "Tap a phrase to see what it means and how to use it.",
    ),
    "txtDsTapToStart": MessageLookupByLibrary.simpleMessage(
      "Tap and start talking",
    ),
    "txtDsTapToStop": MessageLookupByLibrary.simpleMessage("Tap to stop"),
    "txtDsTargetPhraseCount": m22,
    "txtDsTargetPhrases": MessageLookupByLibrary.simpleMessage(
      "Target phrases",
    ),
    "txtDsThingsToFix": MessageLookupByLibrary.simpleMessage("Things to fix"),
    "txtDsThingsYouCanMention": MessageLookupByLibrary.simpleMessage(
      "Things you can mention",
    ),
    "txtDsTime": MessageLookupByLibrary.simpleMessage("Time"),
    "txtDsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "txtDsTopicColon": m23,
    "txtDsTopicFieldHint": MessageLookupByLibrary.simpleMessage(
      "e.g. The most stressful week I had",
    ),
    "txtDsTopicHint": MessageLookupByLibrary.simpleMessage(
      "A topic, a question, or just a vibe — keep it short.",
    ),
    "txtDsTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
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
    "txtDsUseThisHint": MessageLookupByLibrary.simpleMessage("Use this"),
    "txtDsVersionBanner": m24,
    "txtDsVersionShort": m25,
    "txtDsVersionThisOne": m26,
    "txtDsVocabulary": MessageLookupByLibrary.simpleMessage("Vocabulary"),
    "txtDsWhatToTalkAbout": MessageLookupByLibrary.simpleMessage(
      "What do you want to talk about?",
    ),
    "txtDsWhatYouDidWell": MessageLookupByLibrary.simpleMessage(
      "What you did well",
    ),
    "txtDsWhatYouSaid": MessageLookupByLibrary.simpleMessage("What you said"),
    "txtDsWhatYouWrote": MessageLookupByLibrary.simpleMessage("What you wrote"),
    "txtDsWholeRewriteLabel": MessageLookupByLibrary.simpleMessage(
      "Native rewrite",
    ),
    "txtDsWords": MessageLookupByLibrary.simpleMessage("Words"),
    "txtDsWordsYouMightUse": MessageLookupByLibrary.simpleMessage(
      "Words you might use",
    ),
    "txtDsWriteAtLeastChars": m27,
    "txtDsWriteInstead": MessageLookupByLibrary.simpleMessage("Write instead"),
    "txtDsWritePathHint": MessageLookupByLibrary.simpleMessage(
      "Write a paragraph about your topic. Aim for 5-10 sentences.",
    ),
    "txtDsWritingNativeVersion": MessageLookupByLibrary.simpleMessage(
      "Writing a native version of your best attempt…",
    ),
    "txtDsYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "txtDsYourPrompt": MessageLookupByLibrary.simpleMessage("Your prompt"),
    "txtDsYourRecording": MessageLookupByLibrary.simpleMessage(
      "Your recording",
    ),
    "txtDsYourTopic": MessageLookupByLibrary.simpleMessage("Your topic"),
    "txtDsYourVersion": MessageLookupByLibrary.simpleMessage("Your version"),
    "txtEnterValidCode": MessageLookupByLibrary.simpleMessage(
      "Please enter the 6-digit code",
    ),
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
    "txtForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot password?",
    ),
    "txtForgotPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your account email and we\'ll send you a 6-digit code.",
    ),
    "txtForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "txtGotIt": MessageLookupByLibrary.simpleMessage("Got it"),
    "txtHighlightLine": MessageLookupByLibrary.simpleMessage("Line"),
    "txtHighlightNone": MessageLookupByLibrary.simpleMessage("None"),
    "txtHighlightReadAlong": MessageLookupByLibrary.simpleMessage("Read Along"),
    "txtInProgress": MessageLookupByLibrary.simpleMessage("In progress"),
    "txtIncorrect": MessageLookupByLibrary.simpleMessage("Incorrect"),
    "txtKeepIt": MessageLookupByLibrary.simpleMessage("Keep It"),
    "txtLesson": MessageLookupByLibrary.simpleMessage("Lesson"),
    "txtListeningIntroAfter": MessageLookupByLibrary.simpleMessage(
      "Work through these lessons and you\'ll follow real podcasts, YouTube & TED talks — and speak with their rhythm.",
    ),
    "txtListeningIntroBefore": MessageLookupByLibrary.simpleMessage(
      "Right now, native talks can sound like one fast, blurry word.",
    ),
    "txtListeningIntroPath": MessageLookupByLibrary.simpleMessage(
      "Every lesson is a 4-step path: Watch → Study → Shadow → Record.",
    ),
    "txtListeningIntroTitle": MessageLookupByLibrary.simpleMessage(
      "Understand real English — and speak it",
    ),
    "txtListeningListTitle": MessageLookupByLibrary.simpleMessage(
      "Listening And Shadowing",
    ),
    "txtLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "txtLogout": MessageLookupByLibrary.simpleMessage("Log out"),
    "txtLogoutConfirmMessage": MessageLookupByLibrary.simpleMessage(
      "You\'ll need to sign in again to continue learning.",
    ),
    "txtLogoutConfirmTitle": MessageLookupByLibrary.simpleMessage("Log out?"),
    "txtLogoutFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t log out. Please try again.",
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
    "txtNewPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "txtNext": MessageLookupByLibrary.simpleMessage("Next"),
    "txtNoInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection.",
    ),
    "txtNoRecordForSentence": MessageLookupByLibrary.simpleMessage(
      "No Record Found For This Sentence",
    ),
    "txtNotAnswer": MessageLookupByLibrary.simpleMessage("Not Answer"),
    "txtNotStarted": MessageLookupByLibrary.simpleMessage("Not started"),
    "txtOk": MessageLookupByLibrary.simpleMessage("Okay"),
    "txtOr": MessageLookupByLibrary.simpleMessage("or"),
    "txtOtpFieldLabel": MessageLookupByLibrary.simpleMessage("6-digit code"),
    "txtOtpSentTo": m28,
    "txtOutOf": m29,
    "txtOutcomeBannerTitle": MessageLookupByLibrary.simpleMessage(
      "What you\'ll get from this lesson",
    ),
    "txtOutcomeBullet1": MessageLookupByLibrary.simpleMessage(
      "Follow this talk at full native speed — without rewinding",
    ),
    "txtOutcomeBullet2": MessageLookupByLibrary.simpleMessage(
      "Pick up real phrases you can use yourself when you speak",
    ),
    "txtOutcomeBullet3": MessageLookupByLibrary.simpleMessage(
      "Train your pronunciation until it feels natural",
    ),
    "txtOutcomeCountMinutes": m30,
    "txtOutcomeCountPatterns": m31,
    "txtOutcomeCountSentences": m32,
    "txtOutcomeCountVocab": m33,
    "txtOutcomeStepLadder": MessageLookupByLibrary.simpleMessage(
      "Do the 4 steps in order — each one makes the next easier.",
    ),
    "txtPasswordMinLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "txtPasswordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "txtPlaybackDisabledWhileRecording": MessageLookupByLibrary.simpleMessage(
      "Playback is disabled while recording. Please stop the recording to continue.",
    ),
    "txtPlaybackSpeed": MessageLookupByLibrary.simpleMessage("Playback speed"),
    "txtPressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Press back again to exit",
    ),
    "txtPrivacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "txtProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "txtProgressXofY": m34,
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
    "txtResendCode": MessageLookupByLibrary.simpleMessage("Resend code"),
    "txtResendInSeconds": m35,
    "txtResetPasswordButton": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "txtSave": MessageLookupByLibrary.simpleMessage("Save"),
    "txtSaveRecordingTitle": MessageLookupByLibrary.simpleMessage(
      "Save your recording?",
    ),
    "txtSaved": MessageLookupByLibrary.simpleMessage("Saved"),
    "txtSendCode": MessageLookupByLibrary.simpleMessage("Send code"),
    "txtSentenceExplanationComing": MessageLookupByLibrary.simpleMessage(
      "Sentence explanation is on the way.\nStay tuned!",
    ),
    "txtSentenceExplanations": MessageLookupByLibrary.simpleMessage(
      "Sentence Explanations",
    ),
    "txtShadowing": MessageLookupByLibrary.simpleMessage("Shadowing"),
    "txtShowHint": MessageLookupByLibrary.simpleMessage("Show hint"),
    "txtSignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "txtSpeechPracticeSession": MessageLookupByLibrary.simpleMessage(
      "Speech Practice Session",
    ),
    "txtStartHere": MessageLookupByLibrary.simpleMessage("Start here"),
    "txtStepLesson": m36,
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
    "txtStepsProgress": m37,
    "txtStream": MessageLookupByLibrary.simpleMessage("Stream"),
    "txtTapToRecord": MessageLookupByLibrary.simpleMessage("Tap to record"),
    "txtThemeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "txtThemeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "txtThemeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "txtTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "txtTypeMissingWords": MessageLookupByLibrary.simpleMessage(
      "Type the missing word(s)",
    ),
    "txtVerify": MessageLookupByLibrary.simpleMessage("Verify"),
    "txtVerifyEmailTitle": MessageLookupByLibrary.simpleMessage(
      "Verify your email",
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
