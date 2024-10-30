import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/presupuesto/presupuesto.dart';
import '../../data/repository/presupuesto_repository.dart';

class HomeController extends GetxController {
  final PresupuestoRepository _presupuestoRepository;
  HomeController(this._presupuestoRepository);

  final listPresupuestos = <Presupuesto>[].obs;

  final isLoading = false.obs;

  final descripcion = TextEditingController();
  final cantidad = TextEditingController();

  final descripcionFocus = FocusNode();
  final cantidadFocus = FocusNode();

  @override
  void onInit() async {
    listPresupuestos.value = await _presupuestoRepository.getPresupuestos();
    super.onInit();
  }

  void onFieldSubmittedDescricion(String? value) =>
      FocusScope.of(Get.context!).requestFocus(cantidadFocus);

  void onFieldSubmittedCantidad(String? value) async {
    FocusScope.of(Get.context!).unfocus();
    await savePresupuesto();
  }

  Future<void> savePresupuesto({Presupuesto? model}) async {
    if (descripcion.text.isEmpty || cantidad.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Todos los campos son obligatorios',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final presupuesto = model == null
          ? Presupuesto(
              descripcion: descripcion.text,
              presupuesto: double.parse(cantidad.text),
              fechaInsert: DateTime.now(),
            )
          : model.copyWith(
              descripcion: descripcion.text,
              presupuesto: double.parse(cantidad.text),
              fechaUpdate: DateTime.now(),
            );

      final toSave = await _presupuestoRepository.savePresupuesto(presupuesto);

      model == null
          ? listPresupuestos.add(toSave)
          : _replaceItem(model, toSave);

      Get.back();
      Get.snackbar(
        '¡Realizado!',
        'Presupuesto guardado correctamente',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Ocurrio un error al guardar el presupuesto',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      listPresupuestos.refresh();
      descripcion.clear();
      cantidad.clear();

      isLoading.value = false;
    }
  }

  void _replaceItem(Presupuesto model, Presupuesto toSave) {
    final index =
        listPresupuestos.indexWhere((element) => element.id == model.id);
    listPresupuestos[index] = toSave;
  }

  Future<void> deletePresupuesto(Presupuesto model) async {
    try {
      isLoading.value = true;
      await _presupuestoRepository.deletePresupuesto(model);
      listPresupuestos.removeWhere((element) => element.id == model.id);
      Get.back();
      Get.snackbar(
        '¡Realizado!',
        'Presupuesto eliminado correctamente',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Ocurrio un error al eliminar el presupuesto',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      listPresupuestos.refresh();

      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    descripcion.dispose();
    cantidad.dispose();
    descripcionFocus.dispose();
    cantidadFocus.dispose();
    super.onClose();
  }
}
