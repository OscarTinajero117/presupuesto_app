import '../../core/db/crud.dart';
import '../abstract/abstract_sql.dart';
import '../models/preferences/config_model.dart';

class ConfigProvider extends CRUD implements AbstractSQL<Config> {
  ConfigProvider({super.table = 'config'});

  ///Los argumentos no son necesarios.
  @override
  Future<int> deleteAllItems({List<Object>? arguments}) async =>
      await deleteAll();

  @override
  Future<int> deleteItem({required Config model}) async => await delete(
        where: 'parametro=?',
        whereArgs: [model.parametro],
      );

  ///Los argumentos necesarios son:
  ///```
  ///[ parametro ]
  ///```
  @override
  Future<Config?> getItem({required List<Object> arguments}) async {
    final result = await select(
      where: 'parametro=?',
      whereArgs: arguments,
    );
    final Config? regresar =
        result.isNotEmpty ? Config.fromJson(result.first) : null;
    return regresar;
  }

  ///Los argumentos no son necesarios.
  @override
  Future<List<Config>> getItems({List<Object>? arguments}) async {
    final result = await select();
    List<Config> list = [];
    if (result.isNotEmpty) {
      for (Map<String, Object?> row in result) {
        list.add(Config.fromJson(row));
      }
    }
    return list;
  }

  @override
  Future<int> insertItem({required Config model}) async =>
      await insert(json: model.toJson());

  @override
  Future<Config> saveItem({required Config model}) async {
    final Config? item = await getItem(
      arguments: [model.parametro],
    );
    item == null
        ? await insertItem(model: model)
        : await updateItem(model: model);
    return model;
  }

  @override
  Future<int> updateItem({required Config model}) async => await update(
        json: model.toJson(),
        where: 'parametro=?',
        whereArgs: [model.parametro],
      );
}
