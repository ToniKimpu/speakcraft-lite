import 'package:flutter/foundation.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/model/day/day.dart';
import 'package:speakcraft/model/exercise/exercise.dart';
import 'package:speakcraft/model/lesson/lesson.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'day_repository.dart';

class SupabaseDayRepository implements DayRepository {
  @override
  Future<List<Day>> loadDays() async {
    final dataRes = await supabase
        .from('days')
        .select('*,days_users_relation(*)')
        .eq('days_users_relation.user_id', sl<ValueNotifier<AppUser>>().value.id!)
        .eq('is_deleted', false)
        .order('order_number', ascending: true);

    if (dataRes.isEmpty) return [];

    final days = dataRes.map((e) => Day(
      id: e['id'] as int,
      orderNumber: e['order_number'] as int,
      createdAt: DateTime.parse(e['created_at'] as String),
      isComplete: (e['days_users_relation'] as List).isNotEmpty,
      lessons: [],
      exercises: [],
    )).toList();

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
    final allExercises = exerciseDataRes.map((e) => Exercise(
      id: e['id'] as int,
      exerciseName: e['exercise_name'] as String,
      dayId: e['day_id'] as int,
      isComplete: (e['exercises_users_relation'] as List).isNotEmpty,
    )).toList();

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
