import 'package:flutter/material.dart';
import 'package:pmp_english/model/lesson/lesson.dart';
import 'package:pmp_english/model/pattern_user_comment/pattern_user_comment.dart';
import 'package:pmp_english/model/translation/translation.dart';
import 'package:pmp_english/model/translation_day/translation_day.dart';
import 'package:pmp_english/screens/auth/login_screen.dart';
import 'package:pmp_english/screens/auth/sign_up_screen.dart';
import 'package:pmp_english/screens/main/free_user_screen.dart';
import 'package:pmp_english/screens/main/new_version_screen.dart';
import 'package:pmp_english/screens/patterns/pattern_exercise_screen.dart';
import 'package:pmp_english/screens/self_practice_pattern/pattern_list.dart';
import 'package:pmp_english/screens/self_practice_pattern/pattern_reply_screen.dart';
import 'package:pmp_english/screens/translation/translation_day_list.dart';
import 'package:pmp_english/screens/translation/translation_level_list.dart';
import 'package:pmp_english/screens/translation/translation_practice_page.dart';
import 'package:pmp_english/screens/translation/translation_practice_result_screen.dart';

import '../../model/pattern/pattern.dart';
import '../model/day/day.dart';
import '../model/exercise/exercise.dart';
import '../model/pattern_exercise/pattern_exercise.dart';
import '../screens/listening_and_shadowing/youtube_video_page.dart';
import '../screens/main/home_screen.dart';
import '../screens/onboarding/splash_screen.dart';
import '../screens/patterns/day_list_screen.dart';
import '../screens/patterns/pattern_practice_result_screen.dart';
import '../screens/patterns/speaking_pattern_screen.dart';
import '../screens/self_practice_pattern/pattern_practice_screen.dart';

class PmpRoutes {
  static const splash = 'splash';
  static const home = '/home';
  static const dayList = '/day_list';
  static const speakingPattern = '/day_list/speaking_pattern';
  static const translationListPage = '/translation/translation_list_page';
  static const translationDayList = '/translation/translation_day_list';
  static const translationPage = '/translation/translation_page';
  static const loginScreen = '/auth/login';
  static const signUpScreen = '/auth/sign_up';
  static const patternExerciseScreen = '/day_list/pattern_exercise';
  static const patternPracticeResultScreen =
      '/day_list/pattern_practice_result';
  static const translationPracticeResultScreen =
      '/translation/translation_practice_result';
  static const patternList = '/self_practice_pattern/pattern_list';
  static const patternPracticeScreen =
      '/self_practice_pattern/pattern_list/pattern_practice_screen';
  static const patternReplyScreen =
      '/self_practice_pattern/pattern_list/pattern_reply_screen';
  static const freeUserPage = '/free_user_page';
  static const newVersionScreen = '/new_version_screen';
  static const youtubeVideoPage = '/youtube_video_page';

  static Route generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _getRoute(const SplashScreen(), settings);
      case home:
        return _getRoute(const HomePage(), settings);
      case dayList:
        return _getRoute(const DayListScreen(), settings);
      case speakingPattern:
        final args = settings.arguments as Map<String, dynamic>;
        final lesson = args['lesson'] as Lesson;
        return _getRoute(
            SpeakingPatternScreen(
              lesson: lesson,
            ),
            settings);

      case translationPage:
        final args = settings.arguments as Map<String, dynamic>;
        final translationDay = args['translation_day'] as TranslationDay;
        return _getRoute(
            TranslationPracticePage(
              translationDay: translationDay,
            ),
            settings);
      case translationListPage:
        return _getRoute(const TranslationLevelList(), settings);
      case translationDayList:
        // final args = settings.arguments as Map<String, dynamic>;
        // final levelId = args['translation_level_id'] as int;
        return _getRoute(const TranslationDayList(), settings);
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
      case patternPracticeResultScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final patternExercises =
            args['pattern_exercises'] as List<PatternExercise>?;
        final exerciseId = args['exercise_id'] as int?;
        return _getRoute(
          PatternPracticeResultScreen(
            patternExercises: patternExercises,
            exerciseId: exerciseId,
          ),
          settings,
        );
      case translationPracticeResultScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final translations = args['translations'] as List<Translation>?;
        final translationDayId = args['translation_day_id'] as int;
        return _getRoute(
          TranslationPracticeResultScreen(
            translations: translations,
            translationDayId: translationDayId,
          ),
          settings,
        );
      case patternList:
        return _getRoute(const PatternList(), settings);
      case patternPracticeScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final pattern = args['pattern'] as Pattern;
        return _getRoute(
          PatternPracticeScreen(
            pattern: pattern,
          ),
          settings,
        );
      case patternReplyScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final comment = args['comment'] as PatternUserComment;
        return _getRoute(
          PatternReplyScreen(
            comment: comment,
          ),
          settings,
        );
      case youtubeVideoPage:
        // final args = settings.arguments as Map<String, dynamic>;
        // final videoId = args['videoId'] as String;
        return _getRoute(
          const YoutubeVideoPage(),
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
