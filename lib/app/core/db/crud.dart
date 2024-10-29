import 'package:sqflite/sqflite.dart';

import 'db.dart';

class CRUD extends DB {
  final String table;
  CRUD({required this.table});

  ///Se obtiene la lista de elementos de la tabla indicada
  ///según sean los argumentos dados
  Future<List<Map<String, Object?>>> select({
    String? table,
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final Database db = await database;
    final List<Map<String, Object?>> result = await db.query(
      table ?? this.table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
    return result;
  }

  ///Inserta un elemento en la bd
  Future<int> insert({
    String? table,
    required Map<String, dynamic> json,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace,
  }) async {
    final Database db = await database;
    final int row = await db.insert(
      table ?? this.table,
      json,
      conflictAlgorithm: conflictAlgorithm,
    );
    return row;
  }

  ///Se actualiza el elemento de la tabla dada según las condiciones dadas
  Future<int> update({
    String? table,
    required Map<String, dynamic> json,
    required String where,
    required List<Object> whereArgs,
    ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace,
  }) async {
    final Database db = await database;
    final int row = await db.update(
      table ?? this.table,
      json,
      where: where,
      whereArgs: whereArgs,
    );
    return row;
  }

  ///Se elimina un elemento específico de la tabla dada
  Future<int> delete({
    String? table,
    required String where,
    required List<Object> whereArgs,
  }) async {
    final Database db = await database;
    final int result = await db.delete(
      table ?? this.table,
      where: where,
      whereArgs: whereArgs,
    );
    return result;
  }

  ///Se elimina toda la información de la tabla
  Future<int> deleteAll({String? table}) async {
    final Database db = await database;
    final int result = await db.delete(table ?? this.table);
    return result;
  }

  //**Raw Actions */
  Future<List<Map<String, Object?>>> getRawElements({
    required String sql,
    List<Object>? arguments,
  }) async {
    final Database db = await database;
    final List<Map<String, Object?>> result = await db.rawQuery(sql, arguments);
    return result;
  }

  ///Se actualiza la información de la tabla dada.
  ///
  ///Se recibe algo como lo siguiente:
  ///```
  /// final result = await rawUpdate(
  ///   table : "Elementos",        //tabla(Opcional)
  ///   what  : "valor=?, fecha=?", //Que se desea actualizar
  ///   where : "id=?",             //Donde se hará el cambio
  ///   arguments : [               //Lista de argumentos
  ///                 item.valor,
  ///                 item.fecha,
  ///                 item.id
  ///               ]
  ///   );
  ///
  ///```
  ///El Update final sería el siguiente:
  ///```
  /// UPDATE Elementos SET valor=?, fecha=? WHERE id=?
  ///```
  ///Los argumentos (*arguments*) son los valores que reemplazarán los signos ?
  Future<int> rawUpdate({
    String? table,
    required String what,
    required String where,
    required List<Object> arguments,
  }) async {
    final String t = table ?? this.table;
    final Database db = await database;
    final int row =
        await db.rawUpdate("UPDATE $t SET $what WHERE $where", arguments);
    return row;
  }
}
