import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myproject/src/core/utils/injections.dart';
import 'package:myproject/src/features/court/domain/models/Schedule.dart';
import 'package:myproject/src/features/court/domain/usecases/court_usecase.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_bloc.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_event.dart';
import 'package:myproject/src/features/court/presentation/bloc/court_state.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String? _selectedCourt;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final CourtBloc _bloc = CourtBloc(useCase: sl<CourtUseCase>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule a court'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: BlocConsumer<CourtBloc, CourtState>(
            bloc: _bloc,
            listener: (context, state) {},
            builder: (BuildContext context, CourtState state) {
              if (state is SetScheduleState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Scheduled court")),
                  );
                  Navigator.pop(context, true);
                });
                return Container();
              }
              return Column(
                children: <Widget>[
                  DropdownButtonFormField(
                    hint: const Text("Select a court"),
                    value: _selectedCourt,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCourt = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: <String>['Court A', 'Court B', 'Court C']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Select a date',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedCourt != null) {
                          _schedule();
                        }
                      },
                      child: const Text('Schedule'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
      });
    }
  }

  void _schedule() {
    int uniqueId = DateTime.now().millisecondsSinceEpoch;
    final schedule = Schedule(
      id: uniqueId,
      court: _selectedCourt!,
      date: _selectedDate,
      name: _nameController.text,
    );

    _bloc.add(OnSetScheduleEvent(schedule));
  }
}
