import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/src/core/utils/injections.dart';
import 'package:myproject/src/features/court/domain/models/Schedule.dart';
import 'package:myproject/src/features/court/domain/usecases/court_usecase.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_bloc.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_event.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_state.dart';
import 'package:myproject/src/features/court/presentation/pages/schedule_page.dart';
import 'package:myproject/src/features/court/presentation/widgets/court_card_widget.dart';

class CourtPage extends StatefulWidget {
  const CourtPage({super.key});

  @override
  State<CourtPage> createState() => _CourtPageState();
}

class _CourtPageState extends State<CourtPage> {
  final CourtBloc _bloc = CourtBloc(useCase: sl<CourtUseCase>());
  List<Schedule> scheduleList = [];

  @override
  void initState() {
    super.initState();
    _getSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Courts'),
      ),
      body: Expanded(
        child: BlocConsumer<CourtBloc, CourtState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is GetScheduleState) {
              scheduleList = state.scheduleCourts.cast<Schedule>();
              scheduleList.sort((a, b) {
                return a.date.compareTo(b.date);
              });
            }
            if (state is DeleteScheduleState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Reservation deleted")),
              );
              _getSchedule();
            }
          },
          builder: (BuildContext context, CourtState state) {
            if (scheduleList.isEmpty) {
              return const Center(
                child: Text("There are no scheduled courts."),
              );
            }
            return ListView.builder(
              itemCount: scheduleList.length,
              itemBuilder: (context, index) {
                return CourtCardWidget(
                  schedule: scheduleList[index],
                  onDelete: _deleteItem,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SchedulePage()))
              .then((value) {
            if (value == true) {
              _getSchedule();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _getSchedule() {
    _bloc.add(OnGetScheduleEvent());
  }

  _deleteItem(int id) {
    _bloc.add(OnDeleteScheduleEvent(id));
  }
}
