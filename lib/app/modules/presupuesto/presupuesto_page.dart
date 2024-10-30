import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appbar/my_appbar.dart';
import '../../widgets/input/form_input.dart';
import 'presupuesto_controller.dart';

class PresupuestoPage extends GetView<PresupuestoController> {
  const PresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: myAppBar(
        title: Text(controller.presupuesto.value.descripcion),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Text(
                      'Total: \$ ${controller.totalRestante}',
                      style: TextStyle(
                        color: controller.totalRestante <
                                controller.presupuesto.value.presupuesto * 0.1
                            ? theme.colorScheme.error
                            : controller.totalRestante <
                                    controller.presupuesto.value.presupuesto *
                                        0.3
                                ? Colors.yellow.shade800
                                : Colors.green.shade700,
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
            child: Form(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  FormInput(
                    focusNode: controller.descripcionFocus,
                    keyboardType: TextInputType.text,
                    controller: controller.descripcion,
                    onFieldSubmitted: controller.onFieldSubmittedDescripcion,
                    labelText: 'Descripcion',
                    hintText: 'Ejemplo: Lapices',
                  ),
                  FormInput(
                    focusNode: controller.costoFocus,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: controller.costo,
                    onFieldSubmitted: controller.onFieldSubmittedCosto,
                    labelText: 'Costo',
                    hintText: 'Ejemplo: 10.50',
                  ),
                  FormInput(
                    focusNode: controller.cantidadFocus,
                    keyboardType: const TextInputType.numberWithOptions(),
                    controller: controller.cantidad,
                    onFieldSubmitted: controller.onFieldSubmittedCantidad,
                    labelText: 'Cantidad',
                    hintText: 'Ejemplo: 4',
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async =>
                        await controller.saveItemPresupuesto(),
                    child: const Text('Agregar'),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.listItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.listItems[index];
                    return ListTile(
                      title: Text(item.descripcion),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Unidad: \$ ${item.costo}'),
                              Text('Cantidad: ${item.cantidad}'),
                            ],
                          ),
                          Text('Total:     \$ ${item.cantidad * item.costo}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        onPressed: () async =>
                            await controller.deleteItemPresupuesto(item),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
