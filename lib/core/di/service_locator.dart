import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pmp_english/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/bloc/exercise_user_answer/exercise_user_answer_bloc.dart';
import 'package:pmp_english/bloc/internet_checker/internet_checker_bloc.dart';
import 'package:pmp_english/bloc/listening/listening_bloc.dart';
import 'package:pmp_english/bloc/listening_practice_answer/listening_practice_answer_bloc.dart';
import 'package:pmp_english/bloc/pattern_exercise/pattern_exercise_bloc.dart';
import 'package:pmp_english/bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'package:pmp_english/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:pmp_english/bloc/translate_user_answer/translate_user_answer_bloc.dart';
import 'package:pmp_english/bloc/translation/translation_bloc.dart';
import 'package:pmp_english/bloc/translation_day/translation_day_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_bloc.dart';
import 'package:pmp_english/bloc/user_bloc/user_bloc.dart';
import 'package:pmp_english/bloc/user_example_answer/user_example_answer_bloc.dart';
import 'package:pmp_english/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:pmp_english/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:pmp_english/bloc/youtube_player/youtube_player_bloc.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/repositories/auth/auth_repository.dart';
import 'package:pmp_english/repositories/auth/supabase_auth_repository.dart';
import 'package:pmp_english/repositories/day/day_repository.dart';
import 'package:pmp_english/repositories/day/supabase_day_repository.dart';
import 'package:pmp_english/repositories/listening/listening_repository.dart';
import 'package:pmp_english/repositories/listening/supabase_listening_repository.dart';
import 'package:pmp_english/repositories/spoken_pattern/spoken_pattern_repository.dart';
import 'package:pmp_english/repositories/spoken_pattern/supabase_spoken_pattern_repository.dart';
import 'package:pmp_english/services/theme_controller.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => SupabaseAuthRepository());
  sl.registerLazySingleton<DayRepository>(() => SupabaseDayRepository());
  sl.registerLazySingleton<ListeningRepository>(
      () => SupabaseListeningRepository());
  sl.registerLazySingleton<SpokenPatternRepository>(
      () => SupabaseSpokenPatternRepository());

  // Global app state notifiers
  sl.registerLazySingleton<ValueNotifier<AppUser>>(
    () => ValueNotifier<AppUser>(AppUser.empty()),
  );
  sl.registerLazySingleton<ValueNotifier<String?>>(
    () => ValueNotifier<String?>(null),
    instanceName: 'deviceId',
  );
  sl.registerLazySingleton<ValueNotifier<bool>>(
    () => ValueNotifier<bool>(true),
    instanceName: 'isOnline',
  );
  sl.registerLazySingleton<ThemeController>(() => ThemeController.load());

  // Global BLoCs (lazySingleton — survive across screens)
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<DayBloc>(() => DayBloc());
  sl.registerLazySingleton<SpokenPatternBloc>(() => SpokenPatternBloc());
  sl.registerLazySingleton<ExerciseBloc>(() => ExerciseBloc());
  sl.registerLazySingleton<InternetCheckerBloc>(() => InternetCheckerBloc());
  sl.registerLazySingleton<UserActivityBloc>(() => UserActivityBloc());
  sl.registerLazySingleton<VideoStepProgressBloc>(
      () => VideoStepProgressBloc());

  // Screen-local BLoCs (factory — fresh instance per screen)
  sl.registerFactory<ListeningBloc>(() => ListeningBloc());
  sl.registerFactory<AudioPlayerBloc>(() => AudioPlayerBloc());
  sl.registerFactory<YoutubePlayerBloc>(() => YoutubePlayerBloc());
  sl.registerFactory<PatternExerciseBloc>(() => PatternExerciseBloc());
  sl.registerFactory<PatternUserCommentBloc>(() => PatternUserCommentBloc());
  sl.registerFactory<ExerciseUserAnswerBloc>(() => ExerciseUserAnswerBloc());
  sl.registerFactory<UserExampleAnswerBloc>(() => UserExampleAnswerBloc());
  sl.registerFactory<ListeningPracticeAnswerBloc>(
      () => ListeningPracticeAnswerBloc());
  sl.registerFactory<UserRecordedSentenceAudioBloc>(
      () => UserRecordedSentenceAudioBloc());
  sl.registerFactory<AiSentencePracticeBloc>(() => AiSentencePracticeBloc());
  sl.registerFactory<TranslationBloc>(() => TranslationBloc());
  sl.registerFactory<TranslationDayBloc>(() => TranslationDayBloc());
  sl.registerFactory<TranslateUserAnswerBloc>(() => TranslateUserAnswerBloc());
  sl.registerFactory<UserBloc>(() => UserBloc());
}
