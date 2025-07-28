import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/app_ui/app_ui_bloc.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/bloc/pattern/pattern_bloc.dart';

import 'bloc/auth/auth_bloc.dart';

mainBlocProviders() {
  return [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
    ),
    BlocProvider<DayBloc>(
      create: (context) => DayBloc(),
    ),
    BlocProvider<PatternBloc>(
      create: (context) => PatternBloc(),
    ),
    BlocProvider<ExerciseBloc>(
      create: (context) => ExerciseBloc(),
    ),
    BlocProvider(
      create: (context) => AppUIBloc(),
    ),
  ];
}
