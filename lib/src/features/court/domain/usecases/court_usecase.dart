import 'package:myproject/src/features/court/domain/models/Schedule.dart';
import 'package:myproject/src/features/court/domain/repositories/court_repository.dart';

class CourtUseCase {
  final CourtRepository repository;

  CourtUseCase(this.repository);

  Future<void> setSchedule(Schedule schedule) {
    return repository.setSchedule(schedule);
  }

  Future<List<Schedule>> getSchedule() {
    return repository.getSchedule();
  }

  Future<void> deleteSchedule(int id) {
    return repository.deleteSchedule(id);
  }
}
