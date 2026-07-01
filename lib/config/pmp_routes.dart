import 'package:flutter/material.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/screens/auth/login_screen.dart';
import 'package:speakcraft/screens/auth/sign_up_screen.dart';
import 'package:speakcraft/screens/auth/convert_account_screen.dart';
import 'package:speakcraft/model/writing/writing_unit.dart';
import 'package:speakcraft/model/writing/writing_lexicon.dart';
import 'package:speakcraft/screens/writing/writing_path_page.dart';
import 'package:speakcraft/screens/writing/writing_teach_steps_page.dart';
import 'package:speakcraft/screens/writing/writing_practice_page.dart';
import 'package:speakcraft/model/vocabulary/vocab_models.dart';
import 'package:speakcraft/screens/vocabulary/vocabulary_list_page.dart';
import 'package:speakcraft/screens/vocabulary/vocab_group_page.dart';
import 'package:speakcraft/screens/vocabulary/vocab_practice_page.dart';
import 'package:speakcraft/screens/vocabulary/vocab_review_page.dart';
import 'package:speakcraft/model/speak_your_mind/sym_version.dart';
import 'package:speakcraft/screens/speak_your_mind/speak_your_mind_page.dart';
import 'package:speakcraft/screens/speak_your_mind/sym_topic_page.dart';
import 'package:speakcraft/screens/speak_your_mind/sym_produce_page.dart';
import 'package:speakcraft/screens/speak_your_mind/sym_guide_page.dart';
import 'package:speakcraft/screens/speak_your_mind/sym_history_page.dart';
import 'package:speakcraft/screens/speak_your_mind/sym_session_detail_page.dart';
import 'package:speakcraft/services/app_database/app_database.dart';
import 'package:speakcraft/screens/listening_and_shadowing/full_talk_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/key_takeaways_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/lesson_hub_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/listening_list_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/listening_challenge_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_list.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_pager.dart';
import 'package:speakcraft/screens/listening_and_shadowing/shadowing_page.dart';
import 'package:speakcraft/screens/main/new_version_screen.dart';
import 'package:speakcraft/screens/onboarding/onboarding_page.dart';
import 'package:speakcraft/screens/premium/premium_payment_page.dart';
import 'package:speakcraft/screens/premium/payment_status_page.dart';
import 'package:speakcraft/screens/profiles/update_avatar_page.dart';
import 'package:speakcraft/screens/profiles/update_name_page.dart';

import '../model/listening/listening.dart';
import '../screens/grit_json_list.dart';
import '../screens/grit_json_preview.dart';
import '../screens/html_day_list.dart';
import '../screens/html_preview.dart';
import '../screens/listening_and_shadowing/speech_practice_session_page.dart';
import '../screens/listening_and_shadowing/youtube_video_page.dart';
import '../screens/youtube_import/youtube_import_page.dart';
import '../screens/saved_words/saved_terms_page.dart';
import '../screens/main/device_failed_screen.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/profile_page.dart';
import '../screens/onboarding/splash_screen.dart';

class PmpRoutes {
  static const splash = 'splash';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const loginScreen = '/auth/login';
  static const signUpScreen = '/auth/sign_up';
  static const convertAccountScreen = '/auth/convert_account';
  static const newVersionScreen = '/new_version_screen';
  static const listeningListPage = "/listening/listening_list_page";
  static const listeningHub = '/listening/lesson_hub';
  static const youtubeVideoPage = '/youtube_video_page';
  static const youtubeImport = '/youtube_import';
  static const profilePage = '/profile_page';
  static const updateUserName = '/update_user_name';
  static const updateAvatarPage = '/update_avatar_page';
  static const deviceFailedScreen = '/device_failed_screen';
  static const shadowingPage = '/shadowing_page';
  static const speechPracticeSessionPage = '/speech_practice_session_page';
  static const keyTakeawaysPage = '/key_takeaways_page';
  static const fullTalkPage = '/full_talk_page';
  static const sentenceExplanationList = '/sentence_explanation_list';
  static const sentenceExplanationPage = '/sentence_explanation_page';
  static const sentenceExplanationPager = '/sentence_explanation_pager';
  static const listeningChallengePage = '/listening_challenge_page';
  static const htmlList = '/html_list';
  static const htmlPreview = '/html_preview';
  static const savedTermsPage = '/saved_terms_page';
  static const gritJsonList = '/grit_json_list';
  static const gritJsonPreview = '/grit_json_preview';
  static const sentenceExplanationDataList = '/sentence_explanation_data_list';

  // Premium payment (manual KPay/bank screenshot flow)
  static const premiumPaymentPage = '/premium/payment';
  static const paymentStatusPage = '/premium/status';

  // Writing Practice module — see WRITING_FEATURE_PLAN.md
  static const writingPath = '/writing';
  static const writingTeachSteps = '/writing/teach-steps'; // step-by-step pager
  static const writingPractice = '/writing/practice';

  // Vocabulary module (prototype — bundled JSON; Supabase-backed later)
  static const vocabularyList = '/vocabulary';
  static const vocabularyGroup = '/vocabulary/group';
  static const vocabularyPractice = '/vocabulary/practice';
  static const vocabularyReview = '/vocabulary/review';

  // Speak Your Mind — production "bridge" (prototype, bundled JSON)
  static const speakYourMind = '/speak-your-mind';
  static const speakYourMindTopic = '/speak-your-mind/topic';
  static const speakYourMindProduce = '/speak-your-mind/produce';
  static const speakYourMindGuide = '/speak-your-mind/guide';
  static const speakYourMindHistory = '/speak-your-mind/history';
  static const speakYourMindSessionDetail = '/speak-your-mind/session';

  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _getRoute(const SplashScreen(), settings);
      case onboarding:
        return _getRoute(const OnboardingPage(), settings);
      case home:
        return _getRoute(const HomePage(), settings);
      case profilePage:
        return _getRoute(const ProfilePage(), settings);
      case savedTermsPage:
        return _getRoute(const SavedTermsPage(), settings);
      case loginScreen:
        return _getRoute(const LoginScreen(), settings);
      case signUpScreen:
        return _getRoute(const SignUpScreen(), settings);
      case convertAccountScreen:
        return _getRoute(const ConvertAccountScreen(), settings);
      case listeningListPage:
        return _getRoute(
          const ListeningListPage(),
          settings,
        );

      case listeningHub:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          LessonHubPage(listening: listening),
          settings,
        );

      case youtubeImport:
        return _getRoute(const YoutubeImportPage(), settings);
      case youtubeVideoPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          YoutubeVideoPage(
            listening: listening,
          ),
          settings,
        );
      case listeningChallengePage:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          ListeningChallengePage(listening: args['listening'] as Listening),
          settings,
        );
      case newVersionScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final appVersion = args['appVersion'] as Map<String, dynamic>;
        return _getRoute(
            NewVersionScreen(
              appVersion: appVersion,
            ),
            settings);
      case updateUserName:
        return _getRoute(const UpdateNamePage(), settings);
      case updateAvatarPage:
        return _getRoute(const UpdateAvatarPage(), settings);
      case deviceFailedScreen:
        return _getRoute(const DeviceFailedScreen(), settings);
      case shadowingPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          ShadowingPage(
            listening: listening,
          ),
          settings,
        );
      case speechPracticeSessionPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          SpeechPracticeSessionPage(
            listening: listening,
          ),
          settings,
        );
      case sentenceExplanationPage:
        final args = settings.arguments as Map<String, dynamic>;
        final sentenceExplanation =
            args['sentence_explanation'] as SentenceExplanation;
        return _getRoute(
          SentenceExplanationPage(
            sentenceExplanation: sentenceExplanation,
            importId: args['import_id'] as String? ?? '',
          ),
          settings,
        );
      case sentenceExplanationPager:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          SentenceExplanationPager(
            explanations: args['explanations'] as List<SentenceExplanation>,
            initialIndex: args['index'] as int? ?? 0,
            importId: args['import_id'] as String? ?? '',
          ),
          settings,
        );
      case keyTakeawaysPage:
        // Loads the per-video deck from the listening's key_takeaways_path
        // (Bunny URL, normalized in the repo). The Key Takeaways step is only
        // shown when the path is set, so the url is non-empty here.
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          KeyTakeawaysPage(
            url: listening.keyTakeawaysPath,
            youtubeId: listening.youtubeId,
          ),
          settings,
        );
      case fullTalkPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          FullTalkPage(listening: listening),
          settings,
        );
      case sentenceExplanationList:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          SentenceExplanationList(
            listening: listening,
          ),
          settings,
        );
      case htmlList:
        return _getRoute(
          const HtmlDayList(),
          settings,
        );
      case gritJsonList:
        return _getRoute(const GritJsonList(), settings);
      case sentenceExplanationDataList:
        return _getRoute(
          const GritJsonList(
            assetFolder: 'assets/sentence_explanation_data/',
            title: 'Zendaya — JSON Files',
          ),
          settings,
        );
      case gritJsonPreview:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          GritJsonPreview(assetPath: args['assetPath'] as String),
          settings,
        );
      case premiumPaymentPage:
        return _getRoute(const PremiumPaymentPage(), settings);
      case paymentStatusPage:
        return _getRoute(const PaymentStatusPage(), settings);
      case writingPath:
        return _getRoute(const WritingPathPage(), settings);
      case writingTeachSteps:
        final args = settings.arguments as Map<String, dynamic>?;
        final id = args?['id'] as String?;
        return _getRoute(
          id == null
              ? const WritingTeachStepsPage()
              : WritingTeachStepsPage(unitId: id),
          settings,
        );
      case writingPractice:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          WritingPracticePage(
            unit: args['unit'] as WritingUnit,
            toolkit: args['toolkit'] as ResolvedToolkit?,
          ),
          settings,
        );
      case speakYourMind:
        return _getRoute(const SpeakYourMindPage(), settings);
      case speakYourMindTopic:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          SymTopicPage(topicId: args['id'] as String),
          settings,
        );
      case speakYourMindProduce:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          SymProducePage(
            topicId: args['id'] as String,
            resumeSessionId: args['resumeSessionId'] as int?,
            resumeVersions: args['resumeVersions'] as List<SymVersion>?,
            resumeRecordingPath: args['resumeRecordingPath'] as String?,
            initialText: args['initialText'] as String?,
          ),
          settings,
        );
      case speakYourMindGuide:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          SymGuidePage(topicId: args['id'] as String),
          settings,
        );
      case speakYourMindHistory:
        return _getRoute(const SymHistoryPage(), settings);
      case speakYourMindSessionDetail:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          SymSessionDetailPage(
            row: args['row'] as SymSessionTableData,
            title: args['title'] as String,
            initialIndex: (args['index'] as int?) ?? 0,
          ),
          settings,
        );
      case vocabularyList:
        return _getRoute(const VocabularyListPage(), settings);
      case vocabularyGroup:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          VocabGroupPage(
            groupId: args['id'] as String,
            title: args['title'] as String?,
          ),
          settings,
        );
      case vocabularyPractice:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          VocabPracticePage.group(args['group'] as VocabGroup),
          settings,
        );
      case vocabularyReview:
        return _getRoute(const VocabReviewPage(), settings);
      case htmlPreview:
        final args = settings.arguments as Map<String, dynamic>;
        final assetPath = args['assetPath'] as String?;
        final title = args['title'] as String?;
        final sentenceExplanation =
            args['sentence_explanation'] as SentenceExplanation?;
        return _getRoute(
          HtmlPreview(
            assetPath: assetPath,
            title: title,
            sentenceExplanation: sentenceExplanation,
          ),
          settings,
        );
      default:
        throw Exception(
          'Sorry, path ${settings.name} is invalid!',
        );
    }
  }

  static MaterialPageRoute<dynamic> _getRoute(
    Widget widget,
    RouteSettings settings,
  ) =>
      MaterialPageRoute(
        builder: (c) => widget,
        settings: settings,
      );
}
