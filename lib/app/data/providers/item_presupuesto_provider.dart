import '../../core/db/crud.dart';
import '../abstract/abstract_sql.dart';
import '../models/presupuesto/item_presupuesto.dart';

class ItemPresupuestoProvider extends CRUD
    implements AbstractSQL<ItemPresupuesto> {
  ItemPresupuestoProvider({super.table = 'item_presupuesto'});

  /// Los argumentos necesarios son:
  /// ```dart
  /// [idPresupuesto]
  /// ```
  ///
  @override
  Future<int> deleteAllItems({required List<Object> arguments}) async =>
      await delete(where: 'id_presupuesto = ?', whereArgs: arguments);

  @override
  Future<int> deleteItem({required ItemPresupuesto model}) async =>
      await delete(where: 'id=?', whereArgs: [model.id]);

  /// Los argumentos necesarios son:
  /// ```dart
  /// [id]
  /// ```
  @override
  Future<ItemPresupuesto?> getItem({required List<Object> arguments}) async {
    final result = await select(
      where: 'id = ?',
      whereArgs: arguments,
    );

    return result.isNotEmpty ? ItemPresupuesto.fromJson(result.first) : null;
  }

  /// Los argumentos necesarios son:
  /// ```dart
  /// [idPresupuesto]
  /// ```
  ///
  @override
  Future<List<ItemPresupuesto>> getItems(
      {required List<Object> arguments}) async {
    final result = await select(
      where: 'id_presupuesto = ?',
      whereArgs: arguments,
    );
    return result.isNotEmpty
        ? result.map((e) => ItemPresupuesto.fromJson(e)).toList()
        : [];
  }

  @override
  Future<int> insertItem({required ItemPresupuesto model}) async =>
      await insert(json: model.toJson());

  @override
  Future<ItemPresupuesto> saveItem({required ItemPresupuesto model}) async {
    final item = await getItem(arguments: [model.id]);
    item == null ? insertItem(model: model) : updateItem(model: model);
    return model;
  }

  @override
  Future<int> updateItem({required ItemPresupuesto model}) async =>
      await update(
        json: model.toJson(),
        where: 'id=?',
        whereArgs: [model.id],
      );
}
