import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/presupuesto/presupuesto_binding.dart';
import '../modules/presupuesto/presupuesto_page.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRESUPUESTO,
      page: () => PresupuestoPage(),
      binding: PresupuestoBinding(),
    ),
  ];
}
