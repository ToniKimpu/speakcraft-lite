import 'package:flutter/material.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/screens/auth/login_screen.dart';
import 'package:speakcraft/screens/auth/sign_up_screen.dart';
import 'package:speakcraft/model/writing/writing_unit.dart';
import 'package:speakcraft/model/writing/writing_lexicon.dart';
import 'package:speakcraft/screens/writing/writing_path_page.dart';
import 'package:speakcraft/screens/writing/writing_teach_steps_page.dart';
import 'package:speakcraft/screens/writing/writing_practice_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/full_talk_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/key_takeaways_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/lesson_hub_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/listening_list_page.dart';
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
  static const newVersionScreen = '/new_version_screen';
  static const listeningListPage = "/listening/listening_list_page";
  static const listeningHub = '/listening/lesson_hub';
  static const youtubeVideoPage = '/youtube_video_page';
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
  static const htmlList = '/html_list';
  static const htmlPreview = '/html_preview';
  static const savedTermsPage = '/saved_terms_page';
  static const gritJsonList = '/grit_json_list';
  static const gritJsonPreview = '/grit_json_preview';
  static const sentenceExplanationDataList = '/sentence_explanation_data_list';
  static const zendayaJsonList = '/zendaya_json_list';
  static const importantOfSocialHealthJsonList =
      '/important_of_social_health_json_list';
  static const paulRuddInterviewJsonList = '/paul_rudd_interview_json_list';
  static const goingViralTaughtMeJsonList = '/going_viral_taugh_me_json_list';

  // Premium payment (manual KPay/bank screenshot flow)
  static const premiumPaymentPage = '/premium/payment';
  static const paymentStatusPage = '/premium/status';

  // Writing Practice module — see WRITING_FEATURE_PLAN.md
  static const writingPath = '/writing';
  static const writingTeachSteps = '/writing/teach-steps'; // step-by-step pager
  static const writingPractice = '/writing/practice';

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

      case youtubeVideoPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          YoutubeVideoPage(
            listening: listening,
          ),
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
          ),
          settings,
        );
      case sentenceExplanationPager:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          SentenceExplanationPager(
            explanations: args['explanations'] as List<SentenceExplanation>,
            initialIndex: args['index'] as int? ?? 0,
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
      case zendayaJsonList:
        return _getRoute(
          const GritJsonList(
            assetFolder: 'assets/zendaya/',
            title: 'Zendaya',
          ),
          settings,
        );
      case importantOfSocialHealthJsonList:
        return _getRoute(
          const GritJsonList(
            assetFolder: 'assets/important_of_social_health/',
            title: 'Important of Social Health',
          ),
          settings,
        );
      case paulRuddInterviewJsonList:
        return _getRoute(
          const GritJsonList(
            assetFolder: 'assets/paul_rudd_interview/',
            title: 'Paul Rudd Interview',
          ),
          settings,
        );
      case goingViralTaughtMeJsonList:
        return _getRoute(
          const GritJsonList(
            assetFolder: 'assets/going_viral_taugh_me/',
            title: 'Going Viral Taught Me',
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
