import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/bloc/internet_checker/internet_checker_bloc.dart';
import 'package:pmp_english/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_bloc.dart';
import 'package:pmp_english/core/di/service_locator.dart';

List<BlocProvider> mainBlocProviders() {
  return [
    BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
    BlocProvider<DayBloc>.value(value: sl<DayBloc>()),
    BlocProvider<SpokenPatternBloc>.value(value: sl<SpokenPatternBloc>()),
    BlocProvider<ExerciseBloc>.value(value: sl<ExerciseBloc>()),
    BlocProvider<InternetCheckerBloc>.value(value: sl<InternetCheckerBloc>()),
    BlocProvider<UserActivityBloc>.value(value: sl<UserActivityBloc>()),
  ];
}
