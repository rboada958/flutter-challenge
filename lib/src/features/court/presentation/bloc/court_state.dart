import 'package:myproject/src/features/court/domain/models/schedule.dart';

abstract class CourtState {
  const CourtState();
}

class InitialState extends CourtState {}

class SetScheduleState extends CourtState {}

class GetScheduleState extends CourtState {
  final List<Schedule> scheduleCourts;

  GetScheduleState(this.scheduleCourts);
}

class DeleteScheduleState extends CourtState {}
