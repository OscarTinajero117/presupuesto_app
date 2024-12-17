import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../widgets/appbar/my_appbar.dart';
import '../../widgets/input/form_input.dart';
import 'presupuesto_controller.dart';

class PresupuestoPage extends GetView<PresupuestoController> {
  const PresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final txt = AppLocalizations.of(context);
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
                      '${txt!.total}: \$ ${controller.totalRestante}',
                      style: TextStyle(
                        fontSize: 20.0,
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
                    labelText: txt!.descripcion_articulo,
                    hintText: txt.ejemplo_articulo,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormInput(
                          focusNode: controller.costoFocus,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller: controller.costo,
                          onFieldSubmitted: controller.onFieldSubmittedCosto,
                          labelText: txt.costo_articulo,
                          hintText: '10.50',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormInput(
                          focusNode: controller.cantidadFocus,
                          keyboardType: const TextInputType.numberWithOptions(),
                          controller: controller.cantidad,
                          onFieldSubmitted: controller.onFieldSubmittedCantidad,
                          labelText: txt.cantidad_articulo,
                          hintText: '4',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async =>
                        await controller.saveItemPresupuesto(),
                    child: Text(txt.agregar),
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
            flex: 2,
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
                              Text('${txt.unidad}: \$ ${item.costo}'),
                              Text('${txt.cantidad}: ${item.cantidad}'),
                            ],
                          ),
                          Text(
                              '${txt.total}:     \$ ${item.cantidad * item.costo}'),
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
