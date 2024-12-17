import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../data/models/presupuesto/item_presupuesto.dart';
import '../../data/models/presupuesto/presupuesto.dart';
import '../../data/repository/presupuesto_repository.dart';

class PresupuestoController extends GetxController {
  final PresupuestoRepository _presupuestoRepository;

  PresupuestoController(this._presupuestoRepository);

  final presupuesto = Presupuesto.getDefault().obs;

  final listItems = <ItemPresupuesto>[].obs;

  final descripcion = TextEditingController();
  final costo = TextEditingController();
  final cantidad = TextEditingController();

  final descripcionFocus = FocusNode();
  final costoFocus = FocusNode();
  final cantidadFocus = FocusNode();

  @override
  void onInit() async {
    presupuesto.value = Get.arguments as Presupuesto;

    listItems.value =
        await _presupuestoRepository.getItemsPresupuesto(presupuesto.value.id!);
    super.onInit();
  }

  double get total => listItems.fold(
      0,
      (previousValue, element) =>
          previousValue + element.cantidad * element.costo);

  double get totalRestante => presupuesto.value.presupuesto - total;

  void onFieldSubmittedDescripcion(String? value) =>
      FocusScope.of(Get.context!).requestFocus(costoFocus);

  void onFieldSubmittedCosto(String? value) =>
      FocusScope.of(Get.context!).requestFocus(cantidadFocus);

  void onFieldSubmittedCantidad(String? value) async {
    FocusScope.of(Get.context!).unfocus();
    await saveItemPresupuesto();
  }

  Future<void> saveItemPresupuesto() async {
    final txt = AppLocalizations.of(Get.overlayContext!);
    if (descripcion.text.isEmpty ||
        costo.text.isEmpty ||
        cantidad.text.isEmpty) {
      Get.snackbar(
        'Error',
        txt!.campos_obligatorios,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    try {
      final item = ItemPresupuesto(
        idPresupuesto: presupuesto.value.id!,
        descripcion: descripcion.text,
        costo: double.parse(costo.text),
        cantidad: int.parse(cantidad.text),
        fechaInsert: DateTime.now(),
      );

      final result = await _presupuestoRepository.saveItemPresupuesto(item);

      listItems.add(result);
      descripcion.clear();
      costo.clear();
      cantidad.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        txt!.error_guardar,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      FocusScope.of(Get.context!).requestFocus(descripcionFocus);
    }
  }

  Future<void> deleteItemPresupuesto(ItemPresupuesto item) async {
    final txt = AppLocalizations.of(Get.overlayContext!);
    try {
      await _presupuestoRepository.deleteItemPresupuesto(item);
      listItems.removeWhere((element) => element.id == item.id);
    } catch (e) {
      Get.snackbar(
        'Error',
        txt!.error_eliminar,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  @override
  void onClose() {
    descripcion.dispose();
    costo.dispose();
    cantidad.dispose();
    descripcionFocus.dispose();
    costoFocus.dispose();
    cantidadFocus.dispose();
    listItems.clear();
    super.onClose();
  }
}
