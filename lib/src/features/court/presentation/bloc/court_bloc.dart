import 'package:bloc/bloc.dart';
import 'package:myproject/src/features/court/domain/models/schedule.dart';
import 'package:myproject/src/features/court/domain/usecases/court_usecase.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_event.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_state.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  final CourtUseCase useCase;

  CourtBloc({required this.useCase}) : super(InitialState()) {
    on<OnGetScheduleEvent>(_onGetScheduleEvent);
    on<OnSetScheduleEvent>(_onSetScheduleEvent);
    on<OnDeleteScheduleEvent>(_onDeleteScheduleEvent);
  }

  _onGetScheduleEvent(
      OnGetScheduleEvent event, Emitter<CourtState> emitter) async {
    final result = await useCase.getSchedule();
    emitter(GetScheduleState(result.cast<Schedule>()));
  }

  _onSetScheduleEvent(OnSetScheduleEvent event, Emitter<CourtState> emitter) {
    final result = useCase.setSchedule(event.schedule);
    emitter(SetScheduleState());
  }

  _onDeleteScheduleEvent(
      OnDeleteScheduleEvent event, Emitter<CourtState> emitter) {
    final result = useCase.deleteSchedule(event.id);
    emitter(DeleteScheduleState());
  }
}
