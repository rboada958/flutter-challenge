import 'package:myproject/src/features/court/data/data_sources/local/database.dart';
import 'package:myproject/src/features/court/domain/models/Schedule.dart';
import 'package:myproject/src/features/court/domain/repositories/court_repository.dart';
import 'package:sqflite/sqflite.dart';

class CourtRepositoryImpl implements CourtRepository {
  final DatabaseProvider _databaseProvider = DatabaseProvider.instance;

  @override
  Future<List<Schedule>> getSchedule() async {
    Database db = await _databaseProvider.database;
    List<Map<String, dynamic>> data = await db.query(DatabaseProvider.table);
    return data.map((e) => Schedule.fromMap(e)).toList();
  }

  @override
  Future<void> setSchedule(Schedule schedule) async {
    final db = await _databaseProvider.database;
    await db.insert(DatabaseProvider.table, schedule.toMap());
  }

  @override
  Future<void> deleteSchedule(int id) async {
    final db = await _databaseProvider.database;
    await db.delete('schedule', where: 'id = ?', whereArgs: [id]);
  }
}
