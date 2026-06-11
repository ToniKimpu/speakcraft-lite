import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_prep_bloc.dart';
import 'package:speakcraft/model/sentence_explanation/sentence_explanation.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/screens/auth/login_screen.dart';
import 'package:speakcraft/screens/auth/sign_up_screen.dart';
import 'package:speakcraft/screens/daily_speaking/daily_speaking_entry_page.dart';
import 'package:speakcraft/screens/daily_speaking/feedback/choose_feedback_page.dart';
import 'package:speakcraft/screens/daily_speaking/feedback/feedback_result_page.dart';
import 'package:speakcraft/screens/daily_speaking/feedback/review_highlights_page.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/screens/daily_speaking/history/daily_speaking_history_page.dart';
import 'package:speakcraft/screens/daily_speaking/just_record/just_record_page.dart';
import 'package:speakcraft/screens/daily_speaking/own_topic/own_topic_prep_page.dart';
import 'package:speakcraft/screens/daily_speaking/own_topic/own_topic_record_page.dart';
import 'package:speakcraft/screens/daily_speaking/own_topic/own_topic_scaffold_page.dart';
import 'package:speakcraft/screens/daily_speaking/suggested/suggested_topic_list_page.dart';
import 'package:speakcraft/screens/daily_speaking/suggested/suggested_topic_prep_page.dart';
import 'package:speakcraft/screens/daily_speaking/suggested/suggested_topic_record_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/lesson_hub_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/listening_list_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_list.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_page.dart';
import 'package:speakcraft/screens/listening_and_shadowing/sentence_explanation_pager.dart';
import 'package:speakcraft/screens/listening_and_shadowing/shadowing_page.dart';
import 'package:speakcraft/screens/main/new_version_screen.dart';
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

  // Daily Speaking Practice module — see lib/screens/daily_speaking/CLAUDE.md
  static const dailySpeakingEntry = '/daily_speaking';
  static const dailySpeakingJustRecord = '/daily_speaking/just_record';
  static const dailySpeakingOwnTopicPrep = '/daily_speaking/own_topic/prep';
  static const dailySpeakingOwnTopicScaffold =
      '/daily_speaking/own_topic/scaffold';
  static const dailySpeakingOwnTopicRecord = '/daily_speaking/own_topic/record';
  static const dailySpeakingSuggestedList = '/daily_speaking/suggested';
  static const dailySpeakingSuggestedPrep = '/daily_speaking/suggested/prep';
  static const dailySpeakingSuggestedRecord = '/daily_speaking/suggested/record';
  static const dailySpeakingChooseFeedback = '/daily_speaking/choose_feedback';
  static const dailySpeakingFeedback = '/daily_speaking/feedback';
  static const dailySpeakingReview = '/daily_speaking/review';
  static const dailySpeakingHistory = '/daily_speaking/history';

  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _getRoute(const SplashScreen(), settings);
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
      case dailySpeakingEntry:
        return _getRoute(const DailySpeakingEntryPage(), settings);
      case dailySpeakingJustRecord:
        final args = settings.arguments as Map<String, dynamic>?;
        return _getRoute(
          JustRecordPage(
            topic: args?['topic'] as DailySpeakingTopic?,
            topicAttemptId: args?['topicAttemptId'] as String?,
            revisionNumber: args?['revisionNumber'] as int? ?? 1,
          ),
          settings,
        );
      case dailySpeakingOwnTopicPrep:
        return _getRoute(const OwnTopicPrepPage(), settings);
      case dailySpeakingOwnTopicScaffold:
        final args = settings.arguments as Map<String, dynamic>;
        final topicText = args['topicText'] as String;
        return _getRoute(
          // Page-scoped bloc (like the suggested-topic flow): prep state only
          // matters inside this screen. The first expand is kicked off here.
          BlocProvider(
            create: (_) => DailySpeakingPrepBloc()
              ..add(DailySpeakingPrepEvent.expand(topicText)),
            child: OwnTopicScaffoldPage(topicText: topicText),
          ),
          settings,
        );
      case dailySpeakingOwnTopicRecord:
        final args = settings.arguments as Map<String, dynamic>;
        final topic = args['topic'] as DailySpeakingTopic;
        return _getRoute(
          OwnTopicRecordPage(
            topic: topic,
            topicAttemptId: args['topicAttemptId'] as String?,
            revisionNumber: args['revisionNumber'] as int? ?? 1,
          ),
          settings,
        );
      case dailySpeakingSuggestedList:
        return _getRoute(const SuggestedTopicListPage(), settings);
      case dailySpeakingSuggestedPrep:
        final args = settings.arguments as Map<String, dynamic>;
        final topic = args['topic'] as DailySpeakingTopic;
        return _getRoute(SuggestedTopicPrepPage(topic: topic), settings);
      case dailySpeakingSuggestedRecord:
        final args = settings.arguments as Map<String, dynamic>;
        final topic = args['topic'] as DailySpeakingTopic;
        return _getRoute(
          SuggestedTopicRecordPage(
            topic: topic,
            topicAttemptId: args['topicAttemptId'] as String?,
            revisionNumber: args['revisionNumber'] as int? ?? 1,
          ),
          settings,
        );
      case dailySpeakingChooseFeedback:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          ChooseFeedbackPage(
            inputMode: args['inputMode'] as String,
            onRamp: args['onRamp'] as String,
            audioPath: args['audioPath'] as String?,
            text: args['text'] as String?,
            topic: args['topic'] as DailySpeakingTopic?,
            topicAttemptId: args['topicAttemptId'] as String?,
            revisionNumber: args['revisionNumber'] as int? ?? 1,
          ),
          settings,
        );
      case dailySpeakingFeedback:
        final args = settings.arguments as Map<String, dynamic>;
        final session = args['session'] as DailySpeakingSession;
        // Optional — passed for loop-capable on-ramps to enable "Polish &
        // retry" on the result page.
        final topic = args['topic'] as DailySpeakingTopic?;
        return _getRoute(
          FeedbackResultPage(
            session: session,
            topic: topic,
          ),
          settings,
        );
      case dailySpeakingReview:
        final args = settings.arguments as Map<String, dynamic>;
        return _getRoute(
          ReviewHighlightsPage(
            feedback: args['feedback'] as DailySpeakingFeedback,
          ),
          settings,
        );
      case dailySpeakingHistory:
        return _getRoute(const DailySpeakingHistoryPage(), settings);
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
