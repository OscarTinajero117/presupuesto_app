import '../models/presupuesto/item_presupuesto.dart';
import '../models/presupuesto/presupuesto.dart';
import '../providers/item_presupuesto_provider.dart';
import '../providers/presupuesto_provider.dart';

class PresupuestoRepository {
  static final _presProvider = PresupuestoProvider();
  static final _itemProvider = ItemPresupuestoProvider();

  Future<Presupuesto> savePresupuesto(Presupuesto model) async =>
      await _presProvider.saveItem(model: model);

  Future<List<Presupuesto>> getPresupuestos() async =>
      await _presProvider.getItems();

  Future<Presupuesto?> getPresupuesto(int id) async =>
      await _presProvider.getItem(arguments: [id]);

  Future<int> deletePresupuesto(Presupuesto model) async =>
      await _presProvider.deleteItem(model: model);

  Future<ItemPresupuesto> saveItemPresupuesto(ItemPresupuesto model) async =>
      await _itemProvider.saveItem(model: model);

  Future<List<ItemPresupuesto>> getItemsPresupuesto(int idPresupuesto) async =>
      await _itemProvider.getItems(arguments: [idPresupuesto]);

  Future<int> deleteItemPresupuesto(ItemPresupuesto model) async =>
      await _itemProvider.deleteItem(model: model);

  Future<int> deleteAllItemsPresupuesto(int idPresupuesto) async =>
      await _itemProvider.deleteAllItems(arguments: [idPresupuesto]);
}
