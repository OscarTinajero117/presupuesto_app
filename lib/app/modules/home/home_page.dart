import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/pages.dart';
import '../../widgets/appbar/my_appbar.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: const Text('Presupuestos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Descripcion $index'),
            subtitle: Text('Cantidad $index'),
            leading: const Icon(Icons.monetization_on),
            onTap: () => Get.toNamed(
              Routes.PRESUPUESTO,
              arguments: index,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              onPressed: () async {
                await _deletePresupuestoModal();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addPresupuestoModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _deletePresupuestoModal() {
    return Get.defaultDialog(
      title: 'Eliminar presupuesto',
      titleStyle: const TextStyle(
        fontSize: 20,
        color: Colors.red,
      ),
      middleText: '¿Estas seguro de eliminar este presupuesto?',
      textCancel: 'Cancelar',
      textConfirm: 'Eliminar',
      onConfirm: () {
        // TODO: Eliminar presupuesto
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  Future<dynamic> _addPresupuestoModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(20),
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Agregar presupuesto',
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Cantidad',
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    // TODO: Agregar presupuesto
                  },
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
