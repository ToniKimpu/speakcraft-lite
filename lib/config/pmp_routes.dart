import 'package:flutter/material.dart';
import 'package:pmp_english/model/lesson/lesson.dart';
import 'package:pmp_english/model/sentence_explanation/sentence_explanation.dart';
import 'package:pmp_english/screens/auth/login_screen.dart';
import 'package:pmp_english/screens/auth/sign_up_screen.dart';
import 'package:pmp_english/screens/days/pattern_exercise_screen.dart';
import 'package:pmp_english/screens/days/spoken_pattern_exercise_screen.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_list_page.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_explanation_list.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_explanation_page.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_page.dart';
import 'package:pmp_english/screens/main/free_user_screen.dart';
import 'package:pmp_english/screens/main/new_version_screen.dart';
import 'package:pmp_english/screens/practice_with_ai/ai_practice_screen.dart';
import 'package:pmp_english/screens/practice_with_ai/ai_response_detail_screen.dart';
import 'package:pmp_english/screens/practice_with_ai/ai_sentence_practice_list_screen.dart';
import 'package:pmp_english/screens/profiles/update_avatar_page.dart';
import 'package:pmp_english/screens/profiles/update_name_page.dart';

import '../model/ai_sentence_practice/ai_sentence_practice.dart';
import '../model/day/day.dart';
import '../model/exercise/exercise.dart';
import '../model/listening/listening.dart';
import '../model/pattern_exercise/pattern_exercise.dart';
import '../screens/days/day_list_screen.dart';
import '../screens/days/pattern_exercise_result_screen.dart';
import '../screens/days/spoken_pattern/spoken_pattern_detail.dart';
import '../screens/days/spoken_pattern/spoken_pattern_screen.dart';
import '../screens/html_day_list.dart';
import '../screens/html_preview.dart';
import '../screens/listening_and_shadowing/speech_practice_session_page.dart';
import '../screens/listening_and_shadowing/youtube_video_page.dart';
import '../screens/saved_words/saved_words_page.dart';
import '../screens/main/device_failed_screen.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/profile_page.dart';
import '../screens/onboarding/splash_screen.dart';

class PmpRoutes {
  static const splash = 'splash';
  static const home = '/home';
  static const dayList = '/day_list';
  static const speakingPattern = '/day_list/speaking_pattern';
  static const spokenPatternPage = '/day_list/spoken_pattern_page';
  static const translationListPage = '/translation/translation_list_page';
  static const translationDayList = '/translation/translation_day_list';
  static const translationPage = '/translation/translation_page';
  static const loginScreen = '/auth/login';
  static const signUpScreen = '/auth/sign_up';
  static const patternExerciseScreen = '/day_list/pattern_exercise';
  static const patternExerciseResultScreen =
      '/day_list/pattern_exercise_result';
  static const translationPracticeResultScreen =
      '/translation/translation_practice_result';
  static const patternList = '/self_practice_pattern/pattern_list';
  static const patternPracticeScreen =
      '/self_practice_pattern/pattern_list/pattern_practice_screen';
  static const patternReplyScreen =
      '/self_practice_pattern/pattern_list/pattern_reply_screen';
  static const freeUserPage = '/free_user_page';
  static const newVersionScreen = '/new_version_screen';
  static const listeningListPage = "/listening/listening_list_page";
  static const youtubeVideoPage = '/youtube_video_page';
  static const profilePage = '/profile_page';
  static const updateUserName = '/update_user_name';
  static const updateAvatarPage = '/update_avatar_page';
  static const deviceFailedScreen = '/device_failed_screen';
  static const aiSentencePracticeListScreen =
      '/ai_sentence_practice_list_screen';
  static const aiPracticeScreen = '/ai_practice_screen';
  static const aiResponseDetailScreen = '/ai_response_detail_screen';
  static const shadowingPage = '/shadowing_page';
  static const spokenPatternExercisePage = '/spoken_pattern_exercise_page';
  static const speechPracticeSessionPage = '/speech_practice_session_page';
  static const sentenceExplanationList = '/sentence_explanation_list';
  static const sentenceExplanationPage = '/sentence_explanation_page';
  static const spokenPatternDetail = '/spoken_pattern_detail';
  static const htmlList = '/html_list';
  static const htmlPreview = '/html_preview';
  static const savedWordsPage = '/saved_words_page';

  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _getRoute(const SplashScreen(), settings);
      case home:
        return _getRoute(const HomePage(), settings);
      case dayList:
        return _getRoute(const DayListScreen(), settings);
      case profilePage:
        return _getRoute(const ProfilePage(), settings);
      case savedWordsPage:
        return _getRoute(const SavedWordsPage(), settings);
      case spokenPatternPage:
        final args = settings.arguments as Map<String, dynamic>;
        final lesson = args['lesson'] as Lesson;
        return _getRoute(
            SpokenPatternScreen(
              lesson: lesson,
            ),
            settings);
      case loginScreen:
        return _getRoute(const LoginScreen(), settings);
      case signUpScreen:
        return _getRoute(const SignUpScreen(), settings);
      case patternExerciseScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final exercise = args['exercise'] as Exercise;
        final day = args['day'] as Day;
        final isLastIndex = args['is_last_index'] as bool;
        return _getRoute(
          PatternExerciseScreen(
            exercise: exercise,
            day: day,
            isLastIndex: isLastIndex,
          ),
          settings,
        );
      case spokenPatternExercisePage:
        final args = settings.arguments as Map<String, dynamic>;
        final exercise = args['exercise'] as Exercise;
        final day = args['day'] as Day;
        final isLastIndex = args['is_last_index'] as bool;
        return _getRoute(
          SpokenPatternExerciseScreen(
            exercise: exercise,
            day: day,
            isLastIndex: isLastIndex,
          ),
          settings,
        );
      case patternExerciseResultScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final patternExercises =
            args['pattern_exercises'] as List<PatternExercise>?;
        final exerciseId = args['exercise_id'] as int?;
        final pass = args['pass'] as bool?;
        return _getRoute(
          PatternExerciseResultScreen(
            patternExercises: patternExercises,
            exerciseId: exerciseId,
            pass: pass,
          ),
          settings,
        );
      case listeningListPage:
        return _getRoute(
          const ListeningListPage(),
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
      case freeUserPage:
        return _getRoute(const FreeUserScreen(), settings);
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
      case aiSentencePracticeListScreen:
        return _getRoute(const AiSentencePracticeListScreen(), settings);
      case aiPracticeScreen:
        return _getRoute(const AiPracticeScreen(), settings);
      case aiResponseDetailScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final aiSentencePractice =
            args['aiSentencePractice'] as AiSentencePractice;
        return _getRoute(
          AiResponseDetailScreen(aiSentencePractice: aiSentencePractice),
          settings,
        );
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
      case sentenceExplanationList:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          SentenceExplanationList(
            listening: listening,
          ),
          settings,
        );
      case spokenPatternDetail:
        return _getRoute(
          const SpokenPatternDetail(),
          settings,
        );
      case htmlList:
        return _getRoute(
          const HtmlDayList(),
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
