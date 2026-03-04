import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/day/day.dart';
import 'package:pmp_english/model/exercise/exercise.dart';
import 'package:pmp_english/model/lesson/lesson.dart';
import 'package:pmp_english/services/supabase_service.dart';

import 'day_repository.dart';

class SupabaseDayRepository implements DayRepository {
  @override
  Future<List<Day>> loadDays() async {
    final dataRes = await supabase
        .from('days')
        .select('*,days_users_relation(*)')
        .eq('days_users_relation.user_id', GlobalAppState().currentUser.id!)
        .eq('is_deleted', false)
        .order('order_number', ascending: true);

    if (dataRes.isEmpty) return [];

    final days = dataRes.map((e) => Day.fromJson1(e)).toList();

    final lessonDataRes = await supabase
        .from('lessons')
        .select('*')
        .eq('is_deleted', false)
        .inFilter('day_id', days.map((d) => d.id).toList())
        .order('created_at', ascending: true);

    final exerciseDataRes = await supabase
        .from('exercises')
        .select('*, exercises_users_relation(*)')
        .eq('is_deleted', false)
        .inFilter('day_id', days.map((d) => d.id).toList())
        .order('created_at', ascending: true);

    final allLessons = Lesson.fromJsonList(lessonDataRes);
    final allExercises = Exercise.fromJsonList1(exerciseDataRes);

    final lessonsByDay = {
      for (var id in days.map((d) => d.id))
        id: allLessons.where((l) => l.dayId == id).toList()
    };
    final exercisesByDay = {
      for (var id in days.map((d) => d.id))
        id: allExercises.where((e) => e.dayId == id).toList()
    };

    return days
        .map((day) => day.copyWith(
              lessons: lessonsByDay[day.id] ?? [],
              exercises: exercisesByDay[day.id] ?? [],
            ))
        .toList();
  }
}
