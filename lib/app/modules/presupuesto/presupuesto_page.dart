import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appbar/my_appbar.dart';
import 'presupuesto_controller.dart';

class PresupuestoPage extends GetView<PresupuestoController> {
  const PresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: const Text('Presupuesto: Tal'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: \$ 1000.00',
                ),
              ],
            ),
          ),
          Expanded(
            child: Form(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const FormInput(
                    labelText: 'Descripcion',
                  ),
                  const FormInput(
                    labelText: 'Costo',
                  ),
                  const FormInput(
                    labelText: 'Cantidad',
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      // TODO: Agregar item_presupuesto
                    },
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Descripcion $index'),
                    subtitle: Text('Cantidad $index'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        // TODO: Eliminar item_presupuesto
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  final String labelText;
  const FormInput({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
