import 'package:get_it/get_it.dart';
import 'package:pmp_english/repositories/auth/auth_repository.dart';
import 'package:pmp_english/repositories/auth/supabase_auth_repository.dart';
import 'package:pmp_english/repositories/day/day_repository.dart';
import 'package:pmp_english/repositories/day/supabase_day_repository.dart';
import 'package:pmp_english/repositories/listening/listening_repository.dart';
import 'package:pmp_english/repositories/listening/supabase_listening_repository.dart';
import 'package:pmp_english/repositories/spoken_pattern/spoken_pattern_repository.dart';
import 'package:pmp_english/repositories/spoken_pattern/supabase_spoken_pattern_repository.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<AuthRepository>(() => SupabaseAuthRepository());
  sl.registerLazySingleton<DayRepository>(() => SupabaseDayRepository());
  sl.registerLazySingleton<ListeningRepository>(
      () => SupabaseListeningRepository());
  sl.registerLazySingleton<SpokenPatternRepository>(
      () => SupabaseSpokenPatternRepository());
}
