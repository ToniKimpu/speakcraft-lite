import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/bloc/internet_checker/internet_checker_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/core/di/service_locator.dart';

List<BlocProvider> mainBlocProviders() {
  return [
    BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
    BlocProvider<InternetCheckerBloc>.value(value: sl<InternetCheckerBloc>()),
    BlocProvider<UserActivityBloc>.value(value: sl<UserActivityBloc>()),
    BlocProvider<VideoStepProgressBloc>.value(
        value: sl<VideoStepProgressBloc>()),
  ];
}
