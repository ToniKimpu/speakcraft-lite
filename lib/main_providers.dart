import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/internet_checker/internet_checker_bloc.dart';

mainBlocProviders() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    BlocProvider<DayBloc>(
      create: (context) => DayBloc(),
    ),
    BlocProvider<SpokenPatternBloc>(
      create: (context) => SpokenPatternBloc(),
    ),
    BlocProvider<ExerciseBloc>(
      create: (context) => ExerciseBloc(),
    ),
    BlocProvider(
      create: (_) => InternetCheckerBloc(),
    ),
    BlocProvider<UserActivityBloc>(
      create: (_) => UserActivityBloc(),
    ),
  ];
}
