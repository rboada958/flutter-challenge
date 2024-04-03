import 'package:myproject/src/features/court/domain/models/Schedule.dart';

abstract class CourtEvent {
  const CourtEvent();
}

class OnGetScheduleEvent extends CourtEvent {}

class OnSetScheduleEvent extends CourtEvent {
  final Schedule schedule;

  OnSetScheduleEvent(this.schedule);
}

class OnDeleteScheduleEvent extends CourtEvent {
  final int id;

  OnDeleteScheduleEvent(this.id);
}
