import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:speakcraft/bloc/audio_player/audio_player_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/bloc/internet_checker/internet_checker_bloc.dart';
import 'package:speakcraft/bloc/listening/listening_bloc.dart';
import 'package:speakcraft/bloc/listening_practice_answer/listening_practice_answer_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_bloc.dart';
import 'package:speakcraft/bloc/user_bloc/user_bloc.dart';
import 'package:speakcraft/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/bloc/youtube_player/youtube_player_bloc.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/repositories/auth/auth_repository.dart';
import 'package:speakcraft/repositories/auth/supabase_auth_repository.dart';
import 'package:speakcraft/repositories/listening/listening_repository.dart';
import 'package:speakcraft/repositories/listening/supabase_listening_repository.dart';
import 'package:speakcraft/bloc/payment/payment_bloc.dart';
import 'package:speakcraft/repositories/payment/payment_repository.dart';
import 'package:speakcraft/repositories/payment/supabase_payment_repository.dart';
import 'package:speakcraft/services/reminder_service.dart';
import 'package:speakcraft/services/theme_controller.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => SupabaseAuthRepository());
  sl.registerLazySingleton<ListeningRepository>(
      () => SupabaseListeningRepository());
  sl.registerLazySingleton<PaymentRepository>(
      () => SupabasePaymentRepository());

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
  sl.registerLazySingleton<ReminderService>(() => ReminderService());

  // Global BLoCs (lazySingleton — survive across screens)
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<InternetCheckerBloc>(() => InternetCheckerBloc());
  sl.registerLazySingleton<UserActivityBloc>(() => UserActivityBloc());
  sl.registerLazySingleton<VideoStepProgressBloc>(
      () => VideoStepProgressBloc());

  // Screen-local BLoCs (factory — fresh instance per screen)
  sl.registerFactory<ListeningBloc>(() => ListeningBloc());
  sl.registerFactory<AudioPlayerBloc>(() => AudioPlayerBloc());
  sl.registerFactory<YoutubePlayerBloc>(() => YoutubePlayerBloc());
  sl.registerFactory<ListeningPracticeAnswerBloc>(
      () => ListeningPracticeAnswerBloc());
  sl.registerFactory<UserRecordedSentenceAudioBloc>(
      () => UserRecordedSentenceAudioBloc());
  sl.registerFactory<UserBloc>(() => UserBloc());
  sl.registerFactory<PaymentBloc>(() => PaymentBloc());
}
