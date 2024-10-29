import 'package:get/instance_manager.dart';

import '../../../data/models/preferences/config_model.dart';
import '../../../data/providers/config_provider.dart';
import '../../enum/preferences.dart';
import '../datetime/app_time.dart';

export '../../enum/preferences.dart';

abstract class GetPreferences {
  static final _configProvider = Get.find<ConfigProvider>();

  static Future<String?> getDatePreference(Preferences parameter) async {
    final model = await _configProvider.getItem(arguments: [parameter.name]);
    if (model != null) {
      return model.fecha;
    }
    return null;
  }

  static Future<String> getPreference({
    required Preferences parameter,
    String? value,
  }) async {
    final model = await _configProvider.getItem(arguments: [parameter.name]);
    if (model != null) {
      return model.valor;
    }
    return (await savePreference(parameter: parameter, value: value ?? ''));
  }

  static Future<String> savePreference({
    required Preferences parameter,
    required String value,
  }) async {
    final tmpValue = await _configProvider.saveItem(
      model: Config(
        parametro: parameter.name,
        valor: value,
        fecha: AppTime.dateTimeNow().substring(0, 8),
      ),
    );

    return tmpValue.valor;
  }

  static Future<void> removePreference(Preferences parameter) async =>
      await savePreference(
        parameter: parameter,
        value: '',
      );
}
