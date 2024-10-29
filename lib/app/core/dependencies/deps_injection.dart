import 'package:get/get.dart';

import '../../data/providers/config_provider.dart';

abstract class DependencyInjection {
  static void init() {
    Get.lazyPut<ConfigProvider>(
      () => ConfigProvider(),
      fenix: true,
    );
  }
}
