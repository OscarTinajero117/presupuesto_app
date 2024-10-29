import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';

FutureOr<void> createTables(Database db, int version) async {
  const String tag = 'DB';

  //**DROP TABLES */
  final List<String> dropTable = [
    'config',
    'presupuesto',
    'item_presupuesto',
  ];
  //**DROP TABLES */
  for (String row in dropTable) {
    await db.execute('DROP TABLE IF EXISTS $row');
  }

  await db.execute('''
        CREATE TABLE IF NOT EXISTS config (
          parametro TEXT NOT NULL PRIMARY KEY 
        , valor TEXT NOT NULL
        , fecha TEXT
          )
    ''');
  log('$tag -> CREATE TABLE config');

  await db.execute('''
        CREATE TABLE IF NOT EXISTS presupuesto (
          id INTEGER PRIMARY KEY 
        , descripcion TEXT NOT NULL 
        , presupuesto REAL NOT NULL
        , fecha_insert TEXT NOT NULL
        , fecha_update TEXT NULL
          )
    ''');
  log('$tag -> CREATE TABLE presupuesto');

  await db.execute('''
        CREATE TABLE IF NOT EXISTS item_presupuesto (
          id INTEGER PRIMARY KEY
        , id_presupuesto INTEGER NOT NULL
        , descripcion TEXT NOT NULL 
        , costo REAL NOT NULL
        , cantidad INTEGER NOT NULL
        , fecha_insert TEXT NOT NULL
        , fecha_update TEXT NULL
          )
    ''');
  log('$tag -> CREATE TABLE item_presupuesto');
}

FutureOr<void> upgradeTables(Database db, int oldDB, int newDB) async {
  if (oldDB < newDB) {
    await createTables(db, newDB);
  }
}
