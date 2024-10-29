import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/sys_config/preferences/get_preferences.dart';

class ToogleThemeBtn extends StatelessWidget {
  const ToogleThemeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.light_mode),
      onPressed: () async {
        final isDarkMode = Get.isDarkMode;

        await GetPreferences.savePreference(
          parameter: Preferences.isDarkMode,
          value: isDarkMode ? '0' : '1',
        );

        Get.changeThemeMode(
          isDarkMode ? ThemeMode.light : ThemeMode.dark,
        );
      },
    );
  }
}
