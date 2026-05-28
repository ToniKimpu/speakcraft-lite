import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/bloc/day/day_bloc.dart';
import 'package:speakcraft/bloc/exercise/exercise_bloc.dart';
import 'package:speakcraft/bloc/internet_checker/internet_checker_bloc.dart';
import 'package:speakcraft/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/core/di/service_locator.dart';

List<BlocProvider> mainBlocProviders() {
  return [
    BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
    BlocProvider<DayBloc>.value(value: sl<DayBloc>()),
    BlocProvider<SpokenPatternBloc>.value(value: sl<SpokenPatternBloc>()),
    BlocProvider<ExerciseBloc>.value(value: sl<ExerciseBloc>()),
    BlocProvider<InternetCheckerBloc>.value(value: sl<InternetCheckerBloc>()),
    BlocProvider<UserActivityBloc>.value(value: sl<UserActivityBloc>()),
    BlocProvider<VideoStepProgressBloc>.value(
        value: sl<VideoStepProgressBloc>()),
    BlocProvider<DailySpeakingBloc>.value(value: sl<DailySpeakingBloc>()),
    BlocProvider<DailySpeakingHistoryBloc>.value(
        value: sl<DailySpeakingHistoryBloc>()),
  ];
}
