import '../../core/db/crud.dart';
import '../abstract/abstract_sql.dart';
import '../models/presupuesto/presupuesto.dart';

class PresupuestoProvider extends CRUD implements AbstractSQL<Presupuesto> {
  PresupuestoProvider({super.table = 'presupuesto'});

  /// Los argumentos no son necesarios para esta implementación
  @override
  Future<int> deleteAllItems({List<Object>? arguments}) async =>
      await deleteAll();

  @override
  Future<int> deleteItem({required Presupuesto model}) async =>
      await delete(where: 'id = ?', whereArgs: [model.id!]);

  /// Los argumentos necesarios son:
  /// ```dart
  /// [id]
  /// ```
  ///
  @override
  Future<Presupuesto?> getItem({required List<Object> arguments}) async {
    final result = await select(
      where: 'id = ?',
      whereArgs: arguments,
    );

    return result.isNotEmpty ? Presupuesto.fromJson(result.first) : null;
  }

  /// Los argumentos no son necesarios para esta implementación
  @override
  Future<List<Presupuesto>> getItems({List<Object>? arguments}) async {
    final result = await select();
    return result.isNotEmpty
        ? result.map((e) => Presupuesto.fromJson(e)).toList()
        : [];
  }

  @override
  Future<int> insertItem({required Presupuesto model}) async =>
      await insert(json: model.toJson());

  @override
  Future<Presupuesto> saveItem({required Presupuesto model}) async {
    if (model.id == null) {
      final id = await insertItem(model: model);
      final item = await getItem(arguments: [id]);
      return item!;
    }

    await updateItem(model: model);

    return model;
  }

  @override
  Future<int> updateItem({required Presupuesto model}) async => await update(
        json: model.toJson(),
        where: 'id=?',
        whereArgs: [model.id!],
      );
}
