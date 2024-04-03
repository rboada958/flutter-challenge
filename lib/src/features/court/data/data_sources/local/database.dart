import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _databaseName = "CourtDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'schedule';

  DatabaseProvider._internal();

  static DatabaseProvider get instance =>
      _databaseHelper ??= DatabaseProvider._internal();
  static DatabaseProvider? _databaseHelper;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE schedule (
        id INTEGER PRIMARY KEY,
        court TEXT,
        date TEXT,
        name TEXT
      )
    ''');
  }
}
