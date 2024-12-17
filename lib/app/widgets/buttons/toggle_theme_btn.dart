import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/sys_config/preferences/get_preferences.dart';

class ToggleThemeBtn extends StatelessWidget {
  const ToggleThemeBtn({
    super.key,
    this.onPressed,
  });

  final Function(bool)? onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode,
      ),
      onPressed: () async {
        final isDarkMode = Get.isDarkMode;

        await GetPreferences.savePreference(
          parameter: Preferences.isDarkMode,
          value: isDarkMode ? '0' : '1',
        );

        Get.changeThemeMode(
          isDarkMode ? ThemeMode.light : ThemeMode.dark,
        );

        if (onPressed != null) {
          onPressed!(isDarkMode);
        }
      },
    );
  }
}
