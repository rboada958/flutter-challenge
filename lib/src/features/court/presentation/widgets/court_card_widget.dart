import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/src/features/court/domain/models/Schedule.dart';

class CourtCardWidget extends StatefulWidget {
  final Schedule schedule;
  final Function(int) onDelete;

  const CourtCardWidget({Key? key, required this.schedule, required this.onDelete}) : super(key: key);

  @override
  State<CourtCardWidget> createState() => _CourtCardWidgetState();
}

class _CourtCardWidgetState extends State<CourtCardWidget> {
  @override
  Widget build(BuildContext context) {

    String formatDate = DateFormat('dd/MM/yyyy').format(widget.schedule.date);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple[50],
        ),
        child: ListTile(
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
          title: Text(widget.schedule.court),
          subtitle: Text('${widget.schedule.name} - $formatDate'),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete reservation"),
          content:
              const Text("Are you sure you want to delete this reservation?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                widget.onDelete(widget.schedule.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
