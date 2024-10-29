import 'package:get/get.dart';

import '../../data/repository/presupuesto_repository.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        PresupuestoRepository(),
      ),
    );
  }
}
