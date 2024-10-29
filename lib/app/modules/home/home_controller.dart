import 'package:get/get.dart';

import '../../data/models/presupuesto/presupuesto.dart';
import '../../data/repository/presupuesto_repository.dart';

class HomeController extends GetxController {
  final PresupuestoRepository _presupuestoRepository;
  HomeController(this._presupuestoRepository);

  final listPresupuestos = <Presupuesto>[].obs;

  @override
  void onInit() async {
    listPresupuestos.value = await _presupuestoRepository.getPresupuestos();
    super.onInit();
  }
}
