import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:speakcraft/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'package:speakcraft/bloc/audio_player/audio_player_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/bloc/day/day_bloc.dart';
import 'package:speakcraft/bloc/exercise/exercise_bloc.dart';
import 'package:speakcraft/bloc/exercise_user_answer/exercise_user_answer_bloc.dart';
import 'package:speakcraft/bloc/internet_checker/internet_checker_bloc.dart';
import 'package:speakcraft/bloc/listening/listening_bloc.dart';
import 'package:speakcraft/bloc/listening_practice_answer/listening_practice_answer_bloc.dart';
import 'package:speakcraft/bloc/pattern_exercise/pattern_exercise_bloc.dart';
import 'package:speakcraft/bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'package:speakcraft/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:speakcraft/bloc/translate_user_answer/translate_user_answer_bloc.dart';
import 'package:speakcraft/bloc/translation/translation_bloc.dart';
import 'package:speakcraft/bloc/translation_day/translation_day_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_bloc.dart';
import 'package:speakcraft/bloc/user_bloc/user_bloc.dart';
import 'package:speakcraft/bloc/user_example_answer/user_example_answer_bloc.dart';
import 'package:speakcraft/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/bloc/youtube_player/youtube_player_bloc.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/repositories/auth/auth_repository.dart';
import 'package:speakcraft/repositories/auth/supabase_auth_repository.dart';
import 'package:speakcraft/repositories/day/day_repository.dart';
import 'package:speakcraft/repositories/day/supabase_day_repository.dart';
import 'package:speakcraft/repositories/listening/listening_repository.dart';
import 'package:speakcraft/repositories/listening/supabase_listening_repository.dart';
import 'package:speakcraft/repositories/spoken_pattern/spoken_pattern_repository.dart';
import 'package:speakcraft/repositories/spoken_pattern/supabase_spoken_pattern_repository.dart';
import 'package:speakcraft/services/theme_controller.dart';

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
  sl.registerLazySingleton<DailySpeakingBloc>(() => DailySpeakingBloc());
  sl.registerLazySingleton<DailySpeakingHistoryBloc>(
      () => DailySpeakingHistoryBloc());

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
