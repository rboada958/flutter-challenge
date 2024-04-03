import 'package:myproject/src/features/court/domain/models/Schedule.dart';

abstract class CourtRepository {
  Future<List<Schedule>> getSchedule();

  Future<void> setSchedule(Schedule schedule);

  Future<void> deleteSchedule(int id);
}
