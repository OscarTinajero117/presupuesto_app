import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'version/db_1.dart';

FutureOr<void> upgradeDatabase(Database db, int oldDB, int newDB) async {
  for (int version = oldDB; version < newDB; version++) {
    await _databaseOrderMigrations(db, version + 1);
  }
}

///Create table of database
FutureOr<void> createDatabase(Database db, int newVersion) async {
  for (int version = 0; version < newVersion; version++) {
    await _databaseOrderMigrations(db, version + 1);
  }
}

FutureOr<void> _databaseOrderMigrations(Database db, int version) async {
  switch (version) {
    case 1:
      // Drop tables
      await dropTables(db);
      // Create tables
      await createTables(db);
      break;
  }
}
