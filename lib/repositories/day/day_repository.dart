import '../../model/day/day.dart';

abstract class DayRepository {
  Future<List<Day>> loadDays();
}
