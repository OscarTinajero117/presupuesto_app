import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/presupuesto/presupuesto.dart';
import '../../routes/pages.dart';
import '../../widgets/appbar/my_appbar.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(
        title: const Text('Presupuestos'),
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
                    subtitle: Text('Presupuesto: \$ ${item.presupuesto}'),
                    leading: IconButton(
                      onPressed: () async {
                        controller.cantidad.text = item.presupuesto.toString();
                        controller.descripcion.text = item.descripcion;

                        await _savePresupuestoModal(model: item);
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
                          theme.colorScheme.error, item),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await _savePresupuestoModal(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _deletePresupuestoModal(Color deleteColor, Presupuesto item) {
    return Get.defaultDialog(
        title: 'Eliminar presupuesto',
        titleStyle: TextStyle(
          fontSize: 20,
          color: deleteColor,
        ),
        middleText: '¿Estas seguro de eliminar este presupuesto?',
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: deleteColor,
              textStyle: const TextStyle(color: Colors.white),
            ),
            onPressed: () async => await controller.deletePresupuesto(item),
            child: const Text('Eliminar'),
          ),
        ]);
  }

  Future<dynamic> _savePresupuestoModal({Presupuesto? model}) {
    return Get.defaultDialog(
      title: 'Agregar presupuesto',
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
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  hintText: 'Ejemplo: Comida',
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
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  hintText: 'Ejemplo: 10',
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
                    child: const Text('Cancelar'),
                  ),
                  FilledButton(
                    onPressed: () async =>
                        await controller.savePresupuesto(model: model),
                    child: const Text('Agregar'),
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
