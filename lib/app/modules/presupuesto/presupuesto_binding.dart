import 'package:get/get.dart';

import '../../data/repository/presupuesto_repository.dart';
import 'presupuesto_controller.dart';

class PresupuestoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PresupuestoController>(
      () => PresupuestoController(
        PresupuestoRepository(),
      ),
    );
  }
}
