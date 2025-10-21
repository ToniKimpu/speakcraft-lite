import 'package:flutter/material.dart';
import 'package:pmp_english/model/lesson/lesson.dart';
import 'package:pmp_english/model/listening_practice_answer/listening_practice_answer.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/model/pattern_user_comment/pattern_user_comment.dart';
import 'package:pmp_english/model/translation/translation.dart';
import 'package:pmp_english/model/translation_day/translation_day.dart';
import 'package:pmp_english/screens/auth/login_screen.dart';
import 'package:pmp_english/screens/auth/sign_up_screen.dart';
import 'package:pmp_english/screens/days/pattern_exercise_screen.dart';
import 'package:pmp_english/screens/days/spoken_pattern_exercise_screen.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_list_page.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_practice_result_page.dart';
import 'package:pmp_english/screens/listening_and_shadowing/listening_sentence_practice_page.dart';
import 'package:pmp_english/screens/listening_and_shadowing/shadowing_page.dart';
import 'package:pmp_english/screens/main/free_user_screen.dart';
import 'package:pmp_english/screens/main/new_path_screen.dart';
import 'package:pmp_english/screens/main/new_version_screen.dart';
import 'package:pmp_english/screens/practice_with_ai/ai_practice_screen.dart';
import 'package:pmp_english/screens/practice_with_ai/ai_response_detail_screen.dart';
import 'package:pmp_english/screens/practice_with_ai/ai_sentence_practice_list_screen.dart';
import 'package:pmp_english/screens/profiles/update_avatar_page.dart';
import 'package:pmp_english/screens/profiles/update_name_page.dart';
import 'package:pmp_english/screens/self_practice_pattern/pattern_list.dart';
import 'package:pmp_english/screens/self_practice_pattern/pattern_reply_screen.dart';
import 'package:pmp_english/screens/translation/translation_day_list.dart';
import 'package:pmp_english/screens/translation/translation_level_list.dart';
import 'package:pmp_english/screens/translation/translation_practice_page.dart';
import 'package:pmp_english/screens/translation/translation_practice_result_screen.dart';

import '../model/ai_sentence_practice/ai_sentence_practice.dart';
import '../model/day/day.dart';
import '../model/exercise/exercise.dart';
import '../model/listening/listening.dart';
import '../model/pattern_exercise/pattern_exercise.dart';
import '../model/spoken_pattern/spoken_pattern.dart';
import '../screens/days/day_list_screen.dart';
import '../screens/days/pattern_exercise_result_screen.dart';
import '../screens/days/spoken_pattern/spoken_pattern_screen.dart';
import '../screens/listening_and_shadowing/listening_sentence_practice_list.dart';
import '../screens/listening_and_shadowing/vocabulary_listening_page.dart';
import '../screens/listening_and_shadowing/youtube_video_page.dart';
import '../screens/main/device_failed_screen.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/profile_page.dart';
import '../screens/onboarding/splash_screen.dart';
import '../screens/self_practice_pattern/pattern_practice_screen.dart';

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
  static const newPathScreen = '/new_path_screen';
  static const deviceFailedScreen = '/device_failed_screen';
  static const aiSentencePracticeListScreen =
      '/ai_sentence_practice_list_screen';
  static const aiPracticeScreen = '/ai_practice_screen';
  static const aiResponseDetailScreen = '/ai_response_detail_screen';
  static const vocabularyListeningPage = '/vocabulary_listening_page';
  static const listeningSentencePracticePage =
      '/listening_sentence_practice_page';
  static const shadowingPage = '/shadowing_page';
  static const listeningSentencePracticeList =
      "/listening_sentence_practice_list";
  static const listeningPracticeResultPage = '/listening_practice_result_page';
  static const spokenPatternExercisePage = '/spoken_pattern_exercise_page';

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

      case spokenPatternPage:
        final args = settings.arguments as Map<String, dynamic>;
        final lesson = args['lesson'] as Lesson;
        return _getRoute(
            SpokenPatternScreen(
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
        return _getRoute(
          PatternExerciseResultScreen(
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
        final spokenPattern = args['pattern'] as SpokenPattern;
        return _getRoute(
          PatternPracticeScreen(
            spokenPattern: spokenPattern,
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
      case newPathScreen:
        return _getRoute(const NewPathScreen(), settings);
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
      case vocabularyListeningPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          VocabularyListeningPage(
            listening: listening,
          ),
          settings,
        );
      case listeningSentencePracticePage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        final listeningQuestions =
            args['listening_questions'] as List<ListeningQuestion>;
        final complete = args['complete'] as bool;
        final groupId = args['group_id'] as String;
        return _getRoute(
          ListeningSentencePracticePage(
            complete: complete,
            listening: listening,
            listeningQuestions: listeningQuestions,
            groupId: groupId,
          ),
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
      case listeningSentencePracticeList:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        return _getRoute(
          ListeningSentencePracticeList(
            listening: listening,
          ),
          settings,
        );
      case listeningPracticeResultPage:
        final args = settings.arguments as Map<String, dynamic>;
        final listening = args['listening'] as Listening;
        final listeningQuestions =
            args['listening_questions'] as List<ListeningQuestion>;
        final listeningAnswers =
            args['listening_answers'] as List<ListeningPracticeAnswer>;
        return _getRoute(
          ListeningPracticeResultPage(
            listening: listening,
            listeningQuestions: listeningQuestions,
            listeningPracticeAnswers: listeningAnswers,
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
