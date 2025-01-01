import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/bloc/pattern/pattern_bloc.dart';
import 'package:pmp_english/bloc/translate_user_answer/translate_user_answer_bloc.dart';
import 'package:pmp_english/bloc/translation/translation_bloc.dart';
import 'package:pmp_english/bloc/translation_day/translation_day_bloc.dart';

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
    BlocProvider<TranslationBloc>(
      create: (context) => TranslationBloc(),
    ),
    BlocProvider<TranslateUserAnswerBloc>(
      create: (context) => TranslateUserAnswerBloc(),
    ),
    BlocProvider<TranslationDayBloc>(
      create: (context) => TranslationDayBloc(),
    ),
  ];
}
