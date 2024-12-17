import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/presupuesto/presupuesto.dart';
import '../../routes/pages.dart';
import '../../widgets/appbar/my_appbar.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final txt = AppLocalizations.of(context);
    return Scaffold(
      appBar: myAppBar(
        title: Text(txt!.title),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.listPresupuestos.length,
                itemBuilder: (context, index) {
                  final item = controller.listPresupuestos[index];
                  return ListTile(
                    title: Text(item.descripcion),
                    subtitle:
                        Text('${txt.presupuesto}: \$ ${item.presupuesto}'),
                    leading: IconButton(
                      onPressed: () async {
                        controller.cantidad.text = item.presupuesto.toString();
                        controller.descripcion.text = item.descripcion;

                        await _savePresupuestoModal(
                          model: item,
                          title: txt.agregar_presupuesto,
                          descripcion: txt.descripcion,
                          ejemploPresupuesto: txt.ejemplo_nombre_presupuesto,
                          cantidad: txt.cantidad_dinero,
                          ejemploCantidad: txt.ejemplo_cantidad_dinero,
                          cancel: txt.cancelar,
                          add: txt.agregar,
                        );
                      },
                      icon: const Icon(Icons.edit_note),
                    ),
                    onTap: () => Get.toNamed(
                      Routes.PRESUPUESTO,
                      arguments: item,
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () async => await _deletePresupuestoModal(
                        deleteColor: theme.colorScheme.error,
                        item: item,
                        titleDelete: txt.eliminar_presupuesto,
                        middleDelete: txt.pregunta_eliminar_presupuesto,
                        cancel: txt.cancelar,
                        delete: txt.eliminar,
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await _savePresupuestoModal(
          title: txt.agregar_presupuesto,
          descripcion: txt.descripcion,
          ejemploPresupuesto: txt.ejemplo_nombre_presupuesto,
          cantidad: txt.cantidad_dinero,
          ejemploCantidad: txt.ejemplo_cantidad_dinero,
          cancel: txt.cancelar,
          add: txt.agregar,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _deletePresupuestoModal({
    required Color deleteColor,
    required Presupuesto item,
    required String titleDelete,
    required String middleDelete,
    required String cancel,
    required String delete,
  }) {
    return Get.defaultDialog(
        title: titleDelete,
        titleStyle: TextStyle(
          fontSize: 20,
          color: deleteColor,
        ),
        middleText: middleDelete,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: deleteColor,
              textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: () async => await controller.deletePresupuesto(item),
            child: Text(delete),
          ),
        ]);
  }

  Future<dynamic> _savePresupuestoModal({
    required String title,
    required String descripcion,
    required String ejemploPresupuesto,
    required String cantidad,
    required String ejemploCantidad,
    required String cancel,
    required String add,
    Presupuesto? model,
  }) {
    return Get.defaultDialog(
      title: title,
      titlePadding: const EdgeInsets.only(top: 10.0),
      content: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                focusNode: controller.descripcionFocus,
                keyboardType: TextInputType.text,
                controller: controller.descripcion,
                maxLength: 64,
                onSubmitted: controller.onFieldSubmittedDescricion,
                decoration: InputDecoration(
                  labelText: descripcion,
                  hintText: ejemploPresupuesto,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                focusNode: controller.cantidadFocus,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: controller.cantidad,
                maxLength: 10,
                onSubmitted: controller.onFieldSubmittedCantidad,
                decoration: InputDecoration(
                  labelText: cantidad,
                  hintText: ejemploCantidad,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.cantidad.clear();
                      controller.descripcion.clear();
                      Get.back();
                    },
                    child: Text(cancel),
                  ),
                  FilledButton(
                    onPressed: () async =>
                        await controller.savePresupuesto(model: model),
                    child: Text(add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
