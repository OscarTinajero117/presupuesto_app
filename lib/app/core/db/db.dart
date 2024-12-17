import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'tables.dart';

class DB {
  static Database? _database;
  static const String dbName = "Presupuesto.db";
  static const int dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _openDB();
    return _database!;
  }

  static Future<Database> _openDB() async {
    String path = join(
      await getDatabasesPath(),
      dbName,
    );
    return openDatabase(
      path,
      onCreate: createDatabase,
      version: dbVersion,
      onUpgrade: upgradeDatabase,
    );
  }
}
